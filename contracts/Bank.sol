// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Bank  {

    mapping(address=>uint) public balance;
    uint public Total_Supply= 100;

    function mint(address _to, uint _amount) public {
        require(_amount>0 ,"Error");
        Total_Supply+=_amount;
        balance[_to]+= _amount;
    }

        function Burn(uint amount,address _to) public {
        
        if (amount >= balance[_to]) {
            revert("Insufficient balance ");
        }
        balance[msg.sender] -= amount;
        Total_Supply-=amount;

    }
        function check_balance(address _user )public view returns (uint){
            assert(balance[_user] >= 0);
            return balance[_user];
        }
    }

