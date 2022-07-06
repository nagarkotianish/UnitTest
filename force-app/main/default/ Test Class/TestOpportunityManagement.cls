@isTest
private class TestOpportunityManagement {
  @isTest
  static Void testCreatePrivateOpportunities() {
    List<Opportunity> newOpportunityList = OpportunityManagement.createPrivateOpportunities(
      1
    );
    Test.startTest();
    insert newOpportunityList;
    Test.stopTest();

    List<Opportunity> searchOppList = [
      SELECT amount, Amount_after_Discounted__c
      FROM Opportunity
      WHERE Id IN :newOpportunityList
    ];

    for (Opportunity opp : searchOppList) {
      system.assertEquals(900000, opp.Amount_after_Discounted__c, 'true');
    }
  }
}
