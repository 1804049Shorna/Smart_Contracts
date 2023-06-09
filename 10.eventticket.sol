//SPDX-License-Identifier:MIT
pragma solidity ^0.8.13;



 contract eventticket{

     uint public numberofticket;
     uint public ticketprice;
     uint public totalamount;
     uint public startat;
     uint public endat;
     uint public timerange;
     string public s="buy your first event ticket ";

     constructor (uint price){
         ticketprice=price;
         startat=block.timestamp;
         endat=block.timestamp+7 days;
         timerange=(endat-startat)/60/60/24;
     }

         function buyticket(uint _value) public returns(uint256 ticketid){
             numberofticket++;
             totalamount+=_value;
             ticketid=numberofticket;
         }


     }



     
      
  



