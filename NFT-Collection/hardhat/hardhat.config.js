require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: ".env" });

const ALCHEMY_API_KEY_URL = process.env.ALCHEMY_API_KEY_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks:{
    goerli:{
      url: "https://eth-goerli.g.alchemy.com/v2/b9jQWqXVx0w_sLfTbvYoD__B7qlDd3F2",
      accounts: [PRIVATE_KEY],
    }
  }
};


/**@dev
 * npx hardhat compile
 * npx hardhat run scripts/deploy.js --network goerli */ 