// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SavingsBank {
    mapping(address => uint256) private balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    // Deposit ETH
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw ETH
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    // Check user balance
    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }

    // Total ETH in contract
    function getTotalBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
