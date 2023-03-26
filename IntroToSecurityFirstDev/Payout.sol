// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PayoutContract {
    struct Payee {
        address addr;
        uint256 value;
    }

    Payee[] payees;

    function payOut() {
        uint i = 0;
        while (i < payees.length) {
            payees[i].addr.send(payees[i].value);
        }
    }
}

// added onlyOwner modifier, 
// set owner in the constructor,
// implement addPayee function
// payOut function now uses a for loop instead of a while loop
// used .call instead of .send because it is the recommended method for sending ether
contract PayoutContract2 {
    address private owner;

    struct Payee {
        address addr;
        uint256 value;
    }

    Payee[] payees;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addPayee(address _addr, uint256 _value) public onlyOwner {
        payees.push(Payee(_addr, _value));
    }

    function payOut() public onlyOwner {
        for (uint i = 0; i < payees.length; i++) {
            (bool sent, ) = payees[i].addr.call{value: payees[i].value}("");
            require(sent, "Payment failed.");
        }
    }
}
