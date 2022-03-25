//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract stakingcontract is Ownable, ReentrancyGuard{
    struct Stake{
        uint256 stakeamount;
        address staker;
        uint256 staketime;
        uint256 laststakeTime;
        bool haveStaked;
    }
    struct TotalBalance{
        address personStake;
        uint256 totalstake;
    }
    uint256 public newStake;


 address public boredApeOwnerAccount =0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D;
    IERC20 public StakingToken;
  
    mapping (address => uint256) StakingAmount;
    mapping(address =>Stake)stakers;
    mapping(address => TotalBalance) TotalBalances;
    uint256 index = 0;
    constructor(address StakingTokenaddress)public{
        StakingToken = IERC20(StakingTokenaddress);
    }    

    modifier minStake(uint256 amount){
        require(amount >100, "monimumstake");
        _;
    }

    modifier BoredApe(address){
        require (IERC721(boredApeOwnerAccount).balanceOf(msg.sender) >= 1);
        _;
    }
    event Staked(address staker, uint256 amount);
    function createStake(uint256 _amount) external minStake(_amount)BoredApe(msg.sender) returns (uint256 indexx)
    {
        require(StakingToken.balanceOf(msg.sender) >= _amount,  "not enough tokens");
        Stake storage st = stakers[msg.sender];
        st.haveStaked = true;
        st.stakeamount = _amount;
        st.staker = msg.sender;
        st.staketime = block.timestamp;
        StakingToken.transferFrom(msg.sender, address(this), _amount);
        TotalBalance storage pt = TotalBalances[msg.sender];
        pt.personStake = msg.sender;
        pt.totalstake = StakingAmount[msg.sender] + _amount;
            StakingAmount[msg.sender] += _amount;
            st.laststakeTime =block.timestamp;
        
        emit Staked(msg.sender, StakingAmount[msg.sender]);
    }
    function viewTotalBalance() public view returns(uint _balance){
    TotalBalance storage s = TotalBalances[msg.sender];
    _balance = s.totalstake;
    }
    function rewardperday(uint256 day) public view returns(uint bonus){
        uint256 bonus = 0;
        if (day >= 3 days) {
                bonus = ((10 * day *10) / 30);
            } else {
                bonus = 0;
    }
    }
    function getYieldUser(address user)public returns(uint256){
        if(block.timestamp - stakers[user].laststakeTime >= 3 days){
            uint256 day = block.timestamp - stakers[user].laststakeTime;
            StakingAmount[user]+= rewardperday(day);
            TotalBalance storage pt = TotalBalances[msg.sender];
            pt.personStake = msg.sender;
            pt.totalstake = StakingAmount[user];
            return StakingAmount[msg.sender];
            }
            else{
                return StakingAmount[msg.sender];
            }
 }
    function withdraw(uint256 _amount) public returns(bool){
        Stake storage st = stakers[msg.sender];
        
        require(st.haveStaked == true, "no money in the pool");
        require(StakingAmount[msg.sender] >= _amount, "you dont have up to that amount");
        // 120000000000000000000
        // st.stakeamount -= _amount;
        TotalBalance storage pt = TotalBalances[msg.sender];
        require(_amount < pt.totalstake, "insufficient staked amount");
        pt.totalstake = StakingAmount[msg.sender] - _amount;
        StakingAmount[msg.sender] -= _amount;
        uint256 day = block.timestamp -st.laststakeTime;
        require(StakingToken.transfer(msg.sender, _amount));
        // return TotalBalances[msg.sender];
        // return pt.totalstake;
    }
    function getStakers() public view returns(Stake memory) {
        return stakers[msg.sender];
    }

    function getStakerTotalBal() public view returns(TotalBalance memory) {
        return TotalBalances[msg.sender];
    }
 }

