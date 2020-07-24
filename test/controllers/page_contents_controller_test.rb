require 'test_helper'

class PageContentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page_content = page_contents(:one)
  end

  test "should get index" do
    get page_contents_url
    assert_response :success
  end

  test "should get new" do
    get new_page_content_url
    assert_response :success
  end

  test "should create page_content" do
    assert_difference('PageContent.count') do
      post page_contents_url, params: { page_content: {  } }
    end

    assert_redirected_to page_content_url(PageContent.last)
  end

  test "should show page_content" do
    get page_content_url(@page_content)
    assert_response :success
  end

  test "should get edit" do
    get edit_page_content_url(@page_content)
    assert_response :success
  end

  test "should update page_content" do
    patch page_content_url(@page_content), params: { page_content: {  } }
    assert_redirected_to page_content_url(@page_content)
  end

  test "should destroy page_content" do
    assert_difference('PageContent.count', -1) do
      delete page_content_url(@page_content)
    end

    assert_redirected_to page_contents_url
  end
end
