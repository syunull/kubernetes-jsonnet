local containerDefaults = import '../../lib/container.libsonnet';
local kube = import '../../vendor/github.com/jsonnet-libs/k8s-libsonnet/1.24/main.libsonnet';
local config = import './config.libsonnet';

local container = kube.core.v1.container;
local containerPort = kube.core.v1.containerPort;

local msappPort = containerPort.new(config.port.port)
                  + containerPort.withName(config.port.name);

local msappContainer = containerDefaults.defaults
                       + container.new(config.name, config.image + ':' + config.version)
                       + container.livenessProbe.httpGet.withPath('/')
                       + container.livenessProbe.withInitialDelaySeconds(10)
                       + container.resources.withLimits({ memory: '512Mi', cpu: '2000m' })
                       + container.withEnv(config.env)
                       + container.withPorts(msappPort);

{
  defaults: msappContainer,
}
