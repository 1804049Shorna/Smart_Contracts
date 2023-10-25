// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract voting {

    address public chairman ;
    address[] public BoardMemebers ;
    uint256 public VotEndTime ;
    bool public VotingClose;
    uint256 totalvotes;
    uint256 voteChairman;
    mapping (address => bool) public VoteDone ;

    mapping (address => bool) public regiteredvoters;
    mapping (address=>bool) public  notVotecount;
    mapping(address => uint256) public boardMemberVotes;
    mapping (address => bool) public  electedBoardmembers;


    constructor(address[] memory regBoardmember, uint256 votingtime ){
        chairman=msg.sender;
        BoardMemebers=regBoardmember;
        VotEndTime=block.timestamp+ votingtime*1 minutes ;
        VotingClose=false;

        for (uint256 i=0; i<regBoardmember.length;i++){
           regiteredvoters[regBoardmember[i]] =true;
        }
     }

     modifier  isChairman(){
        require(msg.sender==chairman,"Only chairman can do this");
        _;
     }
    modifier isRegister(){
        require(regiteredvoters[msg.sender],"Only register voter can can do this");
        _;
     }
     modifier isVoteOpen(){
        require(block.timestamp<VotEndTime && !VotingClose,"Voting is no longer avaiable");
        _;

     }

     // for  people to be register voter 
     function regForVote (address people) public {
        require(!regiteredvoters[people],"You already register for vote");
        regiteredvoters[people]=true;
     }
     //for voting chairman
     function ChairmanVote() external isRegister isVoteOpen {
        require(!VoteDone[msg.sender],"You have already voted");
        VoteDone[msg.sender]=true;
        voteChairman++;
        totalvotes++;


     }
     function VoteBoardMember() external isRegister isVoteOpen{
        require(!VoteDone[msg.sender],"You have already voted");
        VoteDone[msg.sender]=true;
        totalvotes++;
        boardMemberVotes[msg.sender]++;

     }
     function Notvote() external isRegister isVoteOpen{
        require(!VoteDone[msg.sender],"You already gave your vote");
        VoteDone[msg.sender]=true;
        notVotecount[msg.sender]=true;
        totalvotes++;
     }

     function electcharmain() external isChairman isVoteOpen{
        require(block.timestamp >= VotEndTime, "Voting Open");
        uint256 highestVote=voteChairman++;
        address WinnerChairman=chairman;

         for (uint256 i = 0; i < BoardMemebers.length; i++) {
            if (notVotecount[BoardMemebers[i]]) {
                continue;
            }

            if (boardMemberVotes[BoardMemebers[i]] > highestVote) {
                highestVote = boardMemberVotes[BoardMemebers[i]];
                WinnerChairman = BoardMemebers[i];
            }
        }

        chairman=WinnerChairman;
        voteChairman=0;
        totalvotes=0;
        VotingClose=true;


     }

     function electBoardMemeber() external isChairman isVoteOpen{
        require(block.timestamp >= VotEndTime, "Voting Open");
        for(uint256 i=0; i<BoardMemebers.length;i++)
        {
            if(notVotecount[BoardMemebers[i]])
            {
                continue ;
            }
            else {
                electedBoardmembers[BoardMemebers[i]]=true;
            }
        }
        VotingClose=true;

        
     }


}