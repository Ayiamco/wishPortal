const main = async () => {
  const [deployer] = await hre.ethers.getSigners();
  const accountBalance = await deployer.getBalance();

  console.log("Deploying contracts with account: ", deployer.address);
  console.log("Deployer Account balance: ", accountBalance.toString());

  const wishContractFactory = await hre.ethers.getContractFactory("Wish");
  const wishContract = await wishContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.01"),
  });
  await wishContract.deployed();

  let contractBalance = await hre.ethers.provider.getBalance(
    wishContract.address
  );
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  console.log("WishContract address: ", wishContract.address);
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
