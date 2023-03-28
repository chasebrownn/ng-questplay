// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract UpgradeableMechSuit {

    address public implementation;
    
    /// @notice Constructs the contract
    /// @param _implementation Address of logic contract to be linked
    constructor(address _implementation) {
        implementation = _implementation;
    }

    /// @notice Upgrades contract by updating the linked logic contract
    /// @param _implementation Address of new logic contract to be linked
    function upgradeTo(address _implementation) external {
        implementation = _implementation;
    }

    fallback() external {
        assembly {
            let ptr := mload(0x40)

            // (1) copy incoming calldata into memory
            calldatacopy(ptr, 0, calldatasize())

            // (2) forward call to implementation contract
            let result := delegatecall(gas(), _impl, ptr, calldatasize(), 0, 0)
            let size := returndatasize()

            // (3) retrieve return data
            returndatacopy(ptr, 0, size)

            // (4) forward return data back to caller
            switch result
            case 0 { revert(ptr, size) }  // Revert if call failed
            default { return(ptr, size) } // Return if call succeeded
        }
    }

}