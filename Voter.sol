pragma solidity ^0.4.0;

import { Base } from 'Base';
import { VotingDistrict } from 'VotingDistrict';
import { Bill } from 'Bill';
import { Organization } from 'Organization';

contract Voter is Base {
    /*
    Currency of the voter
    */
    Token token;

    /*
    Bills voter voted for
    */
    Bill[] bills;

    /*
    The contract address of voting districts voter registered in
    */
    VotingDistrict[] votingDistricts;

    /*
    Delegated votes
    */
    Voter[] delegated;

    function Voter(){

    }

    /*
    Get all bills voter voted for plus all active bills in voter's voting district
    */
    function getActiveBills() returns (Bill[] active_bills) {
        active_bills = bills;
        for (uint i = 0; i < votingDistricts.length; i++) {
            district_active_bills = votingDistricts[i].getActiveBills();
            for (uint j = 0; j < district_active_bills.length; j++) {
                // if the bill is not already in active bills
                if (!active_bills.includes(district_active_bills[i])) {
                    active_bills.push(district_active_bills[i]);
                }
            }
        }
    }

    /*
    Delegate vote to another voter
    */
    function addDelegate(Voter voter) onlyOwner {
        // add the voter the an array of votes delegated to another voter
        voter.delegated.push(this);
    }

    /*
    Revoke delegation of the vote from another voter
    */
    function removeDelegate(Voter voter) onlyOwner {
        // remove the voter from an array of votes delegated to another voter
        voter.delegated.remove(this);
    }

    /*
    Vote on behalf of the voters who delegated their votes
    */
    function addDelegatedVotes(Bill bill) onlyOwner {
        for (uint i = 0; i < delegated.length; i++) {
            bill.addVote(delegated[i]);
        }
    }

    /*
    Revoke votes of the voters who delegated their votes
    */
    function removeDelegatedVotes(Bill bill) onlyOwner {
        for (uint i = 0; i < delegated.length; i++) {
            bill.removeVote(delegated[i]);
        }
    }

}
