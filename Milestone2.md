# Milestone 2 Writeup

### Rationale

Our rationale for the set up of the app was that we wanted to allow the user to choose exactly for which patient population they would like see a cancer-incidence time-series graph. We also wanted to allow the user to view other trends in the data, such as age vs. cancer incidence. For this reason we created two tabs: Time Series and Trend.

### Tasks
1. Build a Time Series tab:
    - create a side panel that allows the user to choose the population of interest by filtering region, age, gender, years
    - display a plot based on the user's population of interest:
        - x-axis: time, y-axis: cancer incidence
        - show error bars around each estimate
2. Build a Trend tab:
    - create a side panel that allows the user to choose a variable of interest for a specific cancer type:
        - this would be displayed on the x-axis
        - y-axis is static (always cancer incidence per 100,000)
    - display a plot of variable of interest vs cancer incidence:
        - example: age group vs. cancer incidence
3. Build an interactive map in Time Series tab:
    - display overall cancer incidence in each province
    - user can click on a province and it would act as filter for the time-series region

### Vision and next steps

We were able to complete our first task without any bugs, however the second/third tasks have multiple bugs due to technical difficulties. Our vision is that by next week we will have the trend tab fully working. The main goal is to fix task 2 and address how to best visualize the data for different variables as some are categorical (gender) while others can be treated as continuous (age). Moreover, depending on which trend the user is interested in, there still needs to be filtering of other variables to show the final plot. We may need to narrow down the focus of the 'Trend' tab to only allow for age group vs. cancer incidence trend analysis given the scope of the project.

Our map is currently not interactive with the user and doesn't show any data, we do wonder whether it's really needed since the user can select a region quite easily from the drop down menu in the side panel on the time-series tab. We may change its purpose to only show overall cancer incidence in different provinces and be a static map. Another option would be to make it into its own tab - but given the time for this project and our need to fix the 'Trend' tab this may not be feasible. At this point, having a 'Map' tab would be nice to have, but we are happy with creating a static image with overall cancer incidence statistics.

Our vision has changed in that we would like to allow the user to view other types of trends in the data as recommended by our TA. Initially we were interested in time-series only but the dataset is large and interesting - the users would definitely benefit form examining other types of trends. Our vision has also changed in our use of the map - simply having it for selection of a region is likely not optimal and takes up lots of room and would slow down the app which is why we suggested the changed mentioned previously/below.

### Bugs

1. Map - doesn't display summary statistics, currently not used to interact with user. We will fix this by either making it into its own tab where the user could filter by cancer type, age, sex and quickly view the incidence by region. Another option will be to only display overall cancer incidence in each province and have it be a static summary image which we are happy with.
2. Trend tab - the 'choose variable' doesn't actually filter across the different variables. It only shows a graph of age vs. cancer type selected. We may make this tab examine only Age vs cancer incidence and allow the user to filter the other variables (sex, years, regions) to narrow the scope of the tab. Otherwise we would need to code the tab to plot different types of plots depending on the variable chosen by the user.
3. Time series tab - no bugs, would like to add functionality for the user to be able to add up to three different cancer types onto the same plot to allow for comparison.
4. App aesthetics - we would like to experiment with different themes to see if we can improve the color scheme.
