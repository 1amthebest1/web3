// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

// Escrow Contract
// Buyer deposits Ether into escrow.
// Seller delivers item.
// Buyer confirms delivery → funds released.
// Add dispute handling via try/catch or owner arbitration.

contract escrow {

    uint public contractBalance=address(this).balance;

    address constant escrowWallet=0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    mapping (address => uint) deposits; 
    address[] public buyers;

    mapping (address => string) work; 
    mapping (address => mapping (address => bool)) workCompleted;

    address[] public workers;

    //FOR BUYER
    function depositEscrow() public payable {
        deposits[msg.sender]+=msg.value;
        buyers.push(msg.sender);
    }

    //FOR BUYER
    function deliverItem(address buyer, string memory workComplete) public {
        workers.push(msg.sender);
        work[buyer]=workComplete;
        workCompleted[buyer][msg.sender]=true;
    }

    //FOR SELLER
    function checkWork(address _worker) public returns (string memory result) {
        for(uint i=0; i<buyers.length; i++){
            if(buyers[i]==msg.sender){
                require(workCompleted[msg.sender][_worker]=true, "Not Complete");
                return work[msg.sender];
            }
            else{
                return "Not a buyer";
            }
        }
        
    }
    //FOR BUYER
    function deliverPayment(address payable _worker) public returns(string memory result){
        for(uint i=0; i<buyers.length; i++){
            if(buyers[i]==msg.sender){
                require(workCompleted[msg.sender][_worker]=true, "Not Complete");
                _worker.transfer(deposits[msg.sender]);
                return "payment sent";
            }
            else{
                return "Not a buyer";
            }
        }
    }
}
