// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./simpleStorage.sol";

contract StorageFactory {

    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    //function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
    //    return simpleStorageArray[_simpleStorageIndex].retrieve(); 
    //}

    // My version of sfGet that directly tries to return the number w/o any intermediate method like retrieve
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        return simpleStorageArray[_simpleStorageIndex].number();
    }

}