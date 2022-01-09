// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "./interfaces/IERC20.sol";

contract Invest {

    address public owner;
    address public coin;
    uint256 public MAXAMOUNT = 0;
    mapping(address => uint256) public amountPaid;
    mapping(address => bool) whitelist;
    uint256[4] lootBox;
    address[4] tokens;

    constructor(address _coin, uint256 _maxAmount, uint256 _rare, uint256 _epic, uint256 _legendary) {
        owner = msg.sender;
        coin = _coin;
        MAXAMOUNT = _maxAmount;
        lootBox[0] = _rare;
        lootBox[1] = _epic;
        lootBox[2] = _legendary;
        // lootBox[3] = _cosmic;
    }

    modifier onlyOwner {
      require(msg.sender == owner);
      _;
    }

    modifier tokensSet{
        require(tokens[0] != address(0) && tokens[1] != address(0) && tokens[2] != address(0) && tokens[3] != address(0));
        _;
    }
    modifier isWhitelisted{
        require( whitelist[msg.sender], "whitelist only");
        _;
    }


    function setCoin (address _coin) external onlyOwner{
        coin = _coin;
    }

    function setWhitelist (address _user) external onlyOwner{
        whitelist[_user] = true;
    }

    function setMaxAmount (uint256 _maxAmount) external onlyOwner{
        MAXAMOUNT = _maxAmount;
    }

    function setLootBoxValue(uint256 _rare, uint256 _epic, uint256 _legendary, uint256 _cosmic) external onlyOwner{
        lootBox[0] = _rare;
        lootBox[1] = _epic;
        lootBox[2] = _legendary;
        // lootBox[3] = _cosmic;
    }

    function setTokens(address _rare, address _epic, address _legendary, address _cosmic) external onlyOwner{
        require(_rare != address(0) && _epic != address(0) && _legendary != address(0) && _cosmic != address(0));
        tokens[0] = _rare;
        tokens[1] = _epic;
        tokens[2] = _legendary;
        tokens[3] = _cosmic;
    }

    function invest(uint256 _amount) external tokensSet{
        require((amountPaid[msg.sender] + _amount) <= MAXAMOUNT,"MAX AMOUNT");
        IERC20(coin).transferFrom(msg.sender, address(this), _amount);
        amountPaid[msg.sender] = amountPaid[msg.sender] + _amount;
        _mintToken(msg.sender, _amount);       
    }

    function _mintToken(address _to, uint256 _amount) internal tokensSet{
        if(_amount < lootBox[0]){
            IERC20(tokens[0]).mint(_to, 1);
        } else if(_amount < lootBox[1]){
            IERC20(tokens[1]).mint(_to, 1);
        } else if(_amount < lootBox[2]){
            IERC20(tokens[2]).mint(_to, 1);
        } else {
            IERC20(tokens[3]).mint(_to, 1);
        }
    }

    function withdrawCoin() external onlyOwner{
        uint256 amount = IERC20(coin).balanceOf(address(this));
        IERC20(coin).transfer(msg.sender, amount);
    }
}
