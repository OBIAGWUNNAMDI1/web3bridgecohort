// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {

    event BalancedCheck(address owner , uint amount);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 value) external view returns(uint256);
}