contract Matic {
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct TotalSupplyTuple {
    uint n;
    bool _valid;
  }
  struct IsPauserTuple {
    bool b;
    bool _valid;
  }
  struct UnequalBalanceTuple {
    uint s;
    uint n;
    bool _valid;
  }
  struct TotalBalancesTuple {
    uint m;
    bool _valid;
  }
  struct BalanceOfTuple {
    uint n;
    bool _valid;
  }
  struct AllowanceTuple {
    uint n;
    bool _valid;
  }
  struct PausedTuple {
    bool b;
    bool _valid;
  }
  UnequalBalanceTuple unequalBalance;
  TotalSupplyTuple totalSupply;
  mapping(address=>IsPauserTuple) isPauser;
  TotalBalancesTuple totalBalances;
  mapping(address=>BalanceOfTuple) balanceOf;
  OwnerTuple owner;
  mapping(address=>mapping(address=>AllowanceTuple)) allowance;
  PausedTuple paused;
  event Burn(address p,uint amount);
  event Mint(address p,uint amount);
  event DecreaseAllowance(address p,address s,uint n);
  event IncreaseAllowance(address p,address s,uint n);
  event IsPauser(address p,bool b);
  event Transfer(address from,address to,uint amount);
  event Paused(bool b);
  event TransferFrom(address from,address to,address spender,uint amount);
  constructor(uint n) public {
    updateIsPauserOnInsertConstructor_r22();
    updatePausedOnInsertConstructor_r25();
    updateBalanceOfOnInsertConstructor_r18(n);
    updateTotalBalancesOnInsertConstructor_r32(n);
    updateTotalMintOnInsertConstructor_r20(n);
    updateAllMintOnInsertConstructor_r12(n);
    updateOwnerOnInsertConstructor_r6();
    updateTotalSupplyOnInsertConstructor_r28(n);
  }
  function transfer(address to,uint amount) public  {
     require(totalSupply.n == totalBalances.m);
      bool r11 = updateTransferOnInsertRecv_transfer_r11(to,amount);
      if(r11==false) {
        revert("Rule condition failed");
      }
     assert(totalSupply.n == totalBalances.m);
  }
  function mint(address p,uint amount) public  {
     require(totalSupply.n == totalBalances.m);
      bool r3 = updateMintOnInsertRecv_mint_r3(p,amount);
      if(r3==false) {
        revert("Rule condition failed");
      }
     assert(totalSupply.n == totalBalances.m);
  }
  function burn(address p,uint amount) public  {
     require(totalSupply.n == totalBalances.m);
      bool r8 = updateBurnOnInsertRecv_burn_r8(p,amount);
      if(r8==false) {
        revert("Rule condition failed");
      }
     assert(totalSupply.n == totalBalances.m);
  }
  function transferFrom(address from,address to,uint amount) public  {
     require(totalSupply.n == totalBalances.m);
      bool r2 = updateTransferFromOnInsertRecv_transferFrom_r2(from,to,amount);
      if(r2==false) {
        revert("Rule condition failed");
      }
     assert(totalSupply.n == totalBalances.m);
  }
  function approve(address s,uint n) public  {
     require(totalSupply.n == totalBalances.m);
      bool r31 = updateIncreaseAllowanceOnInsertRecv_approve_r31(s,n);
      if(r31==false) {
        revert("Rule condition failed");
      }
     assert(totalSupply.n == totalBalances.m);
  }
  function addPauser(address p) public  {
     require(totalSupply.n == totalBalances.m);
      bool r5 = updateIsPauserOnInsertRecv_addPauser_r5(p);
      if(r5==false) {
        revert("Rule condition failed");
      }
     assert(totalSupply.n == totalBalances.m);
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply.n;
      return n;
  }
  function getAllowance(address p,address s) public view  returns (uint) {
      uint n = allowance[p][s].n;
      return n;
  }
  function getBalanceOf(address p) public view  returns (uint) {
      uint n = balanceOf[p].n;
      return n;
  }
  function pause() public  {
     require(totalSupply.n == totalBalances.m);
      bool r21 = updatePausedOnInsertRecv_pause_r21();
      if(r21==false) {
        revert("Rule condition failed");
      }
     assert(totalSupply.n == totalBalances.m);
  }
  function renouncePauser() public  {
     require(totalSupply.n == totalBalances.m);
      bool r0 = updateIsPauserOnInsertRecv_renouncePauser_r0();
      if(r0==false) {
        revert("Rule condition failed");
      }
     assert(totalSupply.n == totalBalances.m);
  }
  function decreaseApproval(address p,uint n) public  {
     require(totalSupply.n == totalBalances.m);
      bool r17 = updateDecreaseAllowanceOnInsertRecv_decreaseApproval_r17(p,n);
      if(r17==false) {
        revert("Rule condition failed");
      }
     assert(totalSupply.n == totalBalances.m);
  }
  function unpause() public  {
     require(totalSupply.n == totalBalances.m);
      bool r13 = updatePausedOnInsertRecv_unpause_r13();
      if(r13==false) {
        revert("Rule condition failed");
      }
     assert(totalSupply.n == totalBalances.m);
  }
  function increaseApproval(address p,uint n) public  {
     require(totalSupply.n == totalBalances.m);
      bool r10 = updateIncreaseAllowanceOnInsertRecv_increaseApproval_r10(p,n);
      if(r10==false) {
        revert("Rule condition failed");
      }
     assert(totalSupply.n == totalBalances.m);
  }
  function updateIsPauserOnInsertRecv_addPauser_r5(address p) private   returns (bool) {
      address s = msg.sender;
      if(true==isPauser[s].b) {
        isPauser[p] = IsPauserTuple(true,true);
        emit IsPauser(p,true);
        return true;
      }
      return false;
  }
  function updateDecreaseAllowanceOnInsertRecv_decreaseApproval_r17(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance[o][s].n;
      if(m>=n) {
        emit DecreaseAllowance(o,s,n);
        allowance[o][s].n -= n;
        return true;
      }
      return false;
  }
  function updateBalanceOfOnInsertConstructor_r18(uint n) private    {
      address s = msg.sender;
      balanceOf[s] = BalanceOfTuple(n,true);
  }
  function updatePausedOnInsertConstructor_r25() private    {
      paused = PausedTuple(false,true);
      emit Paused(false);
  }
  function updateOwnerOnInsertConstructor_r6() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateMintOnInsertRecv_mint_r3(address p,uint n) private   returns (bool) {
      if(false==paused.b) {
        address s = owner.p;
        if(s==msg.sender) {
          if(p!=address(0)) {
            emit Mint(p,n);
            totalSupply.n += n;
            balanceOf[p].n += n;
            totalBalances.m += n;
            return true;
          }
        }
      }
      return false;
  }
  function updateTransferFromOnInsertRecv_transferFrom_r2(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      if(false==paused.b) {
        uint m = balanceOf[o].n;
        uint k = allowance[o][s].n;
        if(m>=n && k>=n) {
          emit TransferFrom(o,r,s,n);
          emit Transfer(o,r,n);
          balanceOf[o].n -= n;
          totalBalances.m -= n;
          balanceOf[r].n += n;
          totalBalances.m += n;
          allowance[o][s].n -= n;
          return true;
        }
      }
      return false;
  }
  function updateTransferOnInsertRecv_transfer_r11(address r,uint n) private   returns (bool) {
      if(false==paused.b) {
        address s = msg.sender;
        uint m = balanceOf[s].n;
        if(n<=m) {
          emit Transfer(s,r,n);
          balanceOf[s].n -= n;
          totalBalances.m -= n;
          balanceOf[r].n += n;
          totalBalances.m += n;
          return true;
        }
      }
      return false;
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r31(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance[o][s].n;
      uint d = n-m;
      emit IncreaseAllowance(o,s,d);
      allowance[o][s].n += d;
      return true;
      return false;
  }
  function updatePausedOnInsertRecv_unpause_r13() private   returns (bool) {
      if(true==paused.b) {
        address s = msg.sender;
        if(true==isPauser[s].b) {
          paused = PausedTuple(false,true);
          emit Paused(false);
          return true;
        }
      }
      return false;
  }
  function updateIncreaseAllowanceOnInsertRecv_increaseApproval_r10(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      emit IncreaseAllowance(o,s,n);
      allowance[o][s].n += n;
      return true;
      return false;
  }
  function updateTotalBalancesOnInsertConstructor_r32(uint n) private    {
      totalBalances = TotalBalancesTuple(n,true);
  }
  function updateBurnOnInsertRecv_burn_r8(address p,uint n) private   returns (bool) {
      address s = msg.sender;
      if(false==paused.b) {
        if(s==owner.p) {
          uint m = balanceOf[p].n;
          if(p!=address(0) && n<=m) {
            emit Burn(p,n);
            balanceOf[p].n -= n;
            totalBalances.m -= n;
            totalSupply.n -= n;
            return true;
          }
        }
      }
      return false;
  }
  function updateIsPauserOnInsertConstructor_r22() private    {
      address s = msg.sender;
      isPauser[s] = IsPauserTuple(true,true);
      emit IsPauser(s,true);
  }
  function updateTotalSupplyOnInsertConstructor_r28(uint n) private    {
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateIsPauserOnInsertRecv_renouncePauser_r0() private   returns (bool) {
      address s = msg.sender;
      if(true==isPauser[s].b) {
        isPauser[s] = IsPauserTuple(false,true);
        emit IsPauser(s,false);
        return true;
      }
      return false;
  }
  function updateTotalMintOnInsertConstructor_r20(uint n) private    {
      address s = msg.sender;
      // Empty()
  }
  function updatePausedOnInsertRecv_pause_r21() private   returns (bool) {
      if(false==paused.b) {
        address s = msg.sender;
        if(true==isPauser[s].b) {
          paused = PausedTuple(true,true);
          emit Paused(true);
          return true;
        }
      }
      return false;
  }
  function updateAllMintOnInsertConstructor_r12(uint n) private    {
      // Empty()
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  // function equalBalance() public view {
  //   assert(totalSupply.n == totalBalances.m);
  // }
}
