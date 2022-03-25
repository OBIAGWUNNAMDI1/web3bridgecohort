# Staking contract that allow users to stake an erc20 BRRT token and get 10 percent of the stake after every 30 days, with a caveat that the interest is only added after 3days.

# This project demonstrates the use of various advanced Hardhat concept from integrating other tools commonly used alongside Hardhat in the ecosystem from ethers to using evmincreatime and account impersonation.

# The project comes with a contract folder that has three solidity files, two scripts that deploys the erc20 contract, and the staking contract.
```the scripts are ran on a forked ethereum mainnet instance in the local network host.
```

```console
npx hardhat --node fork "url"
```

## Deployment
```console 
npx hardhat run scripts/mainAcc.ts --network localhost
npx hardhat run scripts/staking.ts --network localhost



