// source: https://docs.soliditylang.org/en/v0.8.11/solidity-by-example.html#blind-auction

// SPDX-License-Identifier: GPL-3.0
//comment: pragma solidity ^0.8.4;
/**
 * @notice invariant forall (address p) withdrawCount[p] <= 1
 */
contract SimpleAuction {
    // Parameters of the auction. Times are either
    // absolute unix timestamps (seconds since 1970-01-01)
    // or time periods in seconds.
    address payable public beneficiary;
    uint public auctionEndTime;

    // Current state of the auction.
    address public highestBidder;
    uint public highestBid;

    // Allowed withdrawals of previous bids
    mapping(address => uint) pendingReturns;

    // Set to true at the end, disallows any change.
    // By default initialized to `false`.
    bool ended;

    // Events that will be emitted on changes.
    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    // Errors that describe failures.

    // The triple-slash comments are so-called natspec
    // comments. They will be shown when the user
    // is asked to confirm a transaction or
    // when an error is displayed.

    // The auction has already ended.
//comment:    error AuctionAlreadyEnded();
    // There is already a higher or equal bid.
//comment:    error BidNotHighEnough(uint highestBid);
    // The auction has not ended yet.
//comment:    error AuctionNotYetEnded();
    // The function auctionEnd has already been called.
//comment:    error AuctionEndAlreadyCalled();

    mapping(address=>uint) withdrawCount;

    /// Create a simple auction with `biddingTime`
    /// seconds bidding time on behalf of the
    /// beneficiary address `beneficiaryAddress`.
    constructor(
        uint biddingTime,
        address payable beneficiaryAddress
    ) public {
        beneficiary = beneficiaryAddress;
        auctionEndTime = block.timestamp + biddingTime;
    }

    /// Bid on the auction with the value sent
    /// together with this transaction.
    /// The value will only be refunded if the
    /// auction is not won.
    function bid() external payable {
        require(withdrawCount[msg.sender] <= 1);
        // No arguments are necessary, all
        // information is already part of
        // the transaction. The keyword payable
        // is required for the function to
        // be able to receive Ether.

        // Revert the call if the bidding
        // period is over.
        if (block.timestamp > auctionEndTime)
//comment:             revert AuctionAlreadyEnded();
		revert("block.timestamp > auctionEndTime");

        // If the bid is not higher, send the
        // money back (the revert statement
        // will revert all changes in this
        // function execution including
        // it having received the money).
        if (msg.value <= highestBid)
//comment:            revert BidNotHighEnough(highestBid);
	    revert("msg <= highestBid");

        if (highestBid != 0) {
            // Sending back the money by simply using
            // highestBidder.send(highestBid) is a security risk
            // because it could execute an untrusted contract.
            // It is always safer to let the recipients
            // withdraw their money themselves.
            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncreased(msg.sender, msg.value);
        assert(withdrawCount[msg.sender] <= 1);
    }

    /// Withdraw a bid that was overbid.
    function withdraw() external returns (bool) {
        require(withdrawCount[msg.sender] <= 1);
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            // It is important to set this to zero because the recipient
            // can call this function again as part of the receiving call
            // before `send` returns.
            pendingReturns[msg.sender] = 0;

            if (!msg.sender.send(amount)) {
                // No need to call throw here, just reset the amount owing
                pendingReturns[msg.sender] = amount;
                return false;
            }
            withdrawCount[msg.sender] += 1;
        }
        assert(withdrawCount[msg.sender] <= 1);
        return true;
    }

    /// End the auction and send the highest bid
    /// to the beneficiary.
    function auctionEnd() external {
        // It is a good guideline to structure functions that interact
        // with other contracts (i.e. they call functions or send Ether)
        // into three phases:
        // 1. checking conditions
        // 2. performing actions (potentially changing conditions)
        // 3. interacting with other contracts
        // If these phases are mixed up, the other contract could call
        // back into the current contract and modify the state or cause
        // effects (ether payout) to be performed multiple times.
        // If functions called internally include interaction with external
        // contracts, they also have to be considered interaction with
        // external contracts.
        require(withdrawCount[msg.sender] <= 1);

        // 1. Conditions
        if (block.timestamp < auctionEndTime)
 //comment           revert AuctionNotYetEnded();
            revert("block.timestamp < anctionEndtime");
        if (ended)
 //comment           revert AuctionEndAlreadyCalled();
	    revert("ended");

        // 2. Effects
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);

        // 3. Interaction
        beneficiary.transfer(highestBid);
        assert(withdrawCount[msg.sender] <= 1);
    }

//    function withdrawOnce(address p) public view {
//      assert(withdrawCount[p] <= 1);
//
//    }
}
