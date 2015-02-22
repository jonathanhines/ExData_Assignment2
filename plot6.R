source("load_data.R");
library(data.table);

vehicle_sources_SCC <- SCC[grep("vehicles", SCC$EI.Sector, ignore.case = TRUE),c("SCC")]
baltimore_emissions <- NEI[NEI$fips == "24510",]

baltimore_emissions_vehicle_sums <- data.table(
    baltimore_emissions[baltimore_emissions$SCC %in% vehicle_sources_SCC,]
)[, list( total=sum(Emissions)), by=year]

la_emissions <- NEI[NEI$fips == "06037",]

la_emissions_vehicle_sums <- data.table(
    la_emissions[la_emissions$SCC %in% vehicle_sources_SCC,]
)[, list( total=sum(Emissions)), by=year]

total_emissions_sums <- rbind(la_emissions_vehicle_sums,baltimore_emissions_vehicle_sums)
total_emissions_sums$county <- factor(c(rep("Los Angeles County",4),rep("Baltimore",4)))

png(file = "plot6.png")
with(total_emissions_sums, plot(year, total, col=total_emissions_sums$county, main="Total Emissions of PM2.5", xlab="Year",ylab="Total Emissions [tons]", pch=20) )
mtext("Motor Vehicle Related Sources")
model <- lm(total ~ year, la_emissions_vehicle_sums)
abline(model, lty=2, col="red")
model <- lm(total ~ year, baltimore_emissions_vehicle_sums)
abline(model, lty=2)
legend("right",legend=c("Los Angeles County","Baltimore"),col=c(2,1),pch=20)
dev.off()