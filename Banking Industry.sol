// SPDX-License_Identifier: MIT
pragma solidity^0.8.0;

contract Banking {
    mapping(address => uint256) public balances ;

    address payable owner ;

    constructor() public{
        owner=payable(msg.sender);

    }

    function deposit() public payable {
        require(msg.value>0,"Deposit amount must be greater to zero");
        balances[msg.sender]+=msg.value ;

    }

    // function withdraw(uint amount) public payable {
    //     require(msg.sender==owner,"only owner can withdraw funds");
    //     require(amount<=balances[msg.sender],"Insufficient funds");
    //     require(amount>0,"withdrawal amount must be greater than 0");
    //     payable(msg.sender).transfer(amount);
    //     balances[msg.sender]-=amount;

    // }
     function withdraw( uint amount) public  {
       // require(msg.sender==owner,"only owner can withdraw funds");
        require(amount<=balances[msg.sender],"Insufficient funds");
        require(amount>0,"withdrawal amount must be greater than 0");
        payable(msg.sender).transfer(amount);
        balances[msg.sender]-=amount;

    }

    //function to transfer fund 
    function transfer(address payable recipent ,uint amount)public {
        require(amount<=balances[msg.sender],"Insufficient funds");
        require(amount>0,"withdrawal amount must be greater than 0");
        balances[msg.sender]-=amount;
        balances[recipent]+=amount;

       }
    //function to check the balance of an account 

    function getBalance(address payable user) public view returns(uint){
        return balances [user];
    }

    //function to grant access 
    //only owner can grant access
    function grantAccess (address payable user2) public{
        require(msg.sender==owner, "This is not your account");
    }
    //revoke acccess 
    //asssinging ownership to another user 
    function revokeaccess(address payable user3) public {
        require(msg.sender==owner ,"Only the owener can revoke access");
        require(user3!=owner,"Cannot revoke access for cuurent owner ");
        owner =payable(msg.sender);
    }

    function destroy() public {
        require(msg.sender==owner,"only the owner can destroy the contract");
        selfdestruct(owner);
    }


}