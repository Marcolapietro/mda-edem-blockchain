# Exercise 5: Smart Contract Storage with Mappings, Modifiers, and Events

In this exercise you will **create and evolve a smart contract** that demonstrates key Solidity concepts like mappings, modifiers, events, and access control using [**Remix**](https://remix.ethereum.org/).

You'll start with a simple storage contract and progressively enhance it to support:
- Individual user storage (using mappings)
- Owner-based access control
- Input validation with modifiers
- Event emissions for transparency
- Owner privileges to manage user data

This exercise reinforces fundamental blockchain patterns used in real-world DeFi, NFT, and DAO applications!

## What You'll Learn

- Using **mappings** for user-specific data storage
- Creating and applying **modifiers** for validation and access control
- Emitting **events** for off-chain monitoring
- Implementing **constructor** initialization
- Managing **owner** privileges
- Writing more complex Solidity functions

## The Challenge

You will transform a basic storage contract into a multi-user system with the following requirements:

### Requirements

1. **Individual User Storage**: The contract currently stores a single global number. Modify it so each user can store their own number without overwriting others (Hint: define a mapping)

2. **Owner Management**: Define a global variable to store the contract owner and initialize it in the constructor. The owner will be whoever deploys the contract (msg.sender)

3. **Create 2 Modifiers**:
   - To prevent storing the number 0
   - To ensure only the owner can modify certain data

4. **Create 2 Events**:
   - When a user stores a number
   - When the owner changes a value on behalf of another user

5. **Update `store` Function**: Change the logic so it stores a number for each specific user instead of a global number. It must not allow storing 0. Emit an event.

6. **Update `retrieve` Function**: Adjust it to return the number stored by a specific user instead of a global value.

7. **New `storeForUser` Function**: Implement a function that allows the owner to assign values to other users. It must not allow storing 0. Emit an event.

## Part A: Understanding the Initial Contract

Here's the simple storage contract you'll start with:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    uint256 public number;

    function store(uint256 num) public {
        number = num;
    }

    function retrieve() public view returns (uint256) {
        return number;
    }
}
```

**Current Behavior:**
- Only stores ONE global number
- Anyone can overwrite it
- No validation
- No events
- No access control

## Part B: Development - Build the Enhanced Contract

1. Go to [Remix IDE](https://remix.ethereum.org/)
2. Create a new file named `Storage.sol`
3. Start with the simple contract above
4. Implement the requirements step by step

### Step-by-Step Implementation Guide

#### Step 1: Add Owner and Constructor

```solidity
address public owner;

constructor() {
    owner = msg.sender;
}
```

#### Step 2: Create the Mapping for User Storage

```solidity
mapping(address => uint256) private userNumbers;
```

#### Step 3: Define the Modifiers

Create two modifiers:
- `notZero(uint256 _num)` - Rejects if the number is 0
- `onlyOwner()` - Restricts function to the contract owner

```solidity
modifier notZero(uint256 _num) {
    require(_num != 0, "Cannot store zero");
    _;
}

modifier onlyOwner() {
    require(msg.sender == owner, "Only owner can call this function");
    _;
}
```

#### Step 4: Define the Events

```solidity
event NumberStored(address indexed user, uint256 number);
event OwnerUpdatedUser(address indexed targetUser, uint256 number, address indexed owner);
```

#### Step 5: Update the `store` Function

Modify it to:
- Store the number for `msg.sender` in the mapping
- Use the `notZero` modifier
- Emit the `NumberStored` event

```solidity
function store(uint256 num) public notZero(num) {
    userNumbers[msg.sender] = num;
    emit NumberStored(msg.sender, num);
}
```

#### Step 6: Update the `retrieve` Function

Change it to accept a user address parameter and return that user's stored number:

```solidity
function retrieve(address user) public view returns (uint256) {
    return userNumbers[user];
}
```

#### Step 7: Create the `storeForUser` Function

This function allows the owner to set values for other users:

```solidity
function storeForUser(address user, uint256 num) public onlyOwner notZero(num) {
    userNumbers[user] = num;
    emit OwnerUpdatedUser(user, num, msg.sender);
}
```

### Complete Contract Solution

Here's what your final contract should look like:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Storage {
    address public owner;
    mapping(address => uint256) private userNumbers;

    // Events
    event NumberStored(address indexed user, uint256 number);
    event OwnerUpdatedUser(address indexed targetUser, uint256 number, address indexed owner);

    // Modifiers
    modifier notZero(uint256 _num) {
        require(_num != 0, "Cannot store zero");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    // Constructor
    constructor() {
        owner = msg.sender;
    }

    // Store a number for the caller
    function store(uint256 num) public notZero(num) {
        userNumbers[msg.sender] = num;
        emit NumberStored(msg.sender, num);
    }

    // Retrieve the number stored by a specific user
    function retrieve(address user) public view returns (uint256) {
        return userNumbers[user];
    }

    // Owner can store a number for any user
    function storeForUser(address user, uint256 num) public onlyOwner notZero(num) {
        userNumbers[user] = num;
        emit OwnerUpdatedUser(user, num, msg.sender);
    }
}
```

## Part C: Compilation

1. Click on the "**Solidity Compiler**" tab (left sidebar)
2. Set compiler version to `0.8.0` or higher
3. Click "**Compile Storage.sol**"
4. Verify you see a green checkmark ✓

