// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SampleContract{
    string public myString="Hello World!";

    function updateString (string memory _newString)public payable{
        if(msg.value>10 ether){    
        myString=_newString;
        }
        else{
            payable(msg.sender).transfer(msg.value);
        }
    }
}
