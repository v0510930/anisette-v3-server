import core.time;
import core.memory;


import std.algorithm.searching;
import std.array;
import std.base64;
import std.digest;
import file = std.file;
import std.format;
import std.getopt;
import std.json;
import std.math;
import std.net.curl;
import std.parallelism;
import process = std.process;
import std.path;
import std.uni;
import std.uuid;
import std.zip;


import vibe.core.core;
import vibe.http.websockets;
import vibe.http.server;
import vibe.http.router;
import vibe.stream.tls;
import vibe.web.web;


import slf4d;
import slf4d: Logger;
import slf4d.default_provider;


import provision;
import provision.androidlibrary;


__gshared string libraryPath;
__gshared string provisioningPath;


enum brandingCode = format!"anisette-v3-server v%s"(provisionVersion);
	enum clientInfo = "<PC> <Windows;6.2(0,0);9200> <com.apple.AuthKit/1 (com.apple.iTunes/12.12.4.1)>";
enum dsId = -2;


__gshared ADI v1Adi;
__gshared Device v1Device;


__gshared Duration timeout;


int main(string[] args) {
	debug {
		configureLoggingProvider(new shared DefaultProvider(true, Levels.DEBUG));
	} else {
		configureLoggingProvider(new shared DefaultProvider(true, Levels.INFO));
	}
