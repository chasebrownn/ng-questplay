// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract Elegy2 {

    uint32[] public lines;
    uint public totalSum;

    constructor(uint32[] memory _lines) {
        lines = _lines;
    }

    function play(uint nonce) external {
        uint _length = lines.length;
        uint _totalSum = 0;
        for(uint i = 0; i < _length; i++) {
            _totalSum += (i * nonce) * lines[i];
        }
        totalSum = _totalSum;
    }

}