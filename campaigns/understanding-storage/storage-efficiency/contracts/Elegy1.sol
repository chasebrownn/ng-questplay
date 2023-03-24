// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract Elegy1 {

    bytes32 public secondVerse;  // 256 bits -> Slot 0
    uint96  public fifthVerse;   // 96  bits
    address public thirdVerse;   // 160 bits -> Slot 1
    uint128 public fourthVerse;  // 128 bits
    bytes8  public firstVerse;   // 64  bits -> Slot 2 with 64 bits left

    function setVerse (
        bytes8  _firstVerse,
        bytes32 _secondVerse,
        address _thirdVerse,
        uint128 _fourthVerse,
        uint96  _fifthVerse
    ) external {
        firstVerse  = _firstVerse;
        secondVerse = _secondVerse;
        thirdVerse  = _thirdVerse;
        fourthVerse = _fourthVerse;
        fifthVerse  = _fifthVerse;
    }

}