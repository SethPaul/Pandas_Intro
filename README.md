# Intro to Pandas

## Schedule
 - Overview of Pandas (30 minutes)
     - uses
     - strengths
     - shortcomings
     - quick overview key commands/ideas
   ____________



 - Split on interest and experience: (45 minutes)
     - Beginners:
         - I'll walk through some examples and answer any questions that may come up.
         - I hope to cover IO, selection/filtering, apply, groupby, filling/dropping rows/columns, some indexing, and more advanced selection techniques as time allows.
     - Intermediate:
         - Work together on intermediate challenges using the available resource material to guide
     - Advanced:
         - Perform data wizardry on the several available datasets
   __________
 - Come back together and share cool findings or crazy operations that did amazing or possibly unexpected things (15 minutes)

## Available resources:
- [Pandas Cheatsheet](http://www.webpages.uidaho.edu/~stevel/504/Pandas%20DataFrame%20Notes.pdf) by Mark Graph
    - (I have found a few deprecated commands in this and one or two that have changed format as well)


- [Pandas Cookbook](https://github.com/jvns/pandas-cookbook) by Julia Evans
    - (Most description, "easiest" to follow, covers the least content)


- [SciPy 2015 and 2016 Pandas tutorial](https://github.com/jonathanrocher/pandas_tutorial) by Johnathan Rocher
    - (Bit more hit the ground running, moves faster, covers a bit more scienctific focus)


- [PyCon 2012 "Data analysis in Python with pandas presentation"](https://www.youtube.com/watch?v=w26x-z-BdWQ) by Wes McMinney - [Notebook outcome available](https://github.com/SethPaul/Pandas_Tutorial_from_PyCon2012_by_Wes_McKinney)
    - (Covers a lot of content intermediate or advanced users could jump in the later notebooks for some more complex operations, as of writing this I haven't gotten to commenting/describing at all)

## Experience levels:
### Beginner:
  * read in data (csv)
  * create DF from dict
  * slice/subset
  * get aggregate eg. means, mins, etc
  * create new columsn with simple operations ie. df['C'] = df['A'] + df['B']
  * write data (csv)

### Intermediate:
  * groupby
  * joins
  * fill/interpolate/drop
  * column wide custom modifications eg. string parsing, df.apply()
  * custom filtering/selection methods eg. df[df['A']>0], select specific row(s)/column(s) values using .ix, .iloc, .loc
  * some indexing manipulation

### Advanced:
  * Data wizardry, doing operations that may seem like magic
    (some of these things can be done with less advanced tools would be slower/less efficient and require several intermediate steps, see df.unstack(), df.resample(), and df.query())
    * master of the indexing universe eg. df['weekday']=df.index.weekday, df.shift(), hierarcical indexing (melt and cast from R)
    * rolling windows
    * caterigorical-type specific operations

## Challenges:

### Beginner
  * read in ./datasets/stocks.csv
  * create DF from dict with columns stock name and symbol for mapping to stocks.csv
  * slice a single month, slice and plot American Airlines stock
  * get aggregate of columns, eg. max of Apple stock in the set (Can you get the date of that price?)
  * create new columns with simple operations eg. df['AAPLnorm'] = df['AAPL'] - mean Apple price
  * write out the resulting dataframe (csv) - make sure to not include the index


### Intermediate
   - using the babyname sets:
       - plot the popularity trend over time of a given name
       - plot the number of babies named 'George' over time (join births.csv and baby-names2.csv)
       - determine what are the most common names that are both boys and girls names
       - are there any surprising names that are given to both boys and girls?

 OR

   - using the boadband speed test set:
       - which county has the most overall tests?
       - identify the county with the fastest home internet download
       - what is the largest spread of test using lower quartile download and upper quartile download?
       - how do the business and home upload speeds covary?
       - you could also combine the states from national_county.txt to do state level analysis

### Advanced
   * Whatever interesting manipulations you want from the available datasets.
   * The movie_lens set may allow for the most possibility, you could try:
       - cut up genre column in the .datasets/movie_lens/movies.dat and take a look at the distribution of genres in the set or covariance between the genres
       - convert the ratings.dat to a user-movie matrix, this would be used in collaborative filtering for a recommender engine
       - identify the highest average rating across genres or all movies
       - identify the movie with the most ratings

## Datasets:
- stock_data.csv - stocks for AA,AAPL,GE,IBM,JNJ,MSFT,PEP,SPX,XOM for 2007-10-29 to 2011-10-14
- baby-names2.csv and births.csv - set for analysis of name popularity from 1880 to 2008
- broadband_speedtest.csv and national_county.txt - goverment supplied data set for broadband service across the country and state, fips, county table
- movie_lens sets - movies with genres, ratings, and tags
