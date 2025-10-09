//SPDX-License-Identifier: MIT

contract ExampleWrapAround{
    uint public myUint;
    uint8 public myUint8=2**4;

    function setMyUint(uint __myUint) public {
        myUint=__myUint;
    }

    function increamentUint() public {
        myUint++;
    }

    function decrementUint() public {
        unchecked{
            myUint--;
        }
    }

    function incrementUint8() public {
        myUint8++;
    }

}

//The unchecked thing bypasses the check provided by new compilers, and brings back roll over, i.e a signed int when decremented after 0, goes to the highest number.
