
# Practical 6 – AWS Account Creation and IAM Identity Center

**Aim:** To create an AWS account, use AWS IAM Identity Center to create users and groups, and assign specific permissions to a user through a permission set.

**Services used:**
1. Amazon Web Services (AWS)
2. AWS IAM Identity Center (formerly AWS Single Sign-On)
3. AWS Free Tier

---

## Part 1: Create an AWS Account

**Step 1:** Open the official AWS website:

https://aws.amazon.com/

**Step 2:** Click on **Create an AWS Account**.

**Step 3:** Enter the required details:
- Email address
- AWS account name
- Password

**Step 4:** Verify your email address using the OTP sent by AWS.

**Step 5:** Enter your contact information:
- Full name
- Phone number
- Country
- Address

**Step 6: Payment verification using UPI**

- Select the UPI payment option, if offered.
- Enter your UPI ID.
- Approve the payment verification request in your UPI application.
- Complete any additional verification requested by AWS.

> **Important:** AWS may require payment verification or a temporary authorization. UPI availability and the verification process can vary. AWS Free Tier does not mean every service or usage is free.

**Step 7:** Complete phone verification.

**Step 8:** Select the Basic Support plan (Free).

**Step 9:** Complete the registration process.

Your AWS account will be created successfully.

## Part 2: Turn Off UPI AutoPay

If you approved a recurring UPI mandate during registration, you can manage it through your UPI application.

1. Open your UPI application (Google Pay, PhonePe, Paytm, etc.).
2. Navigate to **Autopay / UPI Mandates**.
3. Find the AWS-related mandate.
4. Open the mandate details.
5. Select **Cancel / Revoke**.
6. Confirm cancellation.

> **Important:** Cancelling a UPI mandate does not cancel your AWS account. Make sure you understand any outstanding AWS charges. Do not assume the mandate is active unless you can see it in your UPI app.

---

## Part 3: Login to AWS Management Console

**Step 1:** Open:

https://console.aws.amazon.com/

**Step 2:** Select **Root user**.

**Step 3:** Enter the email address used during AWS account registration.

**Step 4:** Enter your password and sign in.

You will now see the AWS Management Console dashboard.

## Part 4: Open IAM Identity Center

**Step 1:** In the AWS Console search bar, search for `IAM Identity Center`.

**Step 2:** Click on **IAM Identity Center**.

**Step 3:** Open the service dashboard.

**Step 4:** If prompted, enable IAM Identity Center.

- Choose the AWS Organizations option if asked to select an identity source.
- Use the default identity source (Identity Center directory) for this practical.
- Complete the setup.

You can now manage users, groups, permission sets and AWS account access.

## Part 5: Create a User

**Step 1:** From the left navigation panel, select **Users**.

**Step 2:** Click **Add user**.

**Step 3:** Fill in the following details:

| Field | Example |
|---|---|
| Username | student01 |
| Email address | student@gmail.com |
| First name | Student |
| Last name | One |

**Step 4:** Under password settings, select the option to send an email to the user with instructions to set up their password, if available.

**Step 5:** Click **Next**.

**Step 6:** Skip adding the user to a group for now, if you want to perform that step separately.

**Step 7:** Review the details and click **Add user**.

Your user is successfully created.

## Part 6: Create a Group

**Step 1:** In the left navigation panel, click **Groups**.

**Step 2:** Click **Create group**.

**Step 3:** Enter the group details.

- Group name: `StudentGroup`
- Description: `Group for AWS practical users`

**Step 4:** Click **Create group**.

Your group is successfully created.

## Part 7: Add the User to the Group

**Step 1:** Open the newly created `StudentGroup`.

**Step 2:** Find the **Add users** option.

**Step 3:** Search for the user `student01`.

**Step 4:** Select the checkbox beside the username.

**Step 5:** Click **Add users**.

The user is now a member of the group.

## Part 8: Create a Permission Set

A **Permission Set** is a collection of permissions that determines which AWS resources a user can access and what actions they can perform.

**Step 1:** In the left navigation panel, under **Multi-account permissions**, click **Permission sets**.

**Step 2:** Click **Create permission set**.

**Step 3:** Select **Predefined permission set**.

**Step 4:** Select a permission set type and choose the required permission.

| Permission | Purpose |
|---|---|
| AdministratorAccess | Full administrative access |
| ReadOnlyAccess | View AWS resources without modifying them |
| PowerUserAccess | Access to AWS services without full IAM administration |

For this practical, you can select `ReadOnlyAccess`.

**Step 5:** Click **Next**.

**Step 6:** Configure the permission set details, such as session duration.

**Step 7:** Click **Next** and then **Create**.

Your permission set is successfully created.

> **Note:** Choose permissions carefully. AdministratorAccess provides extensive control over the AWS account.

## Part 9: Assign Permission to the User or Group

**Step 1:** From the left navigation panel, click **AWS accounts**.

**Step 2:** Select your AWS account by clicking the checkbox.

**Step 3:** Click **Assign users or groups**.

**Step 4:** Under the Users tab, select `student01`.

Alternatively, you can select the Groups tab and select `StudentGroup`.

**Step 5:** Click **Next**.

**Step 6:** Select the permission set you created, such as `ReadOnlyAccess`.

**Step 7:** Click **Next**.

**Step 8:** Review the selected user/group and permission set.

**Step 9:** Click **Submit**.

Your permission set is now assigned to the selected user or group for the selected AWS account.

## Part 10: Login as the Created User and Verify Permissions

**Step 1:** Open the email inbox of the user you created.

**Step 2:** Find the invitation email sent by AWS IAM Identity Center.

**Step 3:** Open the email and follow the instructions to set up the user's password.

**Step 4:** Open the AWS access portal URL provided in the email.

**Step 5:** Sign in using:
- Username: `student01`
- Password: The password created during setup.

**Step 6:** After successful login, you will see the AWS account assigned to the user.

**Step 7:** Click on the AWS account.

**Step 8:** You will see the permission set assigned to that user, for example `ReadOnlyAccess`.

**Step 9:** Click the permission set to access the AWS Management Console.

**Step 10:** Verify the permissions by opening an AWS service. With `ReadOnlyAccess`, you can view resources but cannot perform actions that modify them.

---

## Expected Result

The following resources have been created successfully:

| Component | Created |
|---|---|
| AWS Account | Yes |
| IAM Identity Center User | student01 |
| Group | StudentGroup |
| User added to Group | Yes |
| Permission Set | ReadOnlyAccess |
| Permission assigned | Yes |
| User login verification | Yes |

## Conclusion

Successfully created an AWS account and configured IAM Identity Center. Created a user and group, added the user to the group, created a predefined permission set and assigned the permissions to the AWS account. Finally, logged in through the AWS access portal and verified the assigned permissions.

## Important Points for the Practical

1. **IAM Identity Center vs IAM:** IAM Identity Center manages workforce users and their access to AWS accounts. It is different from traditional IAM users.
2. **User:** Represents an individual who needs access to AWS.
3. **Group:** Contains multiple users and simplifies permission management.
4. **Permission Set:** Defines what actions a user or group can perform.
5. **AWS Account:** The account to which the permissions are assigned.
6. **Access Portal:** Allows users to sign in and access their assigned AWS accounts.

