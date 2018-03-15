pragma solidity ^0.4.0;

import { Base } from 'Base';
import { Bill } from 'Bill';
import { Voter } from 'Voter';

contract VotingDistrict is Base {
    /*
    Currency of the voting district
    */
    Token token;

    /*
    Voters registered to vote in a given district
    */
    Voter[] registeredVoters;

    /*
    Bills that are considered by a given district
    */
    Bill[] bills;

    /*
    District's commission
    */
    uint256 commission;

    function VotingDistrict() {

    }

    /*
    Get bills with more than 50% support of registered voters
    */
    function getActiveBills() returns (Bill[] active_bills) {
        for (uint i = 0; i < bills.length; i+=1) {
            bill = bills[i];
            // Bill is considered active if it has more then 50% support of registered voters
            if (bill.voted.length > 0.5 * registeredVoters.length) {
                active_bills.push(bills[i]);
            }
        }
    }

    /*
    Add registered voter
    */
    function addVoter(Voter voter) onlyOwner {
        registeredVoters.push(voter);
    }

    /*
    Remove voter
    */
    function removeVoter(Voter voter) onlyOwner {
        registeredVoters.remove(voter);
    }

    /*
    Add bill
    */
    function addBill(Bill bill) isRegisteredVoterOrOwner {
        bills.push(bill);
    }

    modifier isRegisteredVoterOrOwner() {
        require(msg.sender == owner || registeredVoters.includes(msg.sender));
    }
}
