# Exercise 2: Interacting with Existing Smart Contracts

In this exercise, you will learn how to **interact with already deployed smart contracts** on the Sepolia testnet using **Etherscan**. This is a crucial skill because in the real world, you'll often need to interact with existing contracts (DeFi protocols, NFT marketplaces, DAOs, etc.) without deploying your own.

## Why This Matters

Most blockchain interaction involves using existing contracts:
- Trading tokens on Uniswap
- Buying NFTs on OpenSea
- Participating in DAO governance
- Staking tokens in DeFi protocols

Learning to interact with existing contracts is **fundamental** to Web3 development.

## Part A: Exploring Verified Contracts on Etherscan

Let's start by exploring the Sepolia testnet:

1. Go to [Sepolia Etherscan - Verified Contracts](https://sepolia.etherscan.io/contractsVerified)
2. Browse through the list of verified contracts
3. Notice different types: ERC20 tokens, ERC721 NFTs, and custom contracts
4. Click on any contract to see its details

## Part B: Interacting with WETH (Wrapped ETH)

WETH is one of the most important contracts in Ethereum. It "wraps" ETH into an ERC20 token, making it compatible with DeFi protocols.

### **Contract Details**
- **Address**: `0xfFf9976782d46CC05630D1f6eBAb18b2324d6B14`
- **What it does**: Converts ETH ↔ WETH (Wrapped ETH)
- **Network**: Sepolia Testnet

### **Step 1: View the Contract**

1. Go to: https://sepolia.etherscan.io/address/0xfFf9976782d46CC05630D1f6eBAb18b2324d6B14
2. Click on the **"Contract"** tab
3. Explore the source code - see how a real production contract is written
4. Notice it's verified ✓ (green checkmark)

### **Step 2: Read Contract Data (Free)**

1. Click on **"Read Contract"** tab
2. Try these functions:
   - **name**: Returns "Wrapped Ether"
   - **symbol**: Returns "WETH"
   - **decimals**: Returns 18
   - **totalSupply**: See how much WETH exists
   - **balanceOf**: Enter your wallet address to see your WETH balance

> No MetaMask connection needed for reading!

### **Step 3: Write to the Contract (Costs Gas)**

Now let's deposit some test ETH and get WETH:

1. Click on **"Write Contract"** tab
2. Click **"Connect to Web3"** - approve MetaMask connection
3. Find the **deposit** function
4. Enter amount in ETH (e.g., `0.01` = 0.01 ETH)
5. Click **"Write"**
6. Confirm the transaction in MetaMask
7. Wait for confirmation (~15 seconds)

### **Step 4: Verify Your WETH Balance**

1. Go back to **"Read Contract"** tab
2. Use **balanceOf** with your wallet address
3. You should see your WETH balance (in wei, so 0.01 ETH = 10000000000000000)
4. Check MetaMask - you might need to import WETH token to see it:
   - Click "Import tokens"
   - Paste WETH address: `0xfFf9976782d46CC05630D1f6eBAb18b2324d6B14`

### **Step 5: Withdraw Your WETH (Optional)**

1. In **"Write Contract"** tab
2. Find the **withdraw** function
3. Enter amount in wei (use the amount you deposited)
4. Click "Write" and confirm
5. Your WETH converts back to ETH!

## Part C: Understanding Read vs Write Functions

What you just learned:

### **Read Functions** (view/pure):
- ✅ Free to call - no gas required
- ✅ Don't change blockchain state
- ✅ Return data immediately
- ✅ No MetaMask connection needed
- Examples: `name()`, `symbol()`, `balanceOf()`

### **Write Functions**:
- 💰 Cost gas (test ETH in this case)
- 📝 Change blockchain state
- ⏱️ Require MetaMask confirmation
- ⛓️ Create transactions on the blockchain
- Examples: `deposit()`, `withdraw()`, `transfer()`

## Part D: Explore More Contracts

Now try exploring other contracts on Sepolia:

1. Go to [Sepolia Verified Contracts](https://sepolia.etherscan.io/contractsVerified)
2. Find an ERC-20 token contract
3. Read its `name`, `symbol`, and your `balanceOf`
4. Find an ERC-721 (NFT) contract
5. Explore its functions

## Part E: Understanding What You Can Do

With Etherscan, you can:
- ✅ Read any public data from any contract
- ✅ Call write functions if you meet the requirements
- ✅ See transaction history
- ✅ View contract source code (if verified)
- ✅ Track events emitted by contracts

## Challenge: Find and Interact with a Token

1. Search for "Sepolia faucet token" or "test token" on Etherscan
2. Find a verified ERC-20 token contract
3. Check if it has a `mint()` or `faucet()` function
4. Try to get some tokens for yourself
5. Check your balance using `balanceOf()`

## Key Takeaways

- Most Web3 interaction is with **existing contracts**, not deploying new ones
- Etherscan is the **industry standard** for contract interaction
- **Read functions are free**, write functions cost gas
- You can interact with **any verified contract** without writing code
- Understanding contract ABIs and functions is essential for Web3 development

## What's Next?

In **Exercise 3**, you'll learn how to **create and deploy your own** smart contracts using Remix IDE. But remember - most of your time in Web3 will be spent interacting with existing contracts like you just did!