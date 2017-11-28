name 'aws-ssm'
maintainer 'Peter Green'
maintainer_email 'peter.green@aztek-native.com'
license 'All Rights Reserved'
description 'Provides custom resources for interacting with AWS Simple Systems Manager (SSM).'
long_description 'Inteded to provide access to AWS SSM, however it only currently supports Parameter Service.'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

gem 'aws-sdk', '~> 3.0.1'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/aws-ssm/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/aws-ssm'
