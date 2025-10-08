//SPDX-License-Identifier: MIT

contract ExampleUInt{
	uint public myInt;		//initialized by zero, costs extra gas.
					//uint is an alias for uint256. 
	uint8 public myInt_eight;
	int public my_signed=-10;       //signed int
	
		function increment() public {
		myInt_eight++;
	}
}


