// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {deployArceusScript} from "../script/deployArceusScript.s.sol";
import {Arceus} from "../src/ArceusToken.sol";

contract arceusTest is Test {
    deployArceusScript public deploy;
    Arceus public arceus;
    address public USER = makeAddr("user");
    string public constant ARCEUS = "ipfs://QmTBFsx7YWsaPnH9QqVz9zvr5y1iY6zccQGGuseFbVXFSj/?filename=Arceus.json";

    function setUp() public {
        deploy = new deployArceusScript();
        arceus = deploy.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Arceus";
        string memory actual = arceus.name();
        // assert(expected == actual); //Built-in binary operator == cannot be applied to types string memory and string memory.
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actual)));
    }

    function testCanMintAndBalance() public {
        vm.prank(USER);
        arceus.mintNFT(ARCEUS);
        assert(arceus.balanceOf(USER) == 1);
        uint256 tokenId = 0;
        assert(keccak256(abi.encodePacked(arceus.tokenURI(tokenId))) == keccak256(abi.encodePacked(ARCEUS)));
    }
}
