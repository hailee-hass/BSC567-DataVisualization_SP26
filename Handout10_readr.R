# Handout 10  - 11 Feb 2026
# READR

#read_csv = comma-delimited files
#read_csv2 = semi-colon files
#read_tsv = tab-delimited files
#read_delim = reads files with ANY delimiter

write_csv(diamonds, "diamonds.csv")

diamonds <-  read_csv("diamonds.csv")

read_csv("a, b, c
         1, 2, 3
         4, 5, 6")

read_csv("The first line of metadata
         The second line of metadata
         x, y, z
         1, 2, 3", skip= 2)

read_csv("# A comment I want to skip
         x, y, z
         1, 2, 3", comment= "x")

read_csv("1, 2, 3\n4, 5, 6", col_names = FALSE)

read_csv("1, 2, 3\n4, 5, 6", col_names = c("x", "y", "z"))

read_csv("a, b, c\n1, 2, .", na= ".")

diamonds

###### Looking at how R parses data ######
guess_parser("2010-10-01")
guess_parser("15:01")
guess_parser(c("TRUE", "FALSE"))
guess_parser(c("1", "5", "9"))

write_excel_csv(df, "df.xlsx")

write_csv(diamonds, "new_diamonds_file.csv")

## Create a small tibble, save as CSV, then read back into R as tibble ##
tibble <- tibble(
  x= 1:5, 
  y= 1,
  z= x ^ 2 +y) #creating a small tibble from handout 9

write_csv(tibble, "tibble.csv")

read_csv("tibble.csv")

###### End code ######