// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract If {
    
    /// @notice Converts minutes to hours. 
    /// Reverts if _minutes is negative or not divisible by 60.
    /// @param _minutes the number of minutes to convert to hours.
    /// @return _hours the number of hours represented by _minutes.
    function minutesToHours(int256 _minutes) public pure returns (uint256 _hours) {
        assembly {

            // if _minutes < 0 || if _minutes is not divisible by 60
            if or(slt(_minutes, 0), sgt(mod(_minutes, 60), 0)) {
                revert(0,0)
            }

            _hours := div(_minutes, 60)
        }
    }
}
