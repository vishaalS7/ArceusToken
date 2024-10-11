// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {Arceus} from "../src/ArceusToken.sol";

contract MintArceus is Script {
    string public constant ARCEUS =
        "ipfs://QmTBFsx7YWsaPnH9QqVz9zvr5y1iY6zccQGGuseFbVXFSj/?filename=Arceus.json";

    function run() public {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "Arceus",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        Arceus(contractAddress).mintNFT(ARCEUS);
        vm.stopBroadcast();
    }
}
