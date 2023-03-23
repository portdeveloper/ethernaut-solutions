// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract X {
    uint256 public counter;
    constructor() {
        counter = 0;
    }

    function increment() public {
        counter +=1;
    }
}

contract Y {
    uint public counter;
    constructor() {
        counter = 0;
    }

    function increment1(address contractX) public {
        (bool success, ) = contractX.delegatecall(
            abi.encodeWithSignature("increment()")
        );
    }
    
    function increment2(address contractX) public {
        (bool success, ) = contractX.call(
            abi.encodeWithSignature("increment()")
        );
    }
}
