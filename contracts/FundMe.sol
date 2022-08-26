// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../contracts/PriceConverter.sol";

error notOwner();

contract FundMe {
    using PriceConverter for uint256;
    address public immutable i_owner;
    address[] public funders;
    mapping(address => uint256) public fundersToAmount;
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    AggregatorV3Interface priceFeed;

    constructor(address priceFeedAddress) {
        i_owner = msg.sender;
        priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    modifier onlyOwner() {
        if (msg.sender != i_owner) revert notOwner();
        _;
    }

    function fund() public payable {
        require(
            msg.value.getConversion(priceFeed) > MINIMUM_USD,
            "Not enough money!"
        );
        funders.push(msg.sender);
        fundersToAmount[msg.sender] += msg.value;
    }

    function withdraw() public payable onlyOwner {
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Not authorized!");
        for (uint256 index = 0; index < funders.length; index++) {
            address _funders = funders[index];
            fundersToAmount[_funders] = 0;
        }
        funders = new address[](0);
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
