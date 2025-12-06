require 'rails_helper'

describe Customer do
  describe 'validations' do
    context 'name validation' do
      it 'is valid with a name' do
        customer = build(:customer)
        expect(customer).to be_valid
      end

      it 'is invalid without a name' do
        customer = build(:customer, name: nil)
        expect(customer).not_to be_valid
        expect(customer.errors[:name]).to include("can't be blank")
      end
    end

    context 'email validation' do 
      it 'is valid email format' do
        customer = build(:customer, email: 'email@domain.com')
        expect(customer).to be_valid
      end

      it 'is invalid email format' do
        customer = build(:customer, email: 'invalid_email')
        expect(customer).not_to be_valid
        expect(customer.errors[:email]).to include("is invalid")
      end
    end

    context 'phone validation' do 
      it 'is valid phone format' do
        customer = build(:customer, phone: '1234567890')
        expect(customer).to be_valid
      end

      it 'is invalid phone format' do
        customer = build(:customer, phone: 'invalid_phone')
        expect(customer).not_to be_valid
        expect(customer.errors[:phone]).to include("is invalid")
      end
    end 

    context 'email and phone validation' do
      it 'is valid with email only' do
        customer = build(:customer, :with_email_only)
        expect(customer).to be_valid
      end

      it 'is valid with phone only' do
        customer = build(:customer, :with_phone_only)
        expect(customer).to be_valid
      end

      it 'is valid with both email and phone' do
        customer = build(:customer)
        expect(customer).to be_valid
      end

      it 'is invalid without email and phone' do
        customer = build(:customer, email: nil, phone: nil)
        expect(customer).not_to be_valid
        expect(customer.errors[:email]).to include("can't be blank")
        expect(customer.errors[:phone]).to include("can't be blank")
      end
    end

    context 'email_subject validation' do
      it 'is invalid without email_subject' do
        customer = build(:customer, email_subject: nil)

        expect(customer).not_to be_valid
        expect(customer.errors[:email_subject]).to include("can't be blank")
      end
    end

    context 'product_code validation' do
      it 'is invalid without product_code' do
        customer = build(:customer, product_code: nil)

        expect(customer).not_to be_valid
        expect(customer.errors[:product_code]).to include("can't be blank")
      end
    end
  end
end
