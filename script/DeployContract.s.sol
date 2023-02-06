// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.6.12;

import "@forge-std/console.sol";
import 'forge-std/Test.sol';
import {Script} from "@forge-std/Script.sol";
import {DefaultReserveInterestRateStrategy} from "@aave-v2/protocol/lendingpool/DefaultReserveInterestRateStrategy.sol";
import {ILendingPoolAddressesProvider} from "@aave-v2/interfaces/ILendingPoolAddressesProvider.sol";
import {WadRayMath} from "@aave-v2/protocol/libraries/math/WadRayMath.sol";

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

contract DeployContract is Script, Test {

    DefaultReserveInterestRateStrategy internal constant previousStrategy = DefaultReserveInterestRateStrategy(0x853844459106feefd8C7C4cC34066bFBC0531722);

    ILendingPoolAddressesProvider internal constant POOL_ADDRESSES_PROVIDER =
        ILendingPoolAddressesProvider(
            0xB53C1a33016B2DC2fF3653530bfF1848a515c8c5
        );

    function run() external {
        vm.startBroadcast();
        DefaultReserveInterestRateStrategy deployedContract = new DefaultReserveInterestRateStrategy(
            POOL_ADDRESSES_PROVIDER,
            800000000000000000000000000,
            1 * WadRayMath.RAY,
            38000000000000000000000000,
            800000000000000000000000000,
            40000000000000000000000000,
            800000000000000000000000000
        );

        // verify excess utilization rate didn't change
        assertEq(previousStrategy.EXCESS_UTILIZATION_RATE(), deployedContract.EXCESS_UTILIZATION_RATE());

        // verify optimalUtilizationRate didn't change
        assertEq(previousStrategy.OPTIMAL_UTILIZATION_RATE(), deployedContract.OPTIMAL_UTILIZATION_RATE());

        // verify stableRateSlope1 didn't change
        assertEq(previousStrategy.stableRateSlope1(), deployedContract.stableRateSlope1());

        // verify stableRateSlope2 didn't change
        assertEq(previousStrategy.stableRateSlope2(), deployedContract.stableRateSlope2());
        
        // verify variableRateSlope2 didn't change
        assertEq(previousStrategy.variableRateSlope2(), deployedContract.variableRateSlope2());

        // verify addressesProvider didn't change
        assertEq(address(previousStrategy.addressesProvider()), address(deployedContract.addressesProvider()));

        console.log("Contract address: ", address(deployedContract));
        console.log("optimalUtilizationRate: ", deployedContract.OPTIMAL_UTILIZATION_RATE());
        console.log("baseVariableBorrowRate: ", deployedContract.baseVariableBorrowRate());
        console.log("variableRateSlope1: ", deployedContract.variableRateSlope1());
        console.log("variableRateSlope2: ", deployedContract.variableRateSlope2());
        console.log("stableRateSlope1: ", deployedContract.stableRateSlope1());
        console.log("stableRateSlope2: ", deployedContract.stableRateSlope2());
        vm.stopBroadcast();
    }
}
