// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "./IERC20Token.sol";

contract SmartInterface {
    IERC20 public erc20;
    IERC20Metadata public erc20Metadata;

    //  IERC721 public erc721;
    //  IERC721Metadata public erc721Metadata;

    constructor(
        IERC20 _erc20,
        IERC20Metadata _erc20Metadata /*IERC721 _erc721,  IERC721Metadata _erc721Metadata*/
    ) {
        erc20 = _erc20;
        erc20Metadata = _erc20Metadata;
        //  erc721 = _erc721;
        //  erc721Metadata= _erc721Metadata;
    }

    //  ERC20 CALLS
    function TokenName() external view returns (string memory) {
        return IERC20Metadata(erc20Metadata).name();
    }

    function TokenSymbol() external view returns (string memory) {
        return IERC20Metadata(erc20Metadata).symbol();
    }

    function TokenDecimals() external view returns (uint8) {
        return IERC20Metadata(erc20Metadata).decimals();
    }

    function TokenMintERC20(
        address contractAddress,
        address to,
        uint256 amount
    ) external {
        IERC20Token(contractAddress).mintToken(to, amount);
    }

    function TokenTotalSupply() external view returns (uint256) {
        //  = wallets[index];
        return IERC20(erc20).totalSupply();
    }

    function TokenbalanceOf(address owner) external view returns (uint256) {
        return IERC20(erc20).balanceOf(owner);
    }

    function TokenTransfer(address receiver, uint256 amount)
        external
        returns (bool)
    {
        return IERC20(erc20).transfer(receiver, amount);
    }

    function TokenTransferFrom(
        address sender,
        address receiver,
        uint256 amount
    ) external returns (bool) {
        return IERC20(erc20).transferFrom(sender, receiver, amount);
    }

    function TokenAllowanceERC20(address owner, address spender)
        external
        view
        returns (uint256)
    {
        return IERC20(erc20).allowance(owner, spender);
    }

    function TokenApprove(address spender, uint256 amount)
        external
        returns (bool)
    {
        return IERC20(erc20).approve(spender, amount);
    }

    //     // ERC721 CALLS

    //     function NFTname (string memory) external view returns(string memory){
    //          return  IERC721Metadata(erc20).name() ;
    //     }

    //   function NFTsymbol(string memory) external view returns(string memory){
    //          return  IERC721Metadata(erc20).symbol() ;
    //     }

    //      function tokenURI(uint256 tokenId) external view returns(string memory){
    //          return  IERC721Metadata(erc20).tokenURI(tokenId) ;
    //     }

    //     function balanceOfNFT(address owner)external view returns(uint256){
    //     return IERC721(erc20).balanceOf(owner);
    //     }

    //      function ownerOf(uint256 tokenId)external view returns(address){
    //     return IERC721(erc20).ownerOf(tokenId);
    //     }

    //     function safeTransferFromWithBytes(address from, address to, uint256 tokenId, bytes memory data)external{
    //     return IERC721(erc20).safeTransferFrom(from, to, tokenId, data);
    //     }

    //     function safeTransferFrom(address from, address to, uint256 tokenId)external{
    //     return IERC721(erc20).safeTransferFrom(from, to, tokenId);
    //     }

    //     function transferFrom(address from, address to, uint256 tokenId)external {
    //         return IERC721(erc20).transferFrom(from, to, tokenId);

    //     }

    //      function approve(address spender, uint256 tokenId)external{
    //     return IERC721(erc20). approve(spender, tokenId);
    //     }

    //       function getApproved(uint256 tokenId)external view returns(address){
    //     return IERC721(erc20).getApproved(tokenId);
    //     }

    //        function setApprovalForAll(address operator, bool _approved)external {
    //     return IERC721(erc20).setApprovalForAll(operator, _approved);
    //     }

    //         function isApprovedForAll(address owner, address operator)external view returns(bool) {
    //     return IERC721(erc20).isApprovedForAll(owner, operator);
    //     }

    //     function supportsInterface(bytes4 interfaceId)external view returns(bool) {
    //     return IERC165(erc20).supportsInterface(interfaceId);
    //     }
}
