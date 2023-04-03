// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract Mind {

    address immutable thisContract;

    /// @notice This could be useful...
    constructor() {
        thisContract = address(this);
    }

    /// @notice Checks if the current call is a delegate call.
    /// @return isDelegate true if this is a delegate call, false otherwise.
    function isDelegateCall() public view returns (bool isDelegate) {
        address(this) == thisContract ? 
            isDelegate = false : // if match, direct call
            isDelegate = true ;  // if no match, delegate call

    }
}
