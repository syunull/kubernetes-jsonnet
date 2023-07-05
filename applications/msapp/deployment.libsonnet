local deploymentDefaults = import '../../lib/deployment.libsonnet';
local kube = import '../../vendor/github.com/jsonnet-libs/k8s-libsonnet/1.24/main.libsonnet';
local config = import './config.libsonnet';

local deployment = kube.apps.v1.deployment;

local defaultDeployment = deployment.metadata.withName(config.name)
                          + deployment.spec.withReplicas(10)
                          + deployment.spec.selector.withMatchLabels(config.labels)
                          + deployment.spec.template.metadata.withLabels(config.labels)
                          + deployment.spec.template.spec.withServiceAccountName(config.name);

{
  mkDeployment:: function(container) {
    deployment: deploymentDefaults.mkDefaults(config.labels)
                + defaultDeployment
                + deployment.spec.template.spec.withContainers([container]),
  }.deployment,
}
