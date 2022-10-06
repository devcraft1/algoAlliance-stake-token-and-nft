// // contracts/GameItem.sol
// // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";

// contract NFTToken is ERC721URIStorage {
//     using Counters for Counters.Counter;
//     Counters.Counter private _tokenIds;

//     constructor(string memory _name, string memory _symbol, string memory tokenURI) ERC721(_name, _symbol) {
//         uint256 newItemId = _tokenIds.current();
//         _mint(msg.sender, newItemId);
//         _setTokenURI(newItemId, tokenURI);
//         _tokenIds.increment();
//     }

//     function mint(address minter, string memory tokenURI)
//         external
//         returns (uint256)
//     {
//         uint256 newItemId = _tokenIds.current();
//         _mint(minter, newItemId);
//         _setTokenURI(newItemId, tokenURI);

//         _tokenIds.increment();
//         return newItemId;
//     }
// }

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTCollection is ERC721Enumerable {
    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
    {}

    uint256 count = 0;

    function mint(uint256 _amount, address _user) public {
        for (uint256 i; i < _amount; ++i) {
            _safeMint(_user, totalSupply());
            incrementId();
        }
    }

    function getId() public view returns (uint256) {
        return count;
    }

    function incrementId() public {
        count++;
    }
}
