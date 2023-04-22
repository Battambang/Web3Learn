// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.8.3/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts@4.8.3/access/Ownable.sol";

contract MyToken is ERC1155, Ownable {
    uint256[] maxSupplies = [10, 5, 20];
    uint256[] mintedSupplies = [0, 0, 0];
    uint256[] fees = [0.01 ether, 0.01 ether, 0.05 ether];

    constructor() ERC1155("https://api.mytestwebsite.com/tokens/{id}") {}

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
        payable
    {
        require(id <= maxSupplies.length, "Token does not exist");
        require (id > 0, "No id 0 Token");
        uint256 index = id - 1;

        require(mintedSupplies[index] + amount <= maxSupplies[index], "Cannot mint more" );
        require(msg.value >= amount * fees[index], "no ether provided");
        mintedSupplies[index] += amount; 
        _mint(account, id, amount, data);
    }

    function withdraw() public onlyOwner {
        require (address(this).balance > 0, "Balance is 0");
        payable(owner()).transfer(address(this).balance);
    }
}
