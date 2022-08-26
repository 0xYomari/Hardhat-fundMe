require("@nomicfoundation/hardhat-toolbox")
require("dotenv").config()
require("hardhat-deploy")

/** @type import('hardhat/config').HardhatUserConfig */
const RIBKEBY_RPC_URL = process.env.RIBKEBY_RPC_URL
const PRIVATE_KEY = process.env.PRIVATE_KEY

module.exports = {
    solidity: "0.8.9",
    networks: {
        rinkeby: {
            url: RIBKEBY_RPC_URL,
            accounts: [PRIVATE_KEY],
            chainId: 4,
        },
    },
    namedAccounts: {
        deployer: {
            default: 0,
        },
    },
}
