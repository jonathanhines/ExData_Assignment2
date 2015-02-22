source("load_data.R");
library(data.table);

# Get the total emissions from Baltimore split by year
baltimore_emissions_sums <- data.table(
    NEI[NEI$fips == "24510",]
)[, list( total=sum(Emissions)), by=year]

# Adjust the values for nicer plotting
baltimore_emissions_sums$total <- baltimore_emissions_sums$total/1e3

# Build the plot
png(file = "plot2.png")
with(baltimore_emissions_sums, 
     plot(
         year, 
         total, 
         col="darkblue", 
         main="Total Emissions of PM2.5 in Baltimore", 
         xlab="Year",
         ylab="Total Emissions [thousands of tons]", 
         pch=20
     ) 
)
model <- lm(total ~ year, baltimore_emissions_sums)
abline(model, lty=2)
dev.off()