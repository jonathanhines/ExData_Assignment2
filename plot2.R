source("load_data.R");
library(data.table);

baltamore_emissions_sums <- data.table(NEI[NEI$fips == "24510",])[, list( total=sum(Emissions)), by=year]
baltamore_emissions_sums$total <- baltamore_emissions_sums$total/1e3

png(file = "plot2.png")

# Scatter plot
with(baltamore_emissions_sums, plot(year, total, col="darkblue", main="Total Emissions of PM2.5 in Baltimore by Year", xlab="Year",ylab="Total Emissions [thousands of tons]", pch=20) )
model <- lm(total ~ year, baltamore_emissions_sums)
abline(model, lty=2)
dev.off()