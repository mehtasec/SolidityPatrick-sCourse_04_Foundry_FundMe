// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeTest is Test {

    FundMe fundMe;
    function setUp() external {
        fundMe = new FundMe();
    }

    function testMinimumDollarIsFive() public view{
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view{
        // assertEq(fundMe.i_owner(), msg.sender); // us calling -> FundMeTest -> this contract deploys new isntance of FundMe, se address is owner here.
        assertEq(fundMe.i_owner(), address(this));
        
        
    }

    function testPriceFeedVersionIsAccurate() public view {
        uint256 version = fundMe.getVersion(); // while calling getVersion, use sepolia rpc_url with chain-fork(--fork-url)
        assertEq(version, 4); 
    }
    
}