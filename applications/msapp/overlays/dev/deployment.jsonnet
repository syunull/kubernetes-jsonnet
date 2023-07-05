local kube = import '../../../../vendor/github.com/jsonnet-libs/k8s-libsonnet/1.24/main.libsonnet';
local container = kube.core.v1.container;
local envVar = kube.core.v1.envVar;

local msappContainer = import '../../container.libsonnet';
local msappDeployment = import '../../deployment.libsonnet';

msappDeployment.mkDeployment(msappContainer.defaults)
