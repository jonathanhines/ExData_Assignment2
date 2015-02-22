source("load_data.R");
library(plyr);
library(ggplot2);

png(file = "plot3.png", width = 800, height = 480, units = "px",)
baltimore_emissions_type_sums <- ddply(NEI[NEI$fips == "24510",], .(year,type),summarize, total=sum(Emissions))
p <- qplot(year, total, data = baltimore_emissions_type_sums, facets= .~type, geom=c("point","smooth"),method="lm", se=FALSE)
p <- p + labs(x = "Year", y="Total Emissions [tons]", title="Change of Various Emissions Types in Baltimore")
print(p)
dev.off()