# Milestone 3 Writeup

### Reflection on the usefulness of the feedback received

There was some (expected) difficulty in the usability of our app, since we were aware that not all of the functionality was present at the time we released our second version. Similar comments across different reviewers included the non-functionality of the map and the non-linkage of some data to the graphic on the Trend tab (which, again, were problem areas we were aware of).

From the feedback, appropriate changes that we have addressed include:
1. Allow user select multiple different line graphs in 'Time Series' (e.g. compare colon to breast cancer)
  - We have allowed users to select 3 cancer types simulaneously to be plotted for comparison
2. The confusion of having both `ALL` and `All cancers`.
  - we will specify that ALL refers to a type of leukemia.

Changes we will not be addressing and reasons why:
1. Functionality of the map
  - Unfortunately, though we very much wanted to get this up and running, due to time constraints and technical difficulties, this is something we have had to remove. We were going to address the comment to move it to another tab, but sadly this will not be implemented.
2. Sort cancer type dropdown options by descending incidence instead of by alphabetical order
  - While we agree this would be a wonderful addition to the app, due to time constraints and technical difficulties it will not be something we'll be able to address.

The least valuable feedback we received was regarding the non-functioning aspects of our app, since we were already well aware of them. The most valuable feedback was to place the map in a separate tab (though it's a shame that this valuable feedback could not be implemented).

Rachel's experience of being a "fly-on-the-wall":
*Having to verbalize my exploration of another app made me much more aware of what I was looking at. If something wasn't obvious then it made me think this same issue might exist in ours. It helped me look at and think of our own app from a different perspective, which was helpful.*

Coste's experience of being a "fly-on-the-wall":
*I learned that its a real good way of viewing how others would use the app - without being able to explain it's really amazing to see how others interpret your intentions and where the real pain points are. I think its a great trouble shooting and feedback method for app creation and I found it very useful. For example when users were testing out app and I was a "fly-on-the-wall" it was quite quick to realize for me that they didn't understand the tabs well as they kept asking "why is this here, what does it do?"*


### Reflection on how the project has changed since Milestone 2, and why.

As stated above, the map functionality was difficult to implement and we are running into a few technical difficulties. Our main challenge has been to combine our data with geo-spatial data - we have found a few tutorials but still are running into trouble. Since we have a few days from today and the final submission deadline we created a tab called map with the map as a placeholder for now! If we get to finishing it then great, but if not we will have to let this go.

<<<<<<< HEAD
Because we lost this aspect of a map, we implemented some additional tabs to explore our variables visually. We broke the 'Trend' tab into 'Cancer rate by age group' and we will be creating a 'Cancer rate by gender' tab time permitting. For the Cancer rate by gender tab, we have it working so far and we chose the 'year' drop down menu to only show every 5 years - since trends don't change too much year to year. We would actually like to plot maybe 2-3 plots in this section of the different years so its easier to compare for the user - but this function would be a nice to have and not a must.
=======
Because we lost this aspect of a map, we implemented some additional tabs to explore our variables visually. We broke the 'Trend' tab into 'Cancer rate by age group' and we will be creating a 'Cancer rate by gender' tab.
>>>>>>> upstream/master
