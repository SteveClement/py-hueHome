#!/usr/bin/env bash

VENV_DIR="${HOME}/code/py-hueHome/app/venv"
ROOT_DIR="${HOME}/code/py-hueHome"

source `which virtualenvwrapper.sh` 2> /dev/null
if [ "$?" != 0 ]; then
  cd ${VENV_DIR}
  source bin/activate
else
  workon py-hueHome
fi

cd ${ROOT_DIR}
${VENV_DIR}/bin/uwsgi uwsgi_application.ini
