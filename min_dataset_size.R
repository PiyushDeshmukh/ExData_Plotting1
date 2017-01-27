
initial_loading <- function(file_name)
{
    # Load all the rows initially
    cat("Loading the whole dataset for initialization...\n")
    hpc <- read.csv(file_name, na.strings = '?', sep = ';', nrows = -1)
    hpc['Date'] <-lapply(hpc['Date'], strptime, "%d/%m/%Y")
    hpc <- hpc[(hpc$Date >= '2007-02-01' & hpc$Date <= '2007-02-02'),]

    # Actual number of rows we require for our analysis
    n_rows <- dim(hpc)[1]
    return (n_rows)
}

find_min_number_of_rows <- function(file_name, n_rows, step_size = 10000)
{
    cat("Finding minimum number of rows in the dataset that we require to load.\n")
    n <- 0
    while (TRUE)
    {
        n <- n + step_size
        hpc <- read.csv(file_name, na.strings = '?', sep = ';', nrows = n)
        hpc['Date'] <-lapply(hpc['Date'], strptime, "%d/%m/%Y")
        hpc <- hpc[(hpc$Date >= '2007-02-01' & hpc$Date <= '2007-02-02'),]
        if (dim(hpc)[1] == n_rows)
            return (n)
        cat(n, " aren't sufficient!\n")
    }
}

file_name <- '../household_power_consumption.txt'
n_rows <- initial_loading(file_name)
cat("There are only ", n_rows, " on which our analysis depends on.\n")
n <- find_min_number_of_rows(file_name, n_rows = n_rows)
cat("Load only first ", n, " rows.\n")
