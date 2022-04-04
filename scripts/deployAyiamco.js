const main = async () => {
  const [deployer] = await hre.ethers.getSigners();
  const accountBalance = await deployer.getBalance();

  console.log("Deploying contracts with account: ", deployer.address);
  console.log("Deployer Account balance: ", accountBalance.toString());

  const HelloTokenContractFactory = await hre.ethers.getContractFactory("Ayiamco");
  const helloTokenContract = await HelloTokenContractFactory.deploy();
  await helloTokenContract.deployed();

  let contractBalance = await hre.ethers.provider.getBalance(helloTokenContract.address);
  console.log("Contract balance:", hre.ethers.utils.formatEther(contractBalance));

  console.log("HelloTokenContract address: ", helloTokenContract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (err) {
    console.log(err);
    process.exit(1);
  }
};

runMain();
