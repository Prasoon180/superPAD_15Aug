//SPDX-License-Identifier:GPL-3.0
pragma solidity ^0.8.16;
import "github.com/Prasoon180/superPAD_Project_5_AUG_2022/blob/main/IBEP20";
import "@openzeppelin/contracts/access/Ownable.sol";

 contract IDO is Ownable  {                   // This is main contract ie; IDO.sol


IBEP20  public  BEP20Address;
uint public _WeeksforPrivate;
uint public _WeeksforPublic;         // define variable of weeks and months of individual item
uint public _MonthsforReward;
uint public _MonthsforReserve = 13;    // due to 1 year lockup
uint public _MonthsforTeam = 13;       // due to 1 year lockup
uint public _MonthsforMarket;
uint public _MonthsforLiquidity;

uint public _TimeLockforPrivate;
uint public _TimeLockforPublic;
uint public _TimeLockforReserve;
uint public _TimeLockforReward;             // define variable of Timelock of individual item
uint public _TimeLockforTeam;
uint public  _TimeLockforLiquidity;
uint public _TimeLockforMarket;


/*  owner of smart contract.
BEP20 address put in IDO contract in Constructor */

constructor(address _BEP20Address)   {
    BEP20Address = IBEP20(_BEP20Address); 
     _TimeLockforPrivate = block.timestamp; 
    _TimeLockforPublic = block.timestamp;
    _TimeLockforReward = block.timestamp; 
    _TimeLockforReserve = block.timestamp + 31104000 seconds;   // 12 months = 31104000 seconds
    _TimeLockforTeam = block.timestamp + 31104000 seconds;       // 12 months = 31104000 seconds
    _TimeLockforLiquidity = block.timestamp;
    _TimeLockforMarket = block.timestamp;               
    }

/*
 Here Timelock is initial time set for individual item
 */



/*  function define for private
* 9 months equal weekly unlocking starting at TGE ---Token Distribution
* 1 WEEK = 604800 seconds*/ 
   
function _private(address to , uint _amount) external onlyOwner {


    if(_WeeksforPrivate < 40) {                // _weeks = 40
    require(block.timestamp > _TimeLockforPrivate, "1 WEEK NOT OVER");
     BEP20Address.transfer( to, _amount);                           
     _WeeksforPrivate ++;
    _TimeLockforPrivate += 604800 seconds;       
    
}

}

/*  function define for public
* 3 months equal weekly unlocking starting at TGE ---Token Distribution
* 1 WEEK = 604800 seconds */

function _public(address to, uint _amount) external onlyOwner {
                
      if( _WeeksforPublic < 14) {                   // _weeks = 15
          require(block.timestamp > _TimeLockforPublic, "1 WEEK NOT OVER");
          BEP20Address.transfer( to, _amount);
          _WeeksforPublic ++;
          _TimeLockforPublic += 604800 seconds;                
      }
    
    }

/*  function define for reward
* 10% TGE then linearly over 12 Months ---Token Distribution
* 1 MONTH = 30 DAYS ;   30 DAYS = 2592000 seconds*/  

function reward(address to, uint _amount) external onlyOwner {
   
               
              
    if( _MonthsforReward < 26) {                    // _weeks = 26
       require(block.timestamp >  _TimeLockforReward, "1 MONTH NOT OVER FOR REWARD");
          BEP20Address.transfer( to, _amount);
          _MonthsforReward ++;
          _TimeLockforReward += 2592000 seconds;    
    }
    
}

/*  function define for reserve
* 1 year lockup then linearly over 12 Months  ---Token Distribution
* 1 MONTH = 30 DAYS ;   30 DAYS = 2592000 seconds
* Wait for 12 Months & after this wait for 1 Month equally
*/

function reserve(address to, uint _amount) external onlyOwner {
                       
 
    if(_MonthsforReserve >= 13 && _MonthsforReserve < 26) {                // _weeks 13 to 25
       require(block.timestamp > _TimeLockforReserve, 
       "1 MONTH NOT OVER NOT OVER FOR RESERVE");
          BEP20Address.transfer( to, _amount);    
          _MonthsforReserve ++;
          _TimeLockforReserve += 2592000 seconds;  
    }
     
      //  block.timestamp - _TGEforReward > 2592000 seconds.
}

/* function define for market
*5% TGE then linearly over 12 months ---Token Distribution
* 1 MONTH = 30 DAYS ;   30 DAYS = 2592000 seconds*/

function market(address to, uint _amount) external onlyOwner {
                
    
    if( _MonthsforMarket < 26) {                               // _weeks = 26
       require(block.timestamp > _TimeLockforMarket, "1 MONTH NOT OVER FOR MARKET");
          BEP20Address.transfer( to, _amount);
          _MonthsforMarket ++;               
          _TimeLockforMarket += 2592000 seconds; 
    }
    
    }

      /* function define for team
      *1 year lockup then linearly over 12 months  ---Token Distribution
      * 1 MONTH = 30 DAYS ;   30 DAYS = 2592000 seconds
      * Wait for 12 Months & after this wait for 1 Month equally
      */
      
      function team(address to, uint _amount) external onlyOwner {

    if(_MonthsforTeam >= 13 && _MonthsforTeam < 26) {                         // _weeks = 13 to 25
       require(block.timestamp > _TimeLockforTeam, "1 MONTH NOT OVER NOT OVER FOR TEAM");
          BEP20Address.transfer( to, _amount);    
          _MonthsforTeam ++;
          _TimeLockforTeam += 2592000 seconds;  
    }
     
       }

        /* function define for liquidity
        *20% TGE then linearly over 12 Months ---Token Distribution
        * 1 MONTH = 30 DAYS ;   30 DAYS = 2592000 seconds*/

    function liquidity(address to, uint _amount) external onlyOwner {

    if( _MonthsforLiquidity < 14) {              // _months = 14
       require(block.timestamp > _TimeLockforLiquidity, "1 MONTH NOT OVER FOR LIQUIDITY");
          BEP20Address.transfer( to, _amount);
          _MonthsforLiquidity ++;
          _TimeLockforLiquidity += 2592000 seconds;           
    }
      
    }

}

