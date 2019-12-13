



#Generazione di file yaml per pod senza creazione (dry run)
kubectl run --generator=run-pod/v1 --dry-run -o yaml
#Identico per replication controller
kubectl run --generator=run/v1 --dry-run -o yaml

#Deployment
kubectl run run/v1 --dry-run -o yaml

#TAINT
kubectl taint node node01 spray=mortein:NoSchedule

#
kubectl get deploy deploymentname -o yaml --export


#Toleration
VIA YAML

specs:
  tolerations:
    - key: ""
      operator: ""
      value: ""
      effect: ""


##
#  Node Selector
##

kubectl label nodes node01 size=Large

specs:
  nodeSelector:
    size: Large


# NODE AFFINITY on the POD DEFINITION

spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: kubernetes.io/e2e-az-name
            operator: In
            values:
            - e2e-az1
            - e2e-az2
      preferredDuringSch


#CONTEXT
kubectl config current-context
kubernetes-admin@kubernetes
master $ kubectl config set-context kubernetes-admin@kubernetes --namespace=kube-system

#AVANCED SCHEDULER

#ON pod scheduler yaml
--scheduler-name=custom-scheduler
--lock-object-name=custom-scheduler

#To use custom scheduler on pod yaml
...
spec:
  containers:
  ...
  schedulerName: custom-scheduler
...

#LOGGIN
clone git repo




kubectl set image deployment/frontend www=image:v2
kubectl scale --replicas=3 rs/foo      
