//SPDX-License-Identifier:MIT
pragma solidity ^0.8.13;


contract STRUCT{

    struct todo{

        string text ;
        bool completed;

    }
    todo[] public todos;

    function create(string calldata _text)public{
        //3 ways to initialize a struct

        // calling it like a function

        todos.push(todo(_text,false));

        // key value mapping 
        todos.push(todo({text:_text,completed:false}));
    

     // creating an empty  struct then push it into the main struct 
        todo memory tod;
        tod.text=_text;
        todos.push(tod);






    }

    //

    function get(uint i) public view returns (string memory text ,bool completed ){

        todo storage todo=todos[i];
        return(todo.text ,todo.completed);

    }

    //update completed 

    function togglecomleted (uint i) public{
        todo storage todo=todos[i];
        todo.completed=!todo.completed;

    }


}