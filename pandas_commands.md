# Commands:
import pandas as pd

## Input
df = pd.read_csv('../data/filename.csv')
with options:
df = pd.read_csv('../data/filename.csv', sep=';', encoding='latin1', parse_dates=['Date'], dayfirst=True, index_col='Date', na_values=['NO CLUE', 'N/A', '0'])
pd.read_html()
pd.read_table()

import sqlite3
con = sqlite3.connect("existing_database.db")
con.execute("DROP TABLE IF EXISTS newtable")
df = pd.read_sql("SELECT * FROM newtable LIMIT 3", con)

df = pd.read_sql("SELECT * FROM newtable LIMIT 3", con, index_col='id')
df.to_sql("newertable", con)

To connect to a MySQL database:
Note: For these to work, you will need a working MySQL / PostgreSQL database, with the correct localhost, database name, etc.
import MySQLdb con = MySQLdb.connect(host="localhost", db="test")
To connect to a PostgreSQL database:
import psycopg2 con = psycopg2.connect(host="localhost")

## Inspection
df.head()
df.tail()
df.index
df.values
df.columns
df.sort_values(by=['this_columns'], ascending=False)

## Selecting/Filtering
df[df.column_name=='specific_name']
df.column_name
df['column_name']
df[['A', 'B']]
df[:5]
df[::5] # every fifth
df.loc[1:5, 'A'] #by label
df.iloc[1:5, 1:3] #by number
df.ix[1:4, 'A'] # by mix

## Removing/Adding/Filling
df.drop('subset_name', axis=1) # columns or rows
df.dropna()
df.dropna(how="any").tail()
df.dropna(how="all").tail()
df.fillna(method="ffill").tail()
df.this_column.interpolate().tail()
df.isnull()
df.notnull()
df.append()

## Little bit of plotting
df.plot()
df.boxplot()
df.hist()

## Summary stats
df.sum()
df.sum(axis=1)
df.sum(axis=0)
.mean(), .size, .count(), .sum(), .prod(), .min(), .max(), .mean(), median(), df['A'].cov(df['B'])
df.idxmin()
df.idxmax()
df.describe()
df.value_counts()
df.corr(), plt.imshow(mean_sea_level.corr(), interpolation="nearest")
df.round()
pd.crosstab(index=df['a'], cols = df['b'])
df.quantile()
df.rank()

## Manipulation
series.astype()
series.astype('category')
series.to_datetime()
df.index = df.index.to_period()
df.apply(lambda x: x+1)
df.fillna()
df.drop_duplicates(cols='index', take_last=True)
df.pop('A')
df.reshape()

## Joining/Aggregating
df.groupby(), row or column
df.groups
grouped_df.aggregate()
df.merge(other_df, how='inner')

## Output
df.to_csv()
pd.ExcelWriter("test.xls")
df.to_excel(writer, sheet_name="GISS temp data")
writer.close()


with pd.HDFStore("all_data.h5") as writer:
    df.to_hdf(writer, "./new_hdf")
    thisDF.to_hdf(writer, "./this_hdf")
    thatDF.to_hdf(writer, "./that_hdf")
    otherDF.to_hdf(writer, "./the_other_hdf")

with pd.HDFStore("all_data.h5") as store:
    df = store["./new_hdf"]
    thisDF = store["./this_hdf"]
    thatDF = store["./that_hdf"]
    otherDF = store["./the_other_hdf"]

## More advanced selection and manipulation

pd.cut(continuos_vals_column, 3, labels=["L", "M", "H"])
df.isin()
df.copy()
df.where() or mask df[df.name=='this_name' & df.age==4]
is_berry = df.object.str.contains('berry')
series.str.startswith()
series.str.endswith()
series.str.replace('old', 'new')
df['short_zip'] = df['long_zip'].str.slice(0, 5)
is_close = zips.str.startswith('0') | zips.str.startswith('1')
requests['City'].str.upper().value_counts()
for (column, series) in df.iteritems():
  # do something
for (index, row) in df.iterrows():
  # do something

expr = '0.0 <= a <= c <= 0.5'
map(lambda frame: frame.query(expr), [df, df2])
df.query('a in b')
df.query('b == ["a", "b", "c"]')

df.set_index('some_index')
df.reset_index()
df.stack()
df.unstack()
df.transpose(), df.T
pd.pivot_table()?
df.align()?
df.sort_index()

## Time series

pd.date_range('1/1/1880', periods=4)
pd.date_range('1/1/1880', '1/1/2016', freq="A")
timeSeriesDF.resample("M").mean()
timeSeriesDF.resample("10A").mean()
timeSeriesDF.index.shift()
timeSeriesDF.diff(periods=1)
timeSeriesDF.pct_change(periods=3)

timeSeriesDFindex.day
timeSeriesDFindex.hour

timeSeriesDFindex.weekday

timeSeriesDF.rolling(window=10, center=False)
rolled_timeSeriesDF.mean()

## Categorical

c=pd.Categorical.from_array(df['A'])
c.levels
c.labels
