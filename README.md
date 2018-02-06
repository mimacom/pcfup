# pcfup

[![Travis](https://img.shields.io/travis/mimacom/pcfup.svg?style=for-the-badge)](https://travis-ci.org/mimacom/pcfup)
[![GitHub tag](https://img.shields.io/github/tag/mimacom/pcfup.svg?style=for-the-badge)](https://github.com/mimacom/pcfup)

In case your Pivotal Cloud Foundry is not fully automated, an upgrade can be a lot of work.
Especially if in your production environment Internet is not easily accessible, it is a lot of work to download the products, upload them in the Operations Manager and stage them.
Afterwards, you will figure out that you need to do the same for the necessary stemcell.

pcfup is trying to solve some of those issues.
It is downloading products with the related stemcells to a local folder, figure out if you already installed the correct stemcell and upload it to the operations manager.
In case you have no internet access, it is generating a local cache and you can reuse the cache for further uploads.
An offline preparation environment is planned, but not fully implemented yet.

The suggested place to install this tool is the Operations Manager.
From there you have the fastest access to the Operations Manager.

## Preparation

For the usage it is required to either use a couple of arguments for authentication against the Operations Manager or just set the following environment variables:

```bash
export OM_TARGET="https://172.18.147.1/"
export OM_USERNAME="admin"
export OM_PASSWORD="secretPassword"
export PIVNET_TOKEN="yourSecretPivnetToken"
```

The credentials of the Operations Manager are the same as you are using for accessing the webinterface.
The pivnet token you can request in your user profile in the [Pivotal Network](https://network.pivotal.io/)

## Quick Start

For start using pivnet, you only need to download the bash script `pcfup` and make it executable.
Afterwards you can use `pcfup` to download all required tools or do it manually like described below.

### Download

You can either download it manually or use wget as described below:

```bash
wget -Opcfup https://raw.githubusercontent.com/mimacom/pcfup/master/pcfup
chmod +x pcfup
```

Afterwards, just move pcfup to your path or call it with `./pcfup`.

### Install Required Tools

For installation of the required tools you can also use pcfup.
Therefore you can use the command `pcfup download-tools` which will download all necessary tools for you.

If you don't have internet access, download and install the following products:

- [OM](https://github.com/pivotal-cf/om/)
- [PivNet CLI](https://github.com/pivotal-cf/pivnet-cli/)
- [JQ](https://github.com/stedolan/jq/)

## Download and Install a Product

tbd

`pcfup product <product> <version>`


## Download and Install a Stemcell

tbd
