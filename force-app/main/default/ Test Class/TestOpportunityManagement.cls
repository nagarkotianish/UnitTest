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
      SELECT amount
      FROM Opportunity
      WHERE Id IN :newOpportunityList
    ];
    for (Opportunity opp : searchOppList) {
      system.debug(opp.Amount);
      system.assertEquals(900000, opp.Amount, 'true');
    }
  }
}
