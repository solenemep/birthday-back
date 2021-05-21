// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Pour remix il faut importer une url depuis un repository github
// Depuis un project Hardhat ou Truffle on utiliserait: import "@openzeppelin/ccontracts/utils/Address.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";

contract Birthday {
    // library usage
    using Address for address payable;

    // State variables
    address private _owner;
    uint256 private _birthday;

    // Events
    event Offered(address indexed sender, uint256 amount);

    // constructor
    constructor(address owner_, uint256 birthday_) {
        _owner = owner_;
        _birthday = birthday_;
    }

    // modifiers
   modifier onTime() {
       require(block.timestamp >= _birthday, "Birthday : not your birthday yet !");
       _;
   }
   
   modifier onlyOwner() {
       require(msg.sender == _owner, "Birthday : this gift is not for you.");
       _;
   }

    // Function declarations below
    receive() external payable {
        emit Offered(msg.sender, msg.value);
    }
    
    function offer() external payable {
        emit Offered(msg.sender, msg.value);
    }
    
    function getGift() public onTime onlyOwner {
        payable(msg.sender).sendValue(address(this).balance);
    }
    
    function remainingTime() public view returns (uint256) {
        require(_birthday >= block.timestamp, "Birthday : birthday has passed.");
        return _birthday - bloc.timestamp; 
    }

    // Add getters