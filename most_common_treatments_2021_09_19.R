#!/usr/bin/env R

library(tidyverse)
library(dplyr)

#import filename
#args=(commandArgs(TRUE))
#if(length(args)==0){
#  print("No arguments supplied.")
#}
#setwd("~/Desktop")
#input = args[1]
input = "SPIA_results_treatmentLymphoma-treatmentHealthy.csv-Treatments.tsv"

looking = read_tsv(input) %>%
  as_tibble() %>%
  #mutate(Is_FDA_Approved = NULL) %>%
  mutate(Target_ID = NULL) %>%
  mutate(Target_Symbol = NULL) %>%
  mutate(Pathway_DB = NULL) %>%
  #mutate(Highest_Clinical_Trial_Phase = NULL) %>%
  #mutate(Has_Been_Withdrawn = NULL) %>%
  mutate(Target_Name = NULL) %>%
  unique()%>%
  group_by(Drug_Name) %>%
  summarize(Drug_Name, Drug_ID, Significant_Pathways_Targeted = length(Drug_Name), 
            Is_FDA_Approved, Highest_Clinical_Trial_Phase, Has_Been_Withdrawn) %>%
  arrange(desc(Significant_Pathways_Targeted)) %>%
  unique() %>%
  print()



#hey_there = read_tsv(input) %>%
#  print()

write_tsv(looking, "Lymphoma_Healthy_Drug_Pathway_Summary.tsv")
