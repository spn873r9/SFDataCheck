@RestResource(urlMapping='/Test/*')
global with sharing class PostTestCtr {
    @HttpDelete
    global static void doDelete() {
        System.debug('★doDelete');
    }
  
    @HttpGet
    global static void doGet() {
        System.debug('★doGet');
    }
  
    @HttpPost
    global static void doPost() {
        System.debug('★doPost');
        RestRequest req = RestContext.request;
        System.debug('★param:' + req);
    }
}