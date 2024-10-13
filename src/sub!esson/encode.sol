// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract Encoding {
    /*1. combineStrings
    This function combines two strings ("Hi Mom! " and "Miss you!") using abi.encodePacked, which joins them together and returns the result as a single string.
    Result: "Hi Mom! Miss you!"*/
    function combineStrings() public pure returns (string memory) {
        return string(abi.encodePacked("Hi Mom! ", "Miss you!"));
    }
    //Encodes the number 1 into bytes using abi.encode. Result: A bytes-encoded version of the number 1.

    function encodeNumber() public pure returns (bytes memory) {
        bytes memory number = abi.encode(1);
        return number;
    }
    //Encodes the string "some string" into bytes using abi.encode. It converts the string into its byte format.Result: Bytes-encoded version of "some string".

    function encodeString() public pure returns (bytes memory) {
        bytes memory someString = abi.encode("some string");
        return someString;
    }

    //Encodes the string "some string" using abi.encodePacked, which is more efficient than abi.encode as it compresses the data.Result: A packed (smaller) byte-encoded version of the string.
    function encodeStringPacked() public pure returns (bytes memory) {
        bytes memory someString = abi.encodePacked("some string");
        return someString;
    }
    //Converts the string "some string" directly into bytes using the bytes() function.Result: A direct byte conversion of the string.

    function encodeStringBytes() public pure returns (bytes memory) {
        bytes memory someString = bytes("some string");
        return someString;
    }
    //Decodes the bytes-encoded string created by the encodeString function back into its original string format.Result: The original string "some string".

    function decodeString() public pure returns (string memory) {
        string memory someString = abi.decode(encodeString(), (string));
        return someString;
    }
    //Encodes two strings ("some string" and "it's bigger!") together using abi.encode.Result: A byte-encoded version of both strings.

    function multiEncode() public pure returns (bytes memory) {
        bytes memory someString = abi.encode("some string", "it's bigger!");
        return someString;
    }
    //Decodes the result from multiEncode into two separate strings. Result: Returns both original strings: "some string" and "it's bigger!".

    function multiDecode() public pure returns (string memory, string memory) {
        (string memory someString, string memory someOtherString) = abi.decode(multiEncode(), (string, string));
        return (someString, someOtherString);
    }
    //Encodes two strings together using abi.encodePacked to create a smaller, packed version of both. Result: A packed version of both strings in bytes.

    function multiEncodePacked() public pure returns (bytes memory) {
        bytes memory someString = abi.encodePacked("some string", "it's bigger!");
        return someString;
    }
    //Attempts to decode the packed data from multiEncodePacked into a single string. This might not work as expected for multiple strings because abi.encodePacked compresses the data in a way that makes it harder to accurately decode multiple values.
    // function multiDecodePacked() public pure returns (string memory, string memory){
    //     string memory someString = abi.decode(multiEncodePacked(), (string));
    //     return someString;
    // }
    /**
     * call:** How we call functions to change the state of the blockchain
     *
     * staticcall:** How we call view or pure functions
     *
     * > **PROTIP** > `send` and `delegatecall` also exist as options for low-level calling to the blockchain, but we'll go over these in greater detail later!
     *
     * When we write `recentWinner.call{value: address(this).balance}("");` we're directly updating the value property of the transaction we're sending. The parenthesis at the end of this call are where we provide our transaction data.
     *
     * within `{}` we're able to pass specific fields of a transaction, like `value`
     * within `()` we can pass the data needed to call a specific function.
     *
     * ###
     */

    function withdraw(address recentWinner) public {
        //recentWinner: This is the address to which we're going to send the contract’s entire balance. It's passed as a parameter to the function.
        (bool success,) = recentWinner.call{value: address(this).balance}("");
        require(success, "Transfer Failed");
    }
    //{value: address(this).balance}: This specifies how much Ether to send. In this case, it’s the entire balance of the contract (address(this).balance).
    //(""): The empty parentheses mean that we're not sending any extra data, which would normally be used to call a specific function on a contract. Since we're just sending Ether, there's no need to provide function data.
    //
}
