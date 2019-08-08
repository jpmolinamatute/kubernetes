#!/usr/bin/env bash

# https://medium.com/@chengzhizhao/explore-airflow-kubernetesexecutor-on-aws-and-kops-1c4dd33e56e0
# https://towardsdatascience.com/kubernetesexecutor-for-airflow-e2155e0f909c

fernet="$(python -c 'from cryptography.fernet import Fernet; FERNET_KEY = Fernet.generate_key().decode(); print(FERNET_KEY)')"


cat <<EOF >/opt/airflow/airflow.cfg
[core]
dags_folder = /opt/airflow/dags
base_log_folder = /opt/airflow/logs
load_examples = False
executor = KubernetesExecutor
fernet_key = ${fernet}
sql_alchemy_conn = postgresql://${AirflowDbUser}:${AirflowDbPass}@${AirflowDbHost}:8432/${AirflowDbName}

[cli]
endpoint_url = http://${Environment}-airflow-webserver.ai-rein.com:8080

[scheduler]
statsd_host = ${MasterNode.PrivateIp}
[kubernetes]
# The repository, tag and imagePullPolicy of the Kubernetes Image for the Worker to Run
worker_container_repository =
worker_container_tag =
worker_container_image_pull_policy = IfNotPresent

# If True (default), worker pods will be deleted upon termination
delete_worker_pods = True

# Number of Kubernetes Worker Pod creation calls per scheduler loop
worker_pods_creation_batch_size = 1

# The Kubernetes namespace where airflow workers should be created. Defaults to `default`
namespace = default

# The name of the Kubernetes ConfigMap Containing the Airflow Configuration (this file)
airflow_configmap =

# For docker image already contains DAGs, this is set to `True`, and the worker will search for dags in dags_folder,
# otherwise use git sync or dags volume claim to mount DAGs
dags_in_image = False

# For either git sync or volume mounted DAGs, the worker will look in this subpath for DAGs
dags_volume_subpath =

# For DAGs mounted via a volume claim (mutually exclusive with git-sync and host path)
dags_volume_claim =

# For volume mounted logs, the worker will look in this subpath for logs
logs_volume_subpath =

# A shared volume claim for the logs
logs_volume_claim =

# For DAGs mounted via a hostPath volume (mutually exclusive with volume claim and git-sync)
# Useful in local environment, discouraged in production
dags_volume_host =

# A hostPath volume for the logs
# Useful in local environment, discouraged in production
logs_volume_host =

# A list of configMapsRefs to envFrom. If more than one configMap is
# specified, provide a comma separated list: configmap_a,configmap_b
env_from_configmap_ref =

# A list of secretRefs to envFrom. If more than one secret is
# specified, provide a comma separated list: secret_a,secret_b
env_from_secret_ref =

# Git credentials and repository for DAGs mounted via Git (mutually exclusive with volume claim)
git_repo =
git_branch =
git_subpath =
# Use git_user and git_password for user authentication or git_ssh_key_secret_name and git_ssh_key_secret_key
# for SSH authentication
git_user =
git_password =
git_sync_root = /git
git_sync_dest = repo
# Mount point of the volume if git-sync is being used.
# i.e. {AIRFLOW_HOME}/dags
git_dags_folder_mount_point =

# To get Git-sync SSH authentication set up follow this format
#
# airflow-secrets.yaml:
# ---
# apiVersion: v1
# kind: Secret
# metadata:
#   name: airflow-secrets
# data:
#   # key needs to be gitSshKey
#   gitSshKey: <base64_encoded_data>
# ---
# airflow-configmap.yaml:
# apiVersion: v1
# kind: ConfigMap
# metadata:
#   name: airflow-configmap
# data:
#   known_hosts: |
#       github.com ssh-rsa <...>
#   airflow.cfg: |
#       ...
#
# git_ssh_key_secret_name = airflow-secrets
# git_ssh_known_hosts_configmap_name = airflow-configmap
git_ssh_key_secret_name =
git_ssh_known_hosts_configmap_name =

# For cloning DAGs from git repositories into volumes: https://github.com/kubernetes/git-sync
git_sync_container_repository = k8s.gcr.io/git-sync
git_sync_container_tag = v3.1.1
git_sync_init_container_name = git-sync-clone
git_sync_run_as_user = 65533

