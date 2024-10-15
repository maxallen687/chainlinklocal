// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title AggregatorV3Interface
/// @notice Interface for accessing detailed data from an aggregator contract, including round data and metadata.
/// @dev Provides methods to get the latest data, historical data for specific rounds, and metadata such as decimals and description.
interface AggregatorV3Interface {
    /**
     * @notice Gets the number of decimals used by the aggregator.
     * @return uint8 - The number of decimals.
     */
    function decimals() external view returns (uint8);

    /**
     * @notice Gets the description of the aggregator.
     * @return string memory - The description of the aggregator.
     */
    function description() external view returns (string memory);

    /**
     * @notice Gets the version of the aggregator.
     * @return uint256 - The version of the aggregator.
     */
    function version() external view returns (uint256);

    /**
     * @notice Gets the round data for a specific round ID.
     * @param _roundId - The round ID to get the data for.
     * @return roundId - The round ID.
     * @return answer - The answer for the round.
     * @return startedAt - The timestamp when the round started.
     * @return updatedAt - The timestamp when the round was updated.
     * @return answeredInRound - The round ID in which the answer was computed.
     * @dev This function should raise "No data present" if no data is available for the given round ID.
     */
    function getRoundData(uint80 _roundId)
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

    /**
     * @notice Gets the latest round data.
     * @return roundId - The latest round ID.
     * @return answer - The latest answer.
     * @return startedAt - The timestamp when the latest round started.
     * @return updatedAt - The timestamp when the latest round was updated.
     * @return answeredInRound - The round ID in which the latest answer was computed.
     * @dev This function should raise "No data present" if no data is available.
     */
    function latestRoundData()
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}
