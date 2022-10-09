const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("erc20 test", function () {
    let erc20Token;
    let owner;
    let addr1;
    let addr2;

    beforeEach(async function () {
        const ERC20Token = await hre.ethers.getContractFactory("ERC20Token");
        const _initialSupply = 1000000
        const _name = "string"
        const _symbol = "symbol"
        erc20Token = await ERC20Token.deploy(_initialSupply, _name, _symbol);
        await erc20Token.deployed();

        [owner, addr1, addr2] = await ethers.getSigners();

    });

    it("Should should successfully deploy", async function () {
        console.log("success!");
    });

    it("Should deploy with 1m of supply for the owner of the contract", async function () {
        const balance = await erc20Token.balanceOf(owner.address);
        expect(ethers.utils.formatEther(balance) == 1000000);
    });

    it("Should let you send tokens to another address", async function () {
        await erc20Token.transfer(addr1.address, ethers.utils.parseEther("100"));
        expect(await erc20Token.balanceOf(addr1.address)).to.equal(ethers.utils.parseEther("100"));
    });

    it("Should let you give another address the approval to send on your behalf", async function () {
        await erc20Token.connect(addr1).approve(owner.address, ethers.utils.parseEther("1000"));
        await erc20Token.transfer(addr1.address, ethers.utils.parseEther("1000"));
        await erc20Token.transferFrom(addr1.address, addr2.address, ethers.utils.parseEther("1000"));
        expect(await erc20Token.balanceOf(addr2.address)).to.equal(ethers.utils.parseEther("1000"));
    })
});
