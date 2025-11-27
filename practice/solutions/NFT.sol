// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract newNFT{

    string public projectName;
    address public smartContractOwner;

     constructor(address _smartContractOwner, string memory _projectName){
        smartContractOwner=_smartContractOwner;
        projectName=_projectName;
    }

    bool entrancyGuard=false;

    bool pause=false;

    mapping(uint => address) public NFTowner;

    mapping(uint => bool) public allApproved;

    mapping(uint => mapping(uint => address)) public approvedAddresses;
    mapping(uint => uint) approvedCount;
    address[] private approvedAddressesToReturn; 

    uint nftcount;

    mapping(uint => bool) public NFT;

    mapping(address => bool) public Owners; //Contract Owners

    modifier OnlyOwner{
        require(Owners[msg.sender]==true);
        _;
    }

    modifier EntrancyGuard{
        require(!entrancyGuard);
        entrancyGuard=true;
        _;
        entrancyGuard=false;
    }

    modifier Pause{
        require(!pause);
        _;
    }

    function pauseOperations() OnlyOwner public {
        pause=true;
    }

    function resumeOperations() OnlyOwner public {
        pause=false;
    }

    function mint(uint amount) OnlyOwner EntrancyGuard public {
        for(uint i=1; i<=amount; i++){
            NFT[nftcount+i]=true;
            nftcount++;
        }
    }

    function burn(uint tokenID) EntrancyGuard public{
        require(NFT[tokenID]==true);
        require(NFTowner[tokenID]==msg.sender);
        NFTowner[tokenID]=address(0);
        NFT[tokenID]=false;
        nftcount--;
    }

    function transferOwnership(uint nft, address buyer) EntrancyGuard public {
        require(NFT[nft]==true);
        require(NFTowner[nft]==msg.sender);
        NFTowner[nft]=buyer;
    }

    function approve(uint tokenID, address to) public {
        require(NFT[tokenID]==true);
        require(NFTowner[tokenID]==msg.sender);
        approvedAddresses[tokenID][approvedCount[tokenID]]=to;
        approvedCount[tokenID]+=1;
    }

    function approveViaInternalCall(uint tokenID, address to) internal {
        approvedAddresses[tokenID][approvedCount[tokenID]]=to;
        approvedCount[tokenID]+=1;
    }

    function setGetApproved(uint tokenID) private {
        delete approvedAddressesToReturn;
        for(uint i=0; i<approvedCount[tokenID]; i++){
            approvedAddressesToReturn.push(approvedAddresses[tokenID][i]);
        }
        approvedAddressesToReturn;
    }

    function getApproved(uint tokenID) public returns (address [] memory){
        setGetApproved(tokenID);
        address [] memory tempArr=new address[](approvedCount[tokenID]);
        for(uint i=0; i<approvedCount[tokenID]; i++){
            tempArr[i]=approvedAddresses[tokenID][i];
        }
        return tempArr;
    }

    function setApprovalForAll (address operator, bool approved, uint tokenID) public {
        
        if(approved==true){
            for(uint i=0; i<nftcount; i++){
                if(NFTowner[i]==msg.sender){
                    approveViaInternalCall(i, operator);
                }
            }
        }
        else{
            for(uint i=0; i<nftcount; i++){
                if(NFTowner[i]==msg.sender){
                    disapprovOwner(operator, tokenID);
                }
            }
        }
    }

    function disapprovOwner(address operator, uint tokenID) private {
        for(uint i=0; i<approvedCount[tokenID]; i++){
            if(approvedAddresses[tokenID][i]==operator){
                approvedAddresses[tokenID][i]=address(0);
            }
        }
    }

    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        bool nftOwner=false; bool allOwner=false;
        for(uint i=0; i<nftcount; i++){
            if(NFTowner[i]==owner){
                nftOwner=true;
                for(uint j=0; i<approvedCount[i]; j++){
                    allOwner=false;
                    if(approvedAddresses[j][i]==operator){
                        allOwner=true;
                        break;
                    }
                    if(j==approvedCount[i]-1 && allOwner==false){
                        return false;
                    }
                }

                
            }
        }

        if(nftOwner==false){
            return false; //not an owner
        }

        if(nftOwner==true && allOwner==true){
            return true;
        }

    }

}
