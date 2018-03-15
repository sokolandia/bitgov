pragma solidity ^0.4.0;

import { Base } from 'Base';
import { Bill, EmissionBill } from 'Bill';
import { Voter } from 'Voter';

contract Token is Base {
    /*
    An array with all balances
    */
    mapping (address => uint256) public balanceOf;

    function Token(uint256 initialSupply){
        balanceOf[msg.sender] = initialSupply;
    }

    /*
    Standard transfer method
    */
    function transfer(address _to, uint256 _value) {
        require(balanceOf[msg.sender] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
    }

    /*
    Extended transfer method
    */
    function transferTaxableIncome(address to, Voter voter, uint256 value) {
        this.transferTaxableIncomeToAddress(to, voter, value);
        this.distributeTaxesToBeneficiaries(voter, value);
    }

    /*
    Transfer salary from an employer to employee
    */
    function transferTaxableIncomeToAddress(address to, Voter voter, uint256 value) {
        // transaction validity checks
        require(balanceOf[msg.sender] >= value);
        require(balanceOf[to] + value >= balanceOf[to]);

        // calculate overall tax rate of the voter
        Bill[] active_bills = voter.getActiveBills();
        uint rate = 1;
        for (uint i = 0; i < active_bills.length; i += 1) {
            rate -= active_bills[i].rate;
        }

        // check if tax rate is valid
        require(rate > 0);

        // subtract the full amount from the employer
        balanceOf[msg.sender] -= value;

        // add the amount minus taxes to the employee
        balanceOf[to] += rate * value;
    }

    /*
    Distribute taxes to bill's beneficiaries
    */
    function distributeTaxesToBeneficiaries(Voter voter, uint256 value) {
        Bill[] active_bills = voter.getActiveBills();
        for (uint i = 0; i < active_bills.length; i++) {
            Bill bill = active_bills[i];
            uint256 amount_before_commission = bill.rate * value;
            uint256 bill_commission = bill.commission * amount_before_commission;
            uint256 district_commission = 0;
            if (bill.votingDistrict) {
                district_commission = bill.votingDistrict.commission * amount_before_commission;
            }
            balanceOf[bill.beneficiary] += amount_before_commission - bill_commission - district_commission;
            balanceOf[bill.owner] += bill_commission;
            balanceOf[bill.votingDistrict] += district_commission;
        }
    }
}

contract SovereignToken is Token(10**10) {
    /*
    Token's voting district
    */
    VotingDistrict votingDistrict;

    function SovereignToken(VotingDistrict _votingDistrict) {
        votingDistrict = _votingDistrict;
    }

    /*
    Create tokens
    */
    function emitTokens(EmissionBill bill) {
        // check if bill wasn't funded in the last month
        if (now > bill.lastTimeFunded + 4 weeks) {
            balanceOf[bill.beneficiary] += bill.funds;
            bill.lastTimeFunded = now;
        }
    }

    /*
    Transfer salary from an employer to employee and destroy taxable tokens
    */
    function transferTaxableIncome(address to, Voter voter, uint256 value) {
        this.transferTaxableIncomeToAddress(to, voter, value);
    }
}