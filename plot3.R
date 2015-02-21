source("load_data.R");
library(plyr);
library(ggplot2);

png(file = "plot3.png")
baltimore_emissions_type_sums <- ddply(NEI[NEI$fips == "24510",], .(year,type),summarize, total=sum(Emissions))
p <- qplot(year, total, data = baltimore_emissions_type_sums, facets= .~type, geom=c("point","smooth"),method="lm")
print(p)
dev.off()