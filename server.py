from bottle import route, run, template, static_file

@route('/')
@route('/home')
def index():
    return template('home.html')

@route('/profile')
def profile():
    return template('profile')

@route('/bootstrap/<filepath:path>')
def boot(filepath):
    return static_file(filepath, root='bootstrap/')

@route('/static/<filepath:path>')
def static(filepath):
    return static_file(filepath, root='/static/')

@route('/bootstrap-tagsinput/<filepath:path>')
def input(filepath):
    return static_file(filepath, root='/bootstrap-tagsinput/')

run(host='ec2-54-234-44-211.compute-1.amazonaws.com', port=8080)
