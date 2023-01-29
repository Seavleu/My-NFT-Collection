// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "./IWhitelist.sol";

contract CryptoDevs is ERC721Enumerable, Ownable {
    // metadata
    string _baseTokenURI;
    // Whitelist contract instance
    IWhitelist whitelist;

    bool public persaleStarted;

    uint256 public persaleEnded;

    uint256 maxTokenId = 20;

    uint256 public tokenIds;

    // uint256 public _publicPrice = 0.02 ether;
    uint256 public _price = 0.01 ether;
    // _paused is used to pause the contract in case of an emergency
    bool public _paused;

    /**
     * @dev setPaused makes the contract paused or unpaused
     */
    modifier onlyWhenNotPaused() {
        require(!_paused, "Contract currently paused");
        _;
    }

    // initalize name and symbol to the token collection
    constructor(string memory baseURI, address whitelistContract)
        ERC721("Crypto Devs", "CD")
    {
        // save baseURI in our var
        _baseTokenURI = baseURI;
        // instance that call the adress from IWhitelist.sol
        whitelist = IWhitelist(whitelistContract);
    }

    // Throws if called by any account other than the owner
    function startPersale() public onlyOwner {
        persaleStarted = true;

        // timestamp: we want to end
        persaleEnded = block.timestamp + 5 minutes;
    }

    function persaleMint() public payable {
        require(
            persaleStarted && block.timestamp < persaleEnded,
            "Presale Ended"
        );
        require(
            whitelist.whitelistAddresses(msg.sender),
            "You are not in the Whitelist"
        );
        require(tokenIds < maxTokenId, "Exceeded the limit");
        require(msg.value >= _price, "Ether sent is inacurrate");

        tokenIds += 1;

        // mint nft to sender
        _safeMint(msg.sender, tokenIds);

        // _safeMint called the mint function
    }

    function mint() public payable {
        /**@dev
         *check if presale ended*/
        require(
            persaleStarted && block.timestamp >= persaleEnded,
            "Presake has not ended yet"
        );
        require(tokenIds < maxTokenId, "Exceeded the limit");
        require(msg.value >= _price, "Ether sent is not correct");
        /*    |
                           _publicPrice*/

        _safeMint(msg.sender, tokenIds);
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    // prevent attack or exploiting fucntion in the contract
    function setPaused(bool val) public onlyOwner {
        _paused = val;
    }

    /**
     * @dev withdraw sends all the ether in the contract
     * to the owner of the contract
     */

    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;
        // check if it is send succesfully
        (bool sent, ) = _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    // function to recieve ether
    // sending ether not any data
    receive() external payable {}

    // found data, sending both data and ether
    fallback() external payable {}

    /**
     *@notice
     *which function is called, fallback() or recieve()?
     *             send Ether
     *                 |
     *         msg.data is empty?
     *                / \
     *              yes  No
     *              /     \
     * recieve() exists?  fallback()
     *           /          \
     *        yes           no
     *        /               \
     *   recieve()          fallback()
     */
}

// conditon
// 1- can be mint 20
// 2- should mint only one == ERC-721 Enumerable

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details
/// @param Documents a parameter just like in doxygen (must be followed by parameter name)
