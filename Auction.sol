// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// The contract below is open to Denial of Service attacks
// if the caller is a contract which implements a malicious
// fallback/receive function
// that contract could keep reverting and thus not letting Auction
// do its job
contract Auction {
    address highestBidder;
    uint highestBid;

    function bid() payable {
        require(msg.value > highestBid);

        highestBidder.transfer(highestBid);

        highestBidder = msg.sender;
        highestBid = msg.value;
    }
}

contract Auction2 {
    address highestBidder;
    uint256 highestBid;
    mapping(address => uint256) credits;

    function bid() public payable {
        require(msg.sender == tx.origin, "only EOAs are allowed");
        require(msg.value > highestBid);

        credits[msg.sender] += highestBid;

        highestBidder = msg.sender;
        highestBid = msg.value;
    }

    function withdrawCredits() public {
        uint256 amount = credits[msg.sender];
        require(amount > 0);

        credits[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to withdraw credits");
    }
}
