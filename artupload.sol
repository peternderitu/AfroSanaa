pragma solidity ^0.7.0;

//SPDX-License-Identifier: UNLICENSED

contract ArtUpload {
    
    struct Art {
        string ipfshash;
        string title;
        string description;
        string tags;
        uint256 uploadingTime;
    }
    
    mapping(address => Art[]) public ownerToArt;
    
    event LogAddedArt(string ipfshash, string title, string description, string tags, uint256 uploadingTime, address artOwner);
    
    function uploadArt(string memory ipfshash, string memory title, string memory description, string memory tags) public returns(bool) {
        uint256 UploadingTime = block.timestamp;
        Art memory art = Art(
            ipfshash,
            title,
            description,
            tags,
            UploadingTime
            );
        ownerToArt[msg.sender].push(art);
        
        emit LogAddedArt(ipfshash, title, description, tags, UploadingTime, msg.sender);
        return true;
    }
    
    function getArtCount(address owner) public view returns(uint){
        return ownerToArt[owner].length;
    }
    
    function getArt(address owner, uint index) public view returns(string memory, string memory, string memory, string memory, uint256) {
        Art memory art = ownerToArt[owner][index];
        return (art.ipfshash,art.title,art.description,art.tags,art.uploadingTime);
    }
    
}
