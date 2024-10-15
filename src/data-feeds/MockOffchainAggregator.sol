// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title MockOffchainAggregator
/// @notice This contract is a mock implementation of an offchain aggregator for testing purposes.
/// @dev This contract simulates the behavior of an offchain aggregator and allows for updating answers and round data.
contract MockOffchainAggregator {
    /// @notice The minimum possible answer the aggregator can report.
    int192 private constant MIN_ANSWER_POSSIBLE = 1;

    /// @notice The maximum possible answer the aggregator can report.
    int192 private constant MAX_ANSWER_POSSIBLE = 95780971304118053647396689196894323976171195136475135; // type(uint176).max

    /// @notice The number of decimals used by the aggregator.
    uint8 public decimals;

    /// @notice The latest answer reported by the aggregator.
    int256 public latestAnswer;

    /// @notice The timestamp of the latest answer.
    uint256 public latestTimestamp;

    /// @notice The latest round ID.
    uint256 public latestRound;

    /// @notice The minimum answer the aggregator is allowed to report.
    int192 public minAnswer;

    /// @notice The maximum answer the aggregator is allowed to report.
    int192 public maxAnswer;

    /// @notice Mapping to get the answer for a specific round ID.
    mapping(uint256 => int256) public getAnswer;

    /// @notice Mapping to get the timestamp for a specific round ID.
    mapping(uint256 => uint256) public getTimestamp;

    /// @notice Mapping to get the start time for a specific round ID.
    mapping(uint256 => uint256) private getStartedAt;

    /**
     * @notice Constructor to initialize the MockOffchainAggregator contract with initial parameters.
     * @param _decimals - The number of decimals for the aggregator.
     * @param _initialAnswer - The initial answer to be set in the mock aggregator.
     */
    constructor(uint8 _decimals, int256 _initialAnswer) {
        decimals = _decimals;
        updateAnswer(_initialAnswer);
        minAnswer = MIN_ANSWER_POSSIBLE;
        maxAnswer = MAX_ANSWER_POSSIBLE;
    }

    /**
     * @notice Updates the answer in the mock aggregator.
     * @param _answer - The new answer to be set.
     */
    function updateAnswer(int256 _answer) public {
        latestAnswer = _answer;
        latestTimestamp = block.timestamp;
        latestRound++;
        getAnswer[latestRound] = _answer;
        getTimestamp[latestRound] = block.timestamp;
        getStartedAt[latestRound] = block.timestamp;
    }

    /**
     * @notice Updates the round data in the mock aggregator.
     * @param _roundId - The round ID to be updated.
     * @param _answer - The new answer to be set.
     * @param _timestamp - The timestamp to be set.
     * @param _startedAt - The timestamp when the round started.
     */
    function updateRoundData(uint80 _roundId, int256 _answer, uint256 _timestamp, uint256 _startedAt) public {
        latestRound = _roundId;
        latestAnswer = _answer;
        latestTimestamp = _timestamp;
        getAnswer[latestRound] = _answer;
        getTimestamp[latestRound] = _timestamp;
        getStartedAt[latestRound] = _startedAt;
    }

    /**
     * @notice Gets the round data for a specific round ID.
     * @param _roundId - The round ID to get the data for.
     * @return roundId - The round ID.
     * @return answer - The answer for the round.
     * @return startedAt - The timestamp when the round started.
     * @return updatedAt - The timestamp when the round was updated.
     * @return answeredInRound - The round ID in which the answer was computed.
     */
    function getRoundData(uint80 _roundId)
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
    {
        return (_roundId, getAnswer[_roundId], getStartedAt[_roundId], getTimestamp[_roundId], _roundId);
    }

    /**
     * @notice Gets the latest round data.
     * @return roundId - The latest round ID.
     * @return answer - The latest answer.
     * @return startedAt - The timestamp when the latest round started.
     * @return updatedAt - The timestamp when the latest round was updated.
     * @return answeredInRound - The round ID in which the latest answer was computed.
     */
    function latestRoundData()
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
    {
        return (
            uint80(latestRound),
            getAnswer[latestRound],
            getStartedAt[latestRound],
            getTimestamp[latestRound],
            uint80(latestRound)
        );
    }

    /**
     * @notice Updates the minimum and maximum answers the aggregator can report.
     * @param _minAnswer - The new minimum answer.
     * @param _maxAnswer - The new maximum answer.
     */
    function updateMinAndMaxAnswers(int192 _minAnswer, int192 _maxAnswer) external {
        require(_minAnswer < _maxAnswer, "minAnswer must be less than maxAnswer");
        require(_minAnswer >= MIN_ANSWER_POSSIBLE, "minAnswer is too low");
        require(_maxAnswer <= MAX_ANSWER_POSSIBLE, "maxAnswer is too high");

        minAnswer = _minAnswer;
        maxAnswer = _maxAnswer;
    }
}
