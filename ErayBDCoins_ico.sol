// ErayBDCoins ICO

// version of the compiler
pragma solidity ^0.4.11;

contract ErayBDCoin_ico {

    // introducing the maximum number of ErayBDCoins available for sale
    uint public max_ErayBDCoins = 1000000;

    // introducing the USD to ErayBDCoins conversion rate
    uint public usd_to_ErayBDCoins = 1000;

    // introducing the total number of ErayBDCoins that have been bought by the investors
    uint public total_ErayBDCoins_bought = 0;

    // mapping from the investor address to its equity in ErayBDCoins and USDm
    mapping(address => uint) equity_ErayBDCoins;
    mapping(address => uint) equity_usd;

    //checking if an investor can buy ErayBDCoins
    modifier can_buy_ErayBDCoins(uint usd_invested) {
        require(usd_invested * usd_to_ErayBDCoins + total_ErayBDCoins_bought <= max_ErayBDCoins);
        _;
    }

    // getting the equity in ErayBDCoins of an investor
    function equity_in_ErayBDCoins(address investor) external constant returns (uint) {
        return equity_ErayBDCoins[investor];
    }


    // getting the equity in USD of an investor
    function equity_in_USD(address investor) external constant returns (uint) {
            return equity_usd[investor];
        }

    // buying ErayBDCoins
    function buy_ErayBDCoins(address investor, uint usd_invested) external can_buy_ErayBDCoins(usd_invested) {
        uint ErayBDCoins_bought = usd_invested * usd_to_ErayBDCoins;
        equity_ErayBDCoins[investor] += ErayBDCoins_bought;
        equity_usd[investor] = equity_ErayBDCoins[investor] / usd_to_ErayBDCoins;
        total_ErayBDCoins_bought += ErayBDCoins_bought;
    }

    // selling ErayBDCoins
    function sell_ErayBDCoins(address investor, uint ErayBDCoins_sold) external {
        equity_ErayBDCoins[investor] -= ErayBDCoins_sold;
        equity_usd[investor] = equity_ErayBDCoins[investor] / usd_to_ErayBDCoins;
        total_ErayBDCoins_bought -= ErayBDCoins_sold;
    }

}