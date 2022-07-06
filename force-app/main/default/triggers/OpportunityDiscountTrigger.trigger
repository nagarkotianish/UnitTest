trigger OpportunityDiscountTrigger on Opportunity(before insert) {
  List<Opportunity> newOppList = new List<Opportunity>();
  for (Opportunity opp : Trigger.new) {
  }
  OpportunityManagement.applyDiscount(newOppList);
}
