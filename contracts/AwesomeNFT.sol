pragma solidity ^0.5.0;

import '@openzeppelin/contracts/token/ERC721/ERC721Full.sol';
import "@openzeppelin/contracts/token/ERC721/ERC721Mintable.sol";
import '@openzeppelin/contracts/ownership/Ownable.sol';

contract AwesomeNFT is ERC721Full, Ownable {

    constructor() ERC721Full("AwesomeNFT", "ANFT") public {}

    event MetadataEvent(uint indexed _tokenId, string _metadata);

    struct Data {
        uint customDataAttr1;
        uint customDataAttr2;
        string customDataAttr3;
    }
    
    mapping (uint256 => Data) tokenIdToData;

    function mint(uint256 _tokenId, uint _customDataAttr1, uint _customDataAttr2, string memory _customDataAttr3, string memory _customMetadata) public onlyOwner {
        Data memory _data = Data({ customDataAttr1: _customDataAttr1, customDataAttr2: _customDataAttr2, customDataAttr3: _customDataAttr3 });
        tokenIdToData[_tokenId] = _data;
        _mint(msg.sender, _tokenId);
        emit MetadataEvent(_tokenId, _customMetadata);
    }

    function getData(uint256 _tokenId) public view returns (uint customDataAttr1, uint customDataAttr2, string memory customDataAttr3)  {
        Data memory _data = tokenIdToData[_tokenId];
        customDataAttr1 = _data.customDataAttr1;
        customDataAttr2 = _data.customDataAttr2;
        customDataAttr3 = _data.customDataAttr3;    
    }

}