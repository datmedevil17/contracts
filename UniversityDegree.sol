// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract UniversityDegree is ERC721URIStorage {
    address public owner;
    uint256 public _tokenIds;

    mapping(address => bool) public issuedDegree;

    constructor() ERC721("UniversityDegree", "Degree") {
        owner = msg.sender; // Set the contract deployer as the owner
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can issue degrees");
        _;
    }

    function issueDegree(address to) external onlyOwner {
        issuedDegree[to] = true;        
    }
    
    function claimDegree(string memory tokenURI) public returns(uint256){
         require(issuedDegree[msg.sender], "Degree is not issued");

         _tokenIds++;
         _mint(msg.sender, _tokenIds);
         _setTokenURI(_tokenIds, tokenURI);

         issuedDegree[msg.sender] = false;

         return _tokenIds;
    }
    mapping(address=>string) public personToDegree;

    function _transfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override {
        require(false, "Soulbound Token: Transfer not allowed");
    }

    // Override the approve function to prevent approvals
    function approve(address to, uint256 tokenId) public virtual override {
        require(false, "Soulbound Token: Approvals not allowed");
    }

    // Override the setApprovalForAll function to prevent setting approvals
    function setApprovalForAll(address operator, bool approved) public virtual override {
        require(false, "Soulbound Token: Approvals not allowed");
    }



}
