public with sharing class AccountHandler {
  public static void insertAccount(Integer numOfAcc) {
    List<Account> addAccounts = new List<Account>();
    Integer n = 1;
    while (n <= numOfAcc) {
      Account acc = new Account();
      acc.Name = 'Acme Inc ' + n;
      acc.AccountNumber = 'A000' + n;
      addAccounts.add(acc);
      n = n + 1;
    }
    insert addAccounts;
  }
}
