public with sharing class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {
  public Integer recordsProcessed = 0;
  public Database.QueryLocator start(Database.BatchableContext bc) {
    String query = 'Select id,LeadSource from Lead';
    return Database.getQueryLocator(Query);
  }

  public void execute(Database.BatchableContext bc, List<Lead> scope) {
    for (Lead lead : scope) {
      lead.LeadSource = 'DreamForce';
    }
    update scope;
  }

  public void finish(Database.BatchableContext bc) {
    System.debug(recordsProcessed + ' records processed. Shazam!');
    AsyncApexJob job = [
      SELECT
        Id,
        Status,
        NumberOfErrors,
        JobItemsProcessed,
        TotalJobItems,
        CreatedBy.Email
      FROM AsyncApexJob
      WHERE Id = :bc.getJobId()
    ];
    system.debug(job);
  }
}
