source("load_data.R");
library(data.table);
year_emissions_sums <- data.table(NEI)[, list( total=sum(Emissions)), by=year]
year_emissions_sums$total <- year_emissions_sums$total/1e6

png(file = "plot1.png")
# Bar chart sample
#with(year_emissions_sums, barplot(total, names.arg=year, col="darkblue", main="United States Total Emissions of PM2.5 by Year") )

# Scatter plot
with(year_emissions_sums, plot(year, total, col="darkblue", main="Total Emissions in Tons by Year", xlab="Year",ylab="Total Emissions [millions of tons]", pch=20) )
model <- lm(total ~ year, year_emissions_sums)
abline(model, lty=2)
dev.off()
