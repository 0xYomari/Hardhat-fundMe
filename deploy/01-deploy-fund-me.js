const { network } = require("hardhat")
const { networkConfig } = require("../helper-hardhat-config")

module.exports = async ({ deployments, getnamedAccounts }) => {
    const { deploy, log } = deployments
    const { deployer } = await getnamedAccounts()
    const chainId = network.config.chainId
    const ethUsdPriceAddress = networkConfig[chainId]["ethUsdPrice"]
    const fundMe = await deploy("FundMe", {
        from: deployer,
        args: [ethUsdPriceAddress],
        log: true,
    })
    log("Deployed.....!")
}
