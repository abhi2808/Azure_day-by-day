# Monitoring

- L1: monitor network traffic/components -> network watcher service
- L2: monitor node polls/vm scale sets -> managed prometheus service(monitor parameters)
- L3: monitor control plane components, eg api server or etcd is failing -> azure monitor(using containers section)
- L4: data plane components, pods/containers -> prometheus
- L5: application performance monitoring(APM) -> application insights in azure monitor
- L6: other azure components, eg storage etc -> azure monitor


can use a single monitoring service, but better to use specialized services.


## azure monitor

integrate swith various services to collect required metrics, logs and traces. Once collected it cas pass these to others components to help with your specific problem like insights(app insights, catalog etc), visualize(garfana, power Bi etc), analyze(metric exporter, log analytics etc) and respond(AIOps, alert and action etc).


# Azure Key Vault

secret management for sensitive info, centralized solution. Help for compliance practices like rotating passwords, throughout azure instead of doing the same for each service.

The services access teh secret using managed identities

for any kubernetes pods to fetch the secrets or communiacte with any external managers/solution you need to install a 'secret store CSI driver' along with the Azure Key Vault provider to fetch secrets from Key Vault or other external secret managers.

Access is restricted so that only pods whose Kubernetes service accounts are bound to the corresponding managed identity can retrieve the secrets.