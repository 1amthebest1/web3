//SPDX-License-Identifier: MIT

contract ExampleAddress{
    address public someAddress;

    function setMyAddress(address _someAddress) public {
        someAddress=_someAddress;
    }
    
    function getAddressBalance(address _someAddress) public view returns (uint){
        return _someAddress.balance;
    }
}
