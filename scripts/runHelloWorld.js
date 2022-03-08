const main = async () => {
  const [deployer] = await hre.ethers.getSigners();
  const contractFactory = await hre.ethers.getContractFactory("HelloWorld");
  const contract = await contractFactory.deploy();
  await contract.deployed();

  console.log("Contract deployed by: ", deployer.address);
  console.log("Contract deployed at: ", contract.address);

  let txn = await contract.sendBlockGameMessage("This is testing.");
  await txn.wait();

  txn = await contract.getBlockgameMessage();
  console.log(txn);
};

async function consol(x) {
  console.log(x);
}

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
