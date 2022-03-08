//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.1;

import "./Ownable.sol";
import "hardhat/console.sol";

contract HelloWorld is Ownable {
    mapping(address => Message) blockgameMessages;
    Message[] blockgameMessagesArray;
    address blockGamesAddress;
    uint256 blockgameMessageCount;
    event NewMessage(address _address, string message, uint256 messageIndex);
    struct Message {
        string Message;
        uint256 CreateAt;
    }

    constructor() {}

    function sendBlockGameMessage(string memory message) external {
        console.log("%s is sending blockgames a message.", msg.sender);
        bytes memory messageByte = bytes(message);
        require(messageByte.length > 0, "Message cannot be empty.");
        blockgameMessagesArray.push(Message(message, block.timestamp));
        blockgameMessages[msg.sender] = Message(message, block.timestamp);
        emit NewMessage(msg.sender, message, blockgameMessageCount);
    }

    function getBlockgameMessage() public view returns (Message memory) {
        console.log("getter address: %s", msg.sender);
        return blockgameMessages[msg.sender];
    }

    function setBlockGameAddress(address _address) external onlyOwner {
        blockGamesAddress = _address;
    }

    function readMessages() public view returns (Message[] memory) {
        require(
            msg.sender == blockGamesAddress,
            "Only blockgames can read messages."
        );
        return blockgameMessagesArray;
    }
}
