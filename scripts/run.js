const main = async () => {
  //get signers
  const [owner, randomAddress] = await hre.ethers.getSigners();
  //get contract Factory
  let wishContractFactory = await hre.ethers.getContractFactory("Wish");
  //deploy contract
  let wishContract = await wishContractFactory.deploy();
  //wait for contract to finish deploying
  await wishContract.deployed();
  console.log("Contract deployed to :", wishContract.address);
  console.log("Contract deployed by:", owner.address);
  console.log(
    "----------------------------------------------------------------------- \n"
  );

  //call the contract function to create public wish
  console.log("Section with wallet address: ", owner.address);
  let wishTxn = await wishContract.makeWish("random public wish 1", false);
  await wishTxn.wait();
  let privateWishes = await wishContract.getPrivateWishes();
  console.log("private wishes: ", privateWishes);
  let publicWishes = await wishContract.getPublicWishes();
  console.log("public wishes: ", publicWishes);
  console.log(
    "----------------------------------------------------------------------- \n"
  );

  //call the contract with random address to create private wish
  console.log("Section with wallet address: ", randomAddress.address);
  wishContract = await wishContract.connect(randomAddress);
  wishTxn = await wishContract.makeWish("random public wish  2", false);
  await wishTxn.wait();
  //call the contract with random address to create public  wish
  wishTxn = await wishContract.makeWish("random  private wish  2", true);
  await wishTxn.wait();
  privateWishes = await wishContract.getPrivateWishes();
  publicWishes = await wishContract.getPublicWishes();
  console.log("private wishes: ", privateWishes);
  console.log("public wishes: ", publicWishes);
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
