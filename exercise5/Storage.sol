// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Storage {
    address public owner;
    mapping(address => uint256) private userNumbers;

    // Events
    event NumberStored(address indexed user, uint256 number);
    event OwnerUpdatedUser(address indexed targetUser, uint256 number, address indexed owner);

    // Modifiers
    modifier notZero(uint256 _num) {
        require(_num != 0, "Cannot store zero");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    // Constructor
    constructor() {
        owner = msg.sender;
    }

    // Store a number for the caller
    function store(uint256 num) public notZero(num) {
        userNumbers[msg.sender] = num;
        emit NumberStored(msg.sender, num);
    }

    // Retrieve the number stored by a specific user
    function retrieve(address user) public view returns (uint256) {
        return userNumbers[user];
    }

    // Owner can store a number for any user
    function storeForUser(address user, uint256 num) public onlyOwner notZero(num) {
        userNumbers[user] = num;
        emit OwnerUpdatedUser(user, num, msg.sender);
    }
}
