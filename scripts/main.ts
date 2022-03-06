import { ethers } from "hardhat";
import { Signer } from "ethers";

async function main() {
  const address = "0x39500416f6e1544b533d71c5c3f619de158b46e9";
  const AVAX = await ethers.getContractAt(
    "IERC20",
    "0x6a07A792ab2965C72a5B8088d3a069A7aC3a993B"
  );
  const balOfAddress = await AVAX.balanceOf(address);
  console.log(balOfAddress);
  // Impersonate the account so we can send in AAVE to another address
  // @ts-ignore
  await hre.network.provider.request({
    method: "hardhat_impersonateAccount",
    params: [address],
  });

  const randAddr = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
  const signer: Signer = await ethers.getSigner(address);
  const balofrandAddr = await AVAX.connect(signer).transfer(
    randAddr,
    "100000000000000000000"
  );
  console.log(balofrandAddr);
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
