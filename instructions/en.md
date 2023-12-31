# A hands-on introduction to Sysdig

###### CE070

## Introduction<!--## makes table of contents-->
Duration: 90 minutes  
Oriented to DevOps Engineers, SREs, Platform Engineers, Security Architects.

### Key Challenges of Securing the cloud

<img src="img/intro/gcp-and-threats.png" alt="b3f25899efc309f8.png"  width="800" />

New cloud approaches using container technologies have introduced a new set of challenges in terms of security. Traditional solutions are inadequate for handling this environment complexity and new abstractions. 
Securing cloud-native applications and infrastructure is not easy, even for professionals.

Some interesting facts about security described on [Sysdig Global Cloud Threat Report](https://sysdig.com/press-releases/2023-cloud-threat-report/)
* **10 Minutes to pain**. Cloud attackers are quick and opportunistic, spending only 10 minutes to initiate an attack.
* **A 90% safe supply chain isn't safe enough**. 10% of advanced supply chain threats are invisible to standard tools.
* **72% of containers live less than five minutes**. Gathering information after a container is done is not effective.
* **87% of Container Images have high risk vulnerabilities**. And several new vulnerabilities are discovered every day.

Companies around the world have to deal with complexity:
* Scale. Large volumes of dynamic cloud assets, configurations and permissions.
* Microservices, distributed infrastructure, CICD pipelines. 
* Multiple teams (Devs, DevOps, Security). 

### Sysdig approach to security

<img src="img/intro/gcp-and-sysdig.png" alt="b3f25899efc309f8.png"  width="800" />

### What you'll learn
Understand Sysdig's unique security approach and its **unified Platform**.
* **Vulnerability Management**
  * Detect, manage and remediate container and hosts vulnerabilities from CICD to run.
  * Reduce noise dramatically thanks to Runtime Insights (in-use).
* **Cloud Security Posture**
  * Detect and fix misconfigurations and risks with CSPM, KSPM and CIEM features.
  * Enforce Security Posture with Runtime Insights findings.
* **Threat Detection and Response**
  * Runtime threats and Falco basics.
  * Cloud Threat Detection (Auditlog).
  * GKE runtime threat detection.

  
<img src="img/intro/sysdig-cnapp.png" alt="b3f25899efc309f8.png"  width="800" />

## Setup

### Sysdig

==TODO: Pending generation of accounts==

### Lab

**Before you click the Start Lab button**

Read these instructions. Labs are timed and you cannot pause them. The timer, which starts when you click Start Lab, shows how long Google Cloud resources will be made available to you.

This hands-on lab lets you do the lab activities yourself in a real cloud environment, not in a simulation or demo environment. It does so by giving you new, temporary credentials that you use to sign in and access Google Cloud for the duration of the lab.

To complete this lab, you need:

* Access to a standard internet browser (Chrome browser recommended).

<div><ql-infobox>

**Note:** Use an Incognito or private browser window to run this lab. This prevents any conflicts between your personal account and the Student account, which may cause extra charges incurred to your personal account.
</ql-infobox></div>

* Time to complete the lab---remember, once you start, you cannot pause a lab.

<div><ql-infobox>

**Note:** If you already have your own personal Google Cloud account or project, do not use it for this lab to avoid extra charges to your account.
</ql-infobox></div>

**How to start your lab and sign in to the Google Cloud Console**

1. Click the **Start Lab** button. If you need to pay for the lab, a pop-up opens for you to select your payment method. On the left is a panel populated with the temporary credentials that you must use for this lab.

<img src="img/fe2f4702aadf2bf0.png" alt="fe2f4702aadf2bf0.png"  width="297.00" />

2. Copy the username, and then click Open Google Console. The lab spins up resources, and then opens another tab that shows the Sign in page.

<img src="img/32f46ef7244eb68e.png" alt="32f46ef7244eb68e.png"  width="433.00" />

***Tip:*** Open the tabs in separate windows, side-by-side.

If you see the **Choose an account** page, click **Use Another Account**.

<img src="img/60ae473c3e6a3ca7.png" alt="60ae473c3e6a3ca7.png"  width="356.00" />

3. In the **Sign in** page, paste the username that you copied from the left panel. Then copy and paste the password.

**Important:** You must use the credentials from the left panel. Do not use your Google Cloud Training credentials. If you have your own Google Cloud account, do not use it for this lab (avoids incurring charges).

1. Click through the subsequent pages:

* Accept the terms and conditions.
* Do not add recovery options or two-factor authentication (because this is a temporary account).
* Do not sign up for free trials.

After a few moments, the Cloud Console opens in this tab.

<div><ql-infobox>

**Note:** You can view the menu with a list of Google Cloud Products and Services by clicking the **Navigation menu** at the top-left.
</ql-infobox></div>

<img src="img/b3f25899efc309f8.png" alt="b3f25899efc309f8.png"  width="624.00" />

**Activate Cloud Shell**

Cloud Shell is a virtual machine that is loaded with development tools. It offers a persistent 5GB home directory and runs on the Google Cloud. Cloud Shell provides command-line access to your Google Cloud resources.

In the Cloud Console, in the top right toolbar, click the **Activate Cloud Shell** button.

<img src="img/92416fecbe1d30f7.png" alt="92416fecbe1d30f7.png"  width="624.00" />

Click **Continue**.

<img src="img/6d14e09346c5c5ed.png" alt="6d14e09346c5c5ed.png"  width="588.00" />

It takes a few moments to provision and connect to the environment. When you are connected, you are already authenticated, and the project is set to your *PROJECT_ID*. For example:

<img src="img/8a28a4a53cbe37b7.png" alt="8a28a4a53cbe37b7.png"  width="624.00" />

`gcloud` is the command-line tool for Google Cloud. It comes pre-installed on Cloud Shell and supports tab-completion.

**Preflight checks**

* Terminal shell and tools
At this point you should have access to your terminall shell. Please check that terraforem, kubectl and helm binaries are installed.   
<br/>
* GCloud Authentication account
You can list the active account name with this command:

  ```
  gcloud auth list
  ```

  *(Output)*

  ```console
  ACTIVE: *
  ACCOUNT: student-01-xxxxxxxxxxxx@qwiklabs.net
  To set the active account, run:
      $ gcloud config set account `ACCOUNT`
  ```
* GCP Project
You can list the project ID with this command:

  ```
  gcloud config list project
  ```

  *(Output)*

  ```console
  [core]
  project = <project_ID>
  ```

  *(Example output)*

  ```console
  [core]
  project = qwiklabs-gcp-44776a13dea667a6
  ```

<div><ql-infobox>

For full documentation of gcloud see the *gcloud*  [command-line](https://cloud.google.com/sdk/gcloud) tool overview.
</ql-infobox></div>

## Task 1: Onboard Sysdig
Please Log in to your Sysdig account using credentials generated by this lab at the beginning.
<sub>*(i.e. url: https://app.us4.sysdig.com/secure user: my-user@gmail.com pwd: A8!#2rq@).*</sub>

You should see Sysdig's home dashboard screen.

<img src="img/onboard-sysdig/sysdig-home-dashboard.png" alt="Sysdig Home Dashboard"  width="800" />

### Connect your GCP Account (agentless)
Browse to <span style="color:DimGray ">*Integrations > Cloud Accounts > Connect GCP sysdig-onboard-gcp.png*</span>

Populate required fields with **GCP Region** (i.e. *us-central1*) and **Project ID** (i.e. *my-company-project*), and copy-paste auto generated Terraform code into a main.tf file following dialog instructions.

<img src="img/onboard-sysdig/sysdig-onboard-gcp.png" alt="GCP onboarding"  width="800" />

Provision resources by executing the script in your terminal shell.

``
  terraform init && terraform apply
``

After the onboarding process, please check that your new GCP account appears on the list of Data Sources from <span style="color:DimGray ">*Integrations > Cloud Accounts*</span>

As of now, any security event happening in your GCP account and services will be detected and analyzed by Sysdig. We will show more details in further chapters.

### Connect GKE agents for deeper visibility
Browse to <span style="color:DimGray ">*Integrations > Sysdig Agents > Connect a Kubernetes cluster*</span>

Specify a meaningful cluster name (i.e. *gke-workshop*) and copy the auto generated helm command. Execute it in your terminal, it will take no more than 1 minute to get your agents installed and protecting the GKE cluster.

<img src="img/onboard-sysdig/sysdig-onboard-gke.png" alt="GKE onboarding"  width="800" />

After the helm installation is done, please check that your new GKE cluster is now listed on the Data Sources agents screen <span style="color:DimGray ">*Integrations > Sysdig Agents*</span>

We will explain soon how to detect and respond to suspecting events.

## Task 2: Vulnerability Management
**From code to run with Sysdig**
Sysdig secures the entire software lifecycle with continuous scanning, covering:
- Dev images and [CICD pipelines](https://docs.sysdig.com/en/docs/sysdig-secure/scanning/integrate-with-cicd-tools/) with Sysdig CLI
- [Image Registies](https://docs.sysdig.com/en/docs/sysdig-secure/scanning/integrate-with-container-registries/)  like GAR (formerly GCR) or any Docker V2 registries)
- [Hosts](https://docs.sysdig.com/en/docs/sysdig-secure/vulnerabilities/runtime/host-scanning/) (Virtual Machine Instances)
- [Runtime container images](https://docs.sysdig.com/en/docs/sysdig-secure/vulnerabilities/runtime/) (Including Kubernetes pods)

In this section we will learn about Registry Scanning, but you can play around with a Trial account and check what protecting other sections of the SDLC looks like.

<img src="img/vuln-management/gcp-sysdig-vuln-mgt.png" alt="Vulnerability management sysdig"  width="800" />

### GAR and GCR Scan

Sysdig brings **agentless** and **agent based** scanning features.  Agentless is easier to install, while agent-based is more flexible and prevents SBOM information to travel outside of your cloud account. We are going to try the agent-based solution.

Sysdig registry scan agent has to be hosted in a cluster, running as a cron job. It will take care of retrieving and scanning all registry images automatically. Results can be collected locally from agent result logs while they are posted on Sysdig UI automatically.

<img src="img/vuln-management/registry-scan-diagram.png" alt="cluster driven vulnerability management for registries (agent based)"  width="800" />

Vulnerability Scanning is essential to detect and remediate software vulnerabilities, but things are a bit more complex when working at scale. Real companies have to deal with thousands of detections, and the question is: what findings should be prioritized first and why? 

**Sysdig Runtime Insights** performs a continuous profiling of  workloads, flagging packages that are loaded at runtime and thus, distinguishing them from packages that were inserted at build time but are never invoked.

#### Hands on: Vulnerability scannig of GCR/ACR images

As part of this lab, a set of images have been stored in a Google Artifact Registry. We want Sysdig Registry Scanner to scan all those images (and any new image) periodically in an automatic way.

Installing Sysdig scanning agent is as easy as executing a helm command, but we need to configure a *service account* first so that our agent can access to registry images.  

A *service account* has been created for that purpose. Let's generate a JSON token 

....

Copy the recently created JSON file and paste it in our current folder, now use terminal to initialize an environment var called *$SERVICE_ACCOUNT*.

```
SERVICE_ACCOUNT=$(cat keyfile.json | base64)
```

Let's install the agent now:

```
helm upgrade --install registry-scanner sysdig/registry-scanner \
    --version=1 \
    --set config.secureBaseURL=<SYSDIG-REGION> \  # https://us2.app.sysdig.com
    --set config.secureAPIToken=<SYSDIG-TOKEN> \  # df06fa4e-...-fa4e7e8fa4e
    --set config.registryURL=<REGISTRY-URL> \     # us-docker.pkg.dev
    --set config.registryType=dockerv2 \
    --set config.registryUser=_json_key_base64 \
    --set config.registryPassword=$SERVICE_ACCOUNT \ # initialize var with json first
    --set config.filter.maxAgeDays=1000 \
    --set scanOnStart.enabled=true \
    --namespace sysdig-agent
```

Scans are scheduled via cron job, every Saturday at 6:00 am, but as we attached the parameter ```--set scanOnStart.enabled=true```, a first scan will be triggered right after the installation finishes.

Let's check that the scanner is doing its duty. *Kubectl get jobs* will help to see the status of the task.

```
$ kubectl get jobs  -l app.kubernetes.io/instance=registry-scanner
NAME                          COMPLETIONS   DURATION   AGE
registry-scanner-start-test   0/1           30s        30s
```

And **kubectl logs** allows us to understand what happened.

```
$ kubectl logs  -l app.kubernetes.io/instance=registry-scanner
...
{"level":"info","component":"report-builder","message":"Total: N = Success: X + Failed: Y + Skipped: Z"}
```

As a final check **kubectl get pods** shows the final status (*Error* or *Completed*)

```
$ kubectl get pods -l app.kubernetes.io/instance=registry-scanner -ojsonpath --template='{.items[*].status.containerStatuses[*].state.terminated.reason}'
```

If everything went as expected, you should see the registry name with a list of scanned images on your *Sysdig > Vulnereabilities > Registries* screen.

<img src="img/vuln-management/registry-scan-screen.png" alt="Sysdig Registry Scan UI (sample)"  width="800" />

By browsing results (click any container image name and check its vulnerabilities, information, content... ), you can easily find out what findings are threatening and what to prioritize first. 

As vulnerability management requires context, you cand filter vulenrabilities by useful flags like "exploitable", "has fix" or expand vulnerability information by clicking any of the findings (CVEs) from the list.

<img src="img/vuln-management/registry-scan-screen-detail.png" alt="Sysdig Registry Scan UI detail (sample)"  width="800" />

More information about registry scanning can be found here https://docs.sysdig.com/en/docs/installation/sysdig-secure/install-registry-scanner.

#### Hands on: Noise reduction with Runtime Insights (In-Use packages)

Previous exercise consisted of analyzing static binary files (we can use Sysdig Admission Controller and OPA rules to prevent some of them to be deployed). But Sysdig provides also continuous Runtime Scanning. Let's see how it works.

Browse to **Vulnerabilities > Runtime**

Eeach item of the list is a running container that is presented with its registry/image:tag url, version and asset where the workload is being executed (cluster or host).

At the right is a summary of vulnerabilities coloured by severity, ad the InUse flagging based on Runtime Insights.

<img src="img/vuln-management/vuln-runtime-insights-1.png" alt="Sysdig Runtime Scan UI detail (sample)"  width="800" />

Click one of the images to see its details screen. If we navigate to the *Vulnerabilities* tab and activate the *InUse* filter, the list will be dramatically reduced. If we add a filter with "Critical" and "High" severities, the resultset will be reduced even more. 

This is the list of high severity and in use packages from that image that we need to prioritize. This is real noise reduction based on dynamic feedback.

<img src="img/vuln-management/vuln-runtime-insights-2.png" alt="Sysdig Runtime Scan UI detail (sample)"  width="800" />

## Task 3: Runtime Threat Detection and Response
==Lorem ipsum==

### Cloud threat detection (agentless)

==Lorem impsum==

#### Hands on: Detect suspicious events in your Cloud
==Lorem ipsum==

 GKE threat detection

### GKE threat detection

Sysdig Threat detection for Hosts and Kubernetes can capture, evaluate and respond to any suspicious event. 

<img src="img/threat-detection-containers/gcp-sysdig-runtime-gke.png" alt="Sysdig Registry Scan UI detail (sample)"  width="800" />

Runtime detection in Sysdig is builit on top of Falco. Runtime policies are collections of Falco rules. Let's go to *Policies > Runtime Policies* and **activate** the policy *Suspicious Container Activity* (click on the Policy first to review and understand what rules are included and how are they configured).

<img src="img/threat-detection-containers/sysdig-runtime-policies.png" alt="Sysdig Runtime Threat Detection"  width="800" />

This policy contains a rule called *"Terminal Shell into container"* that will capture any event related with that not-so-good practice.

Let's go to the terminal and launch a terminal shell into a running pod.

```
kubectl get po --n default
>> (Copy any pod name from the output)
kubectl exec -it -n default <pod-name-abcdef> -- sh 
$ 
```

Go to the *Insights > Kubernetes Activity* screen and voila! there is the suspicious terminal shell that our security team can trace and investigate now.  

Please note that automatic actions can be preconfigured like, for instance, auto-killing the container when the event is detected.

<img src="img/threat-detection-containers/sysdig-ui-insights-kubernetes.png" alt="Sysdig Runtime Threat Detection"  width="800" />


#### Hands on: Detect suspicious events in your Kubernetes cluster
==Lorem ipsum==


## Task 4: Posture Management
==Lorem ipsum==

## Exploring logs with Log Analytics
1. Enable Log Analytics on your default bucket
2. In the Navigation menu, (In the Cloud Console, on the **Navigation menu** ( <img src="img/8c24be286e75dbe7.png" alt="Navigation menu icon"  width="15.00" />), click **Cloud Logging** &gt; **Log analytics**.), click Cloud Logging &gt; Log Analytics.
Enter the following into the SQL field:
```
SELECT
JSON_VALUE(json_payload, '$."http.req.path"') as path, JSON_VALUE(json_payload, '$."http.resp.status"') as code, COUNT(*) AS count
FROM
  `ops-demo-330920.global._Default._AllLogs`

WHERE log_id = "stdout" AND JSON_VALUE(json_payload, '$."http.req.path"')  IS NOT NULL  AND JSON_VALUE(json_payload, '$."http.req.path"') LIKE '%product%'
GROUP BY path, code
ORDER BY count DESC
``````






 




