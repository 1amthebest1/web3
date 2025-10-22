// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Lottery{

    address public owner;
    address public winner;
    uint constant entryFee = 150000000 wei;
    uint size=10;
    address[] public participants; //This is a dynamic array with lenght 0
    uint public player;

    constructor(){
        owner=msg.sender;
    }
    modifier onlyOwner{
        require(msg.sender==owner);
        _;
    }
    
    function viewContractBalance() public view returns (uint) {
        return (address(this).balance);
    }

    function participate()public payable{
        if(msg.value>entryFee && player!=10){
            participants.push(msg.sender);
            player=player+1;
        }
        else{
            
        }
    }

    function lotteryWinner(uint randNonce) public onlyOwner {
        if(participants.length==10){
            giveResult(uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % 10);
        }
    }

    function giveResult(uint winnerIndex) private {
        address payable lotteryWinnerAddress=payable (participants[winnerIndex]);
        lotteryWinnerAddress.call{value: address(this).balance};
    }

    receive() external payable { 
        revert("Transaction reverted");
    }

    fallback() external payable {
        revert("Transaction reverted");
    }
}
