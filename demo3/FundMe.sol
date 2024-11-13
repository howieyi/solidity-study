// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// 1. 创建一个收款函数

// 2. 记录投资人并且查看

// 3. 在锁定期内，达到目标值，生产商可以提款

// 4. 在锁定期内，没有达到，投资人在锁定期之后可以退款

contract FundMe {
    mapping(address => uint256) public fundersMap;

    // payable 调用原生 token 收款
    function fund() external payable {
        fundersMap[msg.sender] = msg.value;
    }
}
