// 1. 指定开源协议
// SPDX-License-Identifier: MIT

// 2. 指定编译版本
pragma solidity ^0.8.26;

contract Helloworld {
    // 布尔值
    bool isBool = true;

    // 无符号整型
    // uint8 2-2^8 即 最大范围 256
    // uint256 2-2^256
    // unit 默认即 unit256
    uint8 uintStr = 255;
    uint256 uintStr2 = 256;

    // 整型
    int256 intStr = -2;

    // bytes 字节
    bytes32 bytesStr = "hello bytes";

    // 动态分配的bytes
    string strStr = "hello world";

    // address 地址
    address addrVar = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    // 函数
    //  可见度标识符
    // public：合约内部、合约外部、子合约、外部账号
    // private：合约内部
    // internal：合约内部、子合约
    // external：合约外部、外部账号
    // view 没有状态变更，纯读取
    function getHelloWorld() public view returns (string memory) {
        return addInfo(strStr);
    }

    function setHelloWorld(string memory newStr) public {
        strStr = newStr;
    }

    // pure 不修改任何值，纯运算操作
    function addInfo(string memory infoStr)
        internal
        pure
        returns (string memory)
    {
        return string.concat(infoStr, "from New's contract.");
    }

    // 存储模式
    /*
    1. storage 永久性存储 默认类型
    2. memory 暂时性存储，运行时可以修改
    3. calldata 暂时性存储，运行时无法修改
    4. stack
    5. codes
    6. logs
    */

    // struct：结构体
    // array：数组
    // mapping：映射，键值对

    struct Info {
        uint256 id;
        string phrase;
        address addr;
    }

    Info[] infos;
    mapping(uint256 => Info) infoMapping;

    function setInfo(string memory newInfo, uint256 newId) public {
        Info memory info = Info(newId, newInfo, msg.sender);
        infos.push(info);
        infoMapping[newId] = info;
    }

    function getInfo(uint256 id) public view returns (string memory) {
        if (infoMapping[id].addr == address(0x0)) {
            return addInfo(strStr);
        } else {
            return addInfo(infoMapping[id].phrase);
        }
    }
}
