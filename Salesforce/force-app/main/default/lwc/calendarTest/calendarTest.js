import { LightningElement,track,api,wire } from 'lwc';

export default class CalendarTest extends LightningElement {
    @api inputDate; 
    @track dateVal;
    @track weeks;
    @track year;
    @track month;
    @track startDate;
    @track endDate;
    @track endDayCount;
    @track startDay;
    
    @track calenderHeader;
    @track calenderData;

    connectedCallback() {
        if(this.inputDate == null){
            this.inputDate = '2024/1/1';
        }
        this.dateVal = new Date(this.inputDate).toISOString();
        this.calenderHeader = ['月','火','水','木','金','土','日'];
        this.calenderData = [
            [
                {day:1,color:false},
                {day:2,color:false},
                {day:3,color:false},
                {day:4,color:false},
                {day:5,color:false},
                {day:6,color:false},
                {day:7,color:false}
            ],
            [
                {day:8,color:false},
                {day:9,color:false},
                {day:10,color:false},
                {day:11,color:true},
                {day:12,color:true},
                {day:13,color:true},
                {day:14,color:true}
            ],
            [
                {day:15,color:false},
                {day:16,color:false},
                {day:17,color:false},
                {day:18,color:true},
                {day:19,color:true},
                {day:20,color:true},
                {day:21,color:false}
            ],
            [
                {day:22,color:true},
                {day:23,color:true},
                {day:24,color:true},
                {day:25,color:true},
                {day:26,color:true},
                {day:27,color:true},
                {day:28,color:true}
            ],
            [
                {day:29,color:true},
                {day:30,color:true},
                {day:31,color:true}
            ],
        ];
    }

    changeDate(event){
        this.dateVal = new Date(event.target.value);
        if(this.dateVal != null){
            this.year = this.dateVal.getFullYear();
            this.month = this.dateVal.getMonth() + 1;
        }
    }
    
    clickDate(event){
        alert(event.target.innerHTML);
    }
}