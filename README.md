# Application of Named Entity Recognition techniques to historical documents for the extraction of geographical data.
## Alex McCall 2021 - MSc Dissertation - Napier University.

This work demonstates the use of a CRF machine learning algorithm on real world Data provided by the National Records of Scotland.  
The code is predominently in R, but the learning aspect has been coded in Python using the CRFSuite of SKlearn.

Napier4 contains the required functions.  'Run all code' chunks before running the code in Napier5.

Napier5 contains the control code.  Recommended to run one chunk at a time.

## Environment requirements:

### RStudio
Conda Python (expected virtual environment is called 'NER'

### R Libraries
tidyr
xml2
dplyr
googleAuthR
ggmap
stringr
spacyr
editData
reticulate

### Python Libraries
import pickle
import os.path
from nltk.tag import pos_tag
from sklearn.metrics import make_scorer,confusion_matrix
from pprint import pprint
from sklearn.metrics import f1_score,classification_report
from sklearn.pipeline import Pipeline
from sklearn_crfsuite import CRF, metrics
import string
import nltk
import numpy as np
from sklearn.model_selection import KFold

### Data directory
PATH:  ..Data/

### Minimum Data directory contents:

  Geoparser (directory containing XML source data)
  townpattern.txt (file containing common town name parts such as 'bourgh', 'field' etc)
  new_geographies.rds.csv (user editable file containing proposed geopgraphical entities)
  google.db (cache file containing all found location names)


