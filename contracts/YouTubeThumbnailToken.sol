pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol";

contract YouTubeThumbnailToken is ERC721Full {

    struct YouTubeThumbnail {
      string author;
      string dateCreated;
    }

    mapping(uint256 => YouTubeThumbnail) youTubeThumbnails;
    mapping(string => uint256) videoIdsCreated;

    constructor(string memory name, string memory symbol)
        ERC721Full(name, symbol)
        public
    {}

    function mintYTT(
        string memory _videoId,
        string memory _author,
        string memory _dateCreated,
        string memory _tokenURI
    ) public {
      require(videoIdsCreated[_videoId] == 0, "videoId has already been created");
      uint256 tokenId = totalSupply().add(1);
      youTubeThumbnails[tokenId] = YouTubeThumbnail(_author, _dateCreated);
      videoIdsCreated[_videoId] = tokenId;

      _mint(msg.sender, tokenId);
      _setTokenURI(tokenId, _tokenURI);
    }

    function getYTT(uint256 _tokenId) public view returns(string memory, string memory) {
      return (youTubeThumbnails[_tokenId].author, youTubeThumbnails[_tokenId].dateCreated);
    }

    function isTokenAlreadyCreated(string memory _videoId) public view returns (bool) {
      return videoIdsCreated[_videoId] != 0 ? true : false;
    }
}
