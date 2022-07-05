trigger AccountDeletion on Account(before delete) { //NOPMD
    //取引先に関連する取引先責任者情報があると削除できない
    List<Account> deletingAccountList = [
      SELECT Id
      FROM Account
      WHERE Id IN (SELECT AccountId FROM Contact) AND Id IN :Trigger.old
    ];
    for (Account acc : deletingAccountList) {
      Trigger.oldMap.get(acc.Id).addError('削除できない。');
    }
  }