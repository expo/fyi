# Understanding Rollouts

Let's consider an example scenario for a better grasp on the possible issues that might pop up during rollouts:

- Your channel is mapped to Branch A, with Update A published to it.
- You have another branch, Branch B with Update B published to it.
- After creating a rollout on your channel, a percentage of your users will be rolled out to Branch B and receive Update B. The rest of your users will remain on Branch A and receive Update A.

## Common problems

### Compatible runtime

Your rollout targets a compatible build. This means Update A and Update B must be of the same runtime. You can double-check your published updates and their runtimes by selecting a branch on the [Branches page](https://expo.dev/accounts/[account]/projects/[project]/branches) of the website.

### Latest update

If you want your users to receive Update B, it must be the latest update published to Branch B.
