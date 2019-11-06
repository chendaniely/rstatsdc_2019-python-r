import pandas as pd
import re

import janitor
from pyprojroot import here

raw_py = pd.read_csv(here('./data/billboard.csv'),
                     encoding = "ISO-8859-1")

billboard_clean_py = (
    raw_py
    .select_columns(['year', 'artist.inverted', 'track', 'time',
                     'date.entered', 'x*.week'])
    .rename_columns({"artist.inverted": "artist"})
    .melt(id_vars = ['year', 'artist', 'track', 'time',
                     'date.entered'],
          var_name = "week",
          value_name = "rank")
    .transform_column('week',
                      lambda x: int(re.findall(r'\d+', x)[0]))
)
mean_rank_by_week = (billboard_clean_py
                       .groupby("week")["rank"]
                        .mean())
