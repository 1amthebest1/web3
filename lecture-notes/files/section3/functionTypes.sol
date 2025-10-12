// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract ExampleViewPure{
    uint public myVariable;
    
    function getMyStorageVariable() public view returns(uint){
        return myVariable;
    }

    function getMyStorageVariables(uint myVariable) public pure returns(uint){
        return myVariable;
    }

    function getMyStorageVariablez()public returns(uint){
        return (myVariable++);
    }
}

/*-> Types Of Functions

        - View
        - Pure
        - Write

-> There are two kinds of reading functions

        - view function

---
Pure
---
        function myFunction() public pure returns(uint){}

        Pure function only has access to its parameters and local variables, it cannot modify state variables, nor read/write block-chain data.


---
View
---
        function myFunction() public view returns(uint){}

        It can read blockchain data, and state variables, but not write to it.


---
Write
---
        function myFunction() public (uint){}

        writing functions are not meant to return data, whenever they are returning something, its meant for other smart contracts.*/
