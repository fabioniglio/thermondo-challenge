# Salesforce Senior Coding Challenge

We appreciate you taking the time to participate and submit a coding challenge! 🥳

In the next step we would like you to implement a simple Invocable Apex Action to be used by your Admin colleagues for a Flow. They need to do HTTP callouts to a NPS Service, whenever an Order got fulfilled. Below you will find a list of tasks and optional bonus points required for completing the challenge.

**🚀 This is a template repo, just use the green button to create your own copy and get started!**

### Invocable:

* accepts the Order Record Ids as Input Parameter
* queries the required records to get the Bill To E-Mail Address (`Contact.Email`) and OrderNumber (`Order.OrderNumber`)
* sends the data to the NPS API
* add a basic Flow, that executes your Action whenever an Order Status is changed to `Fulfilled`

### The Mock NPS API:

* Hosted at https://salesforce-coding-challenge.herokuapp.com
* ✨[API Documentation](https://thermondo.github.io/salesforce-coding-challenge/)
* 🔐 uses HTTP Basic Auth, username: `tmondo`, password: `Noy84LRpYvMZuETB`

### ⚠️ Must Haves:

* [X] use `sfdx` and `git`, commit all code and metadata needed (so we can test with a scratch org)
* [X] write good meaningful unit tests
* [X] properly separate concerns
* [ ] make a list of limitations/possible problems

### ✨ Bonus Points:

* [ ] layer your Code (use [apex-common](https://github.com/apex-enterprise-patterns/fflib-apex-common) if you like)
* [ ] use Inversion of Control to write true unit tests and not integration tests
* [ ] make sure customers don't get duplicate emails
* [X] think of error handling and return them to the Flow for the Admins to handle

### What if I don't finish?

Finishing these tasks should take about 2-3 hours, but we are all about **'quality > speed'**, so it's better to deliver a clean MVP and leave some TODOs open.

Try to produce something that is at least minimally functional. Part of the exercise is to see what you prioritize first when you have a limited amount of time. For any unfinished tasks, please do add `TODO` comments to your code with a short explanation. You will be given an opportunity later to go into more detail and explain how you would go about finishing those tasks.


# Possible limitations

1. Governor Limits: Salesforce imposes strict governor limits on Apex callouts. These include limits on the total number of callouts in a single transaction, the maximum cumulative timeout for all callouts in a transaction, and the maximum size of request and response bodies.

2. Synchronous vs. Asynchronous Execution: Apex callouts in a flow are synchronous by default, which means the flow will wait for the callout to complete before proceeding. This can impact the user experience if the callout takes a long time. Asynchronous callouts can be made using future methods or queueable Apex, but these come with their own set of limitations.

3. Error Handling: It’s important to implement robust error handling in your Apex code to manage timeouts, HTTP status codes, and other exceptions that may occur during a callout.

4. Authentication and Session Management: Depending on the external service you're interacting with, you may need to handle authentication. This can involve managing session tokens, OAuth, or other authentication mechanisms, which can add complexity to your Apex code.

5. Complexity in Debugging: Debugging issues with API callouts can be more complex compared to other Apex code, especially when dealing with external systems where you have limited visibility.

6. Test Coverage: Apex code that includes callouts requires mock responses for unit testing. Salesforce doesn’t allow actual callouts in test methods, so you need to use mock callouts, adding an extra layer of complexity to your test classes.

7. Flow Context: Understanding the context in which the flow is running (e.g., user-triggered, system-triggered) is important, as it can impact the execution behavior and the user experience.

8. Data Volume and Performance: If the API callout is dealing with large volumes of data, it might impact performance and run into size limits for request and response payloads.

9. Security: Security is a significant concern with API callouts. Ensuring that the endpoints are secure and data is transferred securely (e.g., via HTTPS) is crucial.

10. API Limitations of External Service: The limitations of the external service you are calling (e.g., rate limits, data limitations) also need to be considered, as they can affect the reliability and performance of your integration.