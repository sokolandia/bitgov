pragma solidity ^0.4.0;

import { Base } from 'Base';
import { Token } from 'Token';
import { Voter } from 'Voter';
import { VotingDistrict } from 'VotingDistrict';

contract Bill is Base {
    /*
    Currency of the bill
    */
    Token token;

    /*
    Flat tax rate of the bill (0, 1)
    */
    uint256 rate;

    /*
    The address of bill's beneficiary
    */
    address beneficiary;

    /*
    Voters who voted in support of the bill
    */
    Voter[] public voted;

    /*
    Bill's voting district (optional)
    */
    VotingDistrict votingDistrict;

    /*
    Bill's commission
    */
    uint256 commission;

    function Bill(uint256 _rate, address _beneficiary, VotingDistrict _votingDistrict) {
        rate = _rate;
        beneficiary = _beneficiary;
        votingDistrict = _votingDistrict;
    }

    /*
    Vote in support of the bill
    */
    function addVote(Voter voter) isRegisteredVoter {
        voter.bills.push(this);
        voted.push(voter);
    }

    /*
    Revoke support of the bill
    */
    function removeVote(Voter voter) isRegisteredVoter {
        voter.bills.remove(this);
        voted.remove(voter);
    }

    modifier isRegisteredVoter() {
        if (votingDistrict) {
            require(votingDistrict.registeredVoters.includes(msg.sender));
        }
    }

}

contract EmissionBill is Bill {
    /*
    Monthly funds allocated by the bill to the beneficiary
    */
    uint256 funds;

    /*
    Last time the beneficiary was funded by the bill
    */
    Date lastTimeFunded;
}