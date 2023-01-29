// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// 'I' prefix signify only an Interface
interface IWhitelist{
    function whitelistAddresses(address) external view returns (bool);
}

// Purpose: we want to use the function that return us whether the address 
// is in the whitelist or not