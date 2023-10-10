// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract insurance {
    address[] public policyholdders;
    mapping(address => uint256) public policies; 

    mapping(address => uint256) public claims;
    address payable owner;
    uint256 public totalpremium;

    constructor() public {
        owner= payable(msg.sender);
    }
    function purchascepolicy (uint256 premium) public payable{
        require(msg.value==premium, "Incorrect premium amount");
        require(premium>0,"premium must be greater than zero");
        policyholdders.push(msg.sender);
        policies[msg.sender]=premium;
        totalpremium +=premium ;

   }

   function fileclaim(uint256 amount) public {
    require(policies[msg.sender]>0 ,"Must have a valid policy to file a claim");
    require(amount >0,"Must have enough amount to claim a file");
    require (amount<=policies[msg.sender],"claim amount can not exceed policy");
    claims[msg.sender]+=amount;



   }

   function approveClaim (address policyholder) public{
    require(msg.sender==owner,"only the owner can approve claims ");
    require(claims[policyholder]>0,"policyholder has no outstanding claims");
    payable(policyholder).transfer(claims[policyholder]);
    claims[policyholder]=0;

   }
   function getpolicy(address policyholder) public view returns (uint256){
    return policies[policyholder];
   }
   function getclaim(address policyholder)public view returns (uint256){
    return claims[policyholder];
   }
   function gettotal() public view returns(uint256){
    return totalpremium;
   }
   function grantAccess(address payable user) public{
    require(msg.sender==owner,"only the owner can grant access");
    owner=user;
   }
}