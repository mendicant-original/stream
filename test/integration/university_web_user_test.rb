require 'test_helper'

class UniversityWebUserTest < ActionDispatch::IntegrationTest

  test "sign in as alumnus" do
    sign_user_in_as_uniweb_alumnus
    assert_no_flash_alert
  end
  
  test "sign in as staff" do
    sign_user_in_as_uniweb_staff
    assert_no_flash_alert
  end

  test "attempt to sign in as alumnus and staff" do
    sign_user_in_as_uniweb_alumnus_and_staff
    assert_no_flash_alert
  end

  test "attempt to sign in as non-alumnus non-staff" do
    sign_user_in_as_uniweb_student
    assert_flash_alert
  end
    
  test "attempt to sign in with error finding university-web github handle" do
    sign_user_in_uniweb_error
    assert_flash_alert
  end
  
  private
  
  def sign_user_in_as_uniweb_student
    sign_user_in_with_mocks(Factory(:user), 
                            {'github' => 'dummy', 'alumnus' => false, 'staff' => false}
                           )
  end
  
  def sign_user_in_as_uniweb_alumnus
    sign_user_in_with_mocks(Factory(:user), 
                            {'github' => 'dummy', 'alumnus' => true, 'staff' => false}
                           )
  end

  def sign_user_in_as_uniweb_staff
    sign_user_in_with_mocks(Factory(:user),
                            {'github' => 'dummy', 'alumnus' => false, 'staff' => true}
                           )
  end    
  
  def sign_user_in_as_uniweb_alumnus_and_staff
    sign_user_in_with_mocks(Factory(:user),
                            {'github' => 'dummy', 'alumnus' => true, 'staff' => true}
                           )
  end    
  
  def sign_user_in_uniweb_error
    sign_user_in_with_mocks(Factory(:user), 
                            {'error' => 'github handle not found'}
                           )
  end    
    

end
