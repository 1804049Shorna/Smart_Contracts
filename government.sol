// SPDX-License_Identifier: MIT
pragma solidity^0.8.0;

contract Government{

    address[] public citizen ;
    address[] public officials;
    address payable owner;
    mapping(address => bool) public isOfficial;

    constructor() public{
        owner=payable(msg.sender);

    }

    function registercitizen() public {

        require (!isOfficial[msg.sender],"can not register as a citizen ,already registered as officials ");
        citizen.push(msg.sender);

    }
    function registerofficial() public {

        require (!isOfficial[msg.sender],"can not register  ,already registered as officials ");
        officials.push(msg.sender);
        isOfficial[msg.sender]=true ;       

    }
    function vote(address candidate) public{
        require(!isOfficial[msg.sender],"officials can not vote");

    }
     function proposal(string memory proposallaw) public{
        require(isOfficial[msg.sender],"Only officials can propose law");


    }
    function enactlaw(string memory proposal) public {
        require(msg.sender==owner,"Only the owner can enact law ");
    }

    function getofficials() public view returns (address[] memory){
        return officials;
    }

    function grantAccess(address payable user) public{
        require(msg.sender==owner ,"only the owner can call this function");

        owner=user;
    }
    function destroy() public{
        selfdestruct(owner);
    }

    


}