// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {FundMe} from "../src/FundMe.sol";
import {Script} from "forge-std/Script.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) { // shouldn't it return fundMe?
        vm.startBroadcast();
        FundMe fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        vm.stopBroadcast();
        return fundMe ;
    }
}
