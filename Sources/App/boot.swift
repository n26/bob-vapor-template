import Vapor
import Bob

/// Called after your application has initialized.
public func boot(_ app: Application) throws {
    // Your code here
    // https://api.slack.com/apps
    let config = Bob.Configuration(slackToken: "<slack-token>")

    let bob = Bob(config: config, app: app)

    // Register a custom command defined in the `Commands` target.
    try bob.register(BonjourCommand())

    try bob.register(UUIDCommand(container: app))

    // Configure and register the built in BumpCommand
    let githubUser = "<username>"
    let githubRepo = "<repo>"
    let personalAccessToken = "<token>"
    let github = GitHub(config: .init(username: githubUser,
                                      personalAccessToken: personalAccessToken,
                                      repoUrl: "https://api.github.com/repos/\(githubUser)/\(githubRepo)"),
                        container: app)

    // A list of files to bump the version
    let plistPaths: [String] = [
        "App/Info.plist",
        "siriKit/Info.plist",
        "siriKitUI/Info.plist"
    ]
    let author = Author(name: "<commit user name>", email: "<commit email>")


    // Configure and register the built in BumpCommand
    try bob.register(BumpCommand(gitHub: github, plistPaths: plistPaths, author: author))


    // configure and register the AlignVersionCommand
    try bob.register(AlignVersionCommand(gitHub: github, plistPaths: plistPaths, author: author))

    try bob.start()
}
