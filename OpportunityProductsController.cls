public class ProductSummaryController {
    
    public Id oppId {get;set;}
    public Opportunity opportunity {get;set;}
    
    public ProductSummaryController(ApexPages.StandardController stdController) {        
        oppId = ApexPages.currentPage().getParameters().get('id');
        System.debug('AAAA: '+oppId);
        
        if(opportunity != null)
        {
            opportunity = [SELECT Id, Name, Account.Name 
                       FROM Opportunity
                      WHERE Id =: oppId];
        }
	}
    
    public Map<String,list<OpportunityLineItem>> opportunityLineItemMap
    {
        
        get
        {
            opportunityLineItemMap = new Map<String,list<OpportunityLineItem>>();
            
            for(OpportunityLineItem oli:[SELECT Id, Name, Product2.Name, Product2.Family, Discount, ListPrice, Quantity, UnitPrice, TotalPrice 
                                  FROM OpportunityLineItem
                                WHERE OpportunityId=: oppId ])
            {
                
                if(opportunityLineItemMap.get(oli.Product2.Family) == null)
                {
                    opportunityLineItemMap.put(oli.Product2.Family,new list<OpportunityLineItem>());
                }
                opportunityLineItemMap.get(oli.Product2.Family).add(oli);
            }
          
            
            System.debug('AAAA opportunityLineItemMap: '+opportunityLineItemMap);
            return opportunityLineItemMap;
        }
        set;
    }
    
    

}