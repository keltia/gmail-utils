# GMail::Utils

GmVault is a small utility to backup all or parts of a given GMail mailbox.  It generates
a set of directories organized by date (YYYY-MM/*).  Each folder has two files per mail, one
.eml containing the actual mail (headers and body) and a .meta containing all GMail metadata
(id of the mail, date sent, subject, thread ID for a given conversation and so on).

This gem is composed of a library (GMail::Utils) and the corresponding script to transform that
backup into a proper Maildir-formatted mailbox.  The script takes a tag as main argument and
will take only mails matching the given tag.

## Installation

Add this line to your application's Gemfile:

    gem 'gmail-utils'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gmail-utils

## Usage

    tag2maildir [-h] [-b DIR] -t TAG DIR

    -t TAG      Use the following tag +TAG+ to filter the mails
    -b DIR      Use the given directory as base dir to create the mailbox (defaults to +~/Maildir+)
    DIR         Use the following path to the gmvault directory

    $Id: README.md,v af7380ec209e 2012/09/24 22:14:17 roberto $
