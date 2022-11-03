# Exercise 3: Creating a new Smart Contract

In this exercise we will be creating, testing and deploying a Smart Contract using [**Remix**](https://remix.ethereum.org/) (a web-based Solidity IDE).

The Smart Contract code is provided below in Solidity language. You will be introducing it in the IDE, test it in the browser and, once tested, will deploy it into a testnet for interaction.

## Instructions

### Development

We will start with a pre-created contract so, in the "**File explorer**" add a new file (using the "+" button) and add the following code (which will sound familiar):

```
pragma solidity >=0.4.22 <0.7.0;

/**
 * @title EDEM - MDA
 * @dev Store & retreive value in a variable
 */
contract EDEMSmartContract {

    int pokeCount;
    string greeting = "Hi guys!!! Welcome to the Blockchain session in EDEM's MDA.";

    /**
     * @dev Increase the number of pokes
     */
    function poke() public {
        pokeCount = pokeCount + 1;
    }

    /**
     * @dev Get the number of getNumPokes
     * @return Number of pokes
     */
    function getNumPokes() public view returns (int) {
        return pokeCount;
    }

    /**
     * @dev Say hi to the class
     * @return A greeting
     */
    function hello() public view returns (string memory) {
        return greeting;
    }
}
```

### Compilation

It should work fine from the very beginning, so let's compile it using the "**Solidity Compiler**" tab. Everything by default should be ok so, just click on "**Compile XXXX.sol**".

If there is any compilation error, it will show below the button we just pressed. If that is the case, contact the teacher.
If there is no compilation error, the contract will show below and we are ready to test!

### Testing

In the "**Deploy & run transactions**" tab, select the "**JavaScript VM**" environment and click "**Deploy**". This will run your smart contract in the browser, but with the same functionality as if it were deployed in an Ethereum network.

Below, under "**Deployed contracts**" you should see your own smart contract. Click to expand and see your contract methods.

Now you are ready to test it!!

### Deployment

We are now going to deploy the smart contract in a real Ethereum network. In this case a test network (Rinkeby) so it does not cost us any money!

In the same "**Deploy & run transactions**" tab, select the "**Injected Web3**" environment and click "**Deploy**". This will ask for confirmation in MetaMask since we are sending a "create smart contract" transaction to the network, and costs ether.

After a few seconds the transaction will be confirmed, the contract created and you will be able to test it as in the previous section. But in this case, **it is really running in the blockchain**.

## Next steps

Now that you are familiar with the environment, play around with the code, compile, test, deploy, etc. At your will!
