// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {Arceus} from "../src/ArceusToken.sol";

contract deployArceusScript is Script {
    function run() public returns (Arceus) {
        vm.startBroadcast();
        Arceus arceus = new Arceus();
        vm.stopBroadcast();
        return arceus;
    }
}
