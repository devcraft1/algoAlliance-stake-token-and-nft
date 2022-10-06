// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "./ERC20Token.sol";
import "./NFTCollection.sol";

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
        ERC20Token contractAddr;
    }

    struct NFTDetails {
        uint256 id;
        string name;
        string symbol;
        address owner;
        NFTCollection contractAddr;
    }

    mapping(uint256 => ERC20Details) erc20Details;
    mapping(uint256 => NFTDetails) nftDetails;

    mapping(address => bool) ERC20Tokens;
    mapping(address => bool) NFTCollections;

    function CreateContract(
        bool option,
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply
    ) public {
        bool setOption = option;
        // if true it Creates NFT contract
        if (setOption == true) {
            ERC20Token erc20token = createERC20Token(
                _name,
                _symbol,
                _initialSupply
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

    function createNFTCollection(string memory _name, string memory _symbol)
        private
        returns (NFTCollection)
    {
        return new NFTCollection(_name, _symbol);
    }

    function createERC20Token(
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply
    ) private returns (ERC20Token) {
        return new ERC20Token(_initialSupply, _name, _symbol);
    }

    // CONTRACT METHODS
    function ownerOfERC20Contract(uint256 index)
        external
        view
        returns (address)
    {
        require(
            index == erc20Details[index].id,
            "Owner with this address does not exist"
        );
        return erc20Details[index].owner;
    }

    function ownerOfNFTContract(uint256 index) external view returns (address) {
        require(
            index == nftDetails[index].id,
            "Owner with this address does not exist"
        );
        return nftDetails[index].owner;
    }

    function erc20ContractAddressByIndex(uint256 index)
        external
        view
        returns (ERC20Token)
    {
        require(
            index == erc20Details[index].id,
            "Owner with this address does not exist"
        );
        return erc20Details[index].contractAddr;
    }

    function nftContractAddressByIndex(uint256 index)
        external
        view
        returns (NFTCollection)
    {
        require(
            index == nftDetails[index].id,
            "Owner with this address does not exist"
        );
        return nftDetails[index].contractAddr;
    }

    // function getERC20Details(uint256 index)
    //     external
    //     view
    //     returns (
    //         ERC20Token,
    //         string memory,
    //         string memory,
    //         address
    //     )
    // {
    //     require(
    //         index == erc20Details[index].id,
    //         "Owner with this id does not exist"
    //     );
    //     string memory _name = erc20Details[index].name;
    //     string memory _symbol = erc20Details[index].symbol;
    //     address _owner = erc20Details[index].owner;
    //     ERC20Token _contractAddress = erc20Details[index].contractAddr;
    //     return (_contractAddress, _name, _symbol, _owner);
    // }

    //   function getNFTDetails(uint256 index)
    //     external
    //     view
    //     returns (
    //         NFTCollection,
    //         string memory,
    //         string memory,
    //         address
    //     )
    // {
    //     require(
    //         index == nftDetails[index].id,
    //         "Owner with this id does not exist"
    //     );
    //     string memory _name = nftDetails[index].name;
    //     string memory _symbol = nftDetails[index].symbol;
    //     address _owner = nftDetails[index].owner;
    //     NFTCollection _contractAddress = nftDetails[index].contractAddr;
    //     return (_contractAddress, _name, _symbol, _owner);
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
}
