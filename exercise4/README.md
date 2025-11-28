# Exercise 4: Creating and Using ERC-20 Tokens

In this exercise you will learn how to **create your own ERC-20 token**, deploy it to Sepolia testnet, and interact with it using MetaMask and Etherscan.

## What is an ERC-20 Token?

ERC-20 is the standard for fungible tokens on Ethereum. Examples include:
- USDC, USDT (stablecoins)
- LINK, UNI (DeFi tokens)
- Most cryptocurrencies you see on exchanges

## Your Token: EDEM TOKEN

You'll create **EDEMToken (MTK)** - a custom ERC-20 token with special features:
- Initial supply of 1,000,000 tokens
- Ability to buy tokens with ETH at a fixed price
- Owner can withdraw collected ETH
- Built using OpenZeppelin's secure, audited code

The Solidity code is provided below, and you can find its ABI in the `abi.json` file in this folder.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EDEMToken is ERC20 {
    uint256 public constant tokenPrice = 1000 wei;  // Price per token in ETH
    uint256 public constant tokensPerETH = 1 ether / tokenPrice;
    address private _owner;

    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
        _owner = msg.sender;
    }

    function buyTokens() public payable {
        require(msg.value > 0, "Send ETH to buy tokens");
        uint256 amountToBuy = msg.value * tokensPerETH / 1 ether;
        _mint(msg.sender, amountToBuy);
    }

    function withdrawETH(address payable to) public {
        require(msg.sender == _owner, "Only owner can withdraw ETH");
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

**Important**: Make sure MetaMask is connected to the Sepolia Test Network before starting.

### Step 1: Deploy Your Token Contract
1. Copy the contract code above into Remix IDE
2. Compile with Solidity ^0.8.20
3. Deploy to Sepolia testnet using Injected Provider - MetaMask (see Exercise 3)
4. **Save your deployed contract address** - you'll need it!
5. Congratulations! You just created your own cryptocurrency! 🎉

### Step 2: Add Your Token to MetaMask
1. Open MetaMask
2. Click on "Import tokens" (or "Importar tokens" in Spanish)
3. Switch to the "Custom token" tab
4. Paste your deployed contract address
5. The token symbol (MTK) and decimals should auto-populate
6. Click "Add Custom Token" then "Import Tokens"
7. You should now see your token balance! (You start with 1,000,000 MTK as the creator)

### Step 3: Verify Your Contract on Etherscan

To interact with your token through Etherscan:

1. Go to https://sepolia.etherscan.io/
2. Search for your contract address
3. Click "Verify and Publish" (see Exercise 3 for details)
4. Use compiler version ^0.8.20 and include the OpenZeppelin import

### Step 4: Test the Buy Function (Optional)
Let someone else buy tokens from you!

1. Go to your contract on Etherscan
2. Click "Write Contract" tab
3. Connect with MetaMask
4. Find the `buyTokens()` function
5. Enter amount of ETH to spend (e.g., 0.001 in the payableAmount field)
6. Click "Write" and confirm
7. Tokens will be minted and sent to the buyer
8. Check the new balance in MetaMask!

**Token Economics:**
- Price: 1000 wei per token
- Rate: 1,000,000,000,000,000 tokens per 1 ETH
- Example: 0.001 ETH = 1,000,000,000,000 tokens

### Step 5: Explore Token Functions

Try these functions on Etherscan:

**Read Functions (Free):**
- `name()` - See your token name
- `symbol()` - See your token symbol
- `totalSupply()` - See how many tokens exist
- `balanceOf(address)` - Check any address's balance
- `owner()` - See who owns the contract

**Write Functions (Cost Gas):**
- `transfer(to, amount)` - Send tokens to someone
- `approve(spender, amount)` - Allow someone to spend your tokens
- `buyTokens()` - Buy tokens with ETH
- `withdrawETH(address)` - Owner withdraws collected ETH
- `transferOwnership(newOwner)` - Transfer contract ownership

### Step 6: Challenge - Create a Token Economy

1. Ask a classmate for their wallet address
2. Transfer some tokens to them using `transfer()`
3. Have them buy tokens using `buyTokens()`
4. As the owner, withdraw the ETH using `withdrawETH()`
5. Check the `totalSupply()` - it should increase when tokens are bought!

## What You Learned

✅ How to create an ERC-20 token using OpenZeppelin
✅ How to deploy a token contract
✅ How to add custom tokens to MetaMask
✅ How to interact with token functions
✅ Understanding token economics (price, supply, minting)
✅ Owner privileges in smart contracts

## Key Concepts

- **ERC-20**: The standard interface for fungible tokens
- **Minting**: Creating new tokens (happens in constructor and buyTokens)
- **OpenZeppelin**: Industry-standard, audited smart contract library
- **Payable functions**: Functions that can receive ETH
- **Owner privileges**: Certain functions only the contract owner can call