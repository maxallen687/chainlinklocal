// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {
    AggregatorInterface,
    AggregatorV3Interface,
    AggregatorV2V3Interface
} from "./interfaces/AggregatorV2V3Interface.sol";
import {MockOffchainAggregator} from "./MockOffchainAggregator.sol";

/// @title MockV3Aggregator
/// @notice This contract is a mock implementation of the AggregatorV2V3Interface for testing purposes.
/// @dev This contract interacts with a MockOffchainAggregator to simulate price feeds.
contract MockV3Aggregator is AggregatorV2V3Interface {
    /// @notice The version of the aggregator.
    uint256 public constant override version = 0;

    /// @notice The address of the current aggregator.
    address public aggregator;

    /// @notice The address of the proposed aggregator.
    address public proposedAggregator;

    /**
     * @notice Constructor to initialize the MockV3Aggregator contract with initial parameters.
     * @param _decimals - The number of decimals for the aggregator.
     * @param _initialAnswer - The initial answer to be set in the mock aggregator.
     */
    constructor(uint8 _decimals, int256 _initialAnswer) {
        aggregator = address(new MockOffchainAggregator(_decimals, _initialAnswer));
        proposedAggregator = address(0);
    }

    /**
     * @inheritdoc AggregatorV3Interface
     */
    function decimals() external view override returns (uint8) {
        return AggregatorV2V3Interface(aggregator).decimals();
    }

    /**
     * @inheritdoc AggregatorInterface
     */
    function getAnswer(uint256 roundId) external view override returns (int256) {
        return AggregatorV2V3Interface(aggregator).getAnswer(roundId);
    }

    /**
     * @inheritdoc AggregatorV3Interface
     */
    function getRoundData(uint80 _roundId)
        external
        view
        override
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
    {
        return AggregatorV2V3Interface(aggregator).getRoundData(_roundId);
    }

    /**
     * @inheritdoc AggregatorV3Interface
     */
    function latestRoundData()
        external
        view
        override
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
    {
        return AggregatorV2V3Interface(aggregator).latestRoundData();
    }

    /**
     * @inheritdoc AggregatorInterface
     */
    function getTimestamp(uint256 roundId) external view override returns (uint256) {
        return AggregatorV2V3Interface(aggregator).getTimestamp(roundId);
    }

    /**
     * @inheritdoc AggregatorInterface
     */
    function latestAnswer() external view override returns (int256) {
        return AggregatorV2V3Interface(aggregator).latestAnswer();
    }

    /**
     * @inheritdoc AggregatorInterface
     */
    function latestTimestamp() external view override returns (uint256) {
        return AggregatorV2V3Interface(aggregator).latestTimestamp();
    }

    /**
     * @inheritdoc AggregatorInterface
     */
    function latestRound() external view override returns (uint256) {
        return AggregatorV2V3Interface(aggregator).latestRound();
    }

    /**
     * @notice Updates the answer in the mock aggregator.
     * @param _answer - The new answer to be set.
     */
    function updateAnswer(int256 _answer) public {
        MockOffchainAggregator(aggregator).updateAnswer(_answer);
    }

    /**
     * @notice Updates the round data in the mock aggregator.
     * @param _roundId - The round ID to be updated.
     * @param _answer - The new answer to be set.
     * @param _timestamp - The timestamp to be set.
     * @param _startedAt - The timestamp when the round started.
     */
    function updateRoundData(uint80 _roundId, int256 _answer, uint256 _timestamp, uint256 _startedAt) public {
        MockOffchainAggregator(aggregator).updateRoundData(_roundId, _answer, _timestamp, _startedAt);
    }

    /**
     * @notice Proposes a new aggregator.
     * @param _aggregator - The address of the proposed aggregator.
     */
    function proposeAggregator(AggregatorV2V3Interface _aggregator) external {
        require(address(_aggregator) != address(0), "Proposed aggregator cannot be zero address");
        require(address(_aggregator) != aggregator, "Proposed aggregator cannot be current aggregator");
        proposedAggregator = address(_aggregator);
    }

    /**
     * @notice Confirms the proposed aggregator.
     * @param _aggregator - The address of the proposed aggregator.
     */
    function confirmAggregator(address _aggregator) external {
        require(_aggregator == address(proposedAggregator), "Invalid proposed aggregator");
        aggregator = proposedAggregator;
        proposedAggregator = address(0);
    }

    /**
     * @inheritdoc AggregatorV3Interface
     */
    function description() external pure override returns (string memory) {
        return "src/data-feeds/MockV3Aggregator.sol";
    }
}
