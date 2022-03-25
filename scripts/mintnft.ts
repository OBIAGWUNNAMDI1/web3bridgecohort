import { ethers } from "hardhat";

async function mainAcc() {
  const value = await ethers.getContractAt(
    "NFT",
    "0xA4f41f2e45d5bDe6EFCc46CCa081d82F94378194"
  );
  const hold = await value.mintNFT(
    "ipfs://QmQKVttST6vrcM9mmd4hyMhbx64b3qnkb2oWrvgMSBt9KB"
  );
  console.log("token created");
}

mainAcc().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
