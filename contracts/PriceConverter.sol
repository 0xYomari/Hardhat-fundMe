// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getLatestPrice(AggregatorV3Interface priceFeed)
        public
        view
        returns (uint256)
    {
        (, int256 price, , , ) = priceFeed.latestRoundData();
        uint256 ethPrice = uint256(price);
        return ethPrice;
    }

    function getConversion(uint256 ethValue, AggregatorV3Interface priceFeed)
        public
        view
        returns (uint256)
    {
        uint256 ethPrice = getLatestPrice(priceFeed);
        uint256 fundValue = (ethValue * ethPrice) / 1e18;
        return fundValue;
    }
}
