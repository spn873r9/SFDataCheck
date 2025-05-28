global with sharing class BCSC_DailyWork implements Schedulable {
    global void execute(SchedulableContext sc) {
      Database.executeBatch(new BC_DailyWork(), 100);
    }
}