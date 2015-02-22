source("load_data.R");
library(data.table);

vehicle_sources_SCC <- SCC[grep("vehicles", SCC$EI.Sector, ignore.case = TRUE),c("SCC")]
baltimore_emissions <- NEI[NEI$fips == "24510",]

baltimore_emissions_vehicle_sums <- data.table(
        baltimore_emissions[baltimore_emissions$SCC %in% vehicle_sources_SCC,]
    )[, list( total=sum(Emissions)), by=year]

png(file = "plot5.png")
with(baltimore_emissions_vehicle_sums, plot(year, total, col="darkblue", main="Total Emissions of PM2.5 in Baltimore", xlab="Year",ylab="Total Emissions [tons]", pch=20) )
mtext("Motor Vehicle Related Sources")
model <- lm(total ~ year, emissions_vehicle_sums)
abline(model, lty=2)
dev.off()