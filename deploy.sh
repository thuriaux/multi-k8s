docker build -t thuriaux/multi-client:latest -t thuriaux/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t thuriaux/multi-server:latest -t thuriaux/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t thuriaux/multi-worker:latest -t thuriaux/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push thuriaux/multi-client:latest
docker push thuriaux/multi-server:latest
docker push thuriaux/multi-worker:latest

docker push thuriaux/multi-client:$SHA
docker push thuriaux/multi-server:$SHA
docker push thuriaux/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment server=thuriaux/multi-client:$SHA
kubectl set image deployments/server-deployment server=thuriaux/multi-server:$SHA
kubectl set image deployments/worker-deployment server=thuriaux/multi-worker:$SHA
