#!/usr/bin/env fish

function do_func
  argparse -n do_func 'h/help' 'u/user=' 'p/project=' -- $argv
  or return 1

  if test (count $argv) -eq 0
    echo "login-cloud.fish -u/--user <LOGIN_USER> -p/--project <PROJECT_ID>"
    return
  end

  if set -lq _flag_help
    echo "login-cloud.fish -u/--user <LOGIN_USER> -p/--project <PROJECT_ID>"
    return
  end

  set -lq _flag_user
  or set -l _flag_user ""
  set -lq _flag_project
  or set -l _flag_project ""

  gcloud components update --quiet
  gcloud auth login $_flag_user
  gcloud config set project $_flag_project
end

do_func $argv
