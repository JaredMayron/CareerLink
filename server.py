import re, MySQLdb
from bottle import route, run, template, static_file

tags = {}
db = MySQLdb.connect(host="localhost", user="appuser", passwd="",db="onco")
cursor = db.cursor()

resultsPerPage = 4
previousRegex = ""

@route('/')
@route('/home')
def index():
    return template('home.tpl')

@route('/profile')
def profile():
    return template('profile.tpl')
    
@route('/search')
def search():
    return template('search.tpl')
    
@route('/search/<page>/<regex:ex>')
def search(page, regex):
	args = regex.split('+')
	
	result = []
	
	if regex == previousRegex:
		start = resultsPerPage * page
		end = start + resultsPerPage
		return template('search.tpl', search=result[start:end]) 
		
	regex = previousRegex
	for arg in args:
		if arg in tags:
			result += tags[arg]
			
	
		for arg in args:
			if len(arg)>3:
			#Placeholder SQL statements
				
			cursor.execute("SELECT * FROM jobs WHERE company=%s",arg)
			for row in cursor.fetchall():
				result.append(parseJobObject(row))
			
	for arg in args:
		if len(arg)>3:
			if "/" in arg:
				#date select method
				continue
			cursor.execute("SELECT * FROM jobs WHERE title LIKE %s",arg)
			for row in cursor.fetchall():
				result.append(parseJobObject(row))
			
			cursor.execute("SELECT * FROM jobs WHERE location LIKE %s",arg)
			for row in cursor.fetchall():
				result.append(parseJobObject(row))
			
			#Position select
			cursor.execute("SELECT * FROM jobs WHERE position LIKE %s",arg)
			for row in cursor.fetchall():
				result.append(parseJobObject(row))
			
	
				
	for arg in args:
		if len(arg)>5:
			#Maybe a description select?!?
			cursor.execute("SELECT * FROM jobs WHERE description LIKE %s",arg)
			for row in cursor.fetchall():
				result.append(parseJobObject(row))

	result = OrderedSet(result)
	start = resultsPerPage * page
	end = start + resultsPerPage
	return template('search.tpl', search=result[start:end]) 
		
		
			
    
@route('/events')
def events():
	return template('events.tpl')

@route('/bootstrap/<filepath:path>')
def boot(filepath):
    return static_file(filepath, root='bootstrap/')

@route('/static/<filepath:path>')
def static(filepath):
    return static_file(filepath, root='/static/')

@route('/bootstrap-tagsinput/<filepath:path>')
def input(filepath):
    return static_file(filepath, root='/bootstrap-tagsinput/')
    

def OrderedSet(list):
    mmap = {}
    oset = []
    for item in list:
        if item not in mmap:
                mmap[item] = 1
                oset.append(item)
	return oset;
	

	

run(host='ec2-54-234-44-211.compute-1.amazonaws.com', port=8080)