source("load_data.R");
library(data.table);

# Get the sum of all emmissions split by year
year_emissions_sums <- data.table(NEI)[, list( total=sum(Emissions)), by=year]

# Adjust the values for nicer plotting (reflected in the y axis label)
year_emissions_sums$total <- year_emissions_sums$total/1e6

# Build the plot
png(file = "plot1.png")
with(year_emissions_sums, 
     plot(
         year,
         total,
         col="darkblue",
         main="Total PM2.5 Emissions in the United States",
         xlab="Year",
         ylab="Total Emissions [millions of tons]",
         pch=20
     )
)
model <- lm(total ~ year, year_emissions_sums)
abline(model, lty=2)
dev.off()
