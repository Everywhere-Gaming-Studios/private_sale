const Coin = artifacts.require("Coin");
let Token = artifacts.require("Token");
const Invest = artifacts.require("Invest");
var fs = require('fs');
var filename = 'deployment.json';

module.exports = async function (deployer) {
  await deployer.deploy(Coin).then(async () => {
    var file_content = fs.readFileSync(filename);
    var content = JSON.parse(file_content);
    content.Coin = Token.address;
    fs.writeFile(filename, JSON.stringify(content), () => { });
    await deployer.deploy(Invest, Coin.address, "25", "10", "12", "15").then(async () => {
      var file_content = fs.readFileSync(filename);
      var content = JSON.parse(file_content);
      content.Invest = Token.address;
      fs.writeFile(filename, JSON.stringify(content), () => { });
      await deployer.deploy(Token, Invest.address, "Cosmic loot box token").then(async () => {
        var file_content = fs.readFileSync(filename);
        var content = JSON.parse(file_content);
        content.Cosmic = Token.address;
        fs.writeFile(filename, JSON.stringify(content), () => { });
      });
      await deployer.deploy(Token, Invest.address, "Rare loot box token").then(async () => {
        var file_content = fs.readFileSync(filename);
        var content = JSON.parse(file_content);
        content.Rare = Token.address;
        fs.writeFile(filename, JSON.stringify(content), () => { });
      });
      await deployer.deploy(Token, Invest.address, "Legengary loot box token").then(async () => {
        var file_content = fs.readFileSync(filename);
        var content = JSON.parse(file_content);
        content.Legengary = Token.address;
        fs.writeFile(filename, JSON.stringify(content), () => { });
      });
      await deployer.deploy(Token, Invest.address, "Epic loot box token").then(async () => {
        var file_content = fs.readFileSync(filename);
        var content = JSON.parse(file_content);
        content.Epic = Token.address;
        fs.writeFile(filename, JSON.stringify(content), () => { });
      });
    });
  });
};
