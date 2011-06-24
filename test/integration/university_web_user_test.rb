require 'test_helper'

class UniversityWebUserTest < ActionDispatch::IntegrationTest

  test "sign in as alumnus" do
    sign_user_in Factory(:user), uniweb_hash_alumnus
    assert_no_flash_alert
  end
  
  test "sign in as staff" do
    sign_user_in Factory(:user), uniweb_hash_staff
    assert_no_flash_alert
  end

  test "attempt to sign in as non-alumnus non-staff" do
    sign_user_in Factory(:user), uniweb_hash_student
    assert_flash_alert
  end
  
  test "attempt to sign in with error finding university-web github handle" do
    sign_user_in Factory(:user), uniweb_hash_error
    assert_flash_alert
  end
    
end
