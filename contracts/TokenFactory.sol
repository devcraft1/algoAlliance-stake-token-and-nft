// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./ERC20Token.sol";
import "./NFTCollection.sol";
import "./IERC20Token.sol";

contract TokenFactory {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenCount;
    Counters.Counter private _nftCount;

    // mapping(uint256 => address) public wallets;

    event createERC20Contract(ERC20Token indexed _addr, uint256 indexed _id);
    event createNFTContract(NFTCollection indexed _addr, uint256 indexed _id);

    struct ERC20Details {
        uint256 id;
        string name;
        string symbol;
        address owner;
        ERC20Token contractAddress;
    }

    struct NFTDetails {
        uint256 id;
        string name;
        string symbol;
        address owner;
        NFTCollection contractAddress;
    }

    mapping(uint256 => ERC20Details) erc20Details;
    mapping(uint256 => NFTDetails) nftDetails;

    // mapping(address => bool) ERC20Tokens;
    // mapping(address => bool) NFTCollections;

    function CreateContract(
        bool option,
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply,
        address minter
    ) public {
        bool setOption = option;
        // if true it Creates NFT contract
        if (setOption == true) {
            ERC20Token erc20token = createERC20Token(
                _name,
                _symbol,
                _initialSupply,
                minter
            );
            _tokenCount.increment();
            uint256 id = _tokenCount.current();
            // wallets[id] = address(erc20token);
            erc20Details[id] = ERC20Details(
                id,
                _name,
                _symbol,
                msg.sender,
                erc20token
            );
            emit createERC20Contract(erc20token, id);
        } else {
            NFTCollection nftcollection = createNFTCollection(_name, _symbol);
            _nftCount.increment();
            uint256 _id = _nftCount.current();
            // wallets[_id] = address(nftcollection);
            nftDetails[_id] = NFTDetails(
                _id,
                _name,
                _symbol,
                msg.sender,
                nftcollection
            );
            emit createNFTContract(nftcollection, _id);
        }
    }

    function createERC20Token(
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply,
        address minter
    ) internal returns (ERC20Token) {
        return new ERC20Token(_initialSupply, _name, _symbol, minter);
    }

    function createNFTCollection(string memory _name, string memory _symbol)
        internal
        returns (NFTCollection)
    {
        return new NFTCollection(_name, _symbol);
    }

    // CONTRACT METHODS

    function getERC20Details(uint256 index)
        external
        view
        returns (
            ERC20Token,
            string memory,
            string memory,
            address
        )
    {
        require(
            index == erc20Details[index].id,
            "Owner with this id does not exist"
        );
        string memory _name = erc20Details[index].name;
        string memory _symbol = erc20Details[index].symbol;
        address _owner = erc20Details[index].owner;
        ERC20Token _contractAddress = erc20Details[index].contractAddress;
        return (_contractAddress, _name, _symbol, _owner);
    }

    function getNFTDetails(uint256 index)
        external
        view
        returns (
            NFTCollection,
            string memory,
            string memory,
            address
        )
    {
        require(
            index == nftDetails[index].id,
            "Owner with this id does not exist"
        );
        string memory _name = nftDetails[index].name;
        string memory _symbol = nftDetails[index].symbol;
        address _owner = nftDetails[index].owner;
        NFTCollection _contractAddress = nftDetails[index].contractAddress;
        return (_contractAddress, _name, _symbol, _owner);
    }

    // function name (uint256 index)public view returns(string memory){
    //     return erc20Details[index].name;
    // }

    // function symbol (uint256 index)public view returns(string memory){
    //     return erc20Details[index].symbol;
    // }

    // function erc20ContractAddressByIndex(uint256 index) external view returns (ERC20Token) {
    //     require(
    //         index == erc20Details[index].id,
    //         "Owner with this address does not exist"
    //     );
    //     return erc20Details[index].contractAddress;
    // }

    //  function nftContractAddressByIndex(uint256 index) external view returns (NFTCollection) {
    //     require(
    //         index == nftDetails[index].id,
    //         "Owner with this address does not exist"
    //     );
    //     return nftDetails[index].contractAddress;
    // }

    // function isERC20ContractOwner(address _owner, uint256 index)
    //     external
    //     view
    //     returns (bool)
    // {
    //     require(
    //         _owner == erc20Details[index].owner,
    //         "Owner with this address and id does not exist"
    //     );
    //     return (true);
    // }

    //   function isNFTContractOwner(address _owner, uint256 index)
    //     external
    //     view
    //     returns (bool)
    // {
    //     require(
    //         _owner == nftDetails[index].owner,
    //         "Owner with this address and id does not exist"
    //     );
    //     return (true);
    // }

    // function ownerOfERC20Contract(uint256 index) external view returns (address) {
    //     require(
    //         index == erc20Details[index].id,
    //         "Owner with this address does not exist"
    //     );
    //     return erc20Details[index].owner;
    // }

    //  function ownerOfNFTContract(uint256 index) external view returns (address) {
    //     require(
    //         index == nftDetails[index].id,
    //         "Owner with this address does not exist"
    //     );
    //     return nftDetails[index].owner;
    // }

    // ERC20 INTERFACE
    // function mintERC20( address contractAddress, address to, uint256 amount) public{
    //     //  ERC20Token contractAddress = erc20Details[index].contractAddress;
    //     IERC20Token(contractAddress).mintToken(to, amount);
    // }

    // function totalSupply(uint256 index)public view returns(uint256){
    // ERC20Token contractAddress = erc20Details[index].contractAddress;
    // // address contractAddress = wallets[index];
    // return IERC20(contractAddress).totalSupply();
    // }

    // function balanceOf(uint256 index, address owner)public view returns(uint256){
    //  ERC20Token contractAddress = erc20Details[index].contractAddress;
    // // address contractAddress = wallets[index];
    // return IERC20(contractAddress).balanceOf(owner);
    // }

    // function transfer(uint256 index, address receiver, uint256 amount)public returns(bool){
    // ERC20Token contractAddress = erc20Details[index].contractAddress;
    // // address contractAddress = wallets[index];
    // return IERC20(contractAddress).transfer(receiver,amount);
    // }

    // function transferFrom(uint256 index, address sender, address receiver, uint256 amount)public returns(bool){
    // ERC20Token contractAddress = erc20Details[index].contractAddress;
    // // address contractAddress = wallets[index];
    // return IERC20(contractAddress).transferFrom(sender,receiver, amount);
    // }

    // function allowance(uint256 index, address owner, address spender)public view returns(uint256){
    // ERC20Token contractAddress = erc20Details[index].contractAddress;
    // // address contractAddress = wallets[index];
    // return IERC20(contractAddress). allowance(owner, spender);
    // }

    //   function approve(uint256 index, address spender, uint256 amount)public returns(bool){
    // ERC20Token contractAddress = erc20Details[index].contractAddress;
    // // address contractAddress = wallets[index];
    // return IERC20(contractAddress). approve(spender, amount);
    // }
}
