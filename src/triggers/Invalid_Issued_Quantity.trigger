trigger Invalid_Issued_Quantity on Asset_Issue__c (after insert, after update) {
	for(Asset_Issue__c a:Trigger.new){
        if(a.Quantity_Issued_Updated__c<0){
            Trigger.newmap.get(a.Id).addError('Please insert quantity less than issued quantity.');
        }
    }
}