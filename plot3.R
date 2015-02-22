source("load_data.R");
library(plyr);
library(ggplot2);

# Get the total emissions from Baltimore split by year and type of Emission
baltimore_emissions_type_sums <- ddply(
    NEI[NEI$fips == "24510",],
    .(year,type),
    summarize,
    total=sum(Emissions)
)

# Build the plot, this one is going to be wide
png(file = "plot3.png", width = 800, height = 480, units = "px")
p <- qplot(
    year, 
    total, 
    data = baltimore_emissions_type_sums,
    facets= .~type,
    geom=c("point","smooth"),
    method="lm",
    se=FALSE
)
p <- p + labs(
    x = "Year",
    y="Total Emissions [tons]",
    title="PM2.5 Emissions by Type in Baltimore"
)
print(p)
dev.off()