# -*- coding: utf-8 -*-
"""
Tokenize texts
"""
# preprocessing news headlines 
# pandas for data manipulation
import pandas as pd
pd.options.mode.chained_assignment = None
# nltk for nlp
from nltk.tokenize import word_tokenize, sent_tokenize
from nltk.corpus import stopwords
# list of stopwords like articles, preposition 
stop = set(stopwords.words('english'))
from string import punctuation
from collections import Counter
import re
import numpy as np

import scipy as sp
import sklearn
import sys
from nltk.corpus import stopwords
import nltk
from gensim.models import ldamodel
import gensim.corpora
from sklearn.feature_extraction.text import CountVectorizer, TfidfTransformer
from sklearn.decomposition import NMF
from sklearn.preprocessing import normalize
import pickle


def main():
    file_name = 'reuters1.csv'


def readdata(file_name):
    df = pd.read_csv(file_name, error_bad_lines=False,  names = ["Time", "Headlines", "Link"])
    return df

def remove_list():
    remove_list = ["UPDATE","BRIEF","TABLE", "DIARY"]
    return remove_list 

def remove_headers():
    for ind in range(len(data_text)):
    data_text.iloc[ind]['Headlines'] = [word for word in data_text.iloc[ind]['Headlines'].split(' ') if word not in remove_list]
    
    if idx % 1000 == 0:
        sys.stdout.write('\rc = ' + str(idx) + ' / ' + str(len(data_text)));
    return

def remove_stopwords():
    
    for idx in range(len(data_text)):
    
    #go through each word in each data_text row, remove stopwords, and set them on the index.
    data_text.iloc[idx]['Headlines'] = [word for word in data_text.iloc[idx]['Headlines'].split(' ') if word not in stopwords.words()];
    
    #print logs to monitor output
    if idx % 1000 == 0:
        sys.stdout.write('\rc = ' + str(idx) + ' / ' + str(len(data_text)));
    return 

def sample_headlines():
    data_text = df[['Headlines']]
    np.random.seed(1024)
    data_text = data_text.iloc[np.random.choice(len(data_text),10000)]
    
    
def remove_words():
    remove_list ='^BRIEF\W\w*|^UPDATE\s\d\W\w*|^PRESS\sDIGEST\W|^TABLE\W'









































