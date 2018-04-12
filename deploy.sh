#!/usr/bin/env bash

PUBLIC_URL=/brfcheck elm-app build
(cd build ; zip -r deploy.zip *)
