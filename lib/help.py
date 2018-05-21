#!/usr/bin/env python3
#-*- coding: utf-8 -*-
 
# File Name: help.py
# Author: Feng
# Created Time: 2018/5/20 22:10:03
# Content: 

import os
import sys
import time
import subprocess

if sys.version_info[0] < 3:
    pass
else:
    xrange = range
    unicode = str

###################
## Win32
###################

class Win32(object):
    def __init__(self):
        self.unix = sys.platform[:3] != 'win'
        self._kernel32 = None
        self._user32 = None
        self._initialize()

    def _initialize(self):
        if self.unix:
            return -1
        import ctypes
        import ctypes.wintypes
        self._kernel32 = ctypes

