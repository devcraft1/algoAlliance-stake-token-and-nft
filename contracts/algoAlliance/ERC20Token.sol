// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Token is ERC20 {
    constructor(
        uint256 initialSupply,
        string memory _name,
        string memory _symbol
    )
        // address minter
        ERC20(_name, _symbol)
    {
        _mint(msg.sender, initialSupply);
    }

    receive() external payable {}

    function mint(uint256 amount) public {
        _mint(msg.sender, amount);
    }
}
