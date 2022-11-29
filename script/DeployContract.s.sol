// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.6.12;

import "@forge-std/console.sol";
import {Script} from "@forge-std/Script.sol";
import {DefaultReserveInterestRateStrategye} from "../src/DefaultReserveInterestRateStrategy.sol";
import {ILendingPoolAddressesProvider} from "../src/interfaces/ILendingPoolAddressesProvider.sol";
import {AaveV2Ethereum} from "@aave-address-book/AaveV2Ethereum.sol";

contract DeployContract is Script {
    function run() external {
        vm.startBroadcast();
        ILendingPoolAddressesProvider provider = ILendingPoolAddressesProvider(
            0xB53C1a33016B2DC2fF3653530bfF1848a515c8c5
        );
        DefaultReserveInterestRateStrategy deployedContract = new DefaultReserveInterestRateStrategy(
            provider,
            0,
            0,
            0,
            0,
            0,
            0
        );
        console.log("Contract address: ", address(deployedContract));
        vm.stopBroadcast();
    }
}
