// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;

contract Miller {
    address owner;
    uint contractCut = 10; //10%, the percentage would be divided in the payToCreator
    constructor (address _owner){
        owner = _owner;
    }

    function payToCreator (uint _amount, address _creator) payable external {
        require(_amount == msg.value, "wrong amount");
        uint cut = (contractCut * _amount)/ 100;
        uint creatorCut = _amount - cut;
        require (address(this).balance >= creatorCut, "Insufficient contract balance" );
        payable(address(_creator)).transfer(creatorCut);
    }

    function checkContractBalance () external view returns (uint){
        return address(this).balance;
    }
    function drainContract (uint _amount) external {
        require(msg.sender == owner, "not owner");
        require (address(this).balance >= _amount, "Insufficient contract balance" );
        payable(address(owner)).transfer(_amount);
    }


    receive() external payable{}
}

