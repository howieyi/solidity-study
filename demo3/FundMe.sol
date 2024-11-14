// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// https://docs.chain.link/data-feeds/getting-started
// chainlink data feeds
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// 1. 创建一个收款函数
// 2. 记录投资人并且查看
// 3. 在锁定期内，达到目标值，生产商可以提款
// 4. 在锁定期内，没有达到，投资人在锁定期之后可以退款

contract FundMe {
    uint256 MINMUM_USD_VALUE = 100 * 10**18; // USD

    mapping(address => uint256) public fundersMap;

    AggregatorV3Interface internal dataFeed;

    /**
     * Network: Sepolia
     * Aggregator: BTC/USD
     * Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
     */
    // 获取地址 https://docs.chain.link/data-feeds/price-feeds/addresses?network=ethereum&page=1#ethereum-mainnet
    constructor() {
        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
    }

    // payable 调用原生 token 收款
    function fund() external payable {
        require(
            convertEthToUsd(msg.value) >= MINMUM_USD_VALUE,
            "Send more eth."
        );
        fundersMap[msg.sender] = msg.value;
    }

    // chainlink 预言机网络
    /**
     * Returns the latest answer.
     */
    function getChainlinkDataFeedLatestAnswer() public view returns (int256) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }

    function convertEthToUsd(uint256 ethAmount)
        internal
        view
        returns (uint256)
    {
        // ETH / USD precision = 10 ** 8
        // XX / ETH precision = 10 ** 18
        return
            (ethAmount * uint256(getChainlinkDataFeedLatestAnswer())) / (10**8);
    }
}
