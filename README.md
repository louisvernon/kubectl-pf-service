# kubectl-pf-service

If you want to expose a service from Kubernetes Cluster A within Kubernetes Cluster B you probably shouldn't do it this way.

But if you insist, you could...

## Create a service account in Cluster A

`(cluster-a:default)]$) kubectl apply -f serviceaccount.yaml`

## Generate a custom kube-config
```
(cluster-a:default)]$) export KUBECONFIG=$(pwd)/kube-config
## [Connect to Cluster A]
(cluster-a:default)]$) secret=$(kubectl get sa kubectl-pf -o jsonpath={..secrets..name})
(cluster-a:default)]$) kubectl get secret ${secret} -o jsonpath={..token} > secret
(cluster-a:default)]$) USER_PROFILE=$(kubectl config current-context)
(cluster-a:default)]$) kubectl config set-credentials ${USER_PROFILE} --token $(cat secret | base64 -d)
## [Remove other auth methods from config]
(cluster-a:default)]$) unset KUBECONFIG
```

## After connecting to Cluster B
`(cluster-b:default)]$) kubectl create secret generic kubectl-pf-kube-config --from-file=kube-config`

## Customize kubectl-pf.yaml and deploy
`(cluster-b:default)]$) kubectl apply -f kubectl-pf.yaml`

You can now hit your service from within Cluster B. Don't say I didn't warn you!
