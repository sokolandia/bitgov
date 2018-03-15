pragma solidity ^0.4.0;

import { Base } from 'Base';
import { Voter } from 'Voter';
import { Bill } from 'Bill';
import { Token } from 'Token';

contract Organization is Base {
    /*
    Currency of the organization
    */
    Token token;

    function Organization(){

    }
    /*
    Transfers employee's salary
    @param employee - employee's private address
    @param voter - employee's voter address
    @param amount - salary before taxes
    */
    function payEmployee(address employee, Voter voter, uint256 amount) onlyOwner {
        // transfer salary to employee
        token.transferTaxableIncome(employee, voter, amount);
    }
}
