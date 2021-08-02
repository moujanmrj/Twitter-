import mysql.connector
from mysql.connector import Error

connection = mysql.connector.connect(host='localhost',
                                     database='canary',
                                     user='root',
                                     password='60opti78')
if connection.is_connected():
    db_Info = connection.get_server_info()
    print("Connected to MySQL Server version ", db_Info)
    cursor = connection.cursor()
    cursor.execute("select database();")
    record = cursor.fetchone()
    print("You're connected to database: ", record)

cursor = connection.cursor()
while True:
    command = input('Enter your command Or Ask for Menu: ')
    if command == "Create User":
        firstname = input('Enter your firstname: ')
        lastname = input('Enter your lastname: ')
        username = input('Enter your username: ')
        password = input('Enter your password: ')
        birthday = input('Enter your birthdate(YYYY-MM-DD): ')
        biography = input('Enter your bio: ')
        cursor.callproc('create_users', [firstname, lastname, username, password, birthday, biography])
        connection.commit()
    elif command == "User Login":
        command_info = input('Enter your username: ')
        commmand_info = input('Enter your password: ')
        cursor.callproc('user_logins', [command_info, commmand_info])
        connection.commit()
        for result in cursor.stored_results():
            the_row = result.fetchall()
            for row in the_row:
                print("{}".format(row[0]))
    elif command == "List User Logins":
        command_info = input('Enter username: ')
        tuples = command_info.split(" ")
        cursor.callproc('list_user_logins', tuples[0:])
        for result in cursor.stored_results():
            the_row = result.fetchall()
            for row in the_row:
                print("{}: {}".format(row[0], row[1]))
        connection.commit()
    elif command == "Send Ava":
        command_info = input('Enter your ava: ')
        tuples = []
        tuples.insert(0, command_info)
        cursor.callproc('send_avas', tuples)
        connection.commit()
    elif command == "Receive Personal Avas":
        cursor.callproc('receive_personal_avas')
        for result in cursor.stored_results():
            the_row = result.fetchall()
            for row in the_row:
                print("{}".format(row[0]))
    elif command == "Following":
        command_info = input('Enter the username you want to follow: ')
        tuples = []
        tuples.insert(0, command_info)
        cursor.callproc('followings', tuples)
        connection.commit()
    elif command == "Stop Following":
        command_info = input('Enter the username you want to unfollow: ')
        tuples = []
        tuples.insert(0, command_info)
        cursor.callproc('stop_following', tuples)
        connection.commit()
    elif command == "Blocking":
        command_info = input('Enter the username you want to block: ')
        tuples = []
        tuples.insert(0, command_info)
        cursor.callproc('blocking', tuples)
        connection.commit()
    elif command == "Stop Blocking":
        command_info = input('Enter the username you want to unblock: ')
        tuples = []
        tuples.insert(0, command_info)
        cursor.callproc('stop_blocking', tuples)
        connection.commit()
    elif command == "Fetch Followings Activity":
        cursor.callproc('fetch_followings_activity')
        for result in cursor.stored_results():
            the_row = result.fetchall()
            for row in the_row:
                print("{}: {}".format(row[0], row[1]))
    elif command == "Fetch Users Activity":
        command_info = input('Enter username: ')
        tuples = command_info.split(" ")
        cursor.callproc('fetch_users_activity', tuples[0:])
        for result in cursor.stored_results():
            the_row = result.fetchall()
            for row in the_row:
                print("{}: {}".format(row[0], row[1]))
    elif command == "Commenting":
        comment = input('Enter your comment: ')
        idComment = input('Enter the ava ID you want to comment on: ')
        cursor.callproc('commenting', [comment, idComment])
        connection.commit()
        for result in cursor.stored_results():
            the_row = result.fetchall()
            for row in the_row:
                print("{}".format(row[0]))
    elif command == "Fetch Avas Comments":
        command_info = input('Enter an ava ID: ')
        tuples = command_info.split(" ")
        cursor.callproc('fetch_avas_comments', tuples[0:])
        for result in cursor.stored_results():
            the_row = result.fetchall()
            for row in the_row:
                print("{}: {} ON {}".format(row[0], row[1], row[2]))
    elif command == "Liking":
        command_info = input('Enter the ava ID you want to like: ')
        tuples = []
        tuples.insert(0, command_info)
        cursor.callproc('liking', tuples)
        connection.commit()
        for result in cursor.stored_results():
            the_row = result.fetchall()
            for row in the_row:
                print("{}".format(row[0]))
    elif command == "Count Likes":
        command_info = input('Enter an ava ID: ')
        tuples = []
        tuples.insert(0, command_info)
        cursor.callproc('count_likes', tuples)
        for result in cursor.stored_results():
            the_row = result.fetchall()
            for row in the_row:
                print("{}".format(row[0]))
    elif command == "Fetch List Of An Ava Likers":
        command_info = input('Enter an ava ID: ')
        tuples = []
        tuples.insert(0, command_info)
        cursor.callproc('fetch_list_of_an_ava_likers', tuples)
        for result in cursor.stored_results():
            the_row = result.fetchall()
            for row in the_row:
                print("{}".format(row[0]))
    elif command == "Fetch Trending Avas":
        cursor.callproc('fetch_trending_avas')
        for result in cursor.stored_results():
            the_row = result.fetchall()
            for row in the_row:
                print("{} --> {}".format(row[0], row[1]))
    elif command == "Send Ava Message":
        username = input('Enter the username of your message receiver: ')
        ava_content = input('Enter the ava ID you want to send: ')
        cursor.callproc('send_ava_message', [username, ava_content])
        connection.commit()
        for result in cursor.stored_results():
            the_row = result.fetchall()
            for row in the_row:
                print("{}".format(row[0]))
    elif command == "Send Text Message":
        text_content = input('Enter your message content: ')
        username = input('Enter the username of your message receiver: ')
        cursor.callproc('send_text_message', [username, text_content])
        connection.commit()
        for result in cursor.stored_results():
            the_row = result.fetchall()
            for row in the_row:
                print("{}".format(row[0]))
    elif command == "Fetch List Of Received Texts From A User":
        command_info = input('Enter username: ')
        tuples = []
        tuples.insert(0, command_info)
        cursor.callproc('fetch_list_of_received_texts_from_a_user', tuples)
        for result in cursor.stored_results():
            the_row = result.fetchall()
            for row in the_row:
                print("{} ON {}".format(row[0], row[1]))
    elif command == "Fetch List Of All Text Senders":
        cursor.callproc('fetch_list_of_all_text_senders')
        for result in cursor.stored_results():
            the_row = result.fetchall()
            for row in the_row:
                print("{}: {} ON {}".format(row[0], row[1], row[2]))
    elif command == "Fetch Avas Of Hashtag":
        command_info = input('Enter hashtag: ')
        tuples = []
        tuples.insert(0, command_info)
        cursor.callproc('fetch_avas_of_hastag', tuples)
        for result in cursor.stored_results():
            the_row = result.fetchall()
            for row in the_row:
                print("{} POSTED BY {} ON {}".format(row[0], row[1], row[2]))

    else:
        print('Wrong Command\nAsk for Menu Or Enter your command again')
