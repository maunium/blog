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
work as expected and you might just find yourself in a situation where you can't
get GRUB to work.

1. Boot into a live environment
2. Mount your root partition into `/mnt`: `sudo mount /dev/sdXY /mnt`
   where X is the number of the disk (1, 2, 3...) and Y is the letter of the partition
	 (a, b, c...)

	 Your root partition is generally by far the largest partition. You can use a
	 tool like `lsblk` or GParted to figure out the sizes of partitions.
2. Check if there are any files in `/mnt/boot`. If you can find files such as
   `initrd.img`
3. Mount your boot partition into `/mnt/boot`: `sudo mount /dev/sdXZ /mnt`

	 Your boot partition is generally found on the same disk as your root partition.

	 If `/mnt/boot` contains more than one or two files after step 2, it's likely
	 that you don't have a separate boot partition.
