// SPDX-License-Identifier: GPL-2.0-or-later

pragma solidity >=0.7.0 <0.9.0;

contract NFT {
    struct NFTData {
        string name;
        string imageAddress;
    }

    NFTData[] _nfts;
    address public contractAddress;
    uint256 public suply = 3;
    

    constructor() {
        contractAddress = address(this);
    }

    function createNFT(string memory _name, string memory _imageAddress) public {
        require(_nfts.length < suply, "Maximum NFT limit reached");

        NFTData memory newNFT = NFTData(_name, _imageAddress);
        _nfts.push(newNFT);
    }

    function getNFT(uint256 _tokenId)
        public
        view
        returns (string memory, string memory, address)
    {
        require(_tokenId > 0 && _tokenId <= _nfts.length, "Invalid Token ID");

        NFTData memory nft = _nfts[_tokenId - 1];
        return (nft.name, nft.imageAddress, contractAddress);
    }

    function getAllNFTs() public view returns (NFTData[] memory) {
        return _nfts;
    }
}