df <- fread("https://covidtracking.com/api/us/daily.csv",
            select = c("date", "totalTestResults"), showProgress = FALSE)

setnames(df, c("date", "totalTestResults"), c("Date", "Cumulative total"))

df[, Country := "United States"]
df[, Units := "units unclear"]
df[, Date := ymd(Date)]
df[, `Source label` := "COVID Tracking Project"]
df[, `Source URL` := "https://covidtracking.com/api/us/daily.csv"]
df[, Notes := NA_character_]
df[, `Testing type` := "includes non-PCR"]

setorder(df, Date)
df <- df[, .SD[1], `Cumulative total`]

fwrite(df, "automated_sheets/United States - COVID tracking project.csv")
