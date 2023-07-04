local containerDefaults = import '../../lib/container.libsonnet';
local deploymentDefaults = import '../../lib/deployment.libsonnet';
local kube = import '../../vendor/github.com/jsonnet-libs/k8s-libsonnet/1.24/main.libsonnet';

local container = kube.core.v1.container;
local containerPort = kube.core.v1.containerPort;
local deployment = kube.apps.v1.deployment;

local asdfappPort = containerPort.new('8080')
                    + containerPort.withName('http');

local asdfappContainer = container.new('asdfapp', 'asdfapp:latest')
                         + container.withPorts(asdfappPort)
                         + containerDefaults.defaults;

local deploy = deployment.new('asdfapp', 3, [asdfappContainer])
               + deployment.spec.template.spec.withServiceAccountName('asdfapp');

local labels = deploy.spec.selector.matchLabels;

deploy + deploymentDefaults.mkDefaults(labels)
