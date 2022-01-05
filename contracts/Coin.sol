// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Coin is ERC20 {

    uint32 public constant VERSION = 1;
    uint8 private constant DECIMALS = 18;
    uint256 private constant TOKEN_WEI = 10**uint256(DECIMALS);
    uint256 private constant INITIAL_WHOLE_TOKENS = uint256(1.5 * (10**9));
    uint256 private constant INITIAL_SUPPLY =
        uint256(INITIAL_WHOLE_TOKENS) * uint256(TOKEN_WEI);

    constructor() ERC20("Coin", "COIN") {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

}