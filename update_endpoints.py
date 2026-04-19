import os

files = [
    r"d:\Github\aimjobportal\lib\presentation\Side_Dashboard\controller\SideDashboard_Controller.dart",
    r"d:\Github\aimjobportal\lib\presentation\Savedjobs\controller\SaveJob_Controller.dart",
    r"d:\Github\aimjobportal\lib\presentation\Savedjobs\controller\getallsavedjobs_controller.dart",
    r"d:\Github\aimjobportal\lib\presentation\Savedjobs\controller\DeleteSavedJobs_Controller.dart",
    r"d:\Github\aimjobportal\lib\presentation\myresume\controller\getmyresume_Controller.dart",
    r"d:\Github\aimjobportal\lib\presentation\myresume\controller\uploadresume_Controller.dart",
    r"d:\Github\aimjobportal\lib\presentation\myprofile\controller\updatepersonalinfo_controller.dart",
    r"d:\Github\aimjobportal\lib\presentation\myprofile\controller\getProfile_Controller.dart",
    r"d:\Github\aimjobportal\lib\presentation\Login\controller\Auth_Controller.dart",
    r"d:\Github\aimjobportal\lib\presentation\Complete_Profile\Controller\Complete_Profile_Controller.dart",
]

for file_path in files:
    if not os.path.exists(file_path):
        print(f"Not found: {file_path}")
        continue
        
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    if "aurore-nonappendent-ares.ngrok-free.dev" in content:
        # We need to correctly wrap string interpolation
        new_content = content.replace("https://aurore-nonappendent-ares.ngrok-free.dev/api", "${ApiList.baseUrl}")
        
        # Because we replaced inside a string literal, we must ensure the import is present
        if "package:aimjobs/api/apilist.dart" not in new_content:
            # Safely inject the import alongside existing imports
            # Find the last import
            lines = new_content.splitlines()
            last_import_idx = 0
            for i, line in enumerate(lines):
                if line.startswith("import "):
                    last_import_idx = i
            lines.insert(last_import_idx + 1, "import 'package:aimjobs/api/apilist.dart';")
            new_content = "\n".join(lines) + "\n"
            
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {os.path.basename(file_path)}")
