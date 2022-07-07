@istest
private class LeadProcessorTest {
  @testSetup
  static void testDataSetup() {
    List<Lead> leads = new List<Lead>();
    for (Integer i = 0; i < 200; i++) {
      leads.add(
        new Lead(
          LastName = 'Lead ' + i,
          Company = 'Lead',
          Status = 'Open - Not Contacted'
        )
      );
    }
    insert leads;
  }

  @isTest
  static void testLeadUpdate() {
    Test.startTest();
    LeadProcessor lp = new LeadProcessor();
    Id batchId = Database.executeBatch(lp);
    Test.stopTest();
    System.assertEquals(
      200,
      [SELECT COUNT() FROM lead WHERE LeadSource = 'Dreamforce'],
      ''
    );
  }
}
