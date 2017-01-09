trigger Invalid_Quantity on Asset__c (after insert, after update) {
    for(Asset__c a:Trigger.new){
        if(a.Quantity_Available__c<0){
            Trigger.newmap.get(a.Id).addError('Please insert quantity such that available quantity is not less than zero.');
        }
    }
}