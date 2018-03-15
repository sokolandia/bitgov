# Bitgov

This document describes a general purpose blockchain-based fiscal framework. Its purpose is to collect income taxes and to re-distribute them to non-profit organizations that are usually funded by the government like schools and hospitals as well as to hire private contractors to do public works like construction of roads and bridges. It also changes perspective on the conventional way of distribution of power.

The framework described below relies on self-organization and does not require any central authority. As a market driven system it is self regulated and at the same time it is not susceptible to speculative bubbles and economic inequity. All the power in the system belongs to the citizens and is controlled by the direct democracy.

All aspects of a fiscal system are captured in a set of smart-contracts that represent a voter - an individual citizen; a bill - a piece of legislation; a voting district - a form of citizen cooperation; an organization - any entity or corporation that employs people; and an extension of a standard ERC20 token contact.

An interaction between users and the system is accomplished through the web and mobile clients that provide interfaces to examine contract&#39;s state and to make authorized changes to the contracts owned by the different actors of the system.

## Voting District

A contract that represents a group of people who are registered to vote on a set of bills. Contract can be owned and managed by a government entity, municipality, community organization or a private contractor. **Contract owner&#39;s purpose is to register voters** and to do so it may employ qualified personnel and have some form of identity verification procedure that may require presence of a voter in person at a physical address.

District may be based on a geographical location ranging from an apartment complex to a country. The state or local authority can produce laws that mandate participation of all of its citizens in certain districts otherwise districts are optional to join. **Any entity may start a voting district for the purpose of collective funding of some cause.**

A process of voter registration may vary based on the district&#39;s scope. State government may create a single contract for all of its citizens. To get registered a voter will require some form of a government-issued identification like a passport or a driving license. Local authorities in their voting districts may require some form of proof the voter resides in a certain geographical location. Those kinds of districts mirror administrative division of a country and generally fall into a category of country-, province-, county- and city-based voting districts. Ideally there should be laws that require every citizen to register with a set of government-mandated voting districts. However **the system as a whole does not rely solely on the government&#39;s authority** and can be completely self-organized.

On the level of individual communities non-government entities can create voting districts that specialize on the needs of those communities. Apart from location-based districts there also can be interests-based voting districts that are created to promote some cause with funding. Those types of districts will have to convince voters to register with them. The popularity of the district and the amount of funds that goes through it is a function of its reputation among the members of the community and the respect for its cause.

Voters registered in a certain district may add bills to that district&#39;s contract and vote on all of the bills added to that district&#39;s contract. District&#39;s contract owner may also add bills to the contact. **Bill is considered**  **passed**  **if it gets more than 50% of the votes out of all registered voters and will apply to all voters registered in that district.**

**District funds itself via commission** that it collects from all transactions that occur as a result of funds being allocated by the bills that have passed in that district. It creates a monetary incentive for districts to compete for voters and to suggest better bills that will more likely pass the vote. **It also makes it possible for the district to hire professionals or private contractors who specialize in voting district management.**

Voting district contract must include following state variables:

- A list of voter addresses registered to vote in a given district.
- A list of bill addresses that are up for consideration by the registered voters.
- Voting district&#39;s commission rate.

Voting district contract must implement following methods:

- Add/remove a voter&#39;s contract address to/from the list of registered voters. Can be invoked only by voting district&#39;s contract owner.
- Add a bill&#39;s contract address to the list of district&#39;s bills. Can be invoked only by a voter registered with a district or by a district&#39;s contract owner.
- Get all active bills from the list of district&#39;s bills. Bill is active if it has more than 50% of votes of district&#39;s registered voters.

## Bill

A contract that represents a piece of tax legislation that is intended to fund some specific address called bill&#39;s beneficiary. **Bill&#39;s purpose is to allocate funds and to deliver them to the bill&#39;s beneficiary.** Anyone can publish a bill on the blockchain however the bill&#39;s contract owner can&#39;t change the state of the bill once it&#39;s published. All changes to the bill&#39;s state come from voting such that **it keeps addresses of the voters who voted in support of the bill.**

A bill may or may not be tied to a specific voting district. In a former case anyone can vote on a bill, in a latter - only voters registered in that district can vote on it. To be formally considered in a certain district a bill must be added to that district&#39;s contract either by the district itself or by a voter registered in that district. For a bill to pass in a given district it must acquire a majority support of all the voters registered in that district. **If a bill passes it applies to all registered voters in a district** and from that moment onwards is law. A vote for the bill may be withdrawn by a voter at any moment and **if the bill loses majority support it doesn&#39;t apply to every voter in a district anymore** but only to voters whose votes are still in the bill&#39;s contract.

**The main characteristic of the bill is its tax rate:** a percentage of a taxable income of a voter that should be transferred to the bill&#39;s beneficiary. The rate may not necessarily be fixed rather specified as a set of tax brackets with different rates for different ranges of income. Tax brackets may include zero rate for incomes below some threshold.

