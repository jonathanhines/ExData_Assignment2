source("load_data.R");
library(data.table);

# Get source codes related to motor vehicles
vehicle_sources_SCC <- SCC[grep("vehicles", SCC$EI.Sector, ignore.case = TRUE),c("SCC")]

# Get only emissions from Baltimore
baltimore_emissions <- NEI[NEI$fips == "24510",]

# Get the sums of the Baltimore emissions split by year
baltimore_emissions_vehicle_sums <- data.table(
    baltimore_emissions[baltimore_emissions$SCC %in% vehicle_sources_SCC,]
)[, list( total=sum(Emissions)), by=year]

# Build the plot
png(file = "plot5.png")
with(baltimore_emissions_vehicle_sums,
     plot(
         year,
         total,
         col="darkblue",
         main="Motor Vehicle Related Emissions of PM2.5",
         xlab="Year",
         ylab="Total Emissions [tons]",
         pch=20
     )
)
mtext("Baltimore")
model <- lm(total ~ year, baltimore_emissions_vehicle_sums)
abline(model, lty=2)
dev.off()