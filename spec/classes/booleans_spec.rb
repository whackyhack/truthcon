# frozen_string_literal: true

require 'spec_helper'

describe 'truthcon::booleans' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }
      it 'meets no condition' do
        is_expected.not_to contain_notify('boolean good 1')
        is_expected.to contain_notify('bad 1')

        is_expected.not_to contain_notify('boolean good 2')
        is_expected.to contain_notify('bad 2')
      end

      context 'condition1 alone is true' do
        let(:params) {{ 'condition1' => true, }}

        it 'notifies good 1, bad 2' do
          is_expected.to contain_notify('boolean good 1')
          is_expected.not_to contain_notify('bad 1')
  
          is_expected.not_to contain_notify('boolean good 2')
          is_expected.to contain_notify('bad 2')
        end
      end

      context 'condition2 alone is true' do
        let(:params) {{ 'condition2' => true, }}

        it 'notifies good 2, bad 1' do
          is_expected.not_to contain_notify('boolean good 1')
          is_expected.to contain_notify('bad 1')
  
          is_expected.to contain_notify('boolean good 2')
          is_expected.not_to contain_notify('bad 2')
        end
      end

      context 'true on both' do
        let(:params) {{ 'condition1' => true, 'condition2' => true, }}

        it 'notifies good conditions 1 and 2' do
          is_expected.to contain_notify('boolean good 1')
          is_expected.not_to contain_notify('bad 1')
  
          is_expected.to contain_notify('boolean good 2')
          is_expected.not_to contain_notify('bad 2')
        end
      end
    end
  end
end
