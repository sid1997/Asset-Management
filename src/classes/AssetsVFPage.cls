public with sharing class AssetsVFPage {

    public List<Material_In__c> MIList{get;set;}
    public List<Material_Out__c> MOList{get;set;}
    public List<Asset_Issue__c> issueList{get;set;}
    public List<Asset_Returned__c> returnList{get;set;}
    public Asset__c record;
    public Integer index{get;set;}
    public Integer index1{get;set;}
    public Integer index2{get;set;}
    public Integer index3{get;set;}

        public AssetsVFPage(ApexPages.StandardController controller) {
        controller.addFields(new List<String>{'Id'});
        record=new Asset__c();
        record=(Asset__c)controller.getRecord();
        MIList = new List<Material_In__c>();
        MOList = new List<Material_Out__c>();
        issueList= new List<Asset_Issue__c>();
        returnList= new List<Asset_Returned__c>();
       // addRowMatIn();
      //  addRowMatOut();
     //   addRowIssue();
      //  addRowReturn();
        }
    
    public void addRowMatIn(){
        Material_In__c mi = new Material_In__c(Asset__c = record.id); 
        MIList.add(mi);      
    }
    
    public void addRowMatOut(){
        Material_Out__c mo = new Material_Out__c(Asset__c = record.id);
        MOList.add(mo); 
    }
    
    public void addRowIssue(){
        Asset_Issue__c ais = new Asset_Issue__c(Asset__c = record.id);
        issueList.add(ais);
    }
    
    public void addRowReturn(){
        Asset_Returned__c ar = new Asset_Returned__c(Asset__c = record.id);
        returnList.add(ar);
    }
    
    public pagereference saveMatIn(){
    try{
        insert MIList;
        MIList.clear();
        addRowMatIn();
        pagereference pg = new pagereference('/apex/AssetsVFPage?id='+record.id);
        pg.setredirect(true);
        return pg;
    }catch(Exception e){
        ApexPages.addMessages(e);
        return null;
    }
    }
    
    public pagereference saveMatOut(){
     try{  
        insert MOList;
        MOList.clear();
        addRowMatOut();
        pagereference pg = new pagereference('/apex/AssetsVFPage?id='+record.id);
        pg.setredirect(true);
        return pg;
        }catch(Exception e){
        ApexPages.addMessages(e);
        return null;
        }
    }
    
    public pagereference saveIssue(){
     try{
        insert issueList;
        issueList.clear();
        addRowIssue();
        pagereference pg = new pagereference('/apex/AssetsVFPage?id='+record.id);
        pg.setredirect(true);
        return pg;
        }catch(Exception e){
        ApexPages.addMessages(e);
        return null;
        }
    }
    
    public pagereference saveReturn(){
      try{  
        insert returnList;
        returnList.clear();
        addRowReturn();
        pagereference pg = new pagereference('/apex/AssetsVFPage?id='+record.id);
        pg.setredirect(true);
        return pg;
        }catch(Exception e){
        ApexPages.addMessages(e);
        return null;
        }
    }
    
    public void deleteMatIn(){
        if(MIList.get(index).id!=null){
            delete MIList.get(index);
            MIList.remove(index);
        }    
        else{
            MIList.remove(index);
        } 
    }
    
    public void deleteMatOut(){
        if(MOList.get(index1).id!=null){
            delete MOList.get(index1);
            MOList.remove(index1);
        }    
        else{
            MOList.remove(index1);
        } 
    }
    
    public void deleteIssue(){
        if(issueList.get(index2).id!=null){
            delete issueList.get(index2);
            issueList.remove(index2);
        }    
        else{
            issueList.remove(index2);
        } 
    }
    
    public void deleteReturn(){
        if(returnList.get(index3).id!=null){
            delete returnList.get(index3);
            returnList.remove(index3);
        }    
        else{
            returnList.remove(index3);
        } 
    }

//Pie-chart code

    
    public List<PieWedgeData> getPieData(){
        Asset__c qry = [SELECT Quantity_Available__c,Quantity_Used__c,Quantity_Lost__c,Quantity_Damaged__c,Quantity_Sold__c FROM Asset__c WHERE id=:record.id];
        List<PieWedgeData> data = new List<PieWedgeData>();
        data.add(new PieWedgeData('Quantity Available',qry.Quantity_Available__c));
        data.add(new PieWedgeData('Quantity Used',qry.Quantity_Used__c));
        data.add(new PieWedgedata('Quantity Lost',qry.Quantity_Lost__c));
        data.add(new PieWedgedata('Quantity Damaged',qry.Quantity_Damaged__c));
        data.add(new PieWedgedata('Quantity Sold',qry.Quantity_Sold__c));
        return data;
    }
    public class PieWedgeData{
        public String name{get;set;}
        public decimal quantity{get;set;}
        
        public PieWedgeData(String name, decimal quantity){
            this.name = name;
            this.quantity = quantity;
        }
    }

}