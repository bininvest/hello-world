const { BN, singletons } = require("@bininvest/bininvest-test-helpers");

const { expect } = require("chai");

const BIXPresetFixedSupply = artifacts.require("BIXPresetFixedSupply");

contract("BIXPresetFixedSupply", function (accounts) {
    const [registryFunder, owner, defaultOperatorA, defaultOperatorB, anyone] = accounts;

    const initialSupply = new BN("10000");
    const name = "Bininvest";
    const symbol = "BIX";

    const defaultOperators = [defaultOperatorA, defaultOperatorB];

    before(async function () {
        await singletons.TRC1820Registry(registryFunder);
    });

    beforeEach(async function () {
        this.token = await BIXPresetFixedSupply.new(name, symbol, defaultOperators, initialSupply, owner);
    });

    it("returns the bininvest", async function () {
        expect(await this.token.name()).to.equal(name);
    });

    it("returns the bix", async function () {
        expect(await this.token.symbol()).to.equal(symbol);
    });

    it("returns the default operators", async function () {
        expect(await this.token.defaultOperators()).to.deep.equal(defaultOperators);
    });

    it("default operators are operators for all accounts", async function () {
        for (const operator of defaultOperators) {
            expect(await this.token.isOperatorFor(operator, anyone)).to.equal(true);
        }
    });

    it("returns the total supply equal to initial supply", async function () {
        expect(await this.token.totalSupply()).to.be.bignumber.equal(initialSupply);
    });

    it("returns the balance of owner equal to initial supply", async function () {
        expect(await this.token.balanceOf(owner)).to.be.bignumber.equal(initialSupply);
    });
});
