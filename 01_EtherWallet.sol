//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// Smart contract to accept ethers and only owner will able to withdraw.

contract EthWallet{

    // address of the owner
    address payable public owner;  
              //payable: used to send and recieve ether.i.e address payable can transfer and send ethers.  
              //public is a modifier
   // event for the withdrawl and deposit

    event Deposit(address indexed account, uint amount);
    event Withdraw(address indexed account, uint amount);

    // event : used to save the transation on blockchain with less gas as compaired to state variables .
    // indexed: used to do indexing so we can find it on blockchain.
    
    constructor(){
        owner =payable(msg.sender);   // msg sender is the address of the ethereum, the owner of the contract. 
    }
   
   // modifier is used to check the prerequisite;
   // Here the sender must be owner other wise through exception

    modifier onlyOwner(){
        require(msg.sender==owner,"caller is not owner");
        _;  // this is same as continue,  if the above condition of modifier is satisfied while calling this function, the function is executed and otherwise, an exception is thrown.
    }

    // fatch the balance
    function getBalance() external view returns (uint balance){
        return address(this).balance;    // return the balance of this/owner/contract account

    }

   // withdraw the ethers from owner account only by user. 
    function withdraw(uint _amount) external onlyOwner{
        payable(msg.sender).transfer(_amount);

        emit Withdraw(msg.sender, _amount);  // emit is used to send the data on blockchain.
    }
  
  // receive the ethers from user.
    receive() external payable{
        emit Deposit(msg.sender, msg.value);
    }
    
    fallback() external payable{} // it is generally call when no function is called  

}
// Know more about receive and fallback
// https://betterprogramming.pub/solidity-0-6-x-features-fallback-and-receive-functions-69895e3ffe