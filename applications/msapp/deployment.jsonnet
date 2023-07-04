local containerDefaults = import '../../lib/container.libsonnet';
local deploymentDefaults = import '../../lib/deployment.libsonnet';
local kube = import '../../vendor/github.com/jsonnet-libs/k8s-libsonnet/1.24/main.libsonnet';
local config = import './config.libsonnet';

local container = kube.core.v1.container;
local containerPort = kube.core.v1.containerPort;
local deployment = kube.apps.v1.deployment;

local msappPort = containerPort.new(config.port.port)
                  + containerPort.withName(config.port.name);

local msappContainer = container.new(config.name, config.image + ':' + config.version)
                       + container.withPorts(msappPort)
                       + container.withEnv(config.env)
                       + containerDefaults.defaults;


local deploy = deployment.metadata.withName(config.name)
               + deployment.spec.withReplicas(3)
               + deployment.spec.selector.withMatchLabels(config.labels)
               + deployment.spec.template.metadata.withLabels(config.labels)
               + deployment.spec.template.spec.withContainers([msappContainer])
               + deployment.spec.template.spec.withServiceAccountName(config.name);


deploy + deploymentDefaults.mkDefaults(config.labels)
