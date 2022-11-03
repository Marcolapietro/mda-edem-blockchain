# Votación

Here are the details to interact with voting smart contract:

* **Contract**: 0x8B559489a1f7F7A06571944701fbFa4b0eA0eAD7
* **ABI (Application Binary Interface)**:

```
[
			{
				"inputs": [],
				"stateMutability": "nonpayable",
				"type": "constructor"
			},
			{
				"inputs": [],
				"name": "Ganador",
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
				"name": "Representar",
				"outputs": [],
				"stateMutability": "nonpayable",
				"type": "function"
			},
			{
				"inputs": [],
				"name": "VerCandidatos",
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
				"name": "VerResultados",
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
				"inputs": [
					{
						"internalType": "string",
						"name": "_candidato",
						"type": "string"
					}
				],
				"name": "VerVotos",
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
				"name": "Votar",
				"outputs": [],
				"stateMutability": "nonpayable",
				"type": "function"
			}
		]
```
