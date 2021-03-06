#!/usr/bin/env sh
set -e

echo "##### IMPORTANT"
echo "Before using it, make sure the variables are according to your system"
echo "It is set to darwin"

##### Constants

RIGHT_NOW=$(date +"%x %r %Z")
TIME_STAMP="Updated on $RIGHT_NOW by $USER"
VERSION="v1.1.1"
OperationalSystem="darwin"
TARFILE="dgraph-${OperationalSystem}-amd64.tar.gz"
DOWNLOAD_URL="https://github.com/dgraph-io/dgraph/releases/download/$VERSION/$TARFILE"
CheckDgraph=$(ls -f ./dgraph/dgraph | wc -l)

baixarDgraph() {
  echo "$DOWNLOAD_URL"
  wget "$DOWNLOAD_URL" -O ./dgraph/$TARFILE -q
}

unzipTar() {
  echo "./dgraph/$TARFILE "
 tar -xzvf ./dgraph/$TARFILE -C ./dgraph/
}

exportJSON() {
curl http://localhost:8080/admin/export?format=json
}

if [ "$1" = "-export" ] || [ "$1" = "--ex" ]
  then
    echo "Exporting.."
    exportJSON
    touch ./dgraph/new.lock
    echo "Done! exiting..."
    exit 0
  fi

if [ ! -d ./dgraph ] ; then
    mkdir ./dgraph
  fi

if [ ! -f './dgraph/new.lock' ] ; then
    echo "There are no Dgraph's binaries in this Path."
    rm -rf ./dgraph/*
    echo "Downloading..."
    baixarDgraph
    echo "Installing..."
    touch ./dgraph/new.lock
    unzipTar
  fi

# ================================================================ #
# =================== Apenas Funções Locally ===================== #
# ================================================================ #

dgraphZero(){
  echo "Starting Dgraph zero"
  cd dgraph
  ./dgraph zero -w=./wz
}
dgraphAlpha(){
  echo "Starting Dgraph Alpha"
  cd dgraph
  ./dgraph alpha -l 8000 -o=1
}

Dgraph6Alphas(){
  echo "Starting Dgraph Alpha"
  cd dgraph
  ./dgraph alpha -l 8000 -o=1
}

startLocally(){
   echo "Running Cluster"
  # test1 & test2
   (trap 'kill 0' SIGINT; dgraphZero & dgraphAlpha)
}

if [ "$1" = "-ma" ] || [ "$1" = "--multiple" ]
  then
    echo "Starting multiple Alphas.."
    cd dgraph
    ./dgraph zero --cwd=./ --my=localhost:5080 --replicas 3 -w=zw0 --idx 1 & \
    ./dgraph zero --cwd=./ --my=localhost:5081 --replicas 3 --peer=localhost:5080 -w=zw1 -o=1 --idx 2 & \
    ./dgraph zero --cwd=./ --my=localhost:5082 --replicas 3 --peer=localhost:5080 -w=zw2 -o=2 --idx 3 & \
    ./dgraph zero --cwd=./ --my=localhost:5083 --replicas 3 --peer=localhost:5080 -w=zw3 -o=3 --idx 4 & \
    ./dgraph alpha --cwd=./ --lru_mb 8000 --my=localhost:7080 -o=0 -w=wall0 -p=post0 & \
    ./dgraph alpha --cwd=./ --lru_mb 8000 --my=localhost:7081 -o=1 -w=wall1 -p=post1 & \
    ./dgraph alpha --cwd=./ --lru_mb 8000 --my=localhost:7082 -o=2 -w=wall2 -p=post2 & \
    ./dgraph alpha --cwd=./ --lru_mb 8000 --my=localhost:7083 -o=3 -w=wall3 -p=post3 & \
    ./dgraph alpha --cwd=./ --lru_mb 8000 --my=localhost:7084 -o=4 -w=wall4 -p=post4 & \
    ./dgraph alpha --cwd=./ --lru_mb 8000 --my=localhost:7085 -o=5 -w=wall5 -p=post5 --mutations=disallow & \
    ./dgraph alpha --cwd=./ --lru_mb 8000 --my=localhost:7086 -o=6 -w=wall6 -p=post6 --mutations=disallow & \
    ./dgraph alpha --cwd=./ --lru_mb 8000 --my=localhost:7087 -o=7 -w=wall7 -p=post7 --mutations=disallow & \
    ./dgraph alpha --cwd=./ --lru_mb 8000 --my=localhost:7088 -o=8 -w=wall8 -p=post8 --mutations=disallow
    echo "Done! exiting..."
    exit 0
  fi

if [ "$1" = "-maj" ] || [ "$1" = "--multiplej" ]
  then
    echo "Starting multiple Alphas.."
    cd dgraph
    ./dgraph zero --cwd=./ --my=localhost:5080 --jaeger.collector=http://localhost:14268 & \
    ./dgraph zero --cwd=./ --my=localhost:5082 --peer=localhost:5080 -w=zw2 -o=2 --jaeger.collector=http://localhost:14268 & \
    ./dgraph zero --cwd=./ --my=localhost:5083 --peer=localhost:5080 -w=zw3 -o=3 --jaeger.collector=http://localhost:14268 & \
    ./dgraph zero --cwd=./ --my=localhost:5084 --peer=localhost:5080 -w=zw4 -o=4 --jaeger.collector=http://localhost:14268 & \
    ./dgraph zero --cwd=./ --my=localhost:5085 --peer=localhost:5080 -w=zw5 -o=5 --jaeger.collector=http://localhost:14268 & \
    ./dgraph zero --cwd=./ --my=localhost:5086 --peer=localhost:5080 -w=zw6 -o=6 --jaeger.collector=http://localhost:14268 & \
    ./dgraph alpha --cwd=./ --lru_mb 8000 --my=localhost:7081 -o=1 --jaeger.collector=http://localhost:14268 & \
    ./dgraph alpha --cwd=./ --lru_mb 8000 --my=localhost:7082 -o=2 -w=wall2 -p=post2 --jaeger.collector=http://localhost:14268 & \
    ./dgraph alpha --cwd=./ --lru_mb 8000 --my=localhost:7083 -o=3 -w=wall3 -p=post3 --jaeger.collector=http://localhost:14268 & \
    ./dgraph alpha --cwd=./ --lru_mb 8000 --my=localhost:7084 -o=4 -w=wall4 -p=post4 --jaeger.collector=http://localhost:14268 & \
    ./dgraph alpha --cwd=./ --lru_mb 8000 --my=localhost:7085 -o=5 -w=wall5 -p=post5 --jaeger.collector=http://localhost:14268 & \
    ./dgraph alpha --cwd=./ --lru_mb 8000 --my=localhost:7086 -o=6 -w=wall6 -p=post6 --jaeger.collector=http://localhost:14268
    echo "Done! exiting..."
    exit 0
  fi

startLocally

  echo "just exited..."
  exit 0