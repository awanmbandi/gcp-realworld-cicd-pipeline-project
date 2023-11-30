# End-to-End Jenkins CI/CD Pipeline Project Architecture (Java Web Application)
![CompleteCICDProject!](https://github.com/awanmbandi/gcp-realworld-cicd-pipeline-project/blob/zdocs/images/cicd_project_arch.png) 

###### Project ToolBox 🧰
- [Git](https://git-scm.com/) Git will be used to manage our application source code.
- [Github](https://github.com/) Github is a free and open source distributed VCS designed to handle everything from small to very large projects with speed and efficiency
- [Jenkins](https://www.jenkins.io/) Jenkins is an open source automation CI tool which enables developers around the world to reliably build, test, and deploy their software
- [Maven](https://maven.apache.org/) Maven will be used for the application packaging and building including running unit test cases
- [Checkstyle](https://checkstyle.sourceforge.io/) Checkstyle is a static code analysis tool used in software development for checking if Java source code is compliant with specified coding rules and practices.
- [SonarQube](https://docs.sonarqube.org/) SonarQube Catches bugs and vulnerabilities in your app, with thousands of automated Static Code Analysis rules.
- [Nexus](https://www.sonatype.com/) Nexus Manage Binaries and build artifacts across your software supply chain
- [Ansible](https://docs.ansible.com/) Ansible will be used for the application deployment to both lower environments and production
- [GCE](https://cloud.google.com/compute?hl=en) GCE allows users to rent virtual computers (GCE) to run their own workloads and applications.
- [Slack](https://slack.com/) Slack is a communication platform designed for collaboration which can be leveraged to build and develop a very robust DevOps culture. Will be used for Continuous feedback loop.

# Jenkins Complete CI/CD Pipeline Environment Setup Runbook
1) Create a GitHub Repository with the name `Jenkins-CICD-Project` and push the code in this branch(main) to 
    your remote repository (your newly created repository). 
    - Go to GitHub (github.com)
    - Login to your GitHub Account
    - Create a Repository called "Jenkins-CICD-Project"
    - Clone the Repository in the "Repository" directory/folder in your local
    - Download the code in in this repository "Main branch": https://github.com/awanmbandi/realworld-cicd-pipeline-project.git
    - Unzip the code/zipped file
    - Copy and Paste everything from the zipped file into the repository you cloned in your local
    - Add the code to git, commit and push it to your upstream branch "main or master"
    - Confirm that the code exist on GitHub

2) Jenkins/Maven/Ansible
    - Create an Ubuntu 22.04 VM instance 
    - Name: Jenkins/Maven/Ansible
    - Instance type: e2-standard-2
    - Firewall Rules (Open): 8080, 9100 and 22 to 0.0.0.0/0
    - User Script (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-nexus-sonarqube-jenkins-install/jenkins-install.sh
    - Launch Instance

3) SonarQube
    - Create an Create an Ubuntu 22.04 VM instance 
    - Name: SonarQube
    - Instance type: e2-standard-2
    - Firewall Rules (Open): 9000, 9100 and 22 to 0.0.0.0/0
    - User Script (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-nexus-sonarqube-jenkins-install/sonarqube-install.sh
    - Launch Instance

4) Nexus
    - Create an Ubuntu 22.04 VM instance 
    - Name: Nexus
    - Instance type: e2-standard-2
    - Firewall Rules (Open): 8081, 9100 and 22 to 0.0.0.0/0
    - User Script (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-nexus-sonarqube-jenkins-install/nexus-install.sh
    - Launch Instance

5) GCE (Dev/Stage/Prod)
    - Create CentOS 7 VM instance
    - Names: Dev-Env, Stage-Env and Prod-Env
    - Number: `3`
    - Instance type: e2-medium
    - Firewall Rules (Open): 8080, 9100, 9997 and 22 to 0.0.0.0/0
    - User Script (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/tomcat-splunk-installation/tomcat-ssh-configure.sh
    - Launch Instance

#### NOTE: Confirm and make sure you have a total of 8 VM instances
![PipelineEnvSetup!]()

9) Slack 
    - Go to the bellow Workspace and create a Private Slack Channel and name it "yourfirstname-jenkins-cicd-pipeline-alerts"
    - Link: https://join.slack.com/t/jjtechtowerba-zuj7343/shared_invite/zt-24mgawshy-EhixQsRyVuCo8UD~AbhQYQ  
      - You can either join through the browser or your local Slack App
      - Create a `Private Channel` using the naming convention `cicd-pipeline-project-alerts`
      - Click on the Drop down on the Channel and select Integrations and take `Add an App`
      - Search for `Jenkins` and click on `View` -->> `Configuration/Install` -->> `Add to Slack` 
      - On Post to Channel: Click the Drop Down and select your channel above `cicd-pipeline-project-alerts`
      - Click `Add Jenkins CI Integration`
      - SAVE SETTINGS/CONFIGURATIONS
      - Leave this page open
      ![SlackConfig!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-26%20at%202.08.55%20PM.png)
    
    #### NOTE: Update Your Jenkins file with your Slack Channel Name
    - Go back to your local, open your "Jenkins-CICD-Project" repo/folder/directory on VSCODE
    - Open your "Jenkinsfile"
    - Update the slack channel name on line "97" (there about)
    - Change name from "cicd-project-alerts" (or whatever name thst's there) to yours
    - Add the changes to git, commit and push to GitHub
    - Confirm the changes are available on GitHub
		- Save and Push to GitHub

## Configure All Systems
### Jenkins setup
1) #### Access Jenkins
    Copy your Jenkins Public IP Address and paste on the browser = ExternalIP:8080
    - Login to your Jenkins instance using your Shell (GitBash or your Mac Terminal)
    - Copy the Path from the Jenkins UI to get the Administrator Password
        - Run: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
        - Copy the password and login to Jenkins
    ![JenkinsSetup1!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/jenkins-signup.png) 
    - Plugins: Choose Install Suggested Plugings 
    - Provide 
        - Username: **admin**
        - Password: **admin**
        - Name and Email can also be admin. You can use `admin` all, as its a poc.
    - Continue and Start using Jenkins
    ![JenkinsSetup2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%208.49.43%20AM.png) 

2)  #### Plugin installations:
    - Click on "Manage Jenkins"
    - Click on "Plugin Manager"
    - Click "Available"
    - Search and Install the following Plugings "Install Without Restart"
        - **SonarQube Scanner**
        - **Maven Integration**
        - **Pipeline Maven Integration**
        - **Maven Release Plug-In**
        - **Slack Notification**
        - **Nexus Artifact Uploader**
        - **Build Timestamp (Needed for Artifact versioning)**
    - Once all plugins are installed, select **Restart Jenkins when installation is complete and no jobs are running**
    ![PluginInstallation!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2010.07.32%20PM.png)

3)  #### Global tools configuration:
    - Click on Manage Jenkins -->> Global Tool Configuration
    ![JDKSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%208.59.50%20AM.png)

        **JDK** -->> Add JDK -->> Make sure **Install automatically** is enabled -->> 
        
        **Note:** By default the **Install Oracle Java SE Development Kit from the website** make sure to close that option by clicking on the image as shown below.

        ![JDKSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%208.59.50%20AM.png)

        * Click on Add installer
        * Select Extract *.zip/*.tar.gz -->> Fill the below values
        * Name: **localJdk**
        * Download URL for binary archive: **https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz**
        * Subdirectory of extracted archive: **jdk-11.0.1**
    - **Git** -->> Add Git -->> Install automatically(Optional)
      ![GitSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%209.36.23%20AM.png)
    
    - **SonarQube Scanner** -->> Add SonarQube Scanner -->> Install automatically(Optional)
      ![SonarQubeScanner!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%209.35.20%20AM.png)

    - **Maven** -->> Add Maven -->> Make sure **Install automatically** is enabled -->> Install from Apache -->> Fill the below values
      * Name: **localMaven**
      * Version: Keep the default version as it is 
    - Click on SAVE
    ![MavenSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%209.44.14%20AM.png)
    
4)  #### Credentials setup(SonarQube, Nexus, Ansible and Slack):
    - Click on Manage Jenkins -->> Manage Credentials -->> Global credentials (unrestricted) -->> Add Credentials
      1)  ##### SonarQube secret token (SonarQube-Token)
          - ###### Generating SonarQube secret token:
              - Login to your SonarQube server (http://SonarServer-Sublic-IP:9000, with the credentials username: **admin** & password: **admin**)
              - Click on profile -->> My Account -->> Security -->> Tokens
              - Generate Tokens: Fill ``SonarQube-Token``
              - Click on **Generate**
              - Copy the token 
          - ###### Store SonarQube Secret token in Jenkins:
              - Click on ``Add Credentials``
              - Kind: Secret text!! 
              - Secret: Fill the SonarQube token value that we have created on the SonarQube server
              - ID: ``SonarQube-Token``
              - Description: SonarQube-Token
              - Click on Create

      2)  ##### Slack secret token (slack-token)
          - Click on ``Add Credentials``
          - Kind: Secret text            
          - Secret: Place the Integration Token Credential ID (Note: Generate for slack setup)
          - ID: ``Slack-Token``
          - Description: slack-token
          - Click on Create  

      3)  ##### Nexus Credentials (Username and Password)
          - ###### Login to Nexus and Set Password
              - Access Nexus: http://Nexus-Pub-IP:8081/
	          - Default Username: admin
	          - NOTE: Login into your "Nexus" VM and "cat" the following file to get the password.
	          - Command: ``sudo cat /opt/nexus/sonatype-work/nexus3/admin.password``
	          - Password: `Fill In The Password and Click Sign In`
	          - Click Next -->> Provide New Password: "admin" 
	          - Configure Anonymous Access: "Enable anonymous access" -->> Finish
          - ###### Nexus credentials (username & password)
	          - Click on ``Add Credentials``
	          - Kind: Username with password                  
	          - Username: ``admin``
	          - Enable Treat username as secret
	          - Password: ``admin``
	          - ID: ``Nexus-Credential``
	          - Description: nexus-credential
	          - Click on Create   

      4)  ##### Ansible deployment server credential (username & password)
          - Click on ``Add Credentials``
          - Kind: Username with password          
          - Username: ``ansibleadmin``
          - Enable Treat username as secret
          - Password: ``ansibleadmin``
          - ID: ``Ansible-Credential``
          - Description: Ansible-Credential
          - Click on Create   
      ![SonarQubeServerSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-27%20at%202.10.40%20PM.png)

5)  #### Configure system:    
    1)  - Click on ``Manage Jenkins`` -->> ``Configure System`` 
        - `SonarQube Servers`
        ![SonarQubeServerSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2010.13.39%20AM.png)

    2)  - Click on Manage Jenkins -->> Configure System
        - Go to section Slack
            - Use new team subdomain & integration token credentials created in the above slack joining step
            - Workspace: **Replace with Team Subdomain value** (created above)
            - Credentials: select the slack-token credentials (created above) 
            - Default channel / member id: #PROVIDE_YOUR_CHANNEL_NAME_HERE
            - Test Connection
            - Click on Save
        ![SlackSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2010.31.12%20AM.png)

### SonarQube Configuration
2)  ### Setup SonarQube GateKeeper
    - Click on -->> Quality Gate 
    ![SonarQubeSetup2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-27%20at%202.17.50%20PM.png)
    - Click on -->> Create
    ![SonarQubeSetup2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2011.00.25%20AM.png)
    - Add a Quality Gate Condition to Validate the Code Against (Code Smells or Bugs)
    ![SonarQubeSetup3!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2011.02.36%20AM.png)
    
    - Add Quality to SonarQube Project
    -  ``NOTE:`` Make sure to update the `SonarQube` stage in your `Jenkinsfile` and Test the Pipeline so your project will be visible on the SonarQube Project Dashboard.
    - Click on Projects -->> Administration -->> Select `Quality Gate`
    ![SonarQubeSetup3!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2011.05.47%20AM.png)

3)  ### Setup SonarQube Webhook to Integrate Jenkins (To pass the results to Jenkins)
    - Still on `Administration`
    - Select `Webhook`
    - Click on `Create Webhook` 
      - Name: `jenkinswebhook`
      - URL: `http://Jenkins-Server-Private-IP:8080/sonarqube-webhook`
    ![SonarQubeSetup4!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2011.08.26%20AM.png)

    - Go ahead and Confirm in the Jenkinsfile you have the “Quality Gate Stage”. The stage code should look like the below;
    ```bash
    stage('SonarQube GateKeeper') {
        steps {
          timeout(time : 1, unit : 'HOURS'){
          waitForQualityGate abortPipeline: true
          }
       }
    }
    ```
     - Run Your Pipeline To Test Your Quality Gate (It should PASS QG)
     - **(OPTIONAL)** FAIL Your Quality Gate: Go back to SonarQube -->> Open your Project -->> Click on Quality Gates at the top -->> Select your Project Quality Gate -->> Click EDIT -->> Change the Value to “0” -->> Update Condition
     - **(OPTIONAL)** Run/Test Your Pipeline Again and This Time Your Quality Gate Should Fail 
     - **(OPTIONAL)** Go back and Update the Quality Gate value to 10. The Exercise was just to see how Quality Gate Works

### Pipeline creation
- Update The ``Jenkinsfile`` If Neccessary
- Update `SonarQube IP address` in your `Jenkinsfile`
- Update the `SonarQube projectKey or name` in your `Jenkinsfile`
- Update your `Slack Channel Name` in the `Jenkinsfile` 
    
    - Log into Jenkins: http://Jenkins-Public-IP:8080/
    - Click on **New Item**
    - Enter an item name: **Jenkins-Complete-CICD-Pipeline** & select the category as **Pipeline**
    - Now scroll-down and in the Pipeline section -->> Definition -->> Select Pipeline script from SCM
    - GitHub project: `Provide Your Project Repo Git URL`
    - GitHub hook trigger for GITScm polling: `Check the box` 
      - NOTE: Make sure to also configure it on GitHub's side
    - SCM: **Git**
    - Repositories
        - Repository URL: FILL YOUR OWN REPO URL (that we created by importing in the first step)
        - Branch Specifier (blank for 'any'): ``*/main``
        - Script Path: ``Jenkinsfile``
    - Save
    - NOTE: Make Sure Your Pipeline Succeeds Until ``SonarQube GateKeeper``. Upload to Artifactory would fail.
    - TEST Pipeline 

    ### A. Pipeline Test Results 
    - Jenkins Pipeline Job
    ![JenkinsJobResult!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/jenkins-pipeline-first-run.png)

    - SonarQube Code Inspection Result
    ![SonarQubeResult!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/sonarqube-result.png)

    - Slack Continuous Feedback Alert
    ![SlackResult!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/slack-first-notification-from-pipeline-job2.png)

    - SonarQube GateKeeper Webhook Payload
    ![SonarQubeGateKeeper!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/sonarqube-webhook-forGateKepper-Result.png)

    ### B. Troubleshooting (Possible Issues You May Encounter and Suggested Solutions)
    1) **1st ISSUE:** If you experience a long wait time at the level of `GateKeeper`, please check if your `Sonar Webhook` is associated with your `SonarQube Project` with `SonarQube Results`
    - If you check your jenkins Pipeline you'll most likely find the below message at the `SonarQube GateKeper` stage
    ```bash
    JENKINS CONSOLE OUTPUT

    Checking status of SonarQube task 'AYfEB4IQ3rP3Y6VQ_yIa' on server 'SonarQube'
    SonarQube task 'AYfEB4IQ3rP3Y6VQ_yIa' status is 'PENDING'
    ```

### Nexus Configuration
1)  ### Accessing Nexus: 
    The nexus service on port 8081. To access the nexus dashboard, visit http://Nexus-Pub-IP:8081. You will be able to see the nexus homepage as shown below.
    - Default username: ``admin``
    - Default Password: ```sudo cat /app/sonatype-work/nexus3/admin.password```
    - NOTE: Once you login, you will be prompted to reset the password

    ### Go ahead and create your Nexus Project Repositories
    - CREATE 1st REPO: Click on the Gear Icon -->> Repository -->> Create Repository -->> Select `maven2(hosted)` -->> Name: `maven-project-releases` -->> Create Repository

    - CREATE 2nd REPO: Click Create Repository -->> Select `maven2(hosted)` -->> Name: `maven-project-snapshots` -->> Version Policy: Select `Snapshot` -->> Create Repository

    - CREATE 3rd REPO: Click Create Repository -->> Select `maven2(proxy)` -->> Name: `maven-project-central` -->> Remote Storage: provide this link https://repo.maven.apache.org/maven2 -->> Create Repository

    - CREATE 4th REPO: Click Create Repository -->> Select `maven2(group)` -->> Name: `maven-project-group` -->> Version Policy: Select `Mixed` -->> Assign All The Repos You Created to The Group -->> Create Repository
    - Once you select create repository and select maven2(group)

    ![NexusSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-27%20at%203.42.03%20PM.png) 

### Update Maven POM and Integrate/Configure Nexus With Jenkins
A) Update Maven `POM.xml` file
- Update the Following lines of Code ``(Line 32 and 36)`` in the maven `POM` file and save
```bash
<url>http://Nexus-Server-Private-IP:8081/repository/maven-project-snapshots/</url>

<url>http://Nexus-Server-Private-IP:8081/repository/maven-project-releases/</url>
```

-  Add the following Stage in your Jenkins pipeline config and Update the following Values (nexusUrl, repository, credentialsId, artifactId, file etc.). If necessary 
- The following `environment` config represents the NEXUS CREDENTIAL stored in jenkins. we're pulling the credential with the use of the predefine ``NEXUS_CREDENTIAL_ID`` environment variable key. Which jenkins already understands. 
  ```bash
  environment {
    WORKSPACE = "${env.WORKSPACE}"
    NEXUS_CREDENTIAL_ID = 'Nexus-Credential'
  }
  ```

- Here we're using the `Nexus Artifact Uploader` stage config to store the app artifact
  ```bash
  stage("Nexus Artifact Uploader"){
      steps{
          nexusArtifactUploader(
            nexusVersion: 'nexus3',
            protocol: 'http',
            nexusUrl: '172.31.82.36:8081',
            groupId: 'webapp',
            version: "${env.BUILD_ID}-${env.BUILD_TIMESTAMP}",
            repository: 'maven-project-releases',  //"${NEXUS_REPOSITORY}",
            credentialsId: "${NEXUS_CREDENTIAL_ID}",
            artifacts: [
                [artifactId: 'webapp',
                classifier: '',
                file: '/var/lib/jenkins/workspace/jenkins-complete-cicd-pipeline/webapp/target/webapp.war',
                type: 'war']
            ]
          )
      }
  }
  ```
- After confirming all changes, go ahead and save, then push to GitHub.
- Test your Pipeline to ``Make Sure That The Artifacts Upload Stage Succeeds``.
- Navigate to Jenkins Dashboard (Run/Test The Job) 
![PipelineStagesArtifactSuccess!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/second-pipeline-run.png)

- Navigate to `Nexus` as well to confirm that the artifact was `Stored` in the `maven-project-releases` repository
![ArtifactStored!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-27%20at%204.08.33%20PM.png)

## Configure Ansible To Deploy to `Dev`, `Stage` and `Prod`
- NOTE: That you passed a Userdata in the Jenkins/Maven/Ansible and Dev,Stage and Prod Instances to Configure the Environments already. So you do not have to perform these operations again. You just Have to confirm, the Configurations where all Successful.
- NOTE: Update `ALL Pipeline Deploy Stages` with your `Ansible Credentials ID` (IMPORTANT)
- Also Make sure the following Userdata was executed across all the Environment Deployment Nodes/Areas
```bash
#!/bin/bash
# Tomcat Server Installation
sudo su
amazon-linux-extras install tomcat8.5 -y
systemctl enable tomcat
systemctl start tomcat

# Provisioning Ansible Deployer Access
useradd ansibleadmin
echo ansibleadmin | passwd ansibleadmin --stdin
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
echo "ansibleadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
```

### Setup a CI Integration Between `GitHub` and `Jenkins`
1. Navigate to your GitHub project repository
    - Open the repository
    - Click on the repository `Settings`
        - Click on `Webhooks`
        - Click `Add webhook`
            - Payload URL: http://JENKINS-PUBLIC-IP-ADDRESS/github-webhook/
            - Content type: `application/json`
            - Active: Confirm it is `Enable`
            - Click on `Add Webhook`

2. Confirm that this is Enabled at the Level of the Jenkins Job as well
    - Navigate to your Jenkins Application: http://JENKINS-PUBLIC-IP-ADDRESS:8080
        - Click on the `Job Name`
        - Navigate to `Build Triggers`
            - Enable/Check the box `GitHub hook trigger for GITScm polling`
        - Click on `Apply and Save`

### TEST PIPELINE DEPLOYMENT
- Confirm/Confirm that your deployments where all successful accross all Environments
![PipelineStagesCompleted!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-27%20at%204.44.30%20PM.png)

- Verify/Confirm Slack Success Feedback.
![SlackSuccessAllStages!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-27%20at%205.06.44%20PM.png)

- Confirm Access to your application: http://Dev-or-Stage-or-Prod-PubIP:8080/webapp/
![FinalProductDisplay!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-27%20at%204.50.42%20PM.png)

### NOTE: That By completing this project, you are now considered a Professional DevOps Engineer.  
You've been able to accomplish something very unique and special which most people only dream of in their IT journey. Remmber that during an interview, you may be asked some challenging questions or be faced with a trial assignment that require you to both utilize your existing skillsets and think out of the box. During this time you must be very confident and determined in your pursuit. 

Never forget that you have what it takes to add more than enough VALUE to any organization out there in the industry and to STAND OUT in any interview setting no matter who is sitted on the interview seat.

### Congratulations Team!!!👨🏼‍💻 Congratulations!!!👨🏼‍💻





