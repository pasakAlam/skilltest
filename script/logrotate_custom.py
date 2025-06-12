import os
import gzip
import shutil
from datetime import datetime

LOG_DIR = "/var/log/myapp"
ARCHIVE_DIR = os.path.join(LOG_DIR, "archive")
ACTION_LOG = os.path.join(LOG_DIR, "logrotate_action.log")
MAX_SIZE = 5 * 1024 * 1024  # 5 MB

os.makedirs(ARCHIVE_DIR, exist_ok=True)

for filename in os.listdir(LOG_DIR):
    if filename.endswith(".log"):
        file_path = os.path.join(LOG_DIR, filename)
        if os.path.isfile(file_path) and os.path.getsize(file_path) > MAX_SIZE:
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            archive_name = f"{filename}_{timestamp}.gz"
            archive_path = os.path.join(ARCHIVE_DIR, archive_name)

            with open(file_path, 'rb') as f_in:
                with gzip.open(archive_path, 'wb') as f_out:
                    shutil.copyfileobj(f_in, f_out)

            # Truncate original log file
            open(file_path, 'w').close()

            with open(ACTION_LOG, 'a') as log:
                log.write(f"{datetime.now()}: Archived and truncated {file_path} to {archive_path}\n")
