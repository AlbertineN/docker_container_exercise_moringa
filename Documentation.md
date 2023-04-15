Step one
Cloned the project into my local environment.

Step two
created my Dockerfile using the touch comand

Step three
I need to test the app in my local machine so i can know my expected out put once i create and run my docker container. To do this, I have made sure that i have python installed  in my local machine *pyhton3 -V*. Then I've installed the python package installer {pip} 
*sudo apt install -y python3-pip*. To finish the required set up Ive installed the python venv {virtual environment} where i will get to manage my python apps from *sudo apt install python3-venv*.

For more details on the above steps kidnly see:https://www.digitalocean.com/community/tutorials/how-to-install-python-3-and-set-up-a-programming-environment-on-ubuntu-20-04-quickstart

Step Four 
Created a root directory *mkdir ~/.venvs*  to store the virtual envirom=nments i create for my python apllications.I then created a virtual environment for my project (dcem) 
*python3 -m ~/.venvs/dcem* and activated it *source ~/.venvs/dcem/bin/activate*. Inside my environment i installed the following packages;

*pip install django gunicorn psycopg2-binary dj-database-url*

django - Installs the Django framework and libraries
gunicorn - A tool for deploying Django with a WSGI
dj-database-url - A Django tool for parsing a database URL
psycopg2 - A PostgreSQL adapter that allows Django to connect to a PostgreSQL database

After installing the packages, you need to save their requirements and dependancies so that the application platform can install them later. *pip freeze > requirements.txt*

Run *pip install -r requirements.txt*

Now since our Django project had already been created, we can fire up our server and the app will be up and running. *python3 manage.py  runserver*

A link is generated and we can confirm that indeed the app is up and running.

Note better the generated link might not work and bring an invalid host not allowed error, not to worry just go to you settings.py file and set your allowed hosts to all ["*"].

Also in the event you get a migration error you could run *python manage.py migrate* It doesnt affect the running of our applicatio but who likes errors.

Step Five
Now that our application works we can now configure our docker file.

The first layer is our base image which will be pulled to docker hub.
*FROM python:3.10.6*

Then followed by our volume layer which is ment to store any data collected in our container. 
*VOLUME /python_app*

We need to create a working directory where we get to copy all the files required to run our application
*WORKDIR /app*

Afterwards, We copy the file with our app dependacies into our app directory
*COPY requirements.txt requirements.txt*

We install our app dependancies. by this point our app envirenment is all set. 
*RUN pip install -r requirements.txt*

We copy all the files in the docker host directory into the containers directory
*COPY . .*

This will enable us to view our logs once we start up our container. Helps in the debuging process in the event there are errors
*ENV PYTHONUNBUFFERED=1*

Then we need to expose a port for our application.
*EXPOSE 5000*

Finally we need to set the commands that will be run upon starting our container
*ENTRYPOINT [ "python3", "manage.py", "runserver", "0.0.0.0:5000" ]*

By this point, our Docker file is ready to build.
*sudo docker build -t figent/python-app .*

After building our application we need to create the container from our new image.
*sudo docker run -p 5000:5000 -t figent/python-app*








