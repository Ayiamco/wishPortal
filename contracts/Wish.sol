//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Wish {
    mapping(address => UserWish[]) privateWishes;
    UserWish[] publicWishes;
    mapping(address => uint256) lastUpdated;
    uint256 randomSeed;

    struct UserWish {
        string wish;
        uint32 timeStamp;
        uint16 isPrivate;
    }

    constructor() {
        randomSeed = block.timestamp % 100;
    }

    function makeWish(string memory _wish, bool _isPrivate) external {
        if (_isPrivate) {
            privateWishes[msg.sender].push(
                UserWish(_wish, uint32(block.timestamp), 1)
            );
        } else {
            console.log("current randomSeed: %d. ", randomSeed);
            if (randomSeed > 60) {
                console.log("updating publicWishes with seed...");
                publicWishes.push(UserWish(_wish, uint32(block.timestamp), 0));
            }
        }
        randomSeed = (randomSeed + block.timestamp) % 100;
    }

    function getPrivateWishes() external view returns (UserWish[] memory) {
        console.log(
            "Current private wish count: %d",
            privateWishes[msg.sender].length
        );
        return privateWishes[msg.sender];
    }

    function getPublicWishes() external view returns (UserWish[] memory) {
        console.log("Current public wish count: %d", publicWishes.length);
        return publicWishes;
    }
}
