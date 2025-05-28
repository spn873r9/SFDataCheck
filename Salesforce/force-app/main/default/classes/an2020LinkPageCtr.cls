public without sharing class an2020LinkPageCtr {
    public SiteTuisekiRireki__c loadData { get; set; }
    
    public an2020LinkPageCtr(){
        List<SiteTuisekiRireki__c> obj = [
            Select
                 Id
                ,Name
                ,SiteViewCount__c
                ,ClickCountLips__c
                ,ClickCountInsta__c
                ,ClickCountTwitter__c
                ,ClickCountRRoom__c
            From
                 SiteTuisekiRireki__c 
            Where
                Name = 'an2020'
        ];
        
        if(obj.size() != 0){
            this.loadData = obj.get(0);
        
        }
    }
    
    public void viewPage(){
        this.loadData.SiteViewCount__c++;
        
        update this.loadData;
    }
    
    public void linkLips(){
        this.loadData.ClickCountLips__c++;
        
        update this.loadData;
    }
    
    public void linkInsta(){
        this.loadData.ClickCountInsta__c++;
        
        update this.loadData;
    }
    
    public void linkTwitter(){
        this.loadData.ClickCountTwitter__c++;
        
        update this.loadData;
    }
    
    public void linkRRoom(){
        this.loadData.ClickCountRRoom__c++;
        
        update this.loadData;
    }
}