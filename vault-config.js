const STAKING_CONFIG = {
    rewardTokenName: "YieldToken",
    rewardTokenSymbol: "YLD",
    dailyEmission: 10, // 10 Tokens per NFT per day
    stakingContractAddress: "0x...", // Post-deployment address
    networks: {
        ethereum: 1,
        sepolia: 11155111,
        polygon: 137
    }
};

module.exports = STAKING_CONFIG;
