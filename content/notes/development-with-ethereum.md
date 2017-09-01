+ate = "2017-08-30T11:02:05-07:00"
title = "Development and Testing Smart Contract on Ethereum"
draft = true

+++

# Easy way, using testrpc.

This is a nodejs envrionment. Once install testrpc, we can run it and
connect Mist to it

```
testrpc
# cd into Mist folder
./Mist --rpc http://localhost:8545
```

Now, once we

## Step 1: Run test network

```
./geth --rpc --nat none --dev
```

## Step 2: Create first account

Given that it requires ethereum to power anything. We need to mine
outselves for that to work

TO do this, we use `geth` official client:

```
geth attach
ipc:/var/folders/ts/7xznj_p13xb7_5th3w6yjmjm0000gn/T/ethereum_dev_mode/geth.ipc
```

The ipc address can be found hwen we run `geth --rpc` above. Once
console is open, we can run:

```
personal.newAccount()
miner.setEtherbase(personal.listAccounts[0]) // Hit ENTER
miner.start() // Hit ENTER
# We can check balance with
eth.getBalance(personal.listAccounts[0]) // Hit ENTER
```

