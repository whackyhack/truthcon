# frozen_string_literal: true

require 'spec_helper'

describe 'truthcon' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      # sanity checks
      it 'takes no action' do
        is_expected.not_to contain_notify('condition 1')
        is_expected.to contain_notify('no go 1')

        is_expected.not_to contain_notify('condition 2')
        is_expected.to contain_notify('no go 2')
      end

      it 'calls booleans with both conditions false' do
        is_expected.to contain_class('truthcon::booleans')
        .with_condition1(false)
        .with_condition2(false)
      end

      it 'calls booleans with both conditions false' do
        is_expected.to contain_class('truthcon::booleans')
        .with_condition1(false)
        .with_condition2(false)
      end

      it 'contains notify from booleans with both bad' do
        is_expected.not_to contain_notify('boolean good 1')
        is_expected.to contain_notify('bad 1')
        is_expected.not_to contain_notify('boolean good 2')
        is_expected.to contain_notify('bad 2')
      end

      context "merex2 match, only" do
        let(:params) {{ 'merex2' => /test/, }}

        # sanity checks
        it 'takes 2nd action, but not 1st' do
          is_expected.not_to contain_notify('condition 1')
          is_expected.to contain_notify('no go 1')
  
          is_expected.to contain_notify('condition 2')
          is_expected.not_to contain_notify('no go 2')
        end

        it 'calls booleans with condition2 true, but condition1 remaining false' do
          is_expected.to contain_class('truthcon::booleans')
          .with_condition1(false)
          .with_condition2(true)
        end

        it 'contains notify from booleans with good 2, 1 remaining bad' do
          is_expected.not_to contain_notify('boolean good 1')
          is_expected.to contain_notify('bad 1')
          is_expected.to contain_notify('boolean good 2')
          is_expected.not_to contain_notify('bad 2')
        end
      end

      context 'merex1 match, only' do
        let(:params) {{ 'merex1' => /good/, }}

        # sanity checks
        it 'takes both actions' do
          is_expected.to contain_notify('condition 1')
          is_expected.not_to contain_notify('no go 1')
  
          is_expected.to contain_notify('condition 2')
          is_expected.not_to contain_notify('no go 2')
        end

        it 'calls booleans with both conditions true' do
          is_expected.to contain_class('truthcon::booleans')
          .with_condition1(true)
          .with_condition2(true)
        end

        it 'contains notify from booleans with both good' do
          is_expected.to contain_notify('boolean good 1')
          is_expected.not_to contain_notify('bad 1')
          is_expected.to contain_notify('boolean good 2')
          is_expected.not_to contain_notify('bad 2')
        end
      end

      context 'merex1, merex2 match, both' do
        let(:params) {{
          'merex1' => /more/,
          'merex2' => /testing/,
          }}

        # sanity checks
        it 'takes both actions' do
          is_expected.to contain_notify('condition 1')
          is_expected.not_to contain_notify('no go 1')
  
          is_expected.to contain_notify('condition 2')
          is_expected.not_to contain_notify('no go 2')
        end

        it 'calls booleans with both conditions true' do
          is_expected.to contain_class('truthcon::booleans')
          .with_condition1(true)
          .with_condition2(true)
        end

        it 'contains notify from booleans with both good' do
          is_expected.to contain_notify('boolean good 1')
          is_expected.not_to contain_notify('bad 1')
          is_expected.to contain_notify('boolean good 2')
          is_expected.not_to contain_notify('bad 2')
        end
      end
    end
  end
end
