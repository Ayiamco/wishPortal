//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Wish {
    mapping(address => UserWish[]) privateWishes;
    UserWish[] publicWishes;
    mapping(address => uint256) lastWishTime;

    uint256 randomSeed;
    event NewWish(
        address _address,
        string wish,
        uint32 timeStamp,
        uint16 _isPrivate
    );

    struct UserWish {
        string wish;
        uint32 timeStamp;
        uint16 isPrivate;
        address from;
    }

    constructor() payable {
        randomSeed = block.timestamp % 100;
    }

    function makeWish(string memory _wish, bool _isPrivate) external {
        console.log(
            "%s last update time: %d ",
            msg.sender,
            lastWishTime[msg.sender]
        );

        require(
            block.timestamp - lastWishTime[msg.sender] > 1 minutes ||
                lastWishTime[msg.sender] == 0,
            "Trial less than wait time of 1 minute"
        );
        if (_isPrivate) {
            privateWishes[msg.sender].push(
                UserWish(_wish, uint32(block.timestamp), 1, msg.sender)
            );
            lastWishTime[msg.sender] = block.timestamp;
        } else {
            console.log("current randomSeed: %d. ", randomSeed);
            if (randomSeed > 60) {
                console.log("updating publicWishes with seed...");
                publicWishes.push(
                    UserWish(_wish, uint32(block.timestamp), 0, msg.sender)
                );
                lastWishTime[msg.sender] = block.timestamp;
            }
        }
        randomSeed = (randomSeed + block.timestamp) % 100;

        emit NewWish(
            msg.sender,
            _wish,
            uint32(block.timestamp),
            _isPrivate ? 1 : 0
        );
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
