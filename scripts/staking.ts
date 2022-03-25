/* eslint-disable prettier/prettier */
import { ethers, network } from "hardhat";

async function Staking() {
  const boredApeHolder = "0xf8e0C93Fd48B4C34A4194d3AF436b13032E641F3";
  const tokenaddress = "0x827926fe5CeaC1DFf5dC71b91080B669486D680D";
  const stakingAddress = "0x12383b43401735f72dD42C8C9FB559da43053Ac6";
  // account impersonanation of metamask account on ethereum mainnet.
  // The account impersonation will allow us set ether balance of the metamask and do other functions.

  // @ts-ignore
  await hre.network.provider.request({
    method: "hardhat_impersonateAccount",
    params: [boredApeHolder],
  });
  // @ts-ignore
  await hre.network.provider.send("hardhat_setBalance", [
    boredApeHolder,
    "0x5560000000000000000",
  ]);
  // const amount = "8000000000000000000000000";

  // gettin the token instance and transfering boredapetoken to a holder of the boredape nft in a mainnet instance.
  const signer = await ethers.getSigner(boredApeHolder);
  
//   const tokendeployed = await ethers.getContractAt("IERC20",tokenaddress)
//   await tokendeployed.connect(signer).approve(stakingAddress, "100000000000000000000000")
//   const allowances = await tokendeployed.allowance(boredApeHolder, stakingAddress);
//   console.log(`amount allowed ${allowances}`)
// await tokendeployed.connect(signer).transfer(stakingAddress, "1000000000000000000000000")
// console.log("transfer success")


//   const staking = await ethers.getContractFactory("stakingcontract", signer);
//   const stakings = await staking.deploy(tokenaddress);
//   await stakings.deployed();
//   console.log(stakings.address);

// trying to stake in the staking contract.
const sevendays = 604800
const staking = await ethers.getContractAt("stakingcontract",stakingAddress, signer);
const create = await staking.createStake("200000000000000000000")
// to push time ahead. 
await network.provider.send("evm_increaseTime", [1648826660])
await network.provider.send("evm_mine")
const blockNumAfter = await ethers.provider.getBlockNumber();
const blockAfter = await ethers.provider.getBlock(blockNumAfter);
const timestampAfter = blockAfter.timestamp;
console.log(timestampAfter);
const withdrawamount = await staking.withdraw("4000000000000000000000")
const balance = await staking.getStakerTotalBal()
console.log(withdrawamount);

console.log(balance);
// 
}
Staking().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
