// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SafeMath {

    /// @notice Returns a + b.
    /// @dev Reverts on overflow / underflow.
    function add( int256 a, int256 b) public pure returns (int256 result) {
        assembly {
            let success := false
            result := add(a, b)

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
        assembly {
            let success := false

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
        assembly {
            let success := false

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
        assembly {
            let success := false
            let neg_one := sub(0, 1)
            let min := exp(sub(0, 2), 255)

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
