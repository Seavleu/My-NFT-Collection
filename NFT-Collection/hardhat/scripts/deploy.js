const {ethers} = require("hardhat");
require ("dotenv").config({path: ".env"});
const { WHITELIST_CONTRACT_ADDRESS, METADATA_URL } = require("../constants");

async function main(){
    // previous address module of the whitelist contract 
    const whitelistContract = WHITELIST_CONTRACT_ADDRESS;
    // url from where we can extract the metadata for a "Chocolate Save Lifeu" nft
    const metadataURL = METADATA_URL;

    /*ContractFactory in ethers.js is an abstraction used to deploy new smart
    contracts, so Chocolate Save Lifeu contract here is a factrory for instances of 'Chocolate Save Lifeu'
    contract*/
    const cryptoDevsContract = await ethers.getContractFactory("CryptoDevs");

    // deploy the contract
    const deployedcryptoDevsContract = await cryptoDevsContract.deploy(
        metadataURL,
        whitelistContract
    );

    // wait for it to finish deploy
    await deployedcryptoDevsContract.deployed();

    // print address of the deployed contract
    console.log("This is your contract address🙌: ",deployedcryptoDevsContract.address);

}

// call main function and catch if there is any error
main()
.then(() => process.exit(0))
.catch ((error) => {
    console.error(error);
    process.exit(1);
});