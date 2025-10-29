// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Faucet {

    address public owner;

    constructor () {
    owner = msg.sender;
    }

    function viewContractBalance() public view returns(uint bal){
        return address(this).balance;
    }

    bool rentrancyGuard;

    address[] public recipients;

    mapping(address => bool) public recipientsSent;

    modifier norentrancy{
        require(!rentrancyGuard, "Working... Please wait");
        rentrancyGuard=true;
        _;
        rentrancyGuard=false;
    }

    modifier onlyOwner{
        require(msg.sender==owner, "Only owner can interact with this");
        _;
    }

    function contribute () public payable {
    }

    function getWei () public norentrancy returns (string memory process){
        if(recipientsSent[msg.sender]==true){
            revert("Already Sent... Wait until the owner reset");
        }
        else{
            address payable receiver=payable(msg.sender);
            receiver.transfer(1000 wei);
            recipients.push(msg.sender);
            recipientsSent[msg.sender]=true;
            return "1000 wei sent";
            
        }
    }

    function clearMapping() public onlyOwner {
        for(uint i=0; i<recipients.length; i++) {
            recipientsSent[recipients[i]]=false;
        }
        while(recipients.length!=0){
            recipients.pop();
        }
    }

    receive() external payable { 
        revert("Not Allowed To Send Payments");
    }
    
    fallback() external payable {
        revert("Not Allowed To Send Data, Or Money");
    }
}
