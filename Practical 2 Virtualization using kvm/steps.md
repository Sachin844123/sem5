# Practical 2 - Virtualization using kvm

### 1 - detailed information about the CPU (Central Processing Unit) installed in your system.
``` 
  lscpu
```

### 2 
```
  egrep -c '(vmx|svm)' /proc/cpuinfo
```
 - output agar > 0 hai to virtualization hoga else ghar jao

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
  - if it is not active => active it
    ```
      sudo systemctl enable libvirtd.service
      sudo systemctl start libvirtd.service
    ```

###  (optional agar aage ka work nhi kiya to) 
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

ho gaya 
