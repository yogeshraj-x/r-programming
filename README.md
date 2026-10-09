# ITA04 Statistics with R Programming — Lab Experiments

Solutions for all 21 experiments listed in **LAB EXPERIMENTS.pdf**.

## Files
- \`lab_experiments.R\` — commented R code for Experiments 1–21.

## How to run
1. Install [R](https://www.r-project.org/) or use RStudio.
2. Download \`lab_experiments.R\`.
3. Open it in RStudio and run one section at a time. Some sections create plots or write \`exam_data.csv\` in your current working directory.

## Optional packages
- \`reshape2\` for reshaping \`airquality\` and \`ChickWeight\`.
- \`nnet\` for multinomial logistic regression on the three-class \`iris$Species\` outcome.

Install them in R with:
\`\`\`r
install.packages("reshape2")
install.packages("nnet")
\`\`\`

## External data required for specific experiments
- Experiment 11: put your CSV file in the working directory as \`input.csv\`, or edit the filename in the script.
- Experiment 17: the base R \`Titanic\` dataset is aggregated and has no passenger-age column. To draw an age histogram, provide an individual-passenger \`titanic.csv\` with an \`Age\` column.
- Experiment 19: provide \`advertising.csv\` with numeric columns named \`Spend\` and \`Sales\`. No advertising data file was included with the lab sheet, so the script does not fabricate observations.

The script uses the built-in datasets where specified and includes comments for requirements that cannot be completed without an external file.
