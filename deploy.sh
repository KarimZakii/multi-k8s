docker build -t karimzaki98/complex-server:latest -t karimzaki98/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t karimzaki98/multi-client:latest -t karimzaki98/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t karimzaki98/multi-worker:latest -t karimzaki98/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push karimzaki98/complex-server:latest
docker push karimzaki98/multi-client:latest
docker push karimzaki98/multi-worker:latest

docker push karimzaki98/complex-server:$SHA
docker push karimzaki98/multi-client:$SHA
docker push karimzaki98/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=karimzaki98/complex-server:$SHA
kubectl set image deployments/client-deployment client=karimzaki98/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=karimzaki98/multi-worker:$SHA

echo "All Good"
