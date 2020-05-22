# Readme for COVID-2019.ru

This repo was created to keep records of the COVID-2019 epidemics in Russia. The dataset is based on the official reports of confimed cases. This means that the data lag behind the spread of the virus. See also a magnificent project by [Johns Hopkins Univ.](https://github.com/CSSEGISandData/COVID-19)

Other resources on Russia:

* [MediaZona at GitHub](https://github.com/mediazona/data-corona-Russia)

All images originally published in this repository are licensed under cc-by-4.0

Fitting and prognostic scripts ceased to work properly towards the end of April 2020, now they are fixed and the images are kept being updated.

## Data extraction procedures

While working on this project I had to change data gathering procedures several times. During the early weeks, until 2020-03-24, I relied mostly on the media publishing updates from time to time. Then, from 2020-03-24/25 through 2020-04-07 I shifted to the website of RosPotrebNadzor, which published daily reports with a breakdown by regions. Then, from 2020-04-08 on, стопкоронавирус.рф became the main source of information (also, some information on recovered and deceased from it has been used retrospectively to fill in the gaps). RosPotrebNadzor was rather inconsistent in data formats mostly relying on HTML representation of simple lists. стопкоронавирус.рф changed their reporting format twice, most notably on 2020-04-29. Since 2020-04-29 the data have been published as a valid JSON chunk embedded in the code of the webpage.

As for now, the procedure of data extraction works as follows:

* Run `scripts/stopcoronavirus.extractor.20200429.pl` (results in `downloads/stopcoronavirus.storage.cumulative.20200429.txt`, `downloads/stopcoronavirus.storage.moment.20200429.json` and `downloads/stopcoronavirus.timestamp.moment.20200429.txt`
* Run `covid.2019.converter.r` (results in `downloads/increment.txt` and `downloads/increment.0.txt`)
* Pick `downloads/increment.txt` and feed it into an electronic table (to ajust for the English language region codes).
* Copy the resulting table to `data/momentary.txt`
* Run `scripts/covid.2019.disaggregator.pl` (results in `data/momentary.da.txt`).

After that one can start running analytic and plotting R scripts. All of them are listed in:

* `scripts/covid.2019.ru.main.r`

## Illustrations

The visualizations derived from nation-wide data are as follows. For regional graphs see [a special subfolder](https://github.com/alexei-kouprianov/COVID.2019.ru/tree/master/plots/regions "Regional graphs")

<!--![alt text](plots/COVID.2019.cumulated.png "Cumulated curve of COVID-2019 cases for Russia")-->
<!--![alt text](plots/COVID.2019.cumulated.log10.png "Cumulated curve of COVID-2019 cases for Russia, y-logarithmic")-->
![alt text](plots/COVID.2019.cumulated.TARD.png "Cumulated curve of COVID-2019 cases for Russia decomposed")
![alt text](plots/COVID.2019.cumulated.TARD.log10.png "Cumulated curve of COVID-2019 cases for Russia decomposed, y-logarithmic")
![alt text](plots/COVID.2019.cumulated.by_regions.png "Cumulated curve of COVID-2019 cases for Russia, by regions")
![alt text](plots/COVID.2019.cumulated.log.10.by_regions.png "Cumulated curve of COVID-2019 cases for Russia, y-logarithmic, by regions")
![alt text](plots/COVID.2019.cumulated.log10.1M.png "Cumulated curve of COVID-2019 cases for Russia, y-logarithmic, by regions for regions with capital city population over 1000K")

![alt text](plots/COVID.2019.barplot.regions.png "COVID-2019 total cases for Russia by regions")
![alt text](plots/COVID.2019.barplot.regions.log.10.png "COVID-2019 total cases for Russia by regions")
![alt text](plots/COVID.2019.barplot.regions.per_100K.png "COVID-2019 total cases per 100K inhabitants for Russia by regions")

![alt text](plots/COVID.2019.hist.rdi.png "COVID-2019 Rt 7 days rolling averages for regions of Russia")
![alt text](plots/COVID.2019.hist.dt.png "COVID-2019 cases doubling time based on Rt 7 days rolling averages for regions of Russia")
![alt text](plots/COVID.2019.map.regions.png "COVID-2019 total cases for Russia, map")
![alt text](plots/COVID.2019.map.regions.per_100K.png "COVID-2019 total cases per 100K inhabitants for Russia, map")

![alt text](plots/COVID.2019.map.density.regions.png "COVID-2019 total cases for Russia, density map")
![alt text](plots/COVID.2019.map.density.regions.per_100K.png "COVID-2019 total cases per 100K inhabitants for Russia, density map")
![alt text](plots/COVID.2019.map.density.regions.rdi7dt.png "COVID-2019 cases doubling time based on Rt 7 days rolling averages for regions of Russia, density map")

<!--![alt text](plots/COVID.2019.fitting.expGrowth_vs_LL.3.png "Fitting the data with exponent and log-logistic")
![alt text](plots/COVID.2019.fitting.expGrowth_vs_LL.3.log10.png "Fitting the data with exponent and log-logistic, y-logarithmic")-->
![alt text](plots/COVID.2019.fitting.rmc.partial.log10.png "Fitting / extrapolating the data with exponent and log-logistic, y-logarithmic (entire Russia)")
![alt text](plots/COVID.2019.fitting.rmc.partial.Mos.log10.png "Fitting / extrapolating the data with exponent and log-logistic, y-logarithmic (Moscow)")
![alt text](plots/COVID.2019.fitting.rmc.partial.SPb.log10.png "Fitting / extrapolating the data with exponent and log-logistic, y-logarithmic (St. Petersburg)")
