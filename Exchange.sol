// SPDX-License_Identifier: MIT
pragma solidity^0.8.0;

contract Exchange{

    address public owner ;

    mapping (address => mapping (address => uint256 )) public balances;

    mapping (address=>bool) public authorizedTokens;

    uint256 public fee=0.1 ether;

    event Deposit (address indexed token ,address indexed user ,uint256 amount);
    event withdraw(address indexed token,address indexed user ,uint256 amount);
     event trade(address indexed token,address indexed buyer ,address seller, uint256 amount,
     uint256 price );

     constructor(){
         owner=msg.sender;


     }

     modifier onlyOwner(){
         require(msg.sender==owner,"only owner can call this function");
         _;
     }

     function deposit (address token,uint256 amount)public {
         require(authorizedTokens[token],"Token is not authorized");
         require(amount >0,"Amount must be greater zero");

         balances[token][msg.sender]+=amount;
         emit Deposit(token,msg.sender,amount);

     }

     function Withdraw(address token ,uint256 amount) public {
         require(balances[token][msg.sender]>=amount,"insufficient balance ");
         balances[token][msg.sender]-=amount;
         emit withdraw(token,msg.sender,amount);


     }

     function authorizedToken(address token) public onlyOwner{
         authorizedTokens[token]=true;

     }
       function revokeAccess(address token) public onlyOwner{
         authorizedTokens[token]=false ;

     }

     function setfee(uint256 newfee) public onlyOwner{
         fee=newfee;

     }
     function Trade(address token,address seller ,uint256 amount ,uint256 price ) public payable
     {
         require(msg.value == fee, "insufficient fee");
         require(balances[token][seller]>=amount,"Insufficient Amount");
         require(balances[address(this)][msg.sender]>=amount*price,"Insufficient exchange balance ");

         balances[token][seller]-= amount;
         balances [token][msg.sender]+=amount;
         balances[address(this)][msg.sender]-=amount*price;
         balances[address(this)][seller]+=amount*price;

         emit trade(token,msg.sender,seller,amount ,price);



     }
      

   
   

    


}