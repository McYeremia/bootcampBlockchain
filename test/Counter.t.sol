// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    address public alice = makeAddr("Alice"); //membuat akun alice

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    function test_SetPrice() public {
        vm.prank(alice); //prank sbg alice
        vm.expectRevert("Only owner can set price");
        counter.setPrice(100);

        vm.prank(address(this));
        counter.setPrice(100);
        assertEq(counter.price(), 100);
        console.log("Price set to 100");
    }
}
