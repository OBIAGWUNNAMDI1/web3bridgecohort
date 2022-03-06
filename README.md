# Advanced Sample Hardhat Project

This project demonstrates an advanced Hardhat use case, integrating other tools commonly used alongside Hardhat in the ecosystem.

The project comes with a sample contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts. It also comes with a variety of other tools, preconfigured to work with the project code.

It shows how to use hardhat impersonate to impersonate an account, and using mainnet forking to get an archival state of an FTM mainnet.
## mainnet forking;
create an account with either alchemy or moralis.
Decide on which network that you want to use to test or deploy the script

```console
npx hardhat --node fork "url"
```

## Deployment
```console 
npx hardhat run scripts/main.ts --network localhost



