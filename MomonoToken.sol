// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title MOMONO Token (MONO)
 * @dev A meme token with a fixed supply deployed by a professional contract
 */
contract MomonoToken is ERC20, Ownable {
    uint256 private constant _initialSupply = 12_000_000 * 10 ** 18;

    constructor() ERC20("MOMONO", "MONO") Ownable(msg.sender) {
        _mint(msg.sender, _initialSupply);
    }

    /**
     * @dev Get the total initial supply
     */
    function initialSupply() external pure returns (uint256) {
        return _initialSupply;
    }

    /**
     * @dev Owner can recover any ERC20 tokens accidentally sent to the contract
     */
    function recoverERC20(address tokenAddress, uint256 tokenAmount) external onlyOwner {
        require(tokenAddress != address(this), "MOMONO: Cannot recover MONO");
        IERC20(tokenAddress).transfer(owner(), tokenAmount);
    }
}
