public with sharing class OpportunityManagement {
  public static List<Opportunity> createPrivateOpportunities(
    Integer numOfOpportunity
  ) {
    List<Opportunity> newOpportunityList = new List<Opportunity>();
    for (Integer i = 0; i < numOfOpportunity; i++) {
      newOpportunityList.add(
        new Opportunity(
          Name = ' PrivateOpportunity ' + i,
          StageName = 'Prospecting',
          Type = 'New Customer',
          CloseDate = System.today().addMonths(1),
          Amount = Decimal.valueOf('1000000')
        )
      );
    }
    return newOpportunityList;
  }
  public static void applyDiscount(list<Opportunity> oppList) {
    for (Opportunity opp : oppList) {
      Decimal discountPercent = setDiscountPercentage(opp);
      if (discountPercent != 0) {
        opp.Amount *= discountPercent;
      }
    }
  }

  private static Decimal setDiscountPercentage(Opportunity opp) {
    Decimal discountPercent;
    if (isNewCustomer(opp)) {
      discountPercent = 0.95;
      if (isAmountBig(opp)) {
        discountPercent = 0.90;
      }
    } else if (isAmountBig(opp)) {
      discountPercent = 0.95;
    } else {
      discountPercent = 0;
    }
    return discountPercent;
  }

  private static Boolean isNewCustomer(Opportunity opp) {
    if (opp.Type == 'New Customer') {
      return true;
    }
    return false;
  }

  private static Boolean isAmountBig(Opportunity opp) {
    Decimal amount = Decimal.valueOf('1000000');
    if (opp.Amount >= Amount) {
      return true;
    }
    return false;
  }
}
