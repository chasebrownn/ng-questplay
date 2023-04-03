// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract WizardTower is VRFConsumerBaseV2 {

    address private constant COORDINATOR = 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D;
    
    uint32 public floorsClimbed;

    constructor() VRFConsumerBaseV2(COORDINATOR) {
        floorsClimbed = 8;
    }

    function climb(
        bytes32 step1, // 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15  <- key hash
        uint64 step2,  // 11108  <- subscription ID
        uint16 step3,  // 20     <- num blocks to confirm
        uint32 step4,  // 50000  <- gas limt
        uint32 step5   // 8      <- num of words requested
    ) external {
        VRFCoordinatorV2Interface(COORDINATOR).requestRandomWords(
            step1,
            step2,
            step3,
            step4,
            step5
        );
    }

    function fulfillRandomWords(
        uint256, /* requestId */
        uint256[] memory randomWords
    ) internal override {
        floorsClimbed = uint32(randomWords.length);
    }

}

// Deployed to: 0xa57464ad90d32f6aF52e44C62D7f586Aecb17833