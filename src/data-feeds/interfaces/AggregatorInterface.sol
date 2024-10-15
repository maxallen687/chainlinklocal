// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title AggregatorInterface
/// @notice Interface for accessing data from an aggregator contract.
/// @dev Provides methods to get the latest data and historical data for specific rounds.
interface AggregatorInterface {
    /**
     * @notice Gets the latest answer from the aggregator.
     * @return int256 - The latest answer.
     */
    function latestAnswer() external view returns (int256);

    /**
     * @notice Gets the timestamp of the latest answer from the aggregator.
     * @return uint256 - The timestamp of the latest answer.
     */
    function latestTimestamp() external view returns (uint256);

    /**
     * @notice Gets the latest round ID from the aggregator.
     * @return uint256 - The latest round ID.
     */
    function latestRound() external view returns (uint256);

    /**
     * @notice Gets the answer for a specific round ID.
     * @param roundId - The round ID to get the answer for.
     * @return int256 - The answer for the given round ID.
     */
    function getAnswer(uint256 roundId) external view returns (int256);

    /**
     * @notice Gets the timestamp for a specific round ID.
     * @param roundId - The round ID to get the timestamp for.
     * @return uint256 - The timestamp for the given round ID.
     */
    function getTimestamp(uint256 roundId) external view returns (uint256);

    /**
     * @notice Emitted when the answer is updated.
     * @param current - The updated answer.
     * @param roundId - The round ID for which the answer was updated.
     * @param updatedAt - The timestamp when the answer was updated.
     */
    event AnswerUpdated(int256 indexed current, uint256 indexed roundId, uint256 updatedAt);

    /**
     * @notice Emitted when a new round is started.
     * @param roundId - The round ID of the new round.
     * @param startedBy - The address of the account that started the round.
     * @param startedAt - The timestamp when the round was started.
     */
    event NewRound(uint256 indexed roundId, address indexed startedBy, uint256 startedAt);
}
