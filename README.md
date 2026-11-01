# Cloud Computing Practical Journal

A collection of hands-on Cloud Computing practicals covering cloud fundamentals, virtualization, OpenStack, cloud storage, identity and access management, and major cloud platforms.

## Table of Contents

1. [Practical 1 – Study of Cloud Computing & Architecture](#practical-1--study-of-cloud-computing--architecture)
2. [Practical 2 – Virtualization Using KVM](#practical-2--virtualization-using-kvm)
3. [Practical 3 – OpenStack Installation Using DevStack](#practical-3--openstack-installation-using-devstack)
4. [Practical 4 – Google Drive as Storage as a Service (STaaS)](#practical-4--google-drive-as-storage-as-a-service-staas)
5. [Practical 5 – Identity Management Using ownCloud](#practical-5--identity-management-using-owncloud)
6. [Practical 6 – AWS Account Creation and IAM Identity Center](#practical-6--aws-account-creation-and-iam-identity-center)
7. [Practical 7A – Case Study on AWS](#practical-7a--case-study-on-amazon-web-services-aws)
8. [Practical 7B – Case Study on GCP](#practical-7b--case-study-on-google-cloud-platform-gcp)

## Practical Overview

| Practical | Topic | Main tools / platform |
|---|---|---|
| 1 | Cloud Computing concepts, architecture, deployment and service models | Ubuntu, Internet |
| 2 | Virtualization setup and verification using KVM | Ubuntu, KVM, QEMU, libvirt, virt-manager |
| 3 | OpenStack installation and dashboard access | Ubuntu, Git, DevStack, OpenStack Horizon |
| 4 | Cloud file creation and sharing using STaaS | Google Drive |
| 5 | User, group and permission management | ownCloud |
| 6 | AWS account setup and identity management | AWS IAM Identity Center |
| 7A | AWS services and use cases | Amazon Web Services |
| 7B | GCP services and use cases | Google Cloud Platform |

## General Requirements

- A computer capable of running the required operating system and tools.
- Internet connectivity.
- Ubuntu for the KVM and OpenStack practicals.
- The relevant cloud accounts or platforms for Google Drive, ownCloud, AWS and GCP practicals.

## Important Notes

- Follow the commands and steps in the relevant practical section in order.
- Some installation times depend on internet speed and available system resources.
- Use your own account details where examples such as email addresses and usernames are shown.
- The AWS practical includes payment-verification guidance. AWS Free Tier does not mean every service or usage is free; review charges and billing details before using services.
- The password shown in the DevStack configuration is an example for the practical. Do not reuse example passwords for real or public deployments.
- Cloud service interfaces and account-registration options may change over time.

---


## Practical 1 – Study of Cloud Computing & Architecture

### 1. Aim

To study Cloud Computing and its architecture and understand different cloud models.

### 2. Objectives

1. Understand basic concepts of Cloud Computing.
2. Study cloud architecture and service models.

### 3. Outcomes

1. Understand cloud architecture.
2. Understand the impact of cloud computing on organizations.

### 4. Hardware / Software Required

- Ubuntu OS
- Internet Connection

### 5. Theory

Step 1: Cloud Computing

Cloud computing is a technology that provides computing resources such as servers, storage, databases, software and applications over the internet.
Users can access these resources whenever they need them without maintaining their own physical infrastructure.
Cloud Computing provides computing resources like servers, storage, databases and software over the Internet on demand.

Step 2: Benefits

1. Self-service: Access resources whenever required.
2. Elasticity: Increase or decrease resources.
3. Pay-per-use: Pay only for resources used.

Step 3: Deployment Models

1. Public Cloud: Services provided over the Internet. Example: AWS.
2. Private Cloud: Used by a single organization.
3. Hybrid Cloud: Combination of Public and Private Cloud.

Step 4: Service Models

1. IaaS: Provides virtual machines, servers and storage. Example: AWS EC2.
2. PaaS: Provides a platform to develop applications. Example: Google App Engine.
3. SaaS: Provides ready-to-use software. Example: Gmail, Google Docs.

Step 5: Advantages

1. Cost saving.
2. Scalability.
3. Easy accessibility.
4. Automatic updates.
5. Data backup.

Step 6: Disadvantages

1. Internet dependency.
2. Security risks.
3. Ongoing costs.
4. Limited control.
5. Service downtime.

### 6. Conclusion

Cloud Computing provides on-demand computing resources over the Internet. It offers flexibility, scalability and cost savings but also has security and Internet dependency issues.

## Practical 2 - Virtualization using kvm

### 1 - detailed information about the CPU (Central Processing Unit) installed in your system.
``` 
  lscpu
```

### 2 
```
  egrep -c '(vmx|svm)' /proc/cpuinfo
```
 - If the output is greater than 0, the processor supports hardware virtualization.

### 3 Update package information
```
  sudo apt update
```

### 4 Enable the Universe repository
```
  sudo add-apt-repository universe
```
 - Press Enter if prompted.

### 5 Update packages again

``` 
  sudo apt update
```

### 6 Install KVM and required packages
``` 
  sudo apt install -y qemu-system-x86 virt-manager libvirt-daemon-system libvirt-clients bridge-utils ovmf
```

### 7 Add your Ubuntu user to the KVM and Libvirt groups.

``` 
  sudo usermod -aG libvirt,kvm $USER
```

### 8 Check libvirtd service status
``` 
  sudo systemctl status libvirtd.service
```
  - If the service is not active, enable and start it using the following commands:
    ```
      sudo systemctl enable libvirtd.service
      sudo systemctl start libvirtd.service
    ```

###  (Optional: reboot the system if required.) 
```
  sudo reboot
```

### 9 Check KVM availability.
```
  sudo apt install -y cpu-checker
```

```
  kvm-ok
```

o/p 
INFO: /dev/kvm exists
KVM acceleration can be used

### 10 Open Virtual Machine Manager.
```
  virt-manager
```



## Practical 3 – OpenStack Installation Using DevStack

```
  sudo apt update
  sudo apt upgrade -y
```
 - The upgrade step may be skipped if it is not required. 

### Step 2: Install Git
```
  sudo apt install git -y
```

### Step 3: Create a Stack User
```
  sudo useradd -s /bin/bash -d /opt/stack -m stack
```

Give permission to the home directory:
```
  sudo chmod +x /opt/stack
```

Give sudo privileges:
```
  echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
```

Change to the stack user:
```
  sudo su - stack
```


### Step 4: Download DevStack
```
  git clone https://opendev.org/openstack/devstack
```

Enter the DevStack directory:
```
  cd devstack
```

### Step 5: Create the Configuration File
```
  nano local.conf
```

Write the following configuration:
```
[[local|localrc]]

ADMIN_PASSWORD=Admin123
DATABASE_PASSWORD=Admin123
RABBIT_PASSWORD=Admin123
SERVICE_PASSWORD=Admin123
```

Save the file:
- Press CTRL + O
- Press Enter
- Press CTRL + X
This file contains the passwords required by OpenStack services.


### Step 6: Install OpenStack
```
  ./stack.sh
```

Installation may take 15–30 minutes or longer depending on internet speed and system resources.


### Step 7: Access OpenStack Dashboard
After successful installation, open Firefox in Ubuntu.
Enter:
```
http://127.0.0.1/dashboard
```

Login credentials:
```
Username: admin
Password: Admin123
```

You should see the OpenStack Horizon dashboard.


##### 

## Cloud Practical – Using Google Drive as STaaS (Storage as a Service)

Aim: To use Google Drive as Storage as a Service (STaaS) by creating a file, storing it in the cloud and sharing it with other people.

Requirements:

- Google account (Gmail)
- Internet connection
- Google Drive

## Part 1: Open Google Drive


1. Open Google Chrome.
3. Sign in using your Gmail account.
4. You will see the Google Drive dashboard.

## Part 2: Create a File

1. Click on the + New button on the left side.
2. Create new folder
3. Add or upload documents
6. Write some content inside the document.


## Part 3: Share the File with Specific People


1. Open the created folder.
2. Click the Share button in the top-right corner.
3. A sharing dialog box will appear.
4. Under Add people, groups, and calendar events, enter the Gmail address of the person.
5. Select the required access permission.

| Permission | Description                        |
| ---------- | ---------------------------------- |
| Viewer     | Can only view the file             |
| Commenter  | Can view and add comments          |
| Editor     | Can view, edit and modify the file |

6\. Click Send.

The selected person will receive an email invitation to access the file.

## Part 4: Share the File Using a Link

1. Open the document.
2. Click Share.
3. Find the General access section.
4. By default, it is set to Restricted.
5. Click on Restricted.
6. Select Anyone with the link.
7. Select the required permission (Viewer, Commenter or Editor).
8. Click Copy link.
9. Click Done.
10. Send the copied link to other people through WhatsApp, email or any messaging platform.

Now people with the link can access the file according to the permission you selected.

**Practical completed successfully.**


## Conclusion

Successfully used Google Drive as Storage as a Service (STaaS) by creating and storing a document in the cloud and sharing it with other people using email invitations and shareable links.

## Practical No. 5: Implementation of Identity Management Using ownCloud

## 1. Introduction
ownCloud is a cloud storage platform. It is used to store and share files online.

It allows the administrator to manage users, groups and permissions.
## 2. Installation of ownCloud
-  Download and install ownCloud on Windows.
-   Open ownCloud.
-  Complete the required setup.
- Create an admin account.
- Login using the admin username and password.
- Identity Management (Users, Groups and Permissions)
  
## Users:
- Users are people who use ownCloud.
- The admin can create or delete users.
- Every user has a username and password.

## Groups:
- A group is a collection of users.
- The admin can create groups and add users to them.
- It makes user management easy.

## Permissions:
- Permissions decide what a user can do.
- Users can read, write, edit and delete files.
- Permissions help keep files safe.

##  Verification
- Login as an admin.
- Check the created users and groups.
- Login with a user account.
-  Check whether the user can access the files.
-  Check whether the permissions are working properly.

## Practical 6 – AWS Account Creation and IAM Identity Center

**Aim:** To create an AWS account, use AWS IAM Identity Center to create users and groups, and assign specific permissions to a user through a permission set.

**Services used:**
1. Amazon Web Services (AWS)
2. AWS IAM Identity Center (formerly AWS Single Sign-On)
3. AWS Free Tier

---

## Part 1: Create an AWS Account

**Step 1:** Open the official AWS website:

https://aws.amazon.com/

**Step 2:** Click on **Create an AWS Account**.

**Step 3:** Enter the required details:
- Email address
- AWS account name
- Password

**Step 4:** Verify your email address using the OTP sent by AWS.

**Step 5:** Enter your contact information:
- Full name
- Phone number
- Country
- Address

**Step 6: Payment verification using UPI**

- Select the UPI payment option, if offered.
- Enter your UPI ID.
- Approve the payment verification request in your UPI application.
- Complete any additional verification requested by AWS.

> **Important:** AWS may require payment verification or a temporary authorization. UPI availability and the verification process can vary. AWS Free Tier does not mean every service or usage is free.

**Step 7:** Complete phone verification.

**Step 8:** Select the Basic Support plan (Free).

**Step 9:** Complete the registration process.

Your AWS account will be created successfully.

## Part 2: Turn Off UPI AutoPay

If you approved a recurring UPI mandate during registration, you can manage it through your UPI application.

1. Open your UPI application (Google Pay, PhonePe, Paytm, etc.).
2. Navigate to **Autopay / UPI Mandates**.
3. Find the AWS-related mandate.
4. Open the mandate details.
5. Select **Cancel / Revoke**.
6. Confirm cancellation.

> **Important:** Cancelling a UPI mandate does not cancel your AWS account. Make sure you understand any outstanding AWS charges. Do not assume the mandate is active unless you can see it in your UPI app.

---

## Part 3: Login to AWS Management Console

**Step 1:** Open:

https://console.aws.amazon.com/

**Step 2:** Select **Root user**.

**Step 3:** Enter the email address used during AWS account registration.

**Step 4:** Enter your password and sign in.

You will now see the AWS Management Console dashboard.

## Part 4: Open IAM Identity Center

**Step 1:** In the AWS Console search bar, search for `IAM Identity Center`.

**Step 2:** Click on **IAM Identity Center**.

**Step 3:** Open the service dashboard.

**Step 4:** If prompted, enable IAM Identity Center.

- Choose the AWS Organizations option if asked to select an identity source.
- Use the default identity source (Identity Center directory) for this practical.
- Complete the setup.

You can now manage users, groups, permission sets and AWS account access.

## Part 5: Create a User

**Step 1:** From the left navigation panel, select **Users**.

**Step 2:** Click **Add user**.

**Step 3:** Fill in the following details:

| Field | Example |
|---|---|
| Username | student01 |
| Email address | student@gmail.com |
| First name | Student |
| Last name | One |

**Step 4:** Under password settings, select the option to send an email to the user with instructions to set up their password, if available.

**Step 5:** Click **Next**.

**Step 6:** Skip adding the user to a group for now, if you want to perform that step separately.

**Step 7:** Review the details and click **Add user**.

Your user is successfully created.

## Part 6: Create a Group

**Step 1:** In the left navigation panel, click **Groups**.

**Step 2:** Click **Create group**.

**Step 3:** Enter the group details.

- Group name: `StudentGroup`
- Description: `Group for AWS practical users`

**Step 4:** Click **Create group**.

Your group is successfully created.

## Part 7: Add the User to the Group

**Step 1:** Open the newly created `StudentGroup`.

**Step 2:** Find the **Add users** option.

**Step 3:** Search for the user `student01`.

**Step 4:** Select the checkbox beside the username.

**Step 5:** Click **Add users**.

The user is now a member of the group.

## Part 8: Create a Permission Set

A **Permission Set** is a collection of permissions that determines which AWS resources a user can access and what actions they can perform.

**Step 1:** In the left navigation panel, under **Multi-account permissions**, click **Permission sets**.

**Step 2:** Click **Create permission set**.

**Step 3:** Select **Predefined permission set**.

**Step 4:** Select a permission set type and choose the required permission.

| Permission | Purpose |
|---|---|
| AdministratorAccess | Full administrative access |
| ReadOnlyAccess | View AWS resources without modifying them |
| PowerUserAccess | Access to AWS services without full IAM administration |

For this practical, you can select `ReadOnlyAccess`.

**Step 5:** Click **Next**.

**Step 6:** Configure the permission set details, such as session duration.

**Step 7:** Click **Next** and then **Create**.

Your permission set is successfully created.

> **Note:** Choose permissions carefully. AdministratorAccess provides extensive control over the AWS account.

## Part 9: Assign Permission to the User or Group

**Step 1:** From the left navigation panel, click **AWS accounts**.

**Step 2:** Select your AWS account by clicking the checkbox.

**Step 3:** Click **Assign users or groups**.

**Step 4:** Under the Users tab, select `student01`.

Alternatively, you can select the Groups tab and select `StudentGroup`.

**Step 5:** Click **Next**.

**Step 6:** Select the permission set you created, such as `ReadOnlyAccess`.

**Step 7:** Click **Next**.

**Step 8:** Review the selected user/group and permission set.

**Step 9:** Click **Submit**.

Your permission set is now assigned to the selected user or group for the selected AWS account.

## Part 10: Login as the Created User and Verify Permissions

**Step 1:** Open the email inbox of the user you created.

**Step 2:** Find the invitation email sent by AWS IAM Identity Center.

**Step 3:** Open the email and follow the instructions to set up the user's password.

**Step 4:** Open the AWS access portal URL provided in the email.

**Step 5:** Sign in using:
- Username: `student01`
- Password: The password created during setup.

**Step 6:** After successful login, you will see the AWS account assigned to the user.

**Step 7:** Click on the AWS account.

**Step 8:** You will see the permission set assigned to that user, for example `ReadOnlyAccess`.

**Step 9:** Click the permission set to access the AWS Management Console.

**Step 10:** Verify the permissions by opening an AWS service. With `ReadOnlyAccess`, you can view resources but cannot perform actions that modify them.

---

## Expected Result

The following resources have been created successfully:

| Component | Created |
|---|---|
| AWS Account | Yes |
| IAM Identity Center User | student01 |
| Group | StudentGroup |
| User added to Group | Yes |
| Permission Set | ReadOnlyAccess |
| Permission assigned | Yes |
| User login verification | Yes |

## Conclusion

Successfully created an AWS account and configured IAM Identity Center. Created a user and group, added the user to the group, created a predefined permission set and assigned the permissions to the AWS account. Finally, logged in through the AWS access portal and verified the assigned permissions.

## Important Points for the Practical

1. **IAM Identity Center vs IAM:** IAM Identity Center manages workforce users and their access to AWS accounts. It is different from traditional IAM users.
2. **User:** Represents an individual who needs access to AWS.
3. **Group:** Contains multiple users and simplifies permission management.
4. **Permission Set:** Defines what actions a user or group can perform.
5. **AWS Account:** The account to which the permissions are assigned.
6. **Access Portal:** Allows users to sign in and access their assigned AWS accounts.

## Practical 7A – Case Study on Amazon Web Services (AWS)

To study Amazon Web Services (AWS) and its cloud computing services.

## 2. Theory
AWS is a cloud computing platform provided by Amazon. It offers services such as servers, storage, databases, networking and security over the Internet.

## 3. Major Services
1. EC2: Provides virtual servers.
2. S3: Stores files and objects online.
3. RDS: Provides managed databases.
4. Lambda: Runs code without managing servers.
5. VPC: Creates private virtual networks.

## 4. Advantages
- Flexible and scalable.
- Pay-as-you-use pricing.
- Global infrastructure.
- High security.
- Wide range of cloud services.

## 5. Conclusion
AWS provides flexible, secure and scalable cloud computing services for individuals and organizations.

## Practical 7B – Case Study on Google Cloud Platform (GCP)

To study Google Cloud Platform (GCP) and its cloud computing services.

## 2. Theory
GCP is a cloud computing platform provided by Google. It offers services such as computing, storage, databases, networking and machine learning over the Internet.

### 3. Major Services
1. Compute Engine: Creates and manages virtual machines.
2. Cloud Storage: Stores files and data online.
3. Cloud SQL: Provides managed databases.
4. BigQuery: Analyzes large datasets.
5. Google Kubernetes Engine: Manages containerized applications.

### 4. Advantages
- Scalable and flexible.
- Pay-as-you-use pricing.
- High availability.
- Strong security.
- Supports AI and machine learning.

### 5. Conclusion
GCP provides reliable and scalable cloud services for businesses, developers and organizations.

---

## Repository Structure

The original source materials are organized into folders by practical. This README brings the practical instructions together in one place for easier reading and navigation.

## Completion

This journal contains the practical material supplied for Practicals 1–6 and both Practical 7 case studies (AWS and GCP).
