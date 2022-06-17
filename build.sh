#!/bin/bash

command_exists () {
  command "rvm" &> /dev/null ;
}

install_ruby () {
  source ~/.rvm/scripts/rvm ;
  rvm install $1 ;
  rvm use $1;
}

install_dependencies () {
  gem install bundler;
  bundle install;
}

run_tests () {
  export FILENAME='test/controllers/test_file.txt'
  bin/rails test;
}

ruby_version_needed=`cat .ruby-version`

if command_exists
then
  if rvm list | grep $ruby_version_needed;
  then
    source ~/.rvm/scripts/rvm ;
    rvm use $ruby_version_needed;
    install_dependencies
    run_tests
  else
    install_ruby $ruby_version_needed
    install_dependencies
    run_tests
  fi
else
  echo 'Installing RVM.......'
  gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB;
  \curl -sSL https://get.rvm.io | bash -s -- --auto-dotfiles;
  install_ruby $ruby_version_needed
  install_dependencies
  run_tests
fi
