//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Ayiamco is ERC20 {
    event Received(address, uint256);
    uint256 private tokenPrice;

    constructor() ERC20("Ayiamco", "AYC") {
        _mint(msg.sender, 1000000);
        tokenPrice = 1 ether / 1000; //token sold at 1000 Tokens per ETH
    }

    function buyToken(address receiver) public payable {
        uint256 amtPaid = msg.value;
        transfer(receiver, amtPaid / tokenPrice);
    }

    // Function that allows you to convert an address into a payable address
    function makePayable(address x) internal pure returns (address payable) {
        return payable(x);
    }
}
