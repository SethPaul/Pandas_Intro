# Commands:

complaints = pd.read_csv('../data/311-service-requests.csv')
+ options
df = pd.read_csv('../data/bikes.csv', sep=';', encoding='latin1', parse_dates=['Date'], dayfirst=True, index_col='Date', na_values=['NO CLUE', 'N/A', '0'])
.read_html()
.read_table()

import sqlite3
con = sqlite3.connect("../data/weather_2012.sqlite")
df = pd.read_sql("SELECT * from weather_2012 LIMIT 3", con)

df = pd.read_sql("SELECT * from weather_2012 LIMIT 3", con, index_col='id')
df

weather_df = pd.read_csv('../data/weather_2012.csv')
con = sqlite3.connect("../data/test_db.sqlite")
con.execute("DROP TABLE IF EXISTS weather_2012")
weather_df.to_sql("weather_2012", con)

To connect to a MySQL database:
Note: For these to work, you will need a working MySQL / PostgreSQL database, with the correct localhost, database name, etc.
import MySQLdb con = MySQLdb.connect(host="localhost", db="test")
To connect to a PostgreSQL database:
import psycopg2 con = psycopg2.connect(host="localhost")


complaints.head
df.tail
df.index
df.values
df.columns
df.sort_values(by=['this'], ascending=False)
nonlibraries.sort('ctime', ascending=False)[:10]

df[df.name=='specific_name']
df.name
df['name'], df[['A', 'B']]
df[:5]
df[::5] # every fifth
.loc #by label
.iloc #by number
.ix # by mix

df.drop() # columns
.reshape()
df.dropna()
df.dropna(how="any").tail()
df.dropna(how="all").tail()
giss_temp.fillna(method="ffill").tail()
giss_temp.Aug.interpolate().tail()
.isnull()
.notnull()
.isfinite
.append()

.plot()
.boxplot()

.sum()
.sum(axis=1), .sum(axis=0)
.mean(), .size, .count(), .sum(), .prod(), .min(), .max(), .mean(), median(), df['A'].cov(df['B'])
.idxmin(), idxmax()
.describe()
.value_counts()
.corr(), plt.imshow(mean_sea_level.corr(), interpolation="nearest")
.round()
pd.crosstab(index=df['a'], cols = df['b'])
df.quantile()
df.rank()

.astype()
.astype('category')
.to_datetime()
full_globe_temp.index = full_globe_temp.index.to_period()
.apply()
.fillna()
.drop_duplicates(cols='index', take_last=True)
df.pop('A')


.groupby(), row or column
.groups()
grouped_df.aggregate()
.merge()

df.to_csv()
pd.ExcelWriter("test.xls")
giss_temp.to_excel(writer, sheet_name="GISS temp data")
writer.close()


with pd.HDFStore("all_data.h5") as writer:
    giss_temp.to_hdf(writer, "/temperatures/giss")
    full_globe_temp.to_hdf(writer, "/temperatures/full_globe")
    mean_sea_level.to_hdf(writer, "/sea_level/mean_sea_level")
    local_sea_level_stations.to_hdf(writer, "/sea_level/stations")

with pd.HDFStore("all_data.h5") as store:
    giss_temp = store["/temperatures/giss"]
    full_globe_temp = store["/temperatures/full_globe"]
    mean_sea_level = store["/sea_level/mean_sea_level"]
    local_sea_level_stations = store["/sea_level/stations"]

pd.cut(full_globe_temp, 3, labels=["L", "M", "H"])
.isin()
.copy()
.where() or mask df[df.name=='this_name' & df.age==4]
weather_description = weather_2012['Weather']
is_snowing = weather_description.str.contains('Snow')
.str.startswith()
.str.endswith()
.str.replace('old', 'new')
requests['Incident Zip'] = requests['Incident Zip'].str.slice(0, 5)
is_close = zips.str.startswith('0') | zips.str.startswith('1')
requests['City'].str.upper().value_counts()
for (column, series) in df.iteritems():
for (index, row) in df.iterrows():

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

pd.date_range('1/1/1880', periods=4)
pd.date_range('1/1/1880', '1/1/2016', freq="A")
full_globe_temp.resample("M").mean()
full_globe_temp.resample("10A").mean()
dt_index.shift()?
.diff(periods=1)
.pct_change(periods=3)

berri_bikes.index.day
berri_bikes.index.hour

berri_bikes.index.weekday

.rolling(window=10, center=False)
rolled_series.mean()



.lookup
.combine_first()
c=pd.Categorical.from_array(df['A'])
c.levels
c.labels
