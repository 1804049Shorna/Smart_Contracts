// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract googledrive{

    struct Access{
        address user ;
        bool access;//true or false 


    }
    mapping (address=>string[]) value ;
    mapping (address=>mapping(address=>bool))ownership;

    mapping (address => Access[]) accesslist ;

    mapping(address => mapping(address=>bool)) previousData;

   //function to store the url 

   function add(address _user, string memory url) external {
    value[_user].push(url);


   }
   // function to grant access to user 

   function giveAccess(address user) external {
      ownership[msg.sender][user]=true;

      if(previousData[msg.sender][user])
      {
        for(uint256 i=0; i<accesslist[msg.sender].length;i++)
        {
            if(accesslist[msg.sender][i].user==user)
            {
               accesslist[msg.sender][i].access=true;
            }
            
        }

       
      }
      else {
         accesslist[msg.sender].push(Access(user,true));
         previousData[msg.sender][user]=true;
      }
      



   }

   function disallow(address user) public{
    ownership[msg.sender][user]=false;
    for(uint256 i=0; i < accesslist[msg.sender].length;i++)
    {
        if(accesslist[msg.sender][i].user==user){
            accesslist[msg.sender][i].access=false;
        }
    }
   }
   // function to dissplay all the image 
   function display(address _user) external view returns (string[] memory ){
         require(_user==msg.sender|| ownership[_user][msg.sender],"You dont have access to these contents");
         return value[_user];
   }
   // function get all the accesslist 
   function shareAccess() public view returns(Access[] memory){
    return accesslist[msg.sender];
   }

     
}