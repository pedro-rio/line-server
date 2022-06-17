#!/bin/bash

ruby_version_needed=`cat .ruby-version`
source ~/.rvm/scripts/rvm ;
rvm use $ruby_version_needed;

export FILENAME=$1

bin/rails server