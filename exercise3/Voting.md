# Votación (Voting Contract)

This is a more complex smart contract that allows you to create a voting system with candidate registration and vote counting.

## How to Deploy and Use

1. **Deploy the contract**:
   - Use the `Votacion.sol` file in this folder
   - Deploy it to Sepolia using Remix IDE (see Exercise 3)
   - Copy your deployed contract address

2. **Verify on Etherscan**:
   - Go to https://sepolia.etherscan.io/
   - Search for your contract address
   - Verify and publish the contract (see Exercise 2, Part B)

3. **Interact via Etherscan**:
   - Use the "Read Contract" and "Write Contract" tabs on Etherscan
   - Or use Remix's deployed contract interface

## Contract Functions

### Write Functions (Cost Gas)

- **representar(string _nombrePersona, uint _edadPersona, string _idPersona)**: Register yourself as a candidate
- **votar(string _candidato)**: Vote for a candidate (one vote per address)

### Read Functions (Free)

- **verCandidatos()**: View all registered candidates
- **verVotos(string _candidato)**: See how many votes a specific candidate has
- **ganador()**: See who is currently winning (or if there's a tie)
- **verResultados()**: View full results (owner only)
- **yaHaVotado(address)**: Check if an address has already voted
- **owner()**: See who owns the contract

## ABI (For Reference)

```
[
    {
        "inputs": [],
        "stateMutability": "nonpayable",
        "type": "constructor"
    },
    {
        "inputs": [],
        "name": "ganador",
        "outputs": [
            {
                "internalType": "string",
                "name": "",
                "type": "string"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "owner",
        "outputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "_nombrePersona",
                "type": "string"
            },
            {
                "internalType": "uint256",
                "name": "_edadPersona",
                "type": "uint256"
            },
            {
                "internalType": "string",
                "name": "_idPersona",
                "type": "string"
            }
        ],
        "name": "representar",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "verCandidatos",
        "outputs": [
            {
                "internalType": "string[]",
                "name": "",
                "type": "string[]"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "verResultados",
        "outputs": [
            {
                "internalType": "string[]",
                "name": "",
                "type": "string[]"
            },
            {
                "internalType": "uint256[]",
                "name": "",
                "type": "uint256[]"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "_candidato",
                "type": "string"
            }
        ],
        "name": "verVotos",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "_candidato",
                "type": "string"
            }
        ],
        "name": "votar",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "name": "yaHaVotado",
        "outputs": [
            {
                "internalType": "bool",
                "name": "",
                "type": "bool"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    }
]
```
