// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user");

    function setUp() external {
        // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306); // refactor
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, 10e18);
    }

    function testMinimumDollarIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view {
        // assertEq(fundMe.i_owner(), msg.sender); // us calling -> FundMeTest -> this contract deploys new isntance of FundMe, se address is owner here.
        // assertEq(fundMe.i_owner(), address(this)); // again have to do msg.sender after refactoring
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testPriceFeedVersionIsAccurate() public view {
        uint256 version = fundMe.getVersion(); // while calling getVersion, use sepolia rpc_url with chain-fork(--fork-url)
        assertEq(version, 4);
    }

    function testFundFailsWithoutEnoughEth() public {
        vm.expectRevert(); // means, the next line should revert
        // assert (this tx fails/reverts )
        fundMe.fund();  // how we're able to use fundMe here w/o creating new instance, fundMe FundMe works, but importing doesnt work  
    }

    function testFundUpdatesFundedDataStructure() public {  // check if funds are updating
        vm.prank(USER); // next tx will be sent by USER, since who sends what gets confusing
        fundMe.fund{value: 10e18}(); 
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER); // instead of address(this) or msg.sender, use USER 
        assertEq(amountFunded, 10e18);
    }
}
