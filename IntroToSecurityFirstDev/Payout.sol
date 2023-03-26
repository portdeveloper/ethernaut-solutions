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
// this contract may be vulnerable to reentrancy attacks
pragma solidity ^0.8.0;

contract PayoutContract2 {
    address private owner;

    struct Payee {
        address addr;
        uint256 value;
    }

    Payee[] payees;

    event PayeeAdded(address indexed _addr, uint256 _value);
    event Payout(address indexed _addr, uint256 _value);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addPayee(address _addr, uint256 _value) public onlyOwner {
        require(_addr != address(0), "Invalid address");
        require(_value > 0, "Value must be greater than 0");
        payees.push(Payee(_addr, _value));
        emit PayeeAdded(_addr, _value);
    }

    function payOut() public onlyOwner {
        uint step = 10;
        uint remaining = payees.length;
        for (uint i = 0; i < payees.length; i += step) {
            uint batch = remaining < step ? remaining : step;
            for (uint j = i; j < i + batch; j++) {
                (bool sent, ) = payees[j].addr.call{value: payees[j].value}("");
                require(sent, "Payment failed.");
                emit Payout(payees[j].addr, payees[j].value);
            }
            remaining -= batch;
        }
    }
}
