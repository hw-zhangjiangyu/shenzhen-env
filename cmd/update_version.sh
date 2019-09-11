#!/bin/bash

chartName=$1
releaseVersion=$2

if [ -z $chartName ];
then
  echo "chart name is required!"
  exit 1
fi

if [ -z $releaseVersion ];
then
  echo "release version is required"
  exit 1
fi


nameAndVersion=`grep ${chartName} ../env/requirements.yaml`
if [ $? != 0 ];
then
  echo "$chartName is not found in current env"
  exit $?
fi

# sed "$linenumberc"
lineNumber=`grep -n ${chartName} ../env/requirements.yaml |awk -F: '{print $1}'`
if [ -z $lineNumber ]
then
  echo "$chartName is not found in current env"
  exit $?
fi

versionLineNumber=$((${lineNumber} + 2))
sed -i "${versionLineNumber}c version: ${releaseVersion}" ../env/requirements.yaml
if [ $? != 0 ];
then
  echo "Replace release version failed"
  exit $?
fi