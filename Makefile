CHART_REPO := http://172.21.13.12:8080
DIR := "env"
NAMESPACE := "edas-shenzhen"
OS := $(shell uname)

build: clean
    rm -rf requirements.lock
    helm version
    helm init
    helm repo add releases ${CHART_REPO}
    helm repo add jenkins-x http://chartmuseum.jenkins-x.io
    helm dependency build ${DIR}
    helm lint ${DIR}

install: 
    helm upgrade ${NAMESPACE} ${DIR} --install --namespace ${NAMESPACE} --debug

delete:
    helm delete --purge ${NAMESPACE}  --namespace ${NAMESPACE}

clean:


