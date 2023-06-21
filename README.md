# hospitalplanner-inf
Repository to host infrastructure for hospitalplanner

# Structure

- modules/: different reusable terraform modules of the project
    -apigateway
    -buckets
    -database
    -lambdas
- environments/: environment directories where terraform is initialized:
    -dev
    -prod

# Instructions to deploy

1. Install terraform from https://www.terraform.io/.

2. Go in your terminal to the environment you want to work in and run

```bash
terraform init
```
NOTE: This command initializes the terraform project, which syncronizes the backend with the corresponding S3 bucket. Therefore, in order to do so, you will need to have awscli configured to communicate with aws.

Furthermore, aws sso login doesn't work with Terraform, so you need to click on programatic access on the AWS start page, and export the credentials as suggested to your console.


3. Set up credentials file for the terraform user. In the root of the repo (or anywhere you want), create a credentials.env with the following structure:

```
export TF_VAR_AWS_ACCESS_KEY=XXXX
export TF_VAR_AWS_SECRET_KEY=YYYYYYYYY
export TF_VAR_SUPABASE_ANON_KEY=ZZZZZZZZZZZZZ
```

and source it:

```bash
source credentials.env
```

4. Run terraform plan to debug and see the effect of your plan in the cloud, with respect to previous state. For example, for dev, go to the dev directory and run

```bash
hospitalplanner-inf/environments/dev$ terraform plan
```

**WARNING:** Watch out to apply changes because they do deploy the defined infrastructure on the cloud.