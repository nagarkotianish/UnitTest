@SuppressWarnings('PMD')
public with sharing class AccountManagement {
  public static List<Account> createAccountWithContact(
    Integer numAccounts,
    Integer numAccountWithContact
  ) {
    List<Account> newAccountList = new List<Account>();
    for (Integer i = 0; i < numAccounts; i++) {
      Account acc = new Account(Name = 'TestAccount' + i);
      newAccountList.add(acc);
    }
    insert newAccountList;

    List<Contact> newContactList = new List<Contact>();
    for (Account acc : newAccountList) {
      for (Integer k = 0; k < numAccountWithContact; k++) {
        Contact con = new Contact();
        con.LastName = 'TestContact';
        con.FirstName = String.valueOf(k);
        con.AccountId = acc.Id;
        newContactList.add(con);
      }
    }
    insert newContactList;
    return newAccountList;
  }

  public static List<Account> createAccountsWithOpps(
    Integer numAccts,
    Integer numOppsPerAcct
  ) {
    List<Account> newAccountList = new List<Account>();
    for (Integer i = 0; i < numAccts; i++) {
      Account acc = new Account(Name = 'TestAccount' + i);
      newAccountList.add(acc);
    }
    insert (newAccountList);

    List<Opportunity> newOpportunityList = new List<Opportunity>();
    for (Integer j = 0; j < numAccts; j++) {
      Account accountObj = newAccountList[j];
      for (Integer k = 0; k < numOppsPerAcct; k++) {
        newOpportunityList.add(
          new Opportunity(
            Name = accountObj.Name + ' Opportunity ' + k,
            StageName = 'Prospecting',
            CloseDate = System.today().addMonths(1),
            AccountId = accountObj.Id,
            Amount = 10000
          )
        );
      }
    }
    insert newOpportunityList;
    return newAccountList;
  }

  public static List<Account> getOpportunityRelatedToAccount(Set<ID> ids) {
    List<Account> accountList = [
      SELECT id, name, amount__c, (SELECT Amount FROM Opportunities)
      FROM account
      WHERE id IN :ids
    ];
    return accountList;
  }

  public static List<Account> updateAccountAmount(Set<Id> ids) {
    List<Account> accountList = getOpportunityRelatedToAccount(ids);
    calculateOpportunitesAmountRelatedtoAccount(accountList);
    system.debug(accountList);
    update accountList;
    return accountList;
  }

  public static void calculateOpportunitesAmountRelatedtoAccount(
    List<Account> source
  ) {
    for (Account acc : source) {
      acc.amount__c = 0;
      for (Opportunity opp : acc.Opportunities) {
        acc.amount__c += opp.amount;
      }
    }
  }
}
