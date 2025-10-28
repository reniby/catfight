extends Node

var numPlayers = 0
var players = [false,false,false,false]
var mode = 0
var winner = 0
var scores = [0, 0, 0, 0]

func resetGlobals():
	numPlayers = 0
	players = [false,false,false,false]
	mode = 0
	winner = 0
	scores = [0, 0, 0, 0]
