// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.6.12;

import "@forge-std/console.sol";
import {Script} from "@forge-std/Script.sol";
import {DefaultReserveInterestRateStrategy} from "@aave-v2/protocol/lendingpool/DefaultReserveInterestRateStrategy.sol";
import {ILendingPoolAddressesProvider} from "@aave-v2/interfaces/ILendingPoolAddressesProvider.sol";

/*
* Script to deploy new Interest Rate Strategy used by Aave V2 pools
*
* Pass appropriate params as follows:
* ILendingPoolAddressesProvider provider,
* uint256 optimalUtilizationRate,
* uint256 baseVariableBorrowRate,
* uint256 variableRateSlope1,
* uint256 variableRateSlope2,
* uint256 stableRateSlope1,
* uint256 stableRateSlope2
*
* For more information, please read:
* https://docs.aave.com/developers/v/2.0/the-core-protocol/protocol-overview#interest-rate-strategy
*
*/

contract DeployContract is Script {
    ILendingPoolAddressesProvider internal constant POOL_ADDRESSES_PROVIDER =
        ILendingPoolAddressesProvider(
            0xB53C1a33016B2DC2fF3653530bfF1848a515c8c5
        );

    function run() external {
        vm.startBroadcast();
        DefaultReserveInterestRateStrategy deployedContract = new DefaultReserveInterestRateStrategy(
            POOL_ADDRESSES_PROVIDER,
            800000000000000000000000000,
            0,
            57500000000000000000000000,
            800000000000000000000000000,
            40000000000000000000000000,
            1000000000000000000000000000
        );
        console.log("Contract address: ", address(deployedContract));
        vm.stopBroadcast();
    }
}
