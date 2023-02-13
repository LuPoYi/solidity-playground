// Import the ethers.js library
const { Contract, providers, utils } = require("ethers")

// Connect to a local Ethereum node
const provider = new providers.JsonRpcProvider("http://localhost:8545")

// The address of the deployed contract
const contractAddress = "0x..."

// Create an instance of the contract
const contract = new Contract(contractAddress, [], provider)

// The hash of the player's move
const hash = utils.keccak256("mysecretmove")

// Call the play function
contract
  .play(hash, { from: "0x..." })
  .then((receipt) => {
    console.log(receipt)
  })
  .catch((error) => {
    console.error(error)
  })
