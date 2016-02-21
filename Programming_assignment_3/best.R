# Author Sanjeev Sariya
# Date Deb 2016 12
# Programming Assignment 3
# Question 2

#Function: best
#         Takes in 2 arguments:
#                             state, outcome
#                             outcome should be in heart failure, heart attack, and pneumonia
#         Function gives you best hospital in the state


best <- function(state, outcome) {
  
  outcome_data <- read.csv("outcome-of-care-measures.csv",na.strings = "Not Available")

  outcomes<-c("pneumonia","heart failure","heart attack")
  outcome_states<-outcome_data$State # store states
  
  outcome_present<-any(outcomes==outcome) #test if outcome is present
  valid_state<-any(outcome_states == state) #check if valid state
  modified_col_names<-c("h_name","mort_rate")
  best_hosp<-"" #print best hosp at the end
  
  if(!outcome_present){ # if false
    stop("Invalid outcome")
  }

  if(!nchar(state) ==2){
    stop("Invalid State")
  }
  if(!valid_state){
    stop("Invalid state")
  }
  
  if(outcome == "heart attack"){
    
    mortal_heart_attack<-outcome_data[,c(2,7,11)]  # hosp_name, state, and mort_rate
    na_heart_attack<-complete.cases(mortal_heart_attack)
    data_minus_na<-mortal_heart_attack[na_heart_attack,]
    split_by_state<-split(data_minus_na,data_minus_na$State) # split it per state basis -- Yay!!
    data_frame<-data.frame(split_by_state[state])
    data_frame<-data_frame[,c(1,3)]
    names(data_frame)<-modified_col_names
    data_frame<-data_frame[order(data_frame$mort_rate,data_frame$h_name),]
    best_hosp<-levels(droplevels(data_frame[1,1]))
    
    
  }
  ## -- heart attack ends
  
  if(outcome == "heart failure"){
    
    mortal_heart_failure<-outcome_data[,c(2,7,17)]
    na_heart_failure<-complete.cases(mortal_heart_failure)
    hf_minus_na<-mortal_heart_failure[na_heart_failure,]
    split_by_state<-split(hf_minus_na,hf_minus_na$State) # split it per state basis -- Yay!!
    
    data_f<-data.frame(split_by_state[state])
    data_f<-data_f[,c(1,3)]
    names(data_f)<-modified_col_names
    
    data_f<-data_f[order(data_f$mort_rate,data_f$h_name),]
    best_hosp<-levels(droplevels(data_f[1,1]))
  }
  # heart failure ends
  
  if(outcome == "pneumonia"){
    
    mortal_pneumo<-outcome_data[,c(2,7,23)] # hosp_name, state, and mort_rate
    na_pneumo<-complete.cases(mortal_pneumo)
    pneu_minus_na<-mortal_pneumo[na_pneumo,]
    
    split_by_state<-split(pneu_minus_na,pneu_minus_na$State) #split by state
    
    data<-data.frame(split_by_state[state]) # -- get data for the state
    data<-data[,c(1,3)] # -- only names, and rate
    names(data)<-modified_col_names # change col names to access names, and rate
  
    data<-data[order(data$mort_rate,data$h_name),] # sort by morta rate and then hosp name to get ride of ties

    best_hosp<-levels(droplevels(data[1,1]))
    
  }
  # pneumonia ends
  best_hosp
 
}
#-- function ends

#best("TX","heart attack")
#best("MD","heart attack")
#best("MD","pneumonia")
#best("TX","heart failure")

best("SC","heart attack")
best("NY","pneumonia")
best("AK", "pneumonia")
