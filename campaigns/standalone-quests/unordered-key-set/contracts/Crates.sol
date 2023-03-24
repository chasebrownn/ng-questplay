// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import './interfaces/ICrates.sol';

contract Crates is ICrates {

    struct Crate {
        uint index;
        uint size;
        uint strength;
    }

    mapping(uint => Crate) private crates;
    uint[] private crateIds;

    /// @notice Inserts a crate into the contract. Fails if id belongs to an existing crate.
    function insertCrate(uint id, uint size, uint strength) external {
        require(!_isCrate(id));

        crates[id].index = crateIds.length;
        crates[id].size = size;
        crates[id].strength = strength;
        crateIds.push(id);
    }

    /// @notice Retrieves a crate based on id. Fails if id does not belong to an existing crate.
    function getCrate(uint id) external view returns (uint size, uint strength) {
        require(_isCrate(id));

        size = crates[id].size;
        strength = crates[id].strength;
    }

    /// @notice Retrieve the IDs of all existing crates.
    function getCrateIds() external view returns (uint[] memory) {
        return crateIds;
    }

    /// @notice Delete a crate by id. Fails if id doesn't belong to an existing crate.
    function deleteCrate(uint id) external {
        require(_isCrate(id));

        uint where = crates[id].index;
        uint length = crateIds.length;

        crates[id].index = where;
        crateIds[where] = crateIds[length - 1];
        crateIds.pop();
    }

    function _isCrate(uint id) internal view returns (bool) {
        if (crateIds.length == 0) return false;
        return crateIds[crates[id].index] == id;
    }
}