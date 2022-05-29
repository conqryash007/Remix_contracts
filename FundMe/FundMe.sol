// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol"; // importong library

// custom errors
error NotOwner();

contract FundMe{

    using PriceConverter for uint256; // mapping library to any type

    uint constant MIN_USD = 50 * 1e18;
    address[] public funders;
    mapping(address=>uint) public addressToAmtFunded;

    address public immutable i_owner;
    // Constructor
    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable{
        require(msg.value.getConversionRate() >= MIN_USD,"Didn't send enough!!");

        funders.push(msg.sender);
        addressToAmtFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner{
        for(uint i =  0 ; i<funders.length ; i++){
            addressToAmtFunded[funders[i]] = 0;
        }
        funders = new address[](0);

        // transfer amount to sender

        (bool res,) = payable(msg.sender).call{value: address(this).balance}("");

        require(res,"Failed!!!");
    }

    modifier onlyOwner(){
        // require(msg.sender == i_owner,"Not the owner!!!"); (this is before v0.8)
        if( msg.sender != i_owner){ revert NotOwner(); }
        _;
    }

    // fallback & receive

    fallback() external payable{
        fund();
    }
    receive() external payable{
        fund();
    }
}