# This script loads the data if it isn't already
# If the source isn't downloaded yet go get it and download it
if (!file.exists("summarySCC_PM25.rds") || !file.exists("Source_Classification_Code.rds")) {
    if( .Platform$OS.type == "windows" ) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "project.zip", mode="wb")
        unzip("project.zip")
        unlink("project.zip")
    } else {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "project.zip", method="curl")
        unzip("project.zip")
        unlink("project.zip")
    }
    write(date(), file="dateDownloaded.txt")
}

# Check to see if the data is already loaded.  If not load it.
if(!exists("NEI")) {
    message( "Loading NEI..." )
    NEI <- readRDS("summarySCC_PM25.rds")
} else {
    message( "NEI already loaded" )
}
if(!exists("SCC")) {
    message( "Loading SCC..." )
    SCC <- readRDS("Source_Classification_Code.rds")
} else {
    message( "SCC already loaded" )
}
