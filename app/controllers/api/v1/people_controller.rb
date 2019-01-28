class Api::V1::PeopleController < Api::V1::BaseController
    def get_new_phone_number
        errors = ""
        errors += "Name" if params[:name].blank?

        if errors.present?
            render json: {
                success: false,
                message: errors + " is required"
            }, status: 404 and return
        end


        if params[:phone_number].present?
            if /^\d{3}-\d{3}-\d{4}$/.match(params[:phone_number]).present?
            else
                render json: {
                    success: false,
                    message: "Invalid phone number format, valid format is XXX-XXX-XXXX"
                }, status: 404 and return
            end
        end
        
        phone_number_without_dashes = params[:phone_number].scan(/\d/).join('')
        
        new_phone_number = allocate_phone_number(phone_number_without_dashes)
        UserContact.create(name: params[:name], phone_number: new_phone_number)
        
        render json: {
            success: true,
            name: params[:name],
            alloted_phone_number: new_phone_number.to_s.insert(3, '-').insert(7, '-')
        }, status: 200 and return
    end

    private

    def allocate_phone_number(phone_number = "")
        if phone_number.present?
            user_contact_obj = UserContact.find_by(phone_number: phone_number)
            
            if user_contact_obj.present?
                return generate_random_phone_number
            else
                return phone_number
            end
        else
            return generate_random_phone_number
        end
    end

    def generate_random_phone_number
        tmp_var = true
        while tmp_var
            sample_phone_number = rand(1111111111..9999999999)
            user_contact_obj = UserContact.find_by(phone_number: sample_phone_number)

            if user_contact_obj.present?
                # repeat loop
            else
                return sample_phone_number
            end
        end
    end
end
