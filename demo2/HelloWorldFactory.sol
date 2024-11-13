// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {HelloWorld} from "./HelloWorld.sol";

// 1. 直接引用一个系统下的合约
// 2. 引用github上的合约
// 3. 通过包引入

contract HelloWorldFactory {
    HelloWorld hw;
    HelloWorld[] hws;

    function createHello(string memory name, uint256 id) public {
        hw = new HelloWorld();
        hw.setInfo(name, id);
        hws.push(hw);
    }

    function getHello(uint256 id) public view returns (string memory) {
        return hw.getNewInfo(id);
    }
}
