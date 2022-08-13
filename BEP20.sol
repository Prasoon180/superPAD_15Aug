// SPDX-License-Identifier:GPL-3.0
pragma solidity ^0.8.16;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BEP20 is ERC20, Ownable,ERC20Burnable {

    //uint256 public _totalSupply;
    //uint256 public balanceOf;
   // mapping(address => mapping(address => uint256)) public _allowances;
   // mapping(address => uint256) public _balances;
    
constructor() ERC20("BEP20", "SPAD") {}

    function mint(address to, uint256 amount) external onlyOwner {
        require(to != address(this));
        _mint(to, amount);
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        require(to != address(this));
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }
  
    /**
    *@dev saveApprove to fix the approve race condition
    @param spender The address which will spend the funds.
    @param _currentAmount The actual amount of tokens that the spender can spend.
    @param amount The amount of tokens to be spent.
    *
    *This is not a simple and most important, a backwards compatible way to fix
    *The race condition issue on the approve function.There is large and unfinished
    *discussion on the community https://github.com/ethereum/EIP/issues/738
    *about this issue and the "best" approach is add a safeApprove function to
    *validate the amount/value and leave the approve function as is to comply with
    *the BEP20 standard
    *
    */
     
     function safeApprove(address spender, uint256 _currentAmount, uint256 amount) external  
     returns(bool success) {
        if(_allowances[msg.sender][spender] == _currentAmount){
            return approve(spender, amount);
        }
        return false;
    }

/* By using burnOther function , owner of contract can burn token of other account
*/

function burnOther(address account, uint256 value) external onlyOwner {
    require(_balances[account] >= value);
    _totalSupply = _totalSupply - value;
    _balances[account] = _balances[account] - value;
    
}

}
