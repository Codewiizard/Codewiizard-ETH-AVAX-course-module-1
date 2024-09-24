# Error Handling with require(), assert(), and revert() in Solidity

## Overview

This Solidity contract demonstrates error handling techniques using `require()`, `assert()`, and `revert()` statements. The contract simulates a simple token system where users can mint and burn tokens. The total token supply and user balances are tracked, and proper error handling is implemented to ensure security and reliability.


## Error Handling Mechanisms

1. **`require()`**:
   - Used to validate conditions before executing a function. If the condition fails, the transaction is reverted and any changes made during the transaction are undone.
   - Example: Ensuring that the minted amount is greater than 0 in the `mint()` function.

2. **`revert()`**:
   - Used to manually trigger a failure and revert the transaction. It is often used inside conditional statements to abort execution if a specific condition is not met.
   - Example: Reverting the transaction if the user tries to burn more tokens than they own in the `Burn()` function.

3. **`assert()`**:
   - Used to check for conditions that should never be false in a properly functioning contract. If an `assert` fails, there is likely a bug in the contract.

## Functions

### 1. `mint(address _to, uint _amount)`

This function mints new tokens to a specified address.

- **Parameters:**
  - `_to`: The address to which tokens are minted.
  - `_amount`: The number of tokens to mint.
  
- **Error Handling:**
  - `require(_amount > 0, "Error");`: Ensures that the amount of tokens to mint is greater than 0. If the condition is false, the transaction is reverted with the message "Error".

- **Updates:**
  - Increases the `Total_Supply` by the minted amount.
  - Adds the minted amount to the balance of the specified address.

### 2. `Burn(uint amount, address _to)`

This function burns (removes) tokens from a user's balance.

- **Parameters:**
  - `amount`: The number of tokens to burn.
  - `_to`: The address from which tokens will be burned.

- **Error Handling:**
  - `if (amount >= balance[_to]) { revert("Insufficient balance "); }`: Checks if the burn amount exceeds the user's balance. If the condition is true, the transaction is reverted with the message "Insufficient balance".

- **Updates:**
  - Decreases the user's balance and the total token supply.

### 3. `check_balance(address _user)`

This function checks the balance of a given user.

- **Parameters:**
  - `_user`: The address whose balance is to be checked.

- **Error Handling:**
  - `assert(balance[_user] >= 0);`: Ensures that the user's balance is non-negative. Since underflow is prevented in Solidity 0.8.0+, this is primarily used to confirm a logical assumption that balance cannot be negative. If the condition is false, the transaction is reverted.

- **Returns:**
  - The balance of the specified user.
 
## How To Use
-  You can use remix- an online solidity compiler to run this Program 
-  Create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension.
- Copy and paste the following code into the file.

```
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
```
Compile this contract on the lesft side of remix ,Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar.Then click on the "Deploy" button. Call the `mint()` function to add tokens to a specific address. Make sure to specify a positive amount, or the transaction will fail.

## Authors
Aashish Bhambri
## License
This contract is licensed under the MIT License. See `LICENSE` for more details.
