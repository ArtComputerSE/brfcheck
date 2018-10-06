#!/usr/bin/env bash

ELM_DEBUGGER=true PUBLIC_URL=/brfcheck elm-app build
(cd build ; zip -r deploy.zip *)
