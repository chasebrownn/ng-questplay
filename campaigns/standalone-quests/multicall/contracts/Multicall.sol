// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

abstract contract Multicall {

    /**
     * @dev Executes a batch of function calls on this contract.
     * @param calls The sequence of ABI calldata of the transactions to forward to this contract.
     *
     * @return results Returns array of call results represented as bytes.
     */
    function multicall(bytes[] calldata calls) external virtual returns (bytes[] memory results) {
        uint256 length = calls.length;
        results = new bytes[](length);

        for (uint256 i; i < length;) {

            (bool success, bytes memory result) = address(this).delegatecall(calls[i]);

            require(success, "Call failed!");
            results[i] = result;

            unchecked {
                ++i;
            }
        }

        return results;
    }

}
