from bottle import route, run, template, static_file

@route('/')
@route('/home')
def index():
    return template('home')

@route('/profile')
def profile():
    return template('profile')
    
@route('/search')
def profile():
    return template('search')

@route('/bootstrap/<filepath:path>')
def boot(filepath):
    return static_file(filepath, root='bootstrap/')

@route('/static/<filepath:path>')
def static(filepath):
    return static_file(filepath, root='/static/')

@route('/bootstrap-tagsinput/<filepath:path>')
def input(filepath):
    return static_file(filepath, root='/bootstrap-tagsinput/')

<<<<<<< HEAD
run(host='ec2-54-234-44-211.compute-1.amazonaws.com', port=8080)
=======
run(host='ec2-54-234-44-211.compute-1.amazonaws.com', port=8080)
>>>>>>> upstream/master
