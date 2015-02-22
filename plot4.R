source("load_data.R");
library(data.table);

# Get the codes that relate to coal combustion
coal_sources_SCC <- SCC[grep("coal", SCC$EI.Sector, ignore.case = TRUE),c("SCC")]

# Get the sums grouped by year of only the coal related source emissions
emissions_coal_sums <- data.table(
    NEI[NEI$SCC %in% coal_sources_SCC,]
    )[, list( total=sum(Emissions)), by=year]

# Adjust the values so that they plot nicely
emissions_coal_sums$total <- emissions_coal_sums$total/1e3

# Build the plot
png(file = "plot4.png")
with(emissions_coal_sums, 
     plot(
         year, 
         total, 
         col="darkblue",
         main="Coal Combustion Related Emissions of PM2.5",
         xlab="Year",ylab="Total Emissions [thousands of tons]", pch=20
     )
)
mtext("United States")
model <- lm(total ~ year, emissions_coal_sums)
abline(model, lty=2)
dev.off()