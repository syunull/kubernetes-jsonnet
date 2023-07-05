local kube = import '../../../../vendor/github.com/jsonnet-libs/k8s-libsonnet/1.24/main.libsonnet';
local config = import '../../config.libsonnet';
local serviceAccount = kube.core.v1.serviceAccount;

serviceAccount.new(config.name) + serviceAccount.metadata.withAnnotations(config.service_account.annotations)
