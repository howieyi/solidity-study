// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract HelloWorld {
    string strStr = "Hello BTC";

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
            return strStr;
        } else {
            return infoMapping[id].phrase;
        }
    }

    function getNewInfo(uint256 id) public view returns (string memory) {
        return string.concat(getInfo(id), " hello new");
    }
}
