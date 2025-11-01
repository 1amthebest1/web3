2️⃣ — CrowdFunding Contract (Kickstarter Style)

People can create campaigns with funding goals and deadlines.

Others contribute ether.

When the deadline passes:

If goal met → project owner can withdraw.

If goal not met → contributors can claim refunds.

Use try/catch when sending refunds.

Emit events:

CampaignCreated(address owner, uint goal, uint deadline)

ContributionReceived(address contributor, uint amount)

GoalReached(address owner, uint total)

RefundIssued(address contributor, uint amount)

Why it’s great:
You’ll use structs, mappings, events, modifiers, try/catch, and deadlines (with block.timestamp).
