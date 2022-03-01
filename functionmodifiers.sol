// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract FunctionModifier {
    // We will use these variables to demonstrate how to use
    // modifiers.
    //modifiers are used to check a condition prior to executing ahe function. They are reusable and help to keep the code clean and readable.
    address public owner;
    uint public x = 10;
    bool public locked;

    constructor() {
        // Set the transaction sender as the owner of the contract.
        owner = msg.sender;
        // constructors can inherit from parent constructors.
    }

    // Modifier to check that the caller is the owner of
    // the contract.
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        // Underscore is a special character only used inside
        // a function modifier and it tells Solidity to
        // execute the rest of the code.
        _;
    }

    // Modifiers can take inputs. This modifier checks that the
    // address passed in is not the zero address.
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }
    //to call a modifier you have to use the modifier  name in the function being used.
    function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner) {
        owner = _newOwner;
    }

    // Modifiers can be called before and / or after a function.
    // This modifier prevents a function from being called while
    // it is still executing.
    //modifier can take in parameters.

    modifier noReentrancy() {
        require(!locked, "No reentrancy");

        locked = true;
        _;
        locked = false;
    }

    function decrement(uint i) public noReentrancy {
        x -= i;

        if (i > 1) {
            decrement(i - 1);
        }
    }
}

contract modifierTest{
    uint256 threshold = 150;
    uint256 public number;

    modifier less150(uint256 number){
        require(number < threshold, 'Number must be less than threshold');

        _;
    }
    function setNumber(uint256 _number) public less150(_number){
        number = _number;
    }
}
