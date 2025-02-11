contract Wallet {
  struct BalanceOfTuple {
    int n;
    bool _valid;
  }
  struct TotalSupplyTuple {
    int n;
    bool _valid;
  }
  struct NegativeBalanceTuple {
    int n;
    bool _valid;
  }
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct NegativeBalanceKeyTuple {
    address p;
  }
  mapping(address=>BalanceOfTuple) balanceOf;
  TotalSupplyTuple totalSupply;
  mapping(address=>NegativeBalanceTuple) negativeBalance;
  OwnerTuple owner;
  NegativeBalanceKeyTuple[] negativeBalanceKeyArray;
  event Transfer(address from,address to,int amount);
  event Mint(address p,int amount);
  event Burn(address p,int amount);
  constructor() public {
    updateOwnerOnInsertConstructor_r3();
  }
  function getTotalSupply() public view  returns (int) {
      int n = totalSupply.n;
      return n;
  }
  function burn(address p,int amount) public  {
      bool r4 = updateBurnOnInsertRecv_burn_r4(p,amount);
      if(r4==false) {
        revert("Rule condition failed");
      }
  }
  function getBalanceOf(address p) public view  returns (int) {
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      int n = balanceOfTuple.n;
      return n;
  }
  function mint(address p,int amount) public  {
      bool r11 = updateMintOnInsertRecv_mint_r11(p,amount);
      if(r11==false) {
        revert("Rule condition failed");
      }
  }
  function transfer(address from,address to,int amount) public  {
    require(balanceOf[from].n >= 0);
    require(balanceOf[to].n >= 0);
      bool r2 = updateTransferOnInsertRecv_transfer_r2(from,to,amount);
      if(r2==false) {
        revert("Rule condition failed");
      }
    assert(balanceOf[from].n >= 0);
    assert(balanceOf[to].n >= 0);
  }
  // function checkNegativeBalance() private    {
  //     uint N = negativeBalanceKeyArray.length;
  //     for(uint i = 0; i<N; i = i+1) {
  //         NegativeBalanceKeyTuple memory negativeBalanceKeyTuple = negativeBalanceKeyArray[i];
  //         NegativeBalanceTuple memory negativeBalanceTuple = negativeBalance[negativeBalanceKeyTuple.p];
  //         assert(!negativeBalanceTuple._valid);
  //         if(negativeBalanceTuple._valid==true) {
  //           revert("negativeBalance");
  //         }
  //     }
  // }
  // modifier checkViolations() {
  //     // Empty()
  //     _;
  //     checkNegativeBalance();
  // }
  function updateNegativeBalanceOnDeleteBalanceOf_r7(address p,int n) private    {
      if(n<0 && p!=address(0)) {
        NegativeBalanceTuple memory negativeBalanceTuple = negativeBalance[p];
        if(n==negativeBalanceTuple.n) {
          negativeBalance[p] = NegativeBalanceTuple(0,false);
        }
      }
  }
  function updateOwnerOnInsertConstructor_r3() private    {
      if(true) {
        address s = msg.sender;
        if(true) {
          owner = OwnerTuple(s,true);
        }
      }
  }
  function updateTransferOnInsertMint_r12(address p,int n) private    {
      if(true) {
        updateTotalInOnInsertTransfer_r8(p,n);
        updateTotalOutOnInsertTransfer_r5(address(0),n);
        emit Transfer(address(0),p,n);
      }
  }
  function updateBalanceOfOnIncrementTotalOut_r1(address p,int o) private    {
      int delta = int(-o);
      updateNegativeBalanceOnIncrementBalanceOf_r7(p,delta);
      balanceOf[p].n -= o;
  }
  function updateTotalInOnInsertTransfer_r8(address p,int n) private    {
      int delta = int(n);
      updateBalanceOfOnIncrementTotalIn_r1(p,delta);
  }
  function updateTotalSupplyOnIncrementAllMint_r10(int m) private    {
      totalSupply.n += m;
  }
  function updateTransferOnInsertRecv_transfer_r2(address s,address r,int n) private   returns (bool) {
      BalanceOfTuple memory balanceOfTuple = balanceOf[s];
      if(true) {
        int m = balanceOfTuple.n;
        if(m>=n) {
          updateTotalOutOnInsertTransfer_r5(s,n);
          updateTotalInOnInsertTransfer_r8(r,n);
          emit Transfer(s,r,n);
          return true;
        }
      }
      return false;
  }
  function updateTotalOutOnInsertTransfer_r5(address p,int n) private    {
      int delta = int(n);
      updateBalanceOfOnIncrementTotalOut_r1(p,delta);
  }
  function updateBalanceOfOnIncrementTotalIn_r1(address p,int i) private    {
      int delta = int(i);
      updateNegativeBalanceOnIncrementBalanceOf_r7(p,delta);
      balanceOf[p].n += i;
  }
  function updateAllMintOnInsertMint_r0(int n) private    {
      int delta = int(n);
      updateTotalSupplyOnIncrementAllMint_r10(delta);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateTotalSupplyOnIncrementAllBurn_r10(int b) private    {
      totalSupply.n -= b;
  }
  function updateNegativeBalanceOnInsertBalanceOf_r7(address p,int n) private    {
      BalanceOfTuple memory toDelete = balanceOf[p];
      if(toDelete._valid==true) {
        updateNegativeBalanceOnDeleteBalanceOf_r7(p,toDelete.n);
      }
      if(n<0 && p!=address(0)) {
        negativeBalance[p] = NegativeBalanceTuple(n,true);
        negativeBalanceKeyArray.push(NegativeBalanceKeyTuple(p));
      }
  }
  function updateBurnOnInsertRecv_burn_r4(address p,int n) private   returns (bool) {
      if(true) {
        address s = owner.p;
        if(s==msg.sender) {
          BalanceOfTuple memory balanceOfTuple = balanceOf[p];
          if(true) {
            int m = balanceOfTuple.n;
            if(p!=address(0) && n<=m) {
              updateAllBurnOnInsertBurn_r9(n);
              updateTransferOnInsertBurn_r6(p,n);
              emit Burn(p,n);
              return true;
            }
          }
        }
      }
      return false;
  }
  function updateNegativeBalanceOnIncrementBalanceOf_r7(address p,int n) private    {
      int _delta = int(n);
      int newValue = updateintByint(balanceOf[p].n,_delta);
      updateNegativeBalanceOnInsertBalanceOf_r7(p,newValue);
  }
  function updateintByint(int x,int delta) private   returns (int) {
      int newValue = x+delta;
      return newValue;
  }
  function updateAllBurnOnInsertBurn_r9(int n) private    {
      int delta = int(n);
      updateTotalSupplyOnIncrementAllBurn_r10(delta);
  }
  function updateTransferOnInsertBurn_r6(address p,int n) private    {
      if(true) {
        updateTotalInOnInsertTransfer_r8(address(0),n);
        updateTotalOutOnInsertTransfer_r5(p,n);
        emit Transfer(p,address(0),n);
      }
  }
  function updateMintOnInsertRecv_mint_r11(address p,int n) private   returns (bool) {

    require(balanceOf[p].n >= 0);
      if(true) {
        address s = owner.p;
        if(s==msg.sender) {
          if(n>0 && p!=address(0)) {
            updateAllMintOnInsertMint_r0(n);
            updateTransferOnInsertMint_r12(p,n);
            emit Mint(p,n);
    assert(balanceOf[p].n >= 0);
            return true;
          }
        }
      }
      return false;
  }

  // function checkNegativeBalance(address p) public view {
  //   assert(balanceOf[p].n >= 0);
  // }
}
