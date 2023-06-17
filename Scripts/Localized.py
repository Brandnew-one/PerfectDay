import os
import sys

from googleapiclient.discovery import build
from googleapiclient.http import MediaIoBaseDownload
from google.oauth2 import service_account

def get_string_resource():
  save_directory = sys.argv[1]
  credential_directory = sys.argv[2]

  print(sys.argv[1])

  ko_path = os.path.join(save_directory, "ko.lproj")
  en_path = os.path.join(save_directory, "en.lproj")
  resouce_name = "Localizable.strings"

  print(ko_path)
  print(en_path)

  if not os.path.exists(save_directory):
    os.makedirs(save_directory)

  if not os.path.exists(ko_path):
    os.makedirs(ko_path)

  if not os.path.exists(en_path):
    os.makedirs(en_path)

  # 구글 드라이브 API 인증 정보 로드
  credentials = service_account.Credentials.from_service_account_file(credential_directory)
  drive_service = build('drive', 'v3', credentials=credentials)

  folder_name = "PerfectDay"
  subfolder_name = "iOS"

  # 폴더 ID 가져오기
  folder_query = f"name = '{folder_name}' and mimeType = 'application/vnd.google-apps.folder'"
  folder_results = drive_service.files().list(q=folder_query).execute()
  folder_items = folder_results.get('files', [])

  if len(folder_items) > 0:
      folder_id = folder_items[0]['id']

      # 하위 폴더 ID 가져오기
      subfolder_query = f"'{folder_id}' in parents and name = '{subfolder_name}' and mimeType = 'application/vnd.google-apps.folder'"
      subfolder_results = drive_service.files().list(q=subfolder_query).execute()
      subfolder_items = subfolder_results.get('files', [])

      if len(subfolder_items) > 0:
          subfolder_id = subfolder_items[0]['id']

          # 파일 가져오기
          files_query = f"'{subfolder_id}' in parents"
          files_results = drive_service.files().list(q=files_query).execute()
          files = files_results.get('files', [])

          for file in files:
              file_id = file['id']
              file_name = file['name']

              if file_name == "Localizable_KO.strings":
                save_path = f"{ko_path}/{resouce_name}"
              else:
                save_path = f"{en_path}/{resouce_name}"

              request = drive_service.files().get_media(fileId=file_id)

              with open(save_path, 'wb') as file:
                downloader = MediaIoBaseDownload(file, request)
                done = False

                while done is False:
                  status, done = downloader.next_chunk()

                print("다운로드 완료")

  else:
      print("폴더를 찾을 수 없습니다.")


if __name__=='__main__':
    get_string_resource()

