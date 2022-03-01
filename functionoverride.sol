pragma solidity >=0.4.0 <0.7.0;

//FUNCTION OVERRIDDING ARE WHEN A FUNCTION NAME IS THE SAME IN THE SAME SCOPE BUT THE FUNCTION DIFFERS FROM EACH OTHER BY THE TYPES OR THE NUMBER OF ARGUMENT.

contract functionOveride{

    function Addsum(uint a , uint b, uint c) public view returns(uint){
        return a + b + c ;
    }
     function Addsum(uint a , uint b , uint c, uint d)public returns (uint){
         return a + b + c + d ;
     }
}
