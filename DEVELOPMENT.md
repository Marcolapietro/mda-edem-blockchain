# Development Guide

This file provides guidance for developers and AI assistants when working with code in this repository.

## Repository Overview

This is an educational blockchain repository for EDEM's "Blockchain & Cryptocurrencies" masters course. It contains hands-on exercises for learning Ethereum smart contract development, wallet management, and blockchain interactions on the Sepolia testnet.

## Project Structure

The repository is organized into sequential exercises:

- **exercise1/**: Ethereum wallet setup using MetaMask on Sepolia testnet
- **exercise2/**: Interacting with EXISTING deployed smart contracts using Etherscan
  - Focuses on using Etherscan to interact with real, already-deployed contracts
  - Primary example: WETH (Wrapped ETH) contract - deposit/withdraw functionality
  - Teaches how to read contract data (free) vs write functions (costs gas)
  - Explores verified contracts on Sepolia
  - No deployment required - students interact with production contracts
- **exercise3/**: Creating, testing, and deploying YOUR OWN smart contracts using Remix IDE
  - Build a complete Voting System smart contract
  - Contains `Votacion.sol` - voting contract with candidate registration, voting, and winner determination
  - `Voting.md` provides complete function documentation
  - Demonstrates the full lifecycle: development, compilation, testing (JavaScript VM), and deployment (Injected Provider - MetaMask)
  - Includes verification on Etherscan and real classroom interaction challenge
- **exercise4/**: Working with ERC-20 tokens in MetaMask
  - Includes custom EDEMToken contract with token purchasing functionality
  - `abi.json` contains the token contract ABI
  - Contract needs to be deployed to Sepolia testnet
- **exercise5/**: Reference list of blockchain development tools and platforms

## Blockchain Environment

- **Primary Network**: Ethereum Sepolia Testnet
- **Explorer**: https://sepolia.etherscan.io/
- **Wallet**: MetaMask browser extension
- **Contract Interaction**:
  - Etherscan's Read/Write Contract interface (primary method)
  - Remix IDE deployed contracts panel (alternative)
- **Development IDE**: Remix (https://remix.ethereum.org/)
- **Solidity Version**: ^0.8.0 and ^0.8.20
- **Contract Verification**: Etherscan verify and publish feature
- **Faucets** (for test ETH):
  - https://sepoliafaucet.com/ (requires Alchemy account)
  - https://www.infura.io/faucet/sepolia (requires Infura account)
  - https://sepolia-faucet.pk910.de/ (PoW faucet, no account needed)

## Key Smart Contracts

### Votacion Contract (exercise2/Votacion.sol)
A modernized voting system (refactored to Solidity ^0.8.0) with the following functionality:
- `representar(string _nombrePersona, uint _edadPersona, string _idPersona)`: Register as a candidate with hashed credentials (prevents duplicate registrations)
- `verCandidatos()`: View all registered candidates
- `votar(string _candidato)`: Cast a vote (one vote per address, tracked via mapping)
- `verVotos(string _candidato)`: View votes for a specific candidate
- `verResultados()`: View full results as structured arrays (owner only, requires `soloOwner` modifier)
- `ganador()`: Determine the winner or detect ties

**Implementation notes**:
- Uses mapping-based tracking (`yaHaVotado`, `yaSeHaPresentado`, `esCandidato`) for gas efficiency
- Prevents duplicate candidate registrations from the same address
- Modern function naming (camelCase instead of PascalCase)

**Deployment status**: Contract needs to be deployed to Sepolia testnet by students during the exercises.

### EDEMToken Contract (exercise4/)
An ERC-20 token (inherits from OpenZeppelin's ERC20) with custom functionality:
- **Token details**: Name "MyToken", Symbol "MTK", initial supply of 1,000,000 tokens
- `buyTokens()`: Payable function to purchase tokens with ETH at fixed price (1000 wei per token)
- `withdrawETH(address payable to)`: Owner can withdraw accumulated ETH from sales
- `transferOwnership(address newOwner)`: Transfer contract ownership
- `owner()`: View current contract owner
- Standard ERC20 functions: `transfer()`, `approve()`, `transferFrom()`, `balanceOf()`, `allowance()`, etc.

**Constants**:
- `tokenPrice`: 1000 wei
- `tokensPerETH`: Calculated rate based on token price (1 ether / 1000 wei = 1,000,000,000,000,000 tokens per ETH)

**Deployment status**: Contract needs to be deployed to Sepolia testnet by students during the exercises.
ABI available in: exercise4/abi.json

## Development Workflow

When modifying or creating Solidity contracts:

1. **Development**: Write contracts following the existing pattern (MIT license, pragma ^0.8.0+)
2. **Testing**: Use Remix with JavaScript VM environment for local testing
3. **Deployment**:
   - Ensure MetaMask is connected to Sepolia Test Network
   - Switch to "Injected Provider - MetaMask" in Remix
   - Deploy to Sepolia testnet via MetaMask
   - Copy the deployed contract address
4. **Verification**: Verify contract on Etherscan Sepolia
   - Go to https://sepolia.etherscan.io/ and search for your contract
   - Click "Verify and Publish"
   - Provide compiler version, license type, and source code
5. **Interaction**: Use Etherscan's "Read Contract" and "Write Contract" tabs to interact with verified contracts

## Important Notes

- This is a testnet environment - all transactions use test ETH with no real value
- MetaMask must be configured for Ethereum Sepolia Testnet (see exercise1 for setup)
- Contract interactions requiring state changes need MetaMask transaction approval
- **Contract verification on Etherscan is required** before using Etherscan's interaction interface
- Read functions are free; write functions require gas and MetaMask confirmation

## Current Repository Status

- **Network**: All exercises use Ethereum Sepolia testnet
- **Contract deployment**: Contracts (Votacion, EDEMToken) are deployed by students as part of the learning exercises
- `exercise2/Votacion.sol` uses modern Solidity (^0.8.0) with improved gas efficiency and security
- `exercise4/README.md` contains EDEMToken ERC-20 contract for deployment practice
- To deploy contracts, students use Remix IDE following the workflow in exercise3
