
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title EG Life Token
 * @dev एक सुरक्षित और विशेष फीचर्स से लैस ERC20 टोकन स्मार्ट कॉन्ट्रैक्ट
 */

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract EGLifeToken is ERC20, Ownable, ReentrancyGuard {
    uint256 private constant INITIAL_SUPPLY = 1000000 * (10 ** 18);

    constructor() ERC20("EG Life Token", "EGLIFE") {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    /**
     * @dev Owner विशेष address को टोकन ट्रांसफर कर सकता है
     */
    function airdrop(address to, uint256 amount) external onlyOwner nonReentrant {
        _transfer(owner(), to, amount);
    }

    /**
     * @dev Emergency के समय में contract में मौजूद token को वापस ले सकते हैं
     */
    function emergencyWithdraw() external onlyOwner nonReentrant {
        uint256 balance = balanceOf(address(this));
        _transfer(address(this), owner(), balance);
    }
}
