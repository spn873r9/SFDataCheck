global with sharing class BCSC_MonthlyDataCreate implements Schedulable {
    global void execute(SchedulableContext sc) {
      Database.executeBatch(new BC_MonthlyDataCreate(), 1);
    }
}