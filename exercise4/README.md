# Exercise 4: Adding tokens to your wallet

In this exercise you will be adding ERC-20 tokens to your MetaMask wallet.

We will be using two different ones:

* **USD Coin**: A very famous stablecoin linked to the US dollar
* **EDEM TOKEN**: A simple custom token created for testing purposes
  * More info here: https://testnet.snowtrace.io/address/0xDf809526C13Be13777C53B0CCBdF61c819a5f1C4
  * Find the Solidity code down below.
  * You can find its ABI in the abi.json file in this folder.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EDEMToken is ERC20 {
    uint256 public constant tokenPrice = 1000 wei;  // Precio por token en AVAX
    uint256 public constant tokensPerAVAX = 1 ether / tokenPrice; 
    address private _owner;

    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
        _owner = msg.sender;
    }

    function buyTokens() public payable {
        require(msg.value > 0, "Send AVAX to buy tokens");
        uint256 amountToBuy = msg.value * tokensPerAVAX / 1 ether;
        _mint(msg.sender, amountToBuy);
    }

    function withdrawAVAX(address payable to) public {
        require(msg.sender == _owner, "Only owner can withdraw AVAX");
        to.transfer(address(this).balance);
    }

    // Considera añadir una función para cambiar el propietario
    function transferOwnership(address newOwner) public {
        require(msg.sender == _owner, "Only owner can transfer ownership");
        require(newOwner != address(0), "New owner cannot be the zero address");
        _owner = newOwner;
    }

    // Función para ver quién es el propietario actual
    function owner() public view returns (address) {
        return _owner;
    }
}

```

## Instructions

If you open MetaMask you will currently only see the amount of Ether that you have, but the wallet is also able to track ERC-20 tokens.
Let's add some GFT Test Tokens":

* Open MetaMask
* Click on "Add token" (or "Agregar token" in Spanish)
* Look for USDC (ticker for USD Coin) and click "Next"

Now you know how many USDT you have. That is... 0!!

We are now going to add some custom tokens with which we can play around:

* Open MetaMask
* Click on "Add token" (or "Agregar token" in Spanish)
* Change to the "Personalized token" tab and add the following token address: **0xDf809526C13Be13777C53B0CCBdF61c819a5f1C4**
* This will add the rest of the info and you can click on "Next"