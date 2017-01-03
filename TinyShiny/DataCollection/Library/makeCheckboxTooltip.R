makeCheckboxTooltip <- function(checkboxValue, buttonLabel, Tooltip, specialOnes=checkboxValue[1:4]){
  normalOnes<-checkboxValue[!checkboxValue %in% specialOnes]
  
  co<-rep('LightGrey',length(checkboxValue))
  co[checkboxValue %in% specialOnes]<-'LightGreen'

  tags$script(HTML(paste0("
                          $(document).ready(function() {
                          var inputElements = document.getElementsByTagName('input');
                          for(var i = 0; i < inputElements.length; i++){
                          var input = inputElements[i];
                          
                          if(input.getAttribute('value') == '", checkboxValue, "'){
                          var buttonID = 'button_' + Math.floor(Math.random()*1000);
                          
                          var button = document.createElement('button');
                          button.setAttribute('id', buttonID);
                          button.setAttribute('type', 'button');
                          button.setAttribute('class', 'btn action-button btn-inverse btn-xs');
                          if(input.getAttribute('value')=='",specialOnes,"'){
                          button.setAttribute('style', 'background-color:red');
}
                         
                            button.style.backgroundColor = '",co,"';

                          
                          

                          button.appendChild(document.createTextNode('", buttonLabel, "'));
                          
                          input.parentElement.parentElement.appendChild(button);
                          shinyBS.addTooltip(buttonID, \"tooltip\", {\"placement\": \"bottom\", \"trigger\": \"hover\", \"title\": \"", Tooltip, "\"}) 
                          };


                          }
                          });
                          ")))
                          }