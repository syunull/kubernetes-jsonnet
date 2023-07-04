local kube = import '../vendor/github.com/jsonnet-libs/k8s-libsonnet/1.24/main.libsonnet';
local deployment = kube.apps.v1.deployment;
local container = kube.core.v1.container;
local containerPort = kube.core.v1.containerPort;


local containerDefaults = import '../lib/container.libsonnet';
local deploymentDefaults = import '../lib/deployment.libsonnet';

local msappPort = containerPort.new('8080')
                  + containerPort.withName('http');


local msappContainer = container.new('msapp', 'msapp:latest')
                       + container.withPorts(msappPort)
                       + containerDefaults.defaults;

local labels = {
  'app.kubernetes.io/name': 'msapp',
};

deployment.new('msapp', 3, [msappContainer], labels)
+ deployment.spec.template.spec.withServiceAccountName('msapp')
+ deploymentDefaults.mkDefaults(labels)
