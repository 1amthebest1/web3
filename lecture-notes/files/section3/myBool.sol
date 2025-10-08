contract myBool{
	bool public myBool; //default value is false
	
	function updateMyBool(string _myBool) public {
		myBool=_myBool;
	}

	function storeOpposite(string _myBool) public {
		myBool=!_myBool;
	}
}
