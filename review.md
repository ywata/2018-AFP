---
title: Assigments -- Peer review
layout: default
---

# Procedure for peer review

In this course each assignment is reviewed by two other colleagues. This implies
that you need to review two assignments each week. To arrange this we are going
to use the *pull requests* feature from GitHub. This pull request is where the reviewers place their comments.

### Owner of the repo

Each student should create a *pull request* from the `empty` branch into its
`master` branch. These are the steps to do so:

1. Go to your repo.
2. Click the *New pull request* button.
3. In the next screen, select `empty` as your *base* branch, and `master` as
   your *compare* branch.
4. Give it name similar to "Review".

### Reviewers

Each reviewer should place his or her comments in that pull request. To find
it, go to the repo you need to review, click on the *Pull requests* tab.
There should be only one, click on it to go the comment screen.

We expect you to do two kinds of reviewing:

1. General comments about the design and implementation, which should be
   in the *Conversation* tab.

2. An in-depth review of the code. To do this, go to the *Files changed* tab
   and select the *Unified* view. You can place a comment in one line by
   clicking on the small plus sign which appears when you place your mouse
   over the line number.

Owners of the repo can reply to those comments, and engage in conversation.

Once your review is finished, send an e-mail to `w.s.swierstra@uu.nl` **and**
`a.serranomena@uu.nl` with the grades of the two colleagues you reviewed.

### How to do a good review

The main rule is to be **constructive**. This means that for every issue you
find:

1. Be *clear* about which is the problem;
2. Explain or point to a possible *solution*. It is better to suggest
   *improvements* to the current code than a whole new approach;
3. *Distinguish* clearly between "I would have done this differently" from
   "this is wrong or this does not work";
4. Raise *questions* about unclear parts.

Needless to say, be **respectful** about your colleagues' work.