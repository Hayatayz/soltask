// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/SavingsBank.sol";

contract SavingsBankTest is Test {
    SavingsBank bank;

    address user1 = address(1);
    address user2 = address(2);

    function setUp() public {
        bank = new SavingsBank();
        vm.deal(user1, 10 ether);
        vm.deal(user2, 10 ether);
    }

    function testDeposit() public {
        vm.prank(user1);
        bank.deposit{value: 1 ether}();
        assertEq(bank.getBalance(user1), 1 ether);
    }

    function testWithdraw() public {
        vm.startPrank(user1);
        bank.deposit{value: 2 ether}();
        bank.withdraw(1 ether);
        assertEq(bank.getBalance(user1), 1 ether);
        vm.stopPrank();
    }

    function testCannotWithdrawMoreThanBalance() public {
        vm.startPrank(user1);
        bank.deposit{value: 1 ether}();
        vm.expectRevert("Insufficient balance");
        bank.withdraw(2 ether);
        vm.stopPrank();
    }

    function testTotalBalance() public {
        vm.prank(user1);
        bank.deposit{value: 1 ether}();
        vm.prank(user2);
        bank.deposit{value: 2 ether}();
        assertEq(bank.getTotalBalance(), 3 ether);
    }

    function testMultipleUsers() public {
        vm.prank(user1);
        bank.deposit{value: 1 ether}();
        vm.prank(user2);
        bank.deposit{value: 2 ether}();
        vm.prank(user1);
        bank.withdraw(0.5 ether);
        assertEq(bank.getBalance(user1), 0.5 ether);
        assertEq(bank.getBalance(user2), 2 ether);
    }
}