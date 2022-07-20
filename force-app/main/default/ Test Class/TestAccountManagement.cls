@SuppressWarnings('PMD')
@isTest
private class TestAccountManagement {
  @isTest
  static void testDeleteAccountWithOneContact() {
    Account[] account = AccountManagement.createAccountWithContact(1, 1);
    Test.startTest();
    Database.DeleteResult result = Database.delete(account[0], false);
    Test.stopTest();
    System.assert(!result.isSuccess());
    System.assert(result.getErrors().size() > 0);
    System.assertEquals('削除できない。', result.getErrors()[0].getMessage());
  }
  @isTest
  static void testDeleteAccountWithoutContact() {
    Account[] account = AccountManagement.createAccountWithContact(1, 0);
    Test.startTest();
    Database.DeleteResult result = Database.delete(account[0], false);
    Test.stopTest();
    System.assert(result.isSuccess());
  }
  @isTest
  static void testDeleteAccountWithBulkContact() {
    Account[] account = AccountManagement.createAccountWithContact(1, 100);
    Test.startTest();
    Database.DeleteResult result = Database.delete(account[0], false);
    Test.stopTest();
    System.assert(!result.isSuccess());
    System.assert(result.getErrors().size() > 0);
    System.assertEquals('削除できない。', result.getErrors()[0].getMessage());
  }

  @isTest
  static void testAccountAmount() {
    Set<Id> ids = new Set<Id>();
    List<Account> newaccountList = AccountManagement.createAccountsWithOpps(
      1,
      10
    );
    for (Account accToSetId : newaccountList) {
      ids.add(accToSetId.Id);
    }
    List<account> updateAccountList = AccountManagement.updateAccountAmount(
      ids
    );
    Integer expected = 10000 * 10;
    for (Account acc : updateAccountList) {
      system.assertEquals(expected, acc.amount__c, 'True');
    }
  }
  @isTest
  static void testBulkAccountAmount() {
    Set<Id> ids = new Set<Id>();
    List<Account> newaccountList = AccountManagement.createAccountsWithOpps(
      10,
      10
    );
    for (Account accToSetId : newaccountList) {
      ids.add(accToSetId.Id);
    }
    List<account> updateAccountList = AccountManagement.updateAccountAmount(
      ids
    );
    Integer expected = 10000 * 10;
    for (Account acc : updateAccountList) {
      system.assertEquals(expected, acc.amount__c, 'True');
    }
  }
}
