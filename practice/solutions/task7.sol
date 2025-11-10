// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract SMEX {
    string public constant name = "SmaxX";
    string public constant symbol = "SMX";
    uint8 public constant decimals = 18;

    uint256 private _totalSupply;

    mapping(address => uint256) private _balances;
    mapping(address => bool) public owners;

    address public deployer;

    constructor() {
        deployer = msg.sender;
        owners[deployer] = true; // deployer is an owner by default
    }

    modifier onlyOwner() {
        require(owners[msg.sender], "Not an owner");
        _;
    }

    // ---------------- ERC20 functions ----------------

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        require(_balances[msg.sender] >= amount, "Insufficient balance");
        _balances[msg.sender] -= amount;
        _balances[to] += amount;
        return true;
    }

    // ---------------- Minting ----------------

    function mint(address to, uint256 amount) external onlyOwner {
        uint256 amountWithDecimals = amount * 10 ** decimals;
        _totalSupply += amountWithDecimals;
        _balances[to] += amountWithDecimals;
    }

    // ---------------- Owner management ----------------

    function addOwner(address newOwner) external onlyOwner {
        owners[newOwner] = true;
    }

    function removeOwner(address ownerToRemove) external onlyOwner {
        owners[ownerToRemove] = false;
    }
}
