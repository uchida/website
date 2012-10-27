#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import subprocess

KEYID="6bf3f057"

def unsigned_rpms():
    topdir = os.path.join(os.path.dirname(__file__), 'OSXWS')
    for root, dirs, files in os.walk(topdir):
        for f in files:
            if f.endswith('.rpm'):
                path = os.path.join(root, f)
                if not signed(path):
                    yield path
    raise StopIteration

def signed(rpm):
    key = subprocess.Popen(['rpmkeys', '-Kv', '--nodigest', rpm],
                              stdout=subprocess.PIPE)
    grep = subprocess.Popen(['grep', KEYID], stdin=key.stdout,
                            stdout=subprocess.PIPE)
    stdout, stderr = grep.communicate()
    if stdout != '':
        return True
    else:
        return False

if __name__ == '__main__':
    sign = ['rpm', '--resign']
    sign.extend([rpm for rpm in unsigned_rpms()])
    subprocess.check_call(signcmd)

