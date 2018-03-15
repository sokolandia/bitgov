pragma solidity ^0.4.0;

contract Base {
    address owner;
    function Base() internal {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
    }
}