Bill may specify a commission rate that will apply to all transfer transaction that occur as the result of this bill. **The author of the bill - the owner of the bill&#39;s contact - is entitled to a financial reward for the bill&#39;s activity.** This way legislative power becomes more distributed, competitive and in-sync with the market and the will of the people.

Bill contract must include following state variables:

- An address of bill&#39;s beneficiary – an entity that bill funds.
- A tax rate with tax brackets for different ranges of income.
- A list of voter&#39;s addresses who voted in support of the bill.
- An address of a voting district (optional).
- Bill&#39;s commission rate.

Bill contract must implement following methods:

- Add/remove a voter&#39;s address to/from the list of bill&#39;s votes. If a voting district&#39;s address is specified it must check if the voter is in a list of the district&#39;s registered voters. May take as input multiple voter addresses when the votes are delegated.

## Voter

A contract that represents an individual tax-paying citizen. It gives a voter an ability to register with the voting districts and to vote on specific pieces of legislation. Voter may choose which bills to support and with which districts to register. There also may be state-mandated districts the voter has to register with by law.

The voter&#39;s contract holds all the bills the voter supports and pays taxes on. The voter also pays taxes on the bills that have majority support in a voter&#39;s district even if the voter didn&#39;t vote for those bills personally. **A vote can be added to or removed from the bill by a voter at any moment.**

Every voter is not expected to consider every bill rather **a vote can be delegated by the voter to another voter - a representative - who can then vote on the voter&#39;s behalf.** Any voter may become a representative and be delegated votes by the members of the community based on trust and personal respect. However if the representative loses standing in the community delegated votes may be revoked at any moment by individual voters.

Voter contract must include following state variables:

- A list of bills the voter voted for.
- A list of voting districts the voter is registered in.
- A list of other voters who delegate their vote to this voter.

Voter contract must implement following methods:

- Get the list of all bills that apply to the voter. The list includes all the bills in a voter&#39;s contract plus all active bills in a voter&#39;s voting districts.
- Delegate the right to vote on contract owner&#39;s behalf to another voter. May be invoked only by a contract owner.

## Organization

A contract that represents a corporation that employs tax-paying citizens. Its purpose is to transfer tokens to organization&#39;s employees from the contract&#39;s address.

Organization contract must implement following methods:

- Pay employee. Takes as input employee&#39;s personal address, employee&#39;s voter address and an amount to pay (salary).

## Token

A token contract that extends ERC20 standard and in addition to Transfer method implements Transfer taxable income method. **Its purpose is to transfer taxable income from an employer to an employee and to re-distribute a fraction of that income in taxes.**

Method takes as input employee&#39;s voter contract address, calls the method to get all employee&#39;s active bills and for each bill it transfers a fraction of employee&#39;s income to the bill&#39;s beneficiary according to the bill&#39;s rate. If the bill&#39;s rate is defined as a range of tax brackets then the appropriate rate is calculated based on the amount being transferred. Also at this point a voting district&#39;s and bill&#39;s commission is transferred to respective contract owners as a fraction of the bill&#39;s beneficiary income amount.

Token contract must implement following methods:

- Transfer taxable income. Is invoked by an organization&#39;s contract.

## Sovereign Token and Emission Bills

An extension of an idea of the government being represented by a set of smart contracts is a nation-wide token. A sovereign token contract must specify a voting district contract&#39;s address that represents the most top-level administrative voting district of the land. Into that district voters may introduce an extended bill contract – Emission Bill.

Emission bill together with a tax rate and a beneficiary must specify a monthly amount of tokens it can create and the date of the last token creation. It then must implement a method that will invoke a method on the token contact called Emit Tokens. It checks if the bill is active in the token&#39;s district meaning it has the majority voter support, then it checks that the bill wasn&#39;t called in the last month and proceeds to **create tokens and transfer them to the bill&#39;s beneficiary.**

When the Transfer taxable income method of the sovereign token contract is invoked **it doesn&#39;t transfer a fraction of voter&#39;s income to the beneficiary rather it destroys tokens** according to the Emission Bill&#39;s tax rate. That way there is an equilibrium: from one side Emit Tokens has the power to create tokens based on the current legislation and from another – Transfer taxable income will destroy tokens thus maintaining a monetary balance. The actual difference between created and destroyed tokens will depend on the collective decision making and may cause inflation if unbalanced. However everyone benefits if the system stays healthy and everyone loses if it doesn&#39;t. So eventually the public will self-organize and correct for undesired effects.

Sovereign Token contract must include following state variables:

- An address of the token&#39;s voting district.

Sovereign Token contract must implement following methods:

- Emit tokens. Takes an emission bill as input and transfers emitted tokens to bill&#39;s beneficiary.

Emission Bill contract must include following state variables:

- An amount of tokens the bill can emit.
- Last emission date.

Sovereign Token contract must implement following methods:

- Call token contract to emit tokens. Can be invoked by anyone.

## Contributing
The project lacks actual implementation so feel free to contribute.

## License
This project is licensed under the MIT License