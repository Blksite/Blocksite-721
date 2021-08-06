// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/utils/Counters.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721Holder.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/IERC721Receiver.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/introspection/ERC165.sol";

contract Blocksite721 is ERC721, Ownable {
  	using Counters for Counters.Counter;
  	Counters.Counter private _tokenIds;

  	constructor() ERC721("Blocksite721", "BLK") {}

	interface ERC721Metadata {
    		function name() external view returns (string name);
    		function symbol() external view returns (string symbol);
    		function tokenURI(uint256 tokenId) external view returns (string);
	}
	
  	mapping(address => uint) tokens;
  	function approval(address _owner, address _approved,uint _tokenId){
		require(tokens[_owner]==_tokenId);
		tokens[_approved]=_tokenId;
	}
	
	function transfer(address _to, uint _amount) public payable{
		require(_amount <= tokens[msg.sender]);
		tokens[msg.sender]-=_amount;
		tokens[_to]+=_amount;
	}
	function balanceOf(address _owner) public view returns (uint){
		return tokens[_owner];
	}
	function ownerOf(uint _tokenId) public view returns(address){
		return tokens[_id].address;
	}
	function TransferFrom(address _from, address _to, uint _tokenId) payable{
		require(tokens[_from]==_tokenId);
		tokens[_from]=0;
		tokens[_to]=_tokenId;
	}
	function approve(address _approved, uint _tokenId) payable{
		require(tokens[msg.sender]==_tokenId);
		tokens[_approved]=_tokenId;
	}
	function mint(address receiver, string memory tokenURI) external onlyOwner returns (uint256) {
		_tokenIds.increment();

        	uint256 newNftTokenId = _tokenIds.current();
        	_mint(receiver, newNftTokenId);
        	_setTokenURI(newNftTokenId, tokenURI);

        	return newNftTokenId;
		// tokens[_to] = 'Blocksite '+str(uint(blockhash(block.number - 1)));
	}
