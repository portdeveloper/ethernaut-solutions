// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Privacy {
    // slot 0 => takes a slot 
    bool public locked = true;
    // slot 1 => takes a slot because it cannot fit into slot 0
    uint256 public ID = block.timestamp;
    // slot 2 => the 3 variables below can fit into a slot 
    uint8 private flattening = 10;
    uint8 private denomination = 255;
    uint16 private awkwardness = uint16(block.timestamp);
    //slot 3, 4, 5 => an array of 32 byte elements with a fixed length of 3
    bytes32[3] private data;

    constructor(bytes32[3] memory _data) {
        data = _data;
    }

    // to use this function I need the first 16 bytes of the last element
    // of data array
    function unlock(bytes16 _key) public {
        require(_key == bytes16(data[2]));
        locked = false;
    }

    /*
    A bunch of super advanced solidity algorithms...

      ,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`
      .,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,
      *.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^         ,---/V\
      `*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.    ~|__(o.o)
      ^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'  UU  UU
  */
}
