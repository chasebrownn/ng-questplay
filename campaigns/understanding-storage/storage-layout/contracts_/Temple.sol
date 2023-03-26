// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

contract Temple {
    uint128 public entrance;
    address public mainHall;
    mapping(uint8 => mapping(uint8 => address)) public gardens;
    bytes20[] public chambers;


    // Write data to the contract's ith storage slot
    function write(uint256 i, bytes32 data) public {
        assembly {
            sstore(i, data)
        }
    }

    // Temple deployed to: 0xfA5D875609635AE3E5Db6982764576BDF7AE238D

    // 1. write address to mainHall slot.
    //    mainHall is stored in slot 1.
    //    call write(1, 0x000000000000000000000000f4917F33A4A1f8f715402497F45Ba936DC157bF8)

    // 2. write address to gardens[20][22]
    //    Because mappings are dynamic in size, they cannot just be stored sequentially,
    //    like other variables.Instead, only the mapping itself will only take up the next
    //    storage slot (32 bytes). Its elements will be stored in far away slots where the element’s
    //    slot number is computed from its key.Formally, for a mapping map in slot i, the element
    //    map[key] will be stored in slot keccak256(key || i) where || is concatenation.
    //
    //    To find gardens[20][22], we first find the slot mapping gardens[20] occupies.
    //    gardens occupies slot 2, right after mainHall. So gardens[20] can be found in slot x
    //    where x is given by keccak256(abi.encode(20, 2)).
    //    To find gardens[20][22] we repeat the hashing process, the address can be found in
    //    keccak256(abi.encode(22, x)).
    //
    //    to find the slot we need to locate the slot where gardens[20][22] is stored,
    //    we know that gardens occupies slot 2, so now we find gardens[20][22].
    //    to find the specific slot we need to calculate:
    //        uint x = uint(keccak256(abi.encode(20, 2)));
    //        temple.write(
    //            uint(keccak256(abi.encode(22, x))),
    //            yourAddress
    //        );
    //    where yourAddress == 0x000000000000000000000000f4917F33A4A1f8f715402497F45Ba936DC157bF8
    //    call write(
    //        73260345122573571097538219666442874894683432363450978443217705930984513990703,
    //        0x000000000000000000000000f4917F33A4A1f8f715402497F45Ba936DC157bF8
    //    );

    // 3. write address to chambers[5].
    //    Dynamic arrays take up a 32 byte slot (which stores the array length).
    //    But its elements, like mapping, are stored elsewhere. For a dynamic array in slot i,
    //    its elements are stored sequentially starting from slot keccak256(i).
    //
    //    In this example, chambers.length is stored in slot 3, occupying 32 bytes
    //    The elements in chambers are stored starting from keccak256(3).
    //    Since bytes20 is too large to squeeze into single slots, chambers[5]
    //    can be found in slot keccak256(3) + 5.
    //
    //    To find the slot for chambers[5].
    //    We need to calculate the slot with  keccak256(3) + 5
    //    Before writing, we need to update the array length with temple.write(3, bytes32(uint256(6)));
    //    length translating to 0x0000000000000000000000000000000000000000000000000000000000000006
    //    then we call write(
    //                     uint(keccak256(abi.encode(3))) + 5,
    //                     yourAddress
    //                 );
    //    where yourAddress == 0x000000000000000000000000f4917F33A4A1f8f715402497F45Ba936DC157bF8
    //    call write(
    //             87903029871075914254377627908054574944891091886930582284385770809450030037088
    //             0x000000000000000000000000f4917F33A4A1f8f715402497F45Ba936DC157bF8
    //         )
    
}
