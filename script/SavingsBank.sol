// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "forge-std/Script.sol";
import "../src/SavingsBank.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();

        // Deploy the SavingsBank contract
        SavingsBank bank = new SavingsBank();

        vm.stopBroadcast();
    }
}