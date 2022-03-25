import { expect } from "chai";
import { ethers } from "hardhat";
import { IERC20 } from "../typechain-types";
import { main, address, contractSigner, randAddr } from "../scripts/main";
describe("IERC20 ", async function () {
  before(async function () {
    const Token = await ethers.getContractAt(
      "IERC20",
      "0x6a07A792ab2965C72a5B8088d3a069A7aC3a993B",
      address
    );
    const token = await Token.deploy();
    await token.deployed();

    expect(await token.balanceOf(address).to.equal(100000000000000000000));
  });
});
