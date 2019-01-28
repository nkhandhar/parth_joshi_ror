<pre>
Rails version: 5.2.2
Ruby version: 2.5.3 (x86_64-linux)

API endpoint: http://localhost:3000/api/v1/get_new_phone_number
    type: POST

    request parameters:
        name: required
        phone_number: optional
                      validation in phone number format as XXX-XXX-XXXX

    response:
        When name is not present
        {
            "success": false,
            "message": "Name is required"
        }

        When phone number format is invalid
        {
            "success": false,
            "message": "Invalid phone number format, valid format is XXX-XXX-XXXX"
        }

        When valid request parameters is given
        {
            "success": true,
            "name": "Parth",
            "alloted_phone_number": "262-856-1009"
        }
</pre>