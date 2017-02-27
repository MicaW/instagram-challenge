require 'rails_helper'

feature 'posts' do

  context 'no posts have been added' do
    scenario 'should display a prompt to add a post' do
      visit '/posts'
      expect(page).to have_content 'No posts yet'
      expect(page).to have_link 'Add a post'
    end
  end

  scenario 'redirect to new post form' do
    visit '/posts'
    click_link 'Add a post'
    expect(current_path).to eq new_post_path
  end

  context 'posts have been added' do

    scenario 'display posts' do
      visit '/posts'
      click_link 'Add a post'
      attach_file "app/images/instagram default upload.jpg"
      fill_in 'Caption', with: 'This view is incredible!'
      click_button 'Post'
      expect(page).not_to have_content('No posts yet')
    end
  end

  context 'creating posts' do

    scenario 'prompts user to fill out a form, then displays the new post' do
      visit '/posts'
      click_link 'Add a post'
      attach_file "instagram default upload.jpg", app/images
      fill_in 'Caption', with: 'This view is incredible!'
      click_button 'Post'
      expect(page).to have_content 'This view is incredible!'
      expect(current_path).to eq '/posts'
    end
  end

context 'deleting posts' do

  scenario 'removes a post when a user clicks a delete link' do
    visit '/posts'
    click_link 'Add a post'
    attach_file "instagram default upload.jpg", app/images
    fill_in 'Caption', with: 'This view is incredible!'
    click_button 'Post'
    click_link 'Delete'
    expect(page).not_to have_content 'This view is incredible!'
    expect(page).to have_content 'Post deleted successfully'
  end
end
end