## Part D: Testing Locally

Let's test the contract functionality in the Remix JavaScript VM:

1. Click on the "**Deploy & run transactions**" tab
2. Select "**JavaScript VM (London)**" as environment
3. Click "**Deploy**"
4. Expand your deployed contract

### Test Scenarios

**Test 1: Store Your Own Number**

1. Use the `store` function with a value (e.g., 42)
2. Click "transact"
3. Copy your address from the "Account" dropdown
4. Use `retrieve` with your address to verify the stored value

**Test 2: Try to Store Zero (Should Fail)**

1. Use `store` with value `0`
2. Click "transact"
3. You should see an error: "Cannot store zero"

**Test 3: Multiple Users Store Different Values**

1. Note the current account address and store a number (e.g., 100)
2. Switch to a different account in the "Account" dropdown
3. Store a different number (e.g., 200)
4. Use `retrieve` for each address - verify each user has their own number!

**Test 4: Owner Stores for Another User**

1. Make sure you're using the **first account** (the owner/deployer)
2. Copy a different account address
3. Use `storeForUser`:
   - `user`: paste the other address
   - `num`: enter a value (e.g., 777)
4. Click "transact"
5. Verify with `retrieve` that the value was set

**Test 5: Non-Owner Tries to Use `storeForUser` (Should Fail)**

1. Switch to a **different account** (not the owner)
2. Try to use `storeForUser` with any address and number
3. You should see error: "Only owner can call this function"

**Test 6: Check Events**

1. After calling `store` or `storeForUser`, click on the transaction in the console
2. Expand the "logs" section
3. You should see the emitted events with the user address and number!

## Part E: Deploy to Sepolia Testnet

Now let's deploy to the real blockchain:

### Pre-deployment Checklist:

✅ MetaMask installed and connected to Sepolia
✅ You have test ETH from a faucet
✅ Contract compiles successfully
✅ You've tested locally

### Deployment Steps:

1. In "**Deploy & run transactions**" tab
2. Change environment to "**Injected Provider - MetaMask**"
3. Connect MetaMask and verify you're on **Sepolia**
4. Click "**Deploy**"
5. Confirm the transaction in MetaMask
6. Wait for confirmation (~15 seconds)
7. **Save your contract address!**

## Part F: Verify on Etherscan

1. Go to https://sepolia.etherscan.io/
2. Search for your contract address
3. Click "**Contract**" tab → "**Verify and Publish**"
4. Fill in:
   - Compiler Type: Solidity (Single file)
   - Compiler Version: v0.8.0 (or your version)
   - License: MIT
5. Paste your complete Solidity code
6. Click "Verify and Publish"

## Part G: Interact with Your Deployed Contract

### On Etherscan:

1. Go to your verified contract
2. Click "**Write Contract**"
3. Connect your MetaMask wallet
4. Test the functions:
   - Store your number with `store`
   - Check the "**Events**" tab to see your emitted events
   - Use `retrieve` in the "**Read Contract**" tab
   - If you're the owner, try `storeForUser`

### Share with Classmates:

- Have classmates connect their wallets
- Each stores their own number
- View each other's stored values using `retrieve`
- Only the owner (you) can use `storeForUser`

## Part H: Understanding What You Built

### Key Concepts Learned:

**Mappings**: Efficient key-value storage for user-specific data
```solidity
mapping(address => uint256) private userNumbers;
```

**Modifiers**: Reusable validation and access control logic
```solidity
modifier notZero(uint256 _num) { ... }
modifier onlyOwner() { ... }
```

**Events**: Off-chain logging for indexing and monitoring
```solidity
event NumberStored(address indexed user, uint256 number);
```

**Constructor**: One-time initialization when contract is deployed
```solidity
constructor() { owner = msg.sender; }
```

**Access Control**: Restricting functions to specific addresses

### Real-World Applications:

These patterns are used in:
- **ERC-20 Tokens**: Mapping addresses to balances
- **NFT Marketplaces**: User-specific listings and offers
- **DeFi Protocols**: User deposits and collateral tracking
- **DAO Systems**: Voting power and membership management
- **Staking Contracts**: User stake amounts and rewards

## Challenge Extensions

Want to take it further? Try implementing:

1. **Add a getter for current user**: Create `retrieveMine()` that returns `userNumbers[msg.sender]`
2. **History tracking**: Store an array of historical values for each user
3. **Transfer function**: Allow users to transfer their stored number to another address
4. **Batch operations**: Let owner update multiple users at once
5. **Pause mechanism**: Add a modifier to pause/unpause the contract
6. **Maximum value**: Add a modifier to enforce a maximum storable value

## Function Reference

### Read Functions (Blue - Free, no gas)

- `owner()` → Returns the contract owner address
- `retrieve(address user)` → Returns the number stored by `user`

### Write Functions (Orange - Costs gas)

- `store(uint256 num)` → Store `num` for yourself (cannot be 0)
- `storeForUser(address user, uint256 num)` → (Owner only) Store `num` for `user`

### Events

- `NumberStored(address user, uint256 number)` → Emitted when a user stores a number
- `OwnerUpdatedUser(address targetUser, uint256 number, address owner)` → Emitted when owner updates a user's number

Congratulations! You've mastered essential Solidity patterns: mappings, modifiers, events, and access control! 🚀
