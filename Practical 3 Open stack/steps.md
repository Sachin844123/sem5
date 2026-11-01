### Step 1: Update Ubuntu
```
  sudo apt update
  sudo apt upgrade -y
```
 - upgrade nhi bhi kiya to chalega 

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


##### ho gaya 
