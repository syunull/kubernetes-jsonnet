local kube = import '../vendor/github.com/jsonnet-libs/k8s-libsonnet/1.24/main.libsonnet';
local container = kube.core.v1.container;
local envVar = kube.core.v1.envVar;

local datadagAgentEnvVar = envVar.withName('DD_AGENT_HOST')
                           + envVar.valueFrom.fieldRef.withFieldPath('status.hostIP');

local containerDefaults = container.resources.withLimits({ memory: '512Mi', cpu: '1000m' })
                          + container.resources.withRequests({ memory: '512Mi', cpu: '1000m' })
                          + container.withEnvFrom([datadagAgentEnvVar])
                          + container.securityContext.withRunAsNonRoot(true);

{ defaults: containerDefaults }
