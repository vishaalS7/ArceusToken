// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {Arceus} from "../src/ArceusToken.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MintArceus is Script {
    // string public constant ARCEUS = "ipfs://QmTBFsx7YWsaPnH9QqVz9zvr5y1iY6zccQGGuseFbVXFSj/?filename=Arceus.json";
    string public constant ARCEUS = "https://ipfs.io/ipfs/QmS2WR7FpF1urtnBviX6MKmFV1vty1qDRstmCofKjSQ9NS/Arceus.png";

    function run() public {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("Arceus", block.chainid);
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        Arceus(contractAddress).mintNFT(ARCEUS);
        vm.stopBroadcast();
    }
}

contract MintMoodNft is Script {
    function run() external {
        address mostRecentlyDeployedMoodNft = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployedMoodNft);
    }

    function mintNftOnContract(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodNft is Script {
    uint256 public constant TOKEN_ID_TO_FLIP = 0;

    function run() external {
        address mostRecentlyDeployedMoodNft = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        flipMoodNft(mostRecentlyDeployedMoodNft);
    }

    function flipMoodNft(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).flipMood(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }
}
