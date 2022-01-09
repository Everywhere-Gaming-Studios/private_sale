// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract Token is ERC20 {

    address public owner;
    address public investContract;

    // uint8 private constant DECIMALS = 5;
    // uint256 private constant TOKEN_WEI = 10**uint256(DECIMALS);
    // uint256 private constant INITIAL_WHOLE_TOKENS = uint256(25 * (10**5));
    // uint256 private constant INITIAL_SUPPLY =
    //     uint256(INITIAL_WHOLE_TOKENS) * uint256(TOKEN_WEI);

    constructor(address _investContract, string memory _name) ERC20(_name, "COSMICPRVT") {
        owner = msg.sender;
        investContract = _investContract;
    }

    modifier investContractOnly{
        require(msg.sender == investContract, "investContract Only");
        _;
    }

    function mint(address to, uint256 amount) external investContractOnly{
        _mint(to, amount);
    }


}
