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

    fallback() external {}

}