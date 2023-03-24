// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

// MODIFY CODE
contract SimpleGameV2 {
    bool public isFinished;
    uint256 lastDepositedBlock;
    uint256 deposited;

    function totalDeposit() external view returns (uint256) {
        return address(this).balance;
    }

    function deposit() public payable {
        require(msg.value == 0.1 ether, "Must deposit 0.1 Ether");
        require(!isFinished, "The game is over");
        require(
            lastDepositedBlock != block.number,
            "Only can deposit once per block"
        );

        deposited += 0.1 ether;

        lastDepositedBlock = block.number;
    }

    function claim() public {
        require(deposited >= 1 ether, "Condition not satisfied");

        payable(msg.sender).transfer(deposited);
        deposited = 0;
        isFinished = true;
    }
}
