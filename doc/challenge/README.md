# Mamo Pay - Backend Challenge

## Introduction

This test is a part of our hiring process at Mamo Pay for backend positions. It should take you between 2 and 4 hours depending on your experience. 

Hope you will have fun doing the test.

## Summary

The purpose of the test is to reproduce one Mamo Pay feature: send and receive money between accounts.

You will have to design an API for the frontend to interact with the backend for making transactions.

Here is the story:

- An account can have either "pending", "verified", or "unverified" status.
- Only "verified" accounts can send or receive money.
- Other types of accounts when sending / receiving money, the API should return a 403 status code.
- Sending money from one account to another would mean that the money will be deducted from the sender and deposited to the receiver.

## Instructions

### Code

In the repository, you will find a Ruby on Rails application with only one single model: Account. It represents a specific account in Mamo Pay.

In order to implement the feature, you will have to extend the repository and add your logic on top of it.

Please keep the following points in mind:

- You only need to add logic / models / endpoints related to the above story.
- You can add all the models you need or extend the existing ones;
- You can add/modify as many gems as you want or change the Ruby version;
- Make your code as clear as possible, it should be understandable at a first glance (comments are more than welcome);
- Make sure that all of your APIs are well-documented, OpenAPI specification is preferred.
- Tests are more than welcome;
- Dockerizing your application will be a huge plus;

### Use Case

The use case we want to reproduce is the following:

- A verified user can send money to any verified account in the system.
- Users should be able to send their money by "email" or "phone number"
- Users should be able to see their transaction history, this includes inbound / outbound transactions.

### Main steps

Here are some steps to help you start:

- Fork and clone the repository
- Setup your development environment
- Add your own logic
- Submit the PR
