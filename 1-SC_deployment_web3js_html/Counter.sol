// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.19;

contract Counter {

    uint256 count;

    function increment() public returns (uint256) {
        count++;
        return count;
    }
}