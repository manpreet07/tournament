-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

/* Drop Tables */
DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament
DROP VIEW IF EXISTS standings;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS players;

-- player registered for tournament
create table players(
playerId serial,
playerFullName varchar(20),
PRIMARY KEY(playerId)
);

-- Records the outcome of the single match between players
create table matches(
matchId serial,
winner 	serial references players(playerId) on delete cascade,
loser	serial references players(playerId) on delete cascade,
draw	boolean,
PRIMARY KEY(matchId)
);

-- view that returns players standings
create view standings as
select playerId, playerFullName, count(a.winner) as wins, (count(b.matchid) + count(a.matchid)) as matches from players
Left join matches a on a.winner = players.playerId
Left join matches b on b.loser = players.playerId
group by playerId, playerfullname
order by wins desc;



