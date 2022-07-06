trigger OpportunityDiscountTrigger on Opportunity(before insert) {
  List<Opportunity> newOppList = Trigger.new;
  OpportunityManagement.applyDiscount(newOppList);
}
