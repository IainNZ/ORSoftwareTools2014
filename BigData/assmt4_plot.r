library(ggplot2)

output = read.csv("output.csv")
output = subset(output, output$count >= 20)
output = subset(output, output$start != output$end)
ggplot(output, aes(x=start, y=end, fill=mu)) + geom_tile()