Feature: Edited report only submission
  Partners, redhat and community users attempt to publish their chart by submitting
  report that was edited afyter it was generated by chart-verifier.

  Examples:
  | vendor_type  | vendor    | report_path               |
  | partners     | hashicorp | tests/data/report.yaml    |
  | redhat       | redhat    | tests/data/report.yaml    |

  Scenario Outline: A partner or redhat associate submits an edited report
    Given the vendor <vendor> has a valid identity as <vendor_type>
    And a <report_path> is provided
    And the report includes <tested> and <supported> OpenshiftVersion values and chart <kubeversion> value
    When the user sends a pull request with the report
    Then the pull request is not merged
    And user gets the <message> in the pull request comment

    Examples:
      | tested | supported | kubeversion | message                                   |
      | 4.9    | 4.6-4.9   | >=1.20.0    | is not a valid semantic version           |
      | 4.0    | >=4.7     | >=1.20.0    | is not a supported OpenShift version      |
      | 4.6    | >=4.7     | >=1.20.0    | not within specified kube-versions        |
      | 4.8    | >=4.7     | >=1.21.0    | does not match supportedOpenShiftVersions |