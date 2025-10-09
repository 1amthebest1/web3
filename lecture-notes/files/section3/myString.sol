contract ExampleStrings{
    string public myString="Hello World";  //

    function setMyString(string memory _myString) public {
        myString=_myString; //assigning memory storage [like heap], to storage storage global variable.
    }
}

