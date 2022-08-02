# nest_spacing2

r project to analyze nest spacing for use-of-space paper. What is the right metric and how do we calculate it?

In late July 2022 this is my planned approach:

For each territory and year
-	Select one focal nest
-	Find all contemporary nests (with different terr, diff male, diff fem)
o	to be contemporary the hatch date of the comparison nests must be within 19 days (or 30?) of the hatch date of the focal nest
o	Comparison nests must not already been used as a focal or comparison nest (?)
o	Select the closest comparison nest
o	Record the distance


	At this point probably check the outliers to see if there were focal nests which had no realistic comparisons. If a bird nests when nobody else local is nesting…I dunno, might need to play with the criterion for being “contemporary”

This post pretty much outlines an R solution for the last two steps, finding the closest nest and recording the nest and its identity.  There are about three solutions and I ended up using the last one, using sf (simple features). I still have to set up the criteria for identifying the group of contemporary valid nests. https://stackoverflow.com/questions/21977720/r-finding-closest-neighboring-point-and-number-of-neighbors-within-a-given-rad

This second post modifies one of the solutions in the above post to restrict the pool of candidates for closest nest.  Explicitly it modifies one of the solutions I did not use.  But maybe there are tools here I can adapt: https://stackoverflow.com/questions/39260268/looping-and-finding-nearest-data-points-for-sub-groups?noredirect=1&lq=1
