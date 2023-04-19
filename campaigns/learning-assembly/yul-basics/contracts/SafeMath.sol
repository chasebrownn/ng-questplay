// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SafeMath {

    int256 constant private _INT256_MIN = -2**255;

    /// @notice Returns a + b.
    /// @dev Reverts on overflow / underflow.
    function add( int256 a, int256 b) public pure returns (int256 result) {
        bool success;
        assembly {
            result := add(a, b)
            // ( c < a || c < b)
            // if or(slt(result, a), slt(result, b)) {
            //     revert(0, 0)
            // }
            if or(and(or(sgt(b, 0), eq(b, 0)), or(sgt(result, a), eq(result, a))), and(slt(b, 0), slt(result, a))) {
                success := true
            }

            // require(success)
            if eq(success, false) {
                revert(0,0)
            }

        }
    }

    /// @notice Returns a - b.
    /// @dev Reverts on overflow / underflow.
    function sub(int256 a, int256 b) public pure returns (int256 result) {
        bool success;
        assembly {
            result := sub(a, b)

            // (b >= 0 && c <= a) || (b < 0 && c > a)
            if or(and(or(sgt(b, 0), eq(b, 0)), or(slt(result, a), eq(result, a))), and(slt(b, 0), sgt(result, a))) {
                success := true
            }

            // require(success)
            if eq(success, false) {
                revert(0,0)
            }
        }
    }

    /// @notice Returns a * b.
    /// @dev Reverts on overflow / underflow.
    function mul(int256 a, int256 b) public pure returns (int256 result) {
        bool success;
        assembly {
            result := mul(a, b)

            // (c / a) == b
            if eq(sdiv(result, a), b) {
                success := true
            }

            // require(success)
            if eq(success, false) {
                revert(0,0)
            }
        }
    }

    /// @notice Returns a / b.
    /// @dev Reverts on overflow / underflow.
    function div(int256 a, int256 b) public pure returns (int256 result) {
        bool success;
        int256 neg_one = -1;
        int256 min = _INT256_MIN;
        assembly {
            if or(sgt(b, 0), slt(b, 0)) {
                result := sdiv(a, b)

                if eq(mul(result, b), a) {
                    success := true
                }
                if and(eq(b, neg_one), eq(a, min)) {
                    success := false
                }
            }
            // require(success)
            if eq(success, false) {
                revert(0,0)
            }
        }
    }
}
