// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Lottery{
    address public manager;
    address[] public player;
    
    constructor(){
        manager = msg.sender;
        //msg is a global variable provided in every contract
        //it has information about the data,sender,gas and value(ether)
    }
    
    function enter() public payable{
        require(msg.value > 0.01 ether);
        player.push(msg.sender);
    }
    
    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,player.length)));
    }
    
}