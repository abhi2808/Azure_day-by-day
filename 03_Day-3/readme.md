# Stroage Services
-> durability: 99.9....9(11 9's), performance, security

managed using storage account, view in storage browser: 
- containers/blob(like s3): unstructured data, cheap, static website hosting
- file shares(like EFS/EBS): shared files/volumes, backup-policy, can generate a script wich run would connect vm to shared resource
- table(no direct match): No SQL, semi structured
- queue(like SQS): messaging queue

can manage encryption, data protection, access etc


# CLI
az login, for commands refer documentation


# ARM templates
what you create using a service is a resource created by azure resource manager(has APIs)(as per your configs)(for all i.e. ui, bicep, sdk and cli). Standardizes the creation.

ARN provide templates in json which can create resources.(can use documentation or extension for syntax help)(but ARM tools extension has been depricated by microsoft, Bicep is the recommended IAC tool)  

has variables, resource and output sections similar to terraform


# IAM

Authentication(valid, can access)(users and groups), Authorization(What can you access)(roles)
IAM is implemented by Microsoft Entra Id(earlier azure active directory).

created new user, by default no access(roles need to be assigned, premade or custom(need entra id premium p1 and p2))

multiple users same role=> create group->add users-> give roles to the group itself

if resoure wants to communicate with another resource-> service principals and managed identities(in both cases service principles are only created, in service principals you need to manage the rotation and security of keys, MI is azure managed)

**System managed MI**
- created automatically
- lifecycle tied to resorce
- cannot be shared(one-on-one)

**User-assigned MI**
- created as stand alone resource
- lifecycle independent
- can be shared across resources


# Activity

Say your VM wants to communicate with a blob storage:

- VM->security->identity->system assigned managed identities(status:on)

- storage acc->iam->add role assignment->select role and members 