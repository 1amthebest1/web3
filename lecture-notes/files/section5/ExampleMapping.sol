// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract ExampleMappingWithdrawls{

    mapping(address=>uint) public balanceRecieved;

    function sendMoney() public payable returns (uint){
        return balanceRecieved[msg.sender] += msg.value;
        
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdrawAllMoney(address payable _to) public{
        uint balanceToSendOut=balanceRecieved[msg.sender];
        balanceRecieved[msg.sender]=0;
        _to.transfer(balanceToSendOut);
    } 

}
