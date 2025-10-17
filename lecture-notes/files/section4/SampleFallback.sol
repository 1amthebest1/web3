// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SampleFallback{
    uint public lastValueSent;
    string public lastFunctionCalled;
    address public senderAddress;
    uint256 public myUint;

    function setmyUint(uint256 _myNewUint) public {
        myUint=_myNewUint;
    }    

    receive() external payable {
        lastValueSent=msg.value;
        senderAddress=msg.sender;
        lastFunctionCalled="receive";
     }

    fallback() external payable { 
        lastValueSent=msg.value;
        lastFunctionCalled="fallback";
     }
}
