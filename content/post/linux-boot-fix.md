---
Section: post
Url: linux-grub-fix
Slug: linux-grub-fix
Title: Fixing GRUB on GNU/Linux
Description: ""
Keywords:
- GNU/Linux
- GRUB
Topics:
- Tutorial
Draft: true
date: 2016-12-30
disqus_title: Fixing GRUB on GNU/Linux
disqus_url: https://maunium.net/blog/linux-grub-fix
---

While GRUB usually works just fine, there can be cases where everything doesn't
work as expected and you might just find yourself in a situation where you
can't get GRUB to work, especially if you have more than one OS installed.

1. Boot into a live environment
2. Mount your root partition into `/mnt`: `sudo mount /dev/sdXY /mnt`
   where X is the number of the disk and Y is the lowercase letter of the
   partition.

   You can use [`lsblk`](https://linux.die.net/man/8/lsblk) or
   [`sudo fdisk -l`](https://linux.die.net/man/8/fdisk) to view what partitions are
   available.

   Your root partition is generally the largest partition (probably over
   10GB). You can use a tool like `lsblk` or GParted to figure out the sizes
   of partitions.

   If your disk is encrypted, you can use the
   [`cryptsetup`](https://linux.die.net/man/8/cryptsetup)
   command to decrypt it: `sudo cryptsetup luksOpen /dev/sdXY sdXY--crypt`.
   After decrypting, the decrypted data is available at
   `/dev/mapper/sdXY--crypt`.

   If the encrypted partition is using [LVM](https://wiki.ubuntu.com/Lvm), the
   LVM partitions will be available under `/dev/mapper` with the partition
   names provided during setup. On Ubuntu, the main partition should be
   something like `ubuntu-FLAVOR--vg_root`
3. Check if there are any files in `/mnt/boot`. If you can find files with
   names containing `initrd` or `vmlinuz`, you can skip the next step since
   you most likely don't have a separate boot partition.
4. Mount your boot partition into `/mnt/boot`: `sudo mount /dev/sdXY /mnt`. X
   (the disk number) is probably the same as in step 2, but Y (the partition
   letter) will not be the same.
5. If you have an EFI partition, mount it into `/mnt/boot/efi`:
   `sudo mount /dev/sdXY /mnt/boot/efi`.

   To determine if you have an EFI partition, simply type
   `sudo fdisk -l | grep EFI`.
   If you have an EFI partition, the first column in the output will be the
   full path to the EFI partition (i.e. what you replace `/dev/sdXY` in the
   command with)
6. Now mount the special Linux directories to `mnt`:
   ```bash
   for i in proc sys dev dev/pts run
   do
     sudo mount -o bind /$i /mnt/$i
   done
   ```
   You may replace newlines with semicolons (`;`) to write the script in one line.
