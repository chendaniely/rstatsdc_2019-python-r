import pandas as pd
import re
import seaborn as sns

import janitor
from pyprojroot import here

raw = pd.read_csv(here('./data/billboard.csv'), encoding = "ISO-8859-1")

# clean

df = (
    raw
    .select_columns(['year', 'artist.inverted', 'track', 'time', 'date.entered', 'x*.week'])
    .rename_columns({"artist.inverted": "artist"})
)

# tidy

df = (
    df
    .melt(id_vars = ['year', 'artist', 'track', 'time', 'date.entered'],
          var_name = "week",
          value_name = "rank")
    .transform_column('week',
                      lambda x: int(re.findall(r'\d+', x)[0]))
)

mean_rank_by_week = df.groupby("week")["rank"].mean()

df.groupby("week")["rank"].mean().plot()

# https://github.com/apache/arrow
