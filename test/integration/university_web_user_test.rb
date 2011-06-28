require 'test_helper'

class UniversityWebUserTest < ActionDispatch::IntegrationTest

  test "sign in as alumnus" do
    sign_user_in_with_mocks(Factory(:user), 
                            {'github' => 'dummy', 'alumnus' => true, 'staff' => false}
                           )
    assert_no_flash_alert
  end
  
  test "sign in as staff" do
    sign_user_in_with_mocks(Factory(:user),
                            {'github' => 'dummy', 'alumnus' => false, 'staff' => true}
                           )
    assert_no_flash_alert
  end

  test "sign in as alumnus and staff" do
    sign_user_in_with_mocks(Factory(:user),
                            {'github' => 'dummy', 'alumnus' => true, 'staff' => true}
                           )
    assert_no_flash_alert
  end

  test "attempt to sign in as non-alumnus non-staff" do
    sign_user_in_with_mocks(Factory(:user), 
                            {'github' => 'dummy', 'alumnus' => false, 'staff' => false}
                           )
    assert_flash_alert
  end
    
  test "attempt to sign in with error finding university-web github handle" do
    sign_user_in_with_mocks(Factory(:user), 
                            {'error' => 'github handle not found'}
                           )
    assert_flash_alert
  end

end
