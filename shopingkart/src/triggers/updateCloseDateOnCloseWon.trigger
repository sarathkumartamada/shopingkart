trigger updateCloseDateOnCloseWon on Opportunity (before insert,before update) {


 for(Opportunity opp:trigger.new)
      {
          if(opp.isWon)
          {
          opp.CloseDate=date.today();
         
          }
      
      
      }

}