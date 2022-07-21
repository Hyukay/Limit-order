

pragma solidity ^0.8.0;

// SPDX-License-Identifier: MIT

import '@uniswap/v2-periphery/contracts/UniswapV2Router02.sol';


contract LimitOrder{

    UniswapV2Router02 pool;

    address internal constant UniswapV2Router02 = "0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D";
    address[] internal constant tokens = [ "0x64ff637fb478863b7468bc97d30a5bf3a428a1fd","0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"];



    //function that takes as input the amouint of usdc I want to spend and the target price of ONE ether
    function createLimitOrder(uint256 amount, uint256 ethPrice) public payable {
        amount = amount * 1000000000000000000;
        ethPrice = ethPrice * 1000000000000000000;
        uint256 currentETHUSDprices = pool.getAmountsOut(1, tokens);
        uint256 currentETHprice = currentETHUSDprice[0];
        
        //check if the amount of usdc is greater than the amount of usdc in the account
        if(ethPrice == currentETHprice) {
            
            uint256 amountToReceive = amount / currentETHprice;
                //try to execute order
            tryorder(amount,amount*0.99, tokens, msg.sender,block.timestamp);


        }
        
    }

    //function that tries to execute that order on uniswap and if it succeeds it will return the amount of usdc that was spent
    function tryOrder(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline) internal payable returns(uint256[]){


       uint256[] amountSpent = pool.swapETHForExactTokens(amountIn, amountOutMin, path, to, deadline);

         return amountSpent;

    }
    




}