



#Generazione di file yaml per pod senza creazione (dry run)
kubectl run --generator=run-pod/v1 --dry-run -o yaml
#Identico per replication controller
kubectl run --generator=run/v1 --dry-run -o yaml

#Deployment
kubectl run run/v1 --dry-run -o yaml

#TAINT
kubectl taint node node01 spray=mortein:NoSchedule


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
