#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Nov 29 20:03:49 2017

@author: ziqizang
"""

from __future__ import print_function

import pickle
import sys
import numpy as np
from glob import iglob



def read(data_dir):
    count = 0
    output_filename = 'reuters.csv'
    sep = ','
    with open(output_filename, 'w') as w:
        for filename in iglob(data_dir + '/*.pkl'):
            with open(filename, 'rb') as f:
                data = pickle.load(f)
                for datum in data:

                    ts = datum['ts']
                    if ts is None:
                        ts = ''

                    line = str(count)
                    line += sep
                    line += '"' + ts + '"'
                    line += sep
                    line += '"' + datum['title'] + '"'
                    line += sep
                    line += '"' + datum['href'] + '"'
                    line += '\n'

                    w.write(line)
                    print(count)
                    count += 1

def main():
    data_dir = 'test_out'
    read(data_dir)
    return

if __name__ == '__main__':
    #sys.argv[0] = 'dump_to_csv.py'
#     sys.argv[1] = '/output'
#     assert len(sys.argv) == 2, 'Usage: python dump_to_csv.py reuters_pickle_output_dir'.format(sys.argv[0])
#     sys.argv[1] = 'output'
#     read(sys.argv[1])
     main()

    
