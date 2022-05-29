// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract SimpleStorage {

    uint256 public number; // Note that I made this variable public 

    function store(uint256 num) public virtual {
        number = num;
    }

    function retrieve() public view returns(uint256) {
        return number;
    }

}