final readPullRequestsQuery = """
  query (\$username: String!, \$index: Int!) {
    user(login: \$username) {
      pullRequests(
        first: \$index,
        states: [CLOSED, MERGED, OPEN],
        orderBy: {
          field: UPDATED_AT,
          direction: DESC
        }
      ) {
        nodes {
          state,
          title,
          repository {
            nameWithOwner
          },
        }
      }
    }
  }
"""
    .replaceAll('\n', ' ');
