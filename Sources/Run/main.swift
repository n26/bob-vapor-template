import Vapor
import Bob
import BobCustomCommands

// https://api.slack.com/apps
let config = Bob.Configuration(slackToken: "your-slack-token")

let drop = try Droplet()
let bob = Bob(config: config, droplet: drop)

// Register a custom command defined in the `Commands` target.
try bob.register(BonjourCommand())

// Configure and register the built in BumpCommand
let githubUser = "<username>"
let githubRepo = "<repo>"
let personalAccessToken = "<token>"
let github = GitHub(config: .init(username: githubUser,
                                  personalAccessToken: personalAccessToken,
                                  repoUrl: "https://api.github.com/repos/\(githubUser)/\(githubRepo)"),
                    droplet: drop)

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
