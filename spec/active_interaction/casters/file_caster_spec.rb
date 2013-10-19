require 'spec_helper'

describe ActiveInteraction::FileCaster do
  include_context 'casters'
  it_behaves_like 'a caster'

  describe '.prepare(key, value, options = {}, &block)' do
    context 'with a File' do
      let(:value) { File.open(__FILE__) }

      it 'returns the File' do
        expect(result).to equal value
      end
    end

    context 'with a Tempfile' do
      let(:value) { Tempfile.new(SecureRandom.hex) }

      it 'returns the Tempfile' do
        expect(result).to equal value
      end
    end

    context 'with a object that responds to `tempfile`' do
      let(:value) { double(tempfile: Tempfile.new(SecureRandom.hex)) }

      it 'returns the Tempfile' do
        expect(result).to equal value.tempfile
      end
    end
  end
end
