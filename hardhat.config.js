require("@nomicfoundation/hardhat-toolbox");
/** @type import('hardhat/config').HardhatUserConfig */
require("@nomiclabs/hardhat-waffle");
require("@openzeppelin/hardhat-upgrades");
require("hardhat-contract-sizer");
require("solidity-coverage");
require("hardhat-gas-reporter");


const dotenv = require("dotenv");
dotenv.config();

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */

module.exports = {
  mocha: {
    timeout: 100000000000
  },
  solidity: {
    version: "0.8.11",
    settings: {
      optimizer: {
        enabled: true,
        runs: 10,
      },
    },
  },

  contractSizer: {
    alphaSort: true,
    disambiguatePaths: false,
    runOnCompile: true,
    strict: true,
  },
  networks: {
    hardhat: {
      // accounts: [
      //   {
      //     privateKey: process.env.DEPLOYER,
      //     balance: "100000000000000000000"
      //   }
      // ]
    },
    ethereum: {
      url: "https://mainnet.infura.io/v3/fd99781272384f74a5e6aed774deb60c",
      chainId: 1,
      accounts: [process.env.DEPLOYER], // 
      gas: 4698712,
      gasPrice: 25000000000
    },
    develop: {
      url: "http://127.0.0.1:8545",
    },
    ropsten: {
      url: "https://ropsten.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161",
      chainId: 3,
      accounts: [process.env.DEPLOYER], // UserOne
      // accounts: [process.env.BUYERONE], // Buyer
      // accounts: [process.env.DEPLOYER], //Deployer
      // // accounts:[process.env.ESCROW_MGR] ,//EscrowMgr
      gas: 8712388,
      gasPrice: 10000000000,
    },
    moonriver: {
      url: "https://rpc.api.moonriver.moonbeam.network",
      chainId: 1285, //(hex: 0x505),
      accounts: [process.env.DEPLOYER], // Insert your private key here
    },
    // moonbase: {
    //   url: 'https://rpc.api.moonbase.moonbeam.network',
    //   chainId: 1287,
    //   accounts: [process.env.DEPLOYER]
    // }
    moonbeam: {
      url: "https://rpc.api.moonbeam.network",
      chainId: 1284, //(hex: 0x505),
      accounts: [process.env.DEPLOYER], // Insert your private key here
    },
    celo: {
      url: 'https://forno.celo.org',
      chainId: 42220,
      accounts: [process.env.DEPLOYER] //
    },
    //for coverage plugin to run
    ganache: {
      url: "http://127.0.0.1:7545",
    },

    // BSC testnet 
    bsc: {
      url: 'https://data-seed-prebsc-1-s1.binance.org:8545',
      chainId: 97,
      accounts: [process.env.DEPLOYER] //
    },
    // celo: {
    //   url: "https://alfajores-blockscout.celo-testnet.org",
    //   chainId:44787,
    //   accounts: [process.env.DEPLOYER], //Deployer
    //   // // accounts:[process.env.ESCROW_MGR] ,//EscrowMgr
    //   gas: 8712388,
    //   gasPrice: 10000000000,
    // }
  },
};


