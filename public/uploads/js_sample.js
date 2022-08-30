const { Client, GatewayIntentBits, Partials, ActivityType } = require("discord.js");
const fs = require("fs");
require("dotenv").config();

const mySecret = process.env['TOKEN'] // I DON'T want to see this on Mindbase
const { setCommands } = require("./commands/help.js")
const { prefix } = require("./config.js");


const commands = {}; // $ I DO want to see this on Mindbase

const client = new Client(
  {
    intents: [ //$DO
      GatewayIntentBits.Guilds,//DON'T
      GatewayIntentBits.GuildMessages,
      GatewayIntentBits.MessageContent,
      GatewayIntentBits.GuildMembers,
    ],
    partials: [                    //       $DO
      Partials.Message,            //       DON'T
      Partials.User,
      Partials.Channel,
      Partials.GuildMember
    ]
  });
// load commands
const commandFiles = fs.readdirSync("./commands").filter(file => file.endsWith(".js"));

for (const file of commandFiles) {
  const command = require(`./commands/${file}`);
  commands[command.name] = command;
}
// $DO (no code)
setCommands(commands)
// DON'T (no code)
// login bot
client.on("ready", () => {
  console.log(`Logged in as ${client.user.tag}`);

  client.user.setActivity('Dimensions', {
    type: ActivityType.Listening // $$$$ DO
  }) // DON'T
});

client.on("message", message => { // $     DO
  console.log(message)
  if(!message.content.startsWith(prefix) || message.author.bot) return;

  const args = message.content.slice(prefix.length).trim().split(/ +/);
  const command = args.shift().toLowerCase();

  let cmd = commands[command]; //        DON'T
  if(cmd)
    cmd.execute(message, args)
});

client.login(mySecret); // $ LAST comment to be added to Mindbase
