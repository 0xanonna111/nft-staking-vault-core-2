// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";



contract NFTStakingVault is Ownable, ReentrancyGuard {
    IERC721 public nftCollection;
    IERC20 public rewardToken;

    uint256 public rewardsPerDay = 10 ether;
    mapping(uint256 => address) public vault;
    mapping(uint256 => uint256) public lastUpdated;

    event Staked(address indexed user, uint256 tokenId);
    event Claimed(address indexed user, uint256 amount);

    constructor(address _nft, address _reward, address _initialOwner) Ownable(_initialOwner) {
        nftCollection = IERC721(_nft);
        rewardToken = IERC20(_reward);
    }

    function stake(uint256[] calldata tokenIds) external nonReentrant {
        for (uint256 i = 0; i < tokenIds.length; i++) {
            uint256 tokenId = tokenIds[i];
            require(nftCollection.ownerOf(tokenId) == msg.sender, "Not the owner");
            
            nftCollection.transferFrom(msg.sender, address(this), tokenId);
            vault[tokenId] = msg.sender;
            lastUpdated[tokenId] = block.timestamp;
            emit Staked(msg.sender, tokenId);
        }
    }

    function calculateRewards(uint256 tokenId) public view returns (uint256) {
        if (vault[tokenId] == address(0)) return 0;
        uint256 timeStaked = block.timestamp - lastUpdated[tokenId];
        return (timeStaked * rewardsPerDay) / 1 days;
    }

    function claim(uint256[] calldata tokenIds) external nonReentrant {
        uint256 totalReward = 0;
        for (uint256 i = 0; i < tokenIds.length; i++) {
            uint256 tokenId = tokenIds[i];
            require(vault[tokenId] == msg.sender, "Not your NFT");
            
            totalReward += calculateRewards(tokenId);
            lastUpdated[tokenId] = block.timestamp;
        }
        require(totalReward > 0, "No rewards to claim");
        rewardToken.transfer(msg.sender, totalReward);
        emit Claimed(msg.sender, totalReward);
    }
}
