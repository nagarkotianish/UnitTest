trigger OpportunityDiscountTrigger on Opportunity(before insert) {
    List<Opportunity> newOppList = Trigger.New;
    OpportunityManagement.applyDiscount(newOppList);
  }
  