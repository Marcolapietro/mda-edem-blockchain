# Exercise 3: Creating and Deploying a Voting Smart Contract

In this exercise you will **create, test, and deploy a real-world smart contract** using [**Remix**](https://remix.ethereum.org/) - a web-based Solidity IDE.

You'll build a **Voting System** where people can:
- Register as candidates
- Cast votes (one vote per address)
- View results
- Determine the winner

This demonstrates key blockchain concepts: state management, access control, mappings, and more!

## What You'll Learn

- Writing Solidity smart contracts
- Using Remix IDE for development
- Testing contracts locally (JavaScript VM)
- Deploying to Sepolia testnet
- Verifying contracts on Etherscan
- Interacting with your deployed contract

## Part A: Understanding the Voting Contract

Before we start, let's understand what we're building. The contract has these features:

**For Everyone:**
- `representar()` - Register as a candidate
- `votar()` - Vote for a candidate
- `verCandidatos()` - View all candidates
- `verVotos()` - See votes for a candidate
- `ganador()` - See who's winning

**For Owner Only:**
- `verResultados()` - View complete voting results

**Smart Features:**
- Prevents duplicate candidate registration
- One vote per address
- Detects ties
- Hashes candidate credentials for privacy

## Part B: Development - Write the Contract

1. Go to [Remix IDE](https://remix.ethereum.org/)
2. In the "**File explorer**", click the "+" button to create a new file
3. Name it `Votacion.sol`
4. Copy the complete contract code from `Votacion.sol` in this folder, or get it here:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Votacion {
    address public owner;
    mapping(string => bytes32) private ID_Candidato;
    mapping(string => uint) private votos_candidato;
    mapping(address => bool) public yaHaVotado;
    mapping(address => bool) private yaSeHaPresentado;
    mapping(string => bool) private esCandidato;

    string[] private candidatos;

    modifier soloOwner() {
        require(msg.sender == owner, "No tienes permisos para ejecutar esta funcion.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function representar(string memory _nombrePersona, uint _edadPersona, string memory _idPersona) public {
        require(!yaSeHaPresentado[msg.sender], "Ya te has presentado como candidato.");
        require(!esCandidato[_nombrePersona], "Este candidato ya se ha presentado.");

        bytes32 hash_Candidato = keccak256(abi.encodePacked(_nombrePersona, _edadPersona, _idPersona));
        ID_Candidato[_nombrePersona] = hash_Candidato;
        esCandidato[_nombrePersona] = true;
        yaSeHaPresentado[msg.sender] = true;
        candidatos.push(_nombrePersona);
    }

    function verCandidatos() public view returns(string[] memory) {
        return candidatos;
    }

    function votar(string memory _candidato) public {
        require(!yaHaVotado[msg.sender], "Ya has votado previamente");
        yaHaVotado[msg.sender] = true;
        votos_candidato[_candidato]++;
    }

    function verVotos(string memory _candidato) public view returns(uint) {
        return votos_candidato[_candidato];
    }

    function verResultados() public view soloOwner returns(string[] memory, uint[] memory) {
        uint[] memory votos = new uint[](candidatos.length);
        for(uint i = 0; i < candidatos.length; i++){
            votos[i] = votos_candidato[candidatos[i]];
        }
        return (candidatos, votos);
    }

    function ganador() public view returns(string memory) {
        string memory nombreGanador = candidatos[0];
        bool flag = false;

        for(uint i = 1; i < candidatos.length; i++){
            if(votos_candidato[nombreGanador] < votos_candidato[candidatos[i]]){
                nombreGanador = candidatos[i];
                flag = false;
            } else if(votos_candidato[nombreGanador] == votos_candidato[candidatos[i]]){
                flag = true;
            }
        }

        if(flag){
            return "Hay empate entre los candidatos";
        }
        return nombreGanador;
    }
}
```

## Part C: Compilation

Now let's compile the contract:

1. Click on the "**Solidity Compiler**" tab (left sidebar)
2. Make sure compiler version is set to `0.8.0` or higher
3. Click "**Compile Votacion.sol**"
4. You should see a green checkmark ✓

If there are compilation errors, check your code and try again. Otherwise, you're ready to test!

## Part D: Testing Locally

Before deploying to the blockchain, let's test locally in the browser:

1. Click on the "**Deploy & run transactions**" tab (left sidebar)
2. Select "**JavaScript VM (London)**" as the environment
   - This runs a blockchain simulator in your browser
   - Perfect for testing without spending real gas
3. Click "**Deploy**"
4. Your contract appears under "**Deployed Contracts**" - click to expand it

### Run a Mock Election

Let's simulate a real election with your classmates!

**Step 1: Register Candidates**

1. Find the `representar` function (orange button = write function)
2. Fill in the parameters:
   - `_nombrePersona`: "Alice"
   - `_edadPersona`: 25
   - `_idPersona`: "12345X"
3. Click "transact"
4. Repeat for more candidates: "Bob", "Charlie", etc.

**Step 2: View Candidates**

1. Find `verCandidatos` (blue button = read function)
2. Click it - you should see all registered candidates!

**Step 3: Vote**

1. Change the account in the "**Account**" dropdown (simulates different voters)
2. Use `votar` function
3. Enter a candidate name (e.g., "Alice")
4. Click "transact"
5. Switch accounts and vote again for different candidates

**Step 4: Check Results**

1. Use `verVotos` to check votes for each candidate
2. Use `ganador` to see who's winning!
3. Try `verResultados` - only works if you're the owner (first account that deployed)

**Test Edge Cases:**

- Try voting twice from the same account (should fail!)
- Try registering the same candidate twice (should fail!)
- See what happens with a tie

## Part E: Deploy to Sepolia Testnet

Now for the real deal - let's deploy to the actual blockchain!

### Pre-deployment Checklist:

✅ MetaMask installed and connected to Sepolia (Exercise 1)
✅ You have test ETH in your wallet (from faucets)
✅ Contract compiles with no errors
✅ You've tested it locally

### Deployment Steps:

1. In the "**Deploy & run transactions**" tab
2. Change environment to "**Injected Provider - MetaMask**"
3. MetaMask will ask you to connect - approve it
4. Verify you're on **Sepolia Test Network** in MetaMask
5. Click "**Deploy**"
6. **MetaMask popup**: Review the gas fee and click "Confirm"
7. Wait ~15 seconds for confirmation
8. Your contract is now LIVE on the blockchain! 🎉

**Save your contract address!** You'll see it under "Deployed Contracts" - copy it!

## Part F: Verify on Etherscan

Make your contract publicly verifiable:

1. Go to https://sepolia.etherscan.io/
2. Paste your contract address in the search
3. Click the "**Contract**" tab
4. Click "**Verify and Publish**"
5. Fill in:
   - Compiler Type: Solidity (Single file)
   - Compiler Version: v0.8.0
   - License: MIT
6. Paste your entire Solidity code
7. Click "Verify and Publish"
8. ✅ Your contract is now verified!

## Part G: Run a Real Election!

Now the fun part - run an actual election with your classmates on the blockchain:

### Using Etherscan:

1. Go to your contract on Etherscan
2. Click "**Write Contract**" tab
3. Connect MetaMask
4. Have each classmate:
   - Register as a candidate using `representar`
   - Vote for someone using `votar`
5. Check results in real-time with `verCandidatos`, `verVotos`, and `ganador`!

### Or Using Remix:

Your deployed contract is still accessible in Remix under "Deployed Contracts"

## Part H: Understanding What You Built

**Key Concepts You Learned:**

- **Mappings**: Efficient key-value storage (addresses → bools, strings → uints)
- **Modifiers**: `soloOwner` restricts function access
- **Arrays**: Dynamic storage for candidate list
- **Events**: Implicit state changes tracked on blockchain
- **Access Control**: Owner vs public functions
- **Input Validation**: `require` statements prevent invalid states
- **Hashing**: `keccak256` for privacy-preserving candidate IDs

**Real-World Applications:**

This same pattern is used for:
- DAO governance votes
- Community polls
- Shareholder voting
- Election systems
- Proposal approval mechanisms

## Next Steps

Want to improve the contract? Try adding:
- Time limits for voting (start/end timestamps)
- Weighted voting (some addresses count more)
- Ability to change your vote
- Multiple voting rounds
- Event emissions for transparency

See `Voting.md` in this folder for complete function documentation.

Congratulations! You've built and deployed a real blockchain application! 🚀
