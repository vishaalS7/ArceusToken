// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Arceus is ERC721 {
    uint256 private s_tokenCounter; //A private variable to keep track of how many NFTs have been created. It starts at 0 and increases each time a new NFT is minted.
    mapping(uint256 => string) private s_tokenIdtoUri; //A mapping that links each token's ID (number) to a string that holds the token URI (metadata location), such as the image or other details for the NFT.

    //The constructor is called when the contract is deployed. It initializes the name of the token collection as "Arceus" and the symbol as "ARC". The s_tokenCounter is set to 0, meaning the first NFT minted will have an ID of 0.
    constructor() ERC721("Arceus", "ARC") {
        s_tokenCounter = 0;
    }

    //mintNFT(): This function allows anyone to create (or mint) a new NFT.
    function mintNFT(string memory tokenUri) public {
        // tokenUri: The user provides a URI (metadata) for the NFT when minting.
        s_tokenIdtoUri[s_tokenCounter] = tokenUri; //The mapping stores the tokenUri for the current token (tracked by s_tokenCounter).
        _safeMint(msg.sender, s_tokenCounter); //The _safeMint() function (inherited from ERC721) mints the NFT to the person calling the function (msg.sender), giving them ownership.
        s_tokenCounter++; //the s_tokenCounter is increased so the next NFT will have a unique token ID.
    }

    // This function allows anyone to retrieve the metadata (URI) for a specific token by providing its token ID.
    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenIdtoUri[tokenId];
    }
}
