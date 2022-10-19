# Bob's How To

First get credentials from [the portal](https://portal.exoscale.com/) under IAM.

Second put the credentials in env vars like this:

```bash
$ export TF_VAR_key=<my key>
$ export TF_VAR_secret=<my_secret>
```

Now we can use terraform like this:

```bash
$ terraform plan
```