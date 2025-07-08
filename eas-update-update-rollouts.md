# EAS Update - Update Rollouts

## Roll out on branch with existing updates

When there are updates on a branch with the same runtime and platform, a rollout update works by automatically selecting the existing latest update and setting it as the "control update". Then, EAS Update serves the control update or rollout update to X percentage of your users.

### Reverting

Reverting in this case means:
1. Deleting the rollout update so that no users receive it any more.
2. Re-publishing the control update so that users that previously receieved the rollout update are set back to the control update.

## Roll out on empty branch

When there are no updates on a branch with the same runtime and platform, a rollout update works serving no update or the rollout update to X percentage of your users.

### Reverting

Reverting in this case is more complex since there's no control update to republish. EAS Update approximates this using a roll-back-to-embedded update which works for most cases, but in rare instances depending on the state of your app this may not be the perfect approximation of a revert.

A contrived example of when this wouldn't work:
1. Have a channel prod and branch prod.
1. Publish an update on branch prod. It is downloaded by a bunch of devices.
1. Delete that update. Branch is now empty.
1. Publish a rollout of an update, the "first" update on the branch.
1. I want to revert this rollout. Doing a roll-back-to-embedded will revert all the people on the initial update back to the embedded instead of rolling them back to what the state was before the rollout.

In the contrived example above, deleting the rollout update and issuing a new normal publish (not a rollout) would be the better solution to simulate a revert.