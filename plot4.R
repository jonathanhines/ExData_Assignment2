source("load_data.R");
library(data.table);

coal_sources_SCC <- SCC[grep("coal", SCC$EI.Sector, ignore.case = TRUE),c("SCC")]
emissions_coal_sums <- data.table(NEI[NEI$SCC %in% coal_sources_SCC,])[, list( total=sum(Emissions)), by=year]
emissions_coal_sums$total <- emissions_coal_sums$total/1e3

#png(file = "plot4.png")
with(emissions_coal_sums, plot(year, total, col="darkblue", main="Total Emissions of PM2.5 in the Unitied States", xlab="Year",ylab="Total Emissions [thousands of tons]", pch=20) )
mtext("Coal Combustion Related Sources")
model <- lm(total ~ year, emissions_coal_sums)
abline(model, lty=2)
#dev.off()