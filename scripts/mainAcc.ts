/* eslint-disable prettier/prettier */
import { ethers } from "hardhat";
async function mainAcc() {
  const boredApeHolder = "0xf8e0C93Fd48B4C34A4194d3AF436b13032E641F3";
  const tokenaddress = "0x827926fe5CeaC1DFf5dC71b91080B669486D680D";
  const mintaddress = "0x2B31e7c64C803494D932CCd719eED086636c8154";
  // account impersonanation of metamask account on ethereum mainnet.
  // The account impersonation will allow us set ether balance of the metamask and do other functions.
  
// @ts-ignore
  await hre.network.provider.request({
    method: "hardhat_impersonateAccount",
     params: [mintaddress],
});
// setting the ether balance of the metamask account  so we can do transcation on a forked mainnet.
// @ts-ignore
await hre.network.provider.send("hardhat_setBalance", [
  mintaddress,
  "0x550000000000000000",
]);
const amount = "8000000000000000000000000";

// gettin the token instance and transfering boredapetoken to a holder of the boredape nft in a mainnet instance.
const signer = await ethers.getSigner(mintaddress)
const hold = await ethers.getContractAt("Token", tokenaddress, signer)
const amounttransferred = "200000000000000000000000"
const transfer = await hold.transfer(boredApeHolder, amounttransferred)
const balance = await hold.balanceOf(boredApeHolder);
const balance2 = await hold.balanceOf(mintaddress);

// creating the token on a forked mainnet instance in my localhost.
  // const hold = await ethers.getContractFactory("Token", signer);
  // const holder = await hold.deploy(amount)
  // await holder.deployed();
  // const minto = await holder.mint(mintaddress , amount)
  // console.log(holder.address);
  // console.log(await holder.balanceOf(mintaddress));
  console.log(balance);
  console.log(balance2);
  
 
  // const holder = await hold.deploy(amount);
  // eslint-disable-next-line prettier/prettier
}
mainAcc().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
