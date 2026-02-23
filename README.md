# NFT Staking Vault Core

An expert-level repository for deploying a secure NFT staking ecosystem. This project bridges digital collectibles with decentralized finance by enabling holders to generate yield from their assets.

## Architecture
The system consists of a Vault contract that tracks ownership without transferring assets (soft-staking) or through a traditional escrow model. It calculates rewards based on block timestamps to ensure precision.

## Key Features
* **ERC721 & ERC20 Integration**: Seamlessly connects your NFT collection to a reward token.
* **Flexible Reward Logic**: Easily adjust the `REWARDS_PER_DAY` variable via owner functions.
* **Batch Staking**: Optimized functions to stake and claim for multiple NFTs in a single transaction.
* **Flat Structure**: All contracts and scripts are located in the root for simplified deployment.

## Setup
1. Deploy your Reward Token (ERC20).
2. Deploy the `NFTStakingVault.sol` contract providing the NFT and Reward Token addresses.
3. Call `setPaused(false)` to enable staking.
