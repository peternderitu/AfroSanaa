pragma solidity ^0.7.0;

//SPDX-License-Identifier: UNLICENSED

import './artupload.sol';
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4-solc-0.7/contracts/token/ERC721/ERC721.sol';

contract Tokenization is ArtUpload, ERC721 {
    constructor () ERC721("AfroSanaa", "AS") {}
    
    event LogApproveTokenization(uint tokenid);
    mapping (address => uint) public artApproved;
    mapping (address => uint) public ownerToToken;
    
    
    modifier onlyValidator() {
        require(msg.sender == 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        _;
    }
    modifier onlyOwner(uint tokenid) {
        require(msg.sender == ownerOf(tokenid));
        _;
    }
    
    
    function approveTokenization(address owner) public onlyValidator returns(uint) {
        uint tokenid = ownerToArt[owner].length -1;
        artApproved[owner]+=tokenid;
        emit LogApproveTokenization(tokenid);
        return artApproved[owner];
    }
    
    function mintToken(address owner, uint token) internal {
        _safeMint(owner, token);
    }
    function createNft() public returns(uint) {
        uint TokenId = approveTokenization(msg.sender);
        mintToken(msg.sender,TokenId);
        ownerToToken[msg.sender]+=TokenId;
        return totalSupply();
    }
    
}
