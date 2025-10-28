// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

// The owner can grant specific allowances to other addresses.
// Those addresses can withdraw only within their limit.

contract Allowance {

    uint internal deploymentTime=block.timestamp;
    
    address public constant ownerAddress=0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    

    uint public contractBalance;

    uint totalDepositers;
    address[] private arrayOfAddresses;

    uint depositNumber;
    uint withdrawlNumber;
    uint transferTransactionNumber;
    mapping (address => uint) public Balance;

    mapping (uint => DepositLogs) public depositLogs; 
    mapping (uint => WithdrawFromContractLogs) public withdrawFromContractLogs;
    mapping (uint => TransferMoney) public transferMoneyLogs;

    struct DepositLogs{
        uint time; //Time of Deposit
        uint amount; //Amount of Deposit
        address sender; //Sender Address 
    }

    struct WithdrawFromContractLogs{
        uint time; //Time of Deposit
        uint amount; //Amount of Deposit
        address receiver; //Receiver Address
    }

    struct TransferMoney {
        uint time; //Time of Deposit
        uint amount; //Amount of Deposit
        address sender; //Sender Address
        address receiver; //Receiver Address
    }

    function depositMoney() public payable {

        if(Balance[msg.sender]>0){

        }
        else{
             totalDepositers++;
             arrayOfAddresses.push(msg.sender);
        }

        contractBalance+=msg.value; // increase contract balance
        Balance[msg.sender]+=msg.value; // increase sender balance

        depositLogs[depositNumber].time=block.timestamp;
        depositLogs[depositNumber].amount=msg.value;
        depositLogs[depositNumber].sender=msg.sender;
        depositNumber++;
    }

    function withdrawFromContract(uint _amount) internal {
        require(Balance[msg.sender] >_amount, "Not Enough Balance");
        Balance[msg.sender]-=_amount;
        contractBalance-=_amount;

        address payable callerAddress=payable(msg.sender);
        callerAddress.transfer(_amount);

        withdrawFromContractLogs[withdrawlNumber].time=block.timestamp;
        withdrawFromContractLogs[withdrawlNumber].amount=_amount;
        withdrawFromContractLogs[withdrawlNumber].receiver=msg.sender;
        withdrawlNumber++;
    }

    function transferMoney (address payable _reciever, uint _amount) internal {
        require(Balance[msg.sender] >= _amount, "Not Enough Balance");
        Balance[msg.sender]-=_amount;
        contractBalance-=_amount;
        _reciever.transfer(_amount);

        transferMoneyLogs[transferTransactionNumber].time=block.timestamp;
        transferMoneyLogs[transferTransactionNumber].amount=_amount;
        transferMoneyLogs[transferTransactionNumber].sender=msg.sender;
        transferMoneyLogs[transferTransactionNumber].receiver=_reciever;

        transferTransactionNumber++;
    }

    modifier onlyOwner {
        require(msg.sender==ownerAddress);
        _;
    }

    function sendAllowance () public onlyOwner {
        for (uint i=0; i<arrayOfAddresses.length; i++){
            transferMoney(payable(arrayOfAddresses[i]), Balance[arrayOfAddresses[i]]/10);
        }
    }

    //allowance should send percentage of deposited amount every month

    receive() external payable  { 
        revert("Recieve Function Called, Prohibited to send money to recieve function"); //recieve function called
    }

    fallback() external payable {
        revert("Fallback Function Called, Prohibited to send money, or data without via Fallback");
    }
}
