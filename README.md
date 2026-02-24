# bpp

## packages

```
flutter pub add flutter_bloc http intl shared_preferences curved_navigation_bar awesome_dialog introduction_screen
```

Queries :

- Need to understand the flow
- I used Future<dynamic> but let say I am expecting a User or an error how do I handle this.

## register user response

```
{
    "success": true,
    "message": "ok",
    "user": {
        "id": 147,
        "user_group_id": 10,
        "manager_id": 7,
        "uuid": "eb3c9167-f01e-4dcb-819a-36449a203b9d",
        "user_name": "prashant",
        "email": "abc@gmail.com",
        "full_name": "wrwrwer",
        "password": "$2b$10$EmTvWbTJ8YJG/RleF7aWH.d42kmynJ9X12rkf78fqaDr0zWVzIS4q",
        "mobile": "9324360778",
        "user_status": "Active",
        "email_verified": "No",
        "no_type": "Shared",
        "auto_reply": null,
        "is_auto_reply": "Yes",
        "session": "962ad7f2-9f86-4426-8865-166f5d7ae3aa",
        "app_id": "DO-APP",
        "userAttr": {
            "msg_forward": true,
            "backup_alert": true,
            "msg_balance_alert": true
        },
        "webhook": "http://localhost:21465/api/users/eb3c9167-f01e-4dcb-819a-36449a203b9d/webhook",
        "jwt_token": null,
        "password_reset_token": null,
        "password_reset_expiry": null,
        "createdAt": "2026-02-15T10:10:16.440Z",
        "updatedAt": "2026-02-15T10:10:16.440Z"
    }
}
```

## login response

```
{
    "status": "success",
    "data": {
        "id": 1,
        "uuid": "35763a9b-1750-45a5-826c-c8e5f31e315f",
        "user_name": "hardik",
        "full_name": "Hardik Pandya",
        "mobile": "9223588456",
        "user_status": "Active",
        "email": "user@gmail.com",
        "email_verified": "Yes",
        "jwt_token": "$2b$10$SlHTwkXiWlgUCHntux3ozOsjYiMTitgzRFC09P5mQ.Rqi3pVCEspy",
        "session": "0edcdfc1-dd95-4040-b92c-b9e2fc7852d3",
        "no_type": "Shared",
        "user_group_name": "Admin",
        "is_auto_reply": "No",
        "auto_reply": "Active",
        "userAttr": {
            "msg_forward": false,
            "backup_alert": false,
            "msg_balance_alert": false
        }
    }
}
```
