# Author Sanjeev Sariya
# Date Deb 2016 13
# Programming Assignment 3
# Question 4

# Function: rankall
#           Has 2 functions:
#                           set_matrix    - sets global matrix                     
#                           create_matrix  - create matrix with <NA> and state names.. sets row names
#           Takes in arguments for outcomes: heart failure, heart attack and pneumonia     
#           Prints Hospital names for each states based on mortaility rate
#           Hospital rank could be extracted for: best, worst, or any number
#
rankall<-function(outcome,num="best"){
  
  outcome_data <- read.csv("outcome-of-care-measures.csv",na.strings = "Not Available")
  outcomes<-c("pneumonia","heart failure","heart attack")
  outcome_present<-any(outcomes==outcome) #test if outcome is present
  rank_vect<-c("best","worst")
  modified_col_names<-c("h_name","mort_rate")
  
  matrix_main<-data.frame(matrix()) # this will be over written 
  
  if(!outcome_present){ # if false
    stop("Invalid outcome")
  }
  
  if(class(num)=="character"){
    
    valid_num<-any(num == rank_vect)
    
    if(!valid_num){
      stop("Invalid character provided for num: best and worst accepted")
    }
    
  }
  #check for character num ends
  
  set_matrix<-function(m){ # this functoin overwrites the matrix in the beginnig -- lexical scopping
    matrix_main<<-m
  }
  #functoin ends
  
  create_matrix<-function(n_rows,state_name_list){
    # this is going to create <NA> and state name matrix values
    m<-data.frame(matrix(nrow=n_rows,ncol = 2,dimnames = list(state_name_list,c("hospital","state")) ))
    
    for(i in 1:n_rows){
      
      #print(state_name_list[i])
      m[i,1]<-"<NA>"
      m[i,2]<-state_name_list[i]
    }
    return(m)
  }
  
  #functoin ends
  if(outcome == "heart attack"){
    
    mortal_heart_attack<-outcome_data[,c(2,7,11)]  # hosp_name, state, and mort_rate
    na_heart_attack<-complete.cases(mortal_heart_attack)
    data_minus_na<-mortal_heart_attack[na_heart_attack,]
    split_by_state<-split(data_minus_na,data_minus_na$State) # split it per state basis -- Yay!!
    
    state_names<-names(split_by_state)
    #data_matrix<-data.frame(matrix(nrow=length(split_by_state),ncol=2,dimnames = list(state_names,c("hospital","state")) ))
    
    #for( i in 1:nrow(data_matrix)){
    # data_matrix[i,1]<-"<NA>"
    #  data_matrix[i,2]<-state_names[i]
    #}
    
    data_matrix<-create_matrix(length(split_by_state),state_names)  # function that takes length, and state names
    
    for(i in 1:length(state_names)){
      
      data<-data.frame(split_by_state[i]) # -- get data for the state
      data<-data[,c(1,3)] # -- only names, and rate
      names(data)<-modified_col_names
      data<-data[order(data$mort_rate,data$h_name),] # sort by morta rate and then hosp name to get ride of ties
      
      if(num=="worst"){
        
        data_matrix[i,1]<-levels(droplevels(data[nrow(data),1]))
        
      }
      # if worst ends
      
      if(num=="best"){
        
        data_matrix[i,1]<-levels(droplevels(data[1,1]))
      }
      if(class(num)=="numeric"){
        
        if(nrow(data)>num){
          data_matrix[i,1]<-levels(droplevels(data[num,1]))
        }
        # else let the hosp name as <NA>
        
      }
      # loop for numeric ends
      
    }
    ## iteration ends for states
    set_matrix(data_matrix)
    
  }
  ## -- heart attack ends
  
  if(outcome == "heart failure"){
    
    mortal_heart_failure<-outcome_data[,c(2,7,17)]
    na_heart_failure<-complete.cases(mortal_heart_failure)
    hf_minus_na<-mortal_heart_failure[na_heart_failure,]
    split_by_state<-split(hf_minus_na,hf_minus_na$State) # split it per state basis -- Yay!!
    
    state_names<-names(split_by_state)
    data_matrix<-create_matrix(length(split_by_state),state_names) # function that takes length, and state names
    
    for(i in 1:length(state_names)){
      data<-data.frame(split_by_state[i]) # -- get data for the state
      data<-data[,c(1,3)] # -- only names, and rate
      names(data)<-modified_col_names
      
      data<-data[order(data$mort_rate,data$h_name),] # sort by morta rate and then hosp name to get ride of ties
      
      if(num=="worst"){
        
        data_matrix[i,1]<-levels(droplevels(data[nrow(data),1]))
        
      }
      
      if(num=="best"){
        
        data_matrix[i,1]<-levels(droplevels(data[1,1]))
      }
      
      if(class(num)=="numeric"){
        
        if(nrow(data)>num){
          data_matrix[i,1]<-levels(droplevels(data[num,1]))
        }
        # else let the hosp name as <NA>
        
      }
      # loop for numeric ends
      
    }
    set_matrix(data_matrix)
    # for loop ends
    
  }
  ## -- heart failure ends
  if(outcome == "pneumonia"){
    
    mortal_pneumo<-outcome_data[,c(2,7,23)] # hosp_name, state, and mort_rate
    na_pneumo<-complete.cases(mortal_pneumo)
    pneu_minus_na<-mortal_pneumo[na_pneumo,]
    
    split_by_state<-split(pneu_minus_na,pneu_minus_na$State) #split by state
    state_names<-names(split_by_state)
    data_matrix<-create_matrix(length(split_by_state),state_names)  # function that takes length, and state names
    
    for(i in 1:length(state_names)){
      
      data<-data.frame(split_by_state[i]) # -- get data for the state
      data<-data[,c(1,3)] # -- only names, and rate
      names(data)<-modified_col_names
      
      data<-data[order(data$mort_rate,data$h_name),] # sort by morta rate and then hosp name to get ride of ties
      
      if(num=="worst"){
        
        data_matrix[i,1]<-levels(droplevels(data[nrow(data),1]))
        
      }
      if(num=="best"){
        
        data_matrix[i,1]<-levels(droplevels(data[1,1]))
        
      }
      if(class(num)=="numeric"){
        
        if(nrow(data)>num){
          data_matrix[i,1]<-levels(droplevels(data[num,1]))
          
        }
        # else let the hosp name as <NA>
        
      }
      # loop for numeric ends
      
    }
    #iteratoin ends for sytates
    set_matrix(data_matrix)
    
  }
  # pneumonia ends
  matrix_main #-- print everything in the end
  
}
#function ends

#head(rankall("heart attack",20),10)
#rankall("heart attack","worst")
#rankall("heart attack","best")

#rankall("heart failure","best")
#rankall("heart failure","worst")
#tail(rankall("heart failure"),10)
#tail(rankall("pneumonia","worst"),3)
#tail(rankall("pneumonia","best"),3)

#head(rankall("pneumonia",4),4)

r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)


r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)

r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)
