// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract simpleBank{

    address ownerAddress=0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    uint public contractBalance;
    uint public amountOfFunctionCalls;

    function deposit()public payable{
        contractBalance=contractBalance+msg.value;
        amountOfFunctionCalls++;
    }

    function withdrawFundsFromContract(address payable reciverAddress, uint amount) public {
        if(msg.sender==ownerAddress){
            (bool success,)=reciverAddress.call{value: amount}("");
            require(success, "Transaction Failed");
        }
    }

    function sendEth(address payable recieverAddress) public payable{
        (bool success, )=recieverAddress.call{value: msg.value}("");
        require(success, "Transaction Failed");
    }

    receive() external payable {
        revert("Wrong Function Call");
    }

    fallback() external payable { 
        revert("Wrong Function Call");
    }

}
