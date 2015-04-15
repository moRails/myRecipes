require 'test_helper'

class ChefTest < ActiveSupport::TestCase
   
    def setup
      @chef = Chef.new(chefname: "john", email: "john@example.com")
    end 
   
    test "chef should be valid" do
      assert @chef.valid?
    end
   
    test "chef name should be present" do
      @chef.chefname = " "
      assert_not @chef.valid?
    end
   
    test "chefname should not be too long" do
      @chef.chefname = "a" * 41
      assert_not @chef.valid?
    end

    test "chefname should not be too short" do
      @chef.chefname = "aa"
      assert_not @chef.valid?
    end
   
    test "email should be present" do
      @chef.email = " "
      assert_not @chef.valid?
    end
    
    test "email chef may be within bound" do
      @chef.email = "a"*101 + "@example.com"
      assert_not @chef.valid?
    end
    
    test "email adresse should be unique" do
      dup_chef = @chef.dup
      dup_chef.email = @chef.email.upcase
      @chef.save
      assert_not dup_chef.valid?
    end
    
    test "email validation should accept valid adresses" do
      valid_adresses = %w[user@eee.com R_TTD-DS@eee.hello.org user@example.com first.last@eee.au laura+joe@monk.cm]
      valid_adresses.each do |vad|
        @chef.email = vad
        assert @chef.valid?, '#{vad.inspect} should be valid'
      end
    end
    
    test "email validation should reject invalide adresses"do
      invalid_adresses = %w[user@example,com user_at_eee.org user.name@example. eee@i_am_.com foo@ee+aar.com]
      invalid_adresses.each do |iad|
        @chef.email = iad
        assert_not @chef.valid?, '#{iad.inspect} should be invalid'
      end
    end
end