# The name of the Kubernetes service account to be associated with airflow workers, if any.
# Service accounts are required for workers that require access to secrets or cluster resources.
# See the Kubernetes RBAC documentation for more:
#   https://kubernetes.io/docs/admin/authorization/rbac/
worker_service_account_name =

# Any image pull secrets to be given to worker pods, If more than one secret is
# required, provide a comma separated list: secret_a,secret_b
image_pull_secrets =

# GCP Service Account Keys to be provided to tasks run on Kubernetes Executors
# Should be supplied in the format: key-name-1:key-path-1,key-name-2:key-path-2
gcp_service_account_keys =

# Use the service account kubernetes gives to pods to connect to kubernetes cluster.
# It's intended for clients that expect to be running inside a pod running on kubernetes.
# It will raise an exception if called from a process not running in a kubernetes environment.
in_cluster = True

# When running with in_cluster=False change the default cluster_context or config_file
# options to Kubernetes client. Leave blank these to use default behaviour like `kubectl` has.
# cluster_context =
# config_file =


# Affinity configuration as a single line formatted JSON object.
# See the affinity model for top-level key names (e.g. `nodeAffinity`, etc.):
#   https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.12/#affinity-v1-core
affinity =

# A list of toleration objects as a single line formatted JSON array
# See:
#   https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.12/#toleration-v1-core
tolerations =

# **kwargs parameters to pass while calling a kubernetes client core_v1_api methods from Kubernetes Executor
# provided as a single line formatted JSON dictionary string.
# List of supported params in **kwargs are similar for all core_v1_apis, hence a single config variable for all apis
# See:
#   https://raw.githubusercontent.com/kubernetes-client/python/master/kubernetes/client/apis/core_v1_api.py
kube_client_request_args =

# Worker pods security context options
# See:
#   https://kubernetes.io/docs/tasks/configure-pod-container/security-context/

# Specifies the uid to run the first process of the worker pods containers as
run_as_user =

# Specifies a gid to associate with all containers in the worker pods
# if using a git_ssh_key_secret_name use an fs_group
# that allows for the key to be read, e.g. 65533
fs_group =

[kubernetes_node_selectors]
# The Key-value pairs to be given to worker pods.
# The worker pods will be scheduled to the nodes of the specified key-value pairs.
# Should be supplied in the format: key = value

[kubernetes_annotations]
# The Key-value annotations pairs to be given to worker pods.
# Should be supplied in the format: key = value

[kubernetes_environment_variables]
# The scheduler sets the following environment variables into your workers. You may define as
# many environment variables as needed and the kubernetes launcher will set them in the launched workers.
# Environment variables in this section are defined as follows
#     <environment_variable_key> = <environment_variable_value>
#
# For example if you wanted to set an environment variable with value `prod` and key
# `ENVIRONMENT` you would follow the following format:
#     ENVIRONMENT = prod
#
# Additionally you may override worker airflow settings with the AIRFLOW__<SECTION>__<KEY>
# formatting as supported by airflow normally.

[kubernetes_secrets]
# The scheduler mounts the following secrets into your workers as they are launched by the
# scheduler. You may define as many secrets as needed and the kubernetes launcher will parse the
# defined secrets and mount them as secret environment variables in the launched workers.
# Secrets in this section are defined as follows
#     <environment_variable_mount> = <kubernetes_secret_object>=<kubernetes_secret_key>
#
# For example if you wanted to mount a kubernetes secret key named `postgres_password` from the
# kubernetes secret object `airflow-secret` as the environment variable `POSTGRES_PASSWORD` into
# your workers you would follow the following format:
#     POSTGRES_PASSWORD = airflow-secret=postgres_credentials
#
# Additionally you may override worker airflow settings with the AIRFLOW__<SECTION>__<KEY>
# formatting as supported by airflow normally.

[kubernetes_labels]
# The Key-value pairs to be given to worker pods.
# The worker pods will be given these static labels, as well as some additional dynamic labels
# to identify the task.
# Should be supplied in the format: key = value

EOF
