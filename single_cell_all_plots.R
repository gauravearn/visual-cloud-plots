#!/usr/bin/env Rscript --vanilla
library(argparse)
library(ggrain)
#   an addition to the single cell analysis to make the rainbow cloud maps for the expression datasets
#   if you have used the multi-samples analysis and have clustered them using the ident.1 and ident.2
#   and used the use.test, then you can use the following command line script to plot the rainbow cloud.
#   if you have used the limma package for the analysis then also you can use the same. You can also 
#   view the expression summation across the replicates as the rainbow plot.
parser <- ArgumentParser()
parser$argument("-s", "--single_cell_expression", action="store_true",
                help = "please provide the single cell expression analysis sheet")
parser$argument("-c", "--control_replicates_col", 
                help = "please provide the control replicates column number")
parse$argument("-f", "--first_replicate_col", 
                help= "please provide the first treatment column number")
parse$argument("-s", "--second_replicate_col", 
                help = "please provide the second treatment column number")
parse$argument("-t", "--third_replicate_col", 
                help = "please provide the third treatment column number")
parse$argument("-e", "--expression_view", 
                help = "please tell if you are using for the expression view")
parse$argument("-d", "--differential_view", 
                help = "please tell if you are using for the differential view
                along with the column number for the log2fc")
parse$argument("-ec", "--expression_class",
                 help = "please tell the species or the label class for the classification")
args <- parser$parse_args()
expression_datasets <- args$single_cell_expression
control_rep <- args$control_replicates_col
first_rep <- args$first_replicate_col
second_rep <- args$second_expression
third_rep <- args$third_expression 
control_expression <- expression_datasets["control_rep"]
first_expression <- expression_datasets["first_rep"]
second_expression <- eexpression_datasets["second_rep"]
third_expression <- expression_datasets["third_rep"]

if (args$single_cell_expression && 
        args$control_replicates_col && 
                args$first_replicate_col && 
                    args$second_replicate_col && 
                            args$third_replicate_col)
{
    control_sum <- for (i in seq_len(nrow(control_expression))){
        print(sum(control_expression[i,]))
        }
    first_expression <- for (i in seq_len(nrow(first_expression))){
        print(sum(first_expression[i,]))
        }
    second_expression <- for (i in seq_len(nrow(second_expression))){
        print(sum(second_expression[i,]))
        }
    third_expression <- for (i in seq_len(nrow(third_expression))){
        print(sum(third_expression[i,]))
        }
    expression_list <- expression_datasets["list"]
    expression_sum <- as.data.frame(c(control_expression,first_expression,
                                  second_expression, third_expression, expression_list))
    control <- ggplot(new, aes(expression_list, control_expression, fill = expression_list)) + geom_rain()
    first <- ggplot(new, aes(expression_list, first_expression, fill = expression_list)) + geom_rain()
    second <- ggplot(new, aes(expression_list, second_expression, fill = expression_list)) + geom_rain()
    third <- ggplot(new, aes(expression_list, third_expression, fill = expression_list)) + geom_rain()
    control+first+second+third
}
if (args$differential_view && 
        args$single_cell_expression && 
                    args$expression_class
) {
    expression_datasets <- args$single_cell_expression
    differential_view <- args$differential_view
    expression_list <- args$expression_class
    expression_change <- differential_view["differential_view"]
    expression_list <- differential_view["expression_list"]
    ggplot(new, aes(expression_list, third_expression, fill = expression_list)) + geom_rain()
}
