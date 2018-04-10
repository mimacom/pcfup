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
```

The credentials of the Operations Manager are the same as you are using for accessing the webinterface.

## Quick Start

For start using pivnet, you need to download this repository and execute the bash script `pcfup`.
Afterwards you can use `pcfup` to download all required tools or do it manually like described below.
Another option is to download the repository and execute `create-bundled-pcfup.sh`.
The result will be the script `pcfup-bundle` which includes everything what you need. 
It is recommended to move the `pcfup-bundle` to your bin folder and call it `pcfup`.

### Dependencies

The following software should be installed to use `pcfup`:

* ruby

### Installation

For the setup there is a small preparation script which is combining this repository to an executable.
Aftewards you can move the executable to a location in your PATH and run it.
A sample how it can look like is the following:

```bash
# download this repository to a local folder
git clone https://github.com/mimacom/pcfup.git

# create the bundle
cd pcfup
./create-bundled-pcfup.sh

# copy the bundle to a location in the PATH and make it executable 
mv pcfup-bundle /usr/local/bin/pcfup
chmod +x /usr/local/bin/pcfup

# run pcfup help
pcfup help
```

### Install Required Tools

For installation of the required tools you can also use pcfup.
Therefore you can use the command `pcfup download-tools` which will download all necessary tools for you.

If you don't have internet access, download and install the following products:

- [OM](https://github.com/pivotal-cf/om/)
- [PivNet CLI](https://github.com/pivotal-cf/pivnet-cli/)
- [JQ](https://github.com/stedolan/jq/)

## Login to Pivotal Network

For the login to the pivotal network you need a token from the [Pivotal Network](https://network.pivotal.io/).
There you can go to the profile and request a token (the deprecated token).
Afterwards you can use the `pcfup` cli to login:

```bash
pcfup pivnet-login <pivnet-auth-token>
```

## Download and Install a Product

If you know the name and the version of a product, you can easily install it with the following command:

```bash
pcfup product <product> <version>
```

Otherwise there are two options to figure out the name of the product.
First of all, you can go to the [PivNet](https://network.pivotal.io/) and select the product there.
The name of the product is also in the URL.
You can select the specific versions and just pick one.
`pcfup` expects the full version, a prefix matching is not implemented yet.

Another possibility is to use `pcfup` to figure out which products are currently installed.
Therefore you can use the command `pcfup installed-products`.

After figuring out the correct product, you can figure out which versions are available in the PivNet by using the following command:

```bash
pcfup available-product-versions <product>
```

### Configuration and Stemcell

During the installation `pcfup` will automatically figure out if there is a new stemcell necessary.
In that case `pcfup` downloads the stemcell automatically and installs it to your PCF installation.

In case the new product needs configuration, you need to go to the Ops Manager manually.

## Download and Install a Stemcell

In case you upgrade for example the Operations Manager, you might get requested to install several new stemcells.
For that pcfup has the `stemcell` command. You need to specify the full version of the stemcell there:

```bash
pcfup stemcell <version>
```

The stemcell is only downloaded and installed if it is not already installed for your Operations Manager

## Further Commands

Execute `pcfup help` to see information about all commands.
Alternatively, you can have a look to the [commands](commands) folder inside this repository.