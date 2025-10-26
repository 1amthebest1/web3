// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract WillThrow{
    error NotAllowedError(string);
    function aFunction() public pure {
        // require(false, "Error Message");
    revert NotAllowedError("You are not allowed");
    }
}

contract ErrorHandling{
    event ErrorLogBytes(bytes lowLevelData);
    event ErrorLogging(string reason);
    function catchTheError() public {
        WillThrow will=new WillThrow(); //creates new contract here
        try will.aFunction(){
    
        } catch Error(string memory reason){
            emit ErrorLogging(reason);
        } catch(bytes memory lowLevelData){

        }
        
    }

}
