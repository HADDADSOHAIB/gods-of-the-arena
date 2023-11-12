# frozen_string_literal: true
require 'rails_helper'

describe GladiatorsController, type: :request do
  describe 'GET ludus' do
    it 'renders successfully' do
      get the_ludus_gladiators_url
      expect(response).to be_successful
    end
  end
  
  describe 'GET index' do
    context 'With no gladiators in the database' do
      it 'renders successfully' do
        get gladiators_url
        expect(response).to be_successful
      end
    end

    context 'With  gladiators in the database' do
      it 'renders successfully' do
        create_list(:gladiator, 2)
        get gladiators_url
        expect(response).to be_successful
      end
    end
  end

  describe 'GET show' do
    context 'With no fights in the database' do
      it 'renders successfully' do
        gladiator = create(:gladiator)
        get gladiator_url(gladiator)
        expect(response).to be_successful
      end
    end

    context 'With fights in the database' do
      it 'renders successfully' do
        gladiator = create(:gladiator, :with_won_fights, :with_lost_fights, :with_planned_fights)
        get gladiator_url(gladiator)
        expect(response).to be_successful
      end
    end
  end

  describe 'GET new' do
    it 'renders successfully' do
      get new_gladiator_url
      expect(response).to be_successful
    end
  end

  describe 'GET edit' do
    it 'renders successfully' do
      gladiator = create(:gladiator)
      get edit_gladiator_url(gladiator)
      expect(response).to be_successful
    end
  end

  describe 'POST create' do
    context 'With valid argument' do
      it 'redirect successfully' do
        expect{ post gladiators_url, params: { gladiator: build(:gladiator).attributes} }.to change { Gladiator.count }.by 1
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'With no valid argument' do
      it 'renders successfully' do
        expect{ post gladiators_url, params: { gladiator: build(:gladiator, age: -10).attributes} }.to change { Gladiator.count }.by 0
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH update' do
    context 'With valid argument' do
      it 'redirect successfully' do
        gladiator = create(:gladiator, age: 10)
        patch gladiator_url(gladiator), params: { gladiator: build(:gladiator).attributes.merge({ 'age' => 5 })}
        
        expect(gladiator.reload.age).to eq(5)
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'With no valid argument' do
      it 'renders successfully' do
        gladiator = create(:gladiator, age: 10)
        patch gladiator_url(gladiator), params: { gladiator: build(:gladiator).attributes.merge({ 'age' => -10 })}
        
        expect(gladiator.reload.age).to eq(10)
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE destroy' do
    it 'redirect successfully' do
      gladiator = create(:gladiator)
      expect{ delete gladiator_url(gladiator) }.to change { Gladiator.count }.by -1
      expect(response).to have_http_status(:redirect)
    end
  end
end
