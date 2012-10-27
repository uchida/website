#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import subprocess
import argparse

def unsigned_rpms(keyid, directory):
    for root, dirs, files in os.walk(directory):
        for f in files:
            if f.endswith('.rpm'):
                path = os.path.join(root, f)
                if not signed(path, keyid):
                    yield path
    raise StopIteration

def signed(rpm, keyid):
    key = subprocess.Popen(['rpmkeys', '-Kv', '--nodigest', rpm],
                           stdout=subprocess.PIPE)
    grep = subprocess.Popen(['grep', keyid], stdin=key.stdout,
                            stdout=subprocess.PIPE)
    stdout, stderr = grep.communicate()
    if stdout != '':
        return True
    else:
        return False

def sign(args):
    addsign = ['rpm', '--resign']
    to_be_signed = [rpm for rpm in unsigned_rpms(args.keyid, args.dir)]
    if to_be_signed != []:
        addsign.extend(to_be_signed)
        subprocess.check_call(addsign)
    return

if __name__ == '__main__':
    description = 'add sign to unsigned rpm files'
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('keyid', metavar='keyid', type=str,
                        help='key id to sign')
    parser.add_argument('-d', '--dir', default='.',
                        help='directory contains unsigned rpm files')
    args = parser.parse_args()
    sign(args)

