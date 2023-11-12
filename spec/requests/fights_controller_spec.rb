# frozen_string_literal: true
require 'rails_helper'

describe FightsController, type: :request do
  describe 'GET index' do
    context 'with no fights in the database' do
      it 'renders successfully' do
        get fights_url
        expect(response).to be_successful
      end
    end

    context 'with  fights in the database' do
      it 'renders successfully' do
        create_list(:fight, 2)
        get fights_url
        expect(response).to be_successful
      end
    end
  end

  describe 'GET show' do
    context 'with no gladiators in the database' do
      it 'renders successfully' do
        fight = create(:fight)
        get fight_url(fight)
        expect(response).to be_successful
      end
    end

    context 'with fights in the database' do
      it 'renders successfully' do
        fight = create(:fight, :with_won_gladiators, :with_lost_gladiators, :with_planned_gladiators)
        get fight_url(fight)
        expect(response).to be_successful
      end
    end
  end

  describe 'GET new' do
    context 'with no gladiators ready for fights' do
      it 'redirect successfully' do
        get new_fight_url
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'with gladiators ready for fights' do
      it 'renders successfully' do
        create_list(:gladiator, 2, life_points: 40, health_status: 'ready_for_fight')
        get new_gladiator_url
        expect(response).to be_successful
      end
    end
  end

  describe 'POST Create' do
    context 'with valid argument' do
      it 'redirect successfully' do
        first_gladiator = create(:gladiator, age: 10)
        second_gladiator = create(:gladiator, age: 15)
        expect do
          post fights_url,
               params: { fight_form: { first_gladiator_id: first_gladiator.id,
                                       second_gladiator_id: second_gladiator.id } }
        end.to change(Fight, :count).by 1

        expect(response).to have_http_status(:redirect)
      end
    end

    context 'with no valid argument' do
      it 'renders successfully' do
        first_gladiator = create(:gladiator, age: 10)

        expect do
          post fights_url,
               params: { fight_form: { first_gladiator_id: first_gladiator.id,
                                       second_gladiator_id: first_gladiator.id } }
        end.to change(Fight, :count).by 0

        expect(response).to be_successful
      end
    end
  end

  describe 'GET execute' do
    it 'call fight service' do
      fight = create(:fight)
      expect_any_instance_of(Fights::Execute).to receive(:call) # rubocop:disable RSpec/AnyInstance

      get execute_fight_url(fight)
    end
  end
end
