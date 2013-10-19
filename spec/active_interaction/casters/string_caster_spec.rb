require 'spec_helper'

describe ActiveInteraction::StringCaster do
  include_context 'casters'
  it_behaves_like 'a caster'

  describe '.prepare(key, value, options = {}, &block)' do
    context 'with a String' do
      let(:value) { SecureRandom.hex }

      it 'returns the String' do
        expect(result).to eql value
      end
    end

    context 'with a strippable String' do
      let(:value) { " #{SecureRandom.hex} " }

      it 'returns the stripped String' do
        expect(result).to eql value.strip
      end

      context 'with options[:strip] as false' do
        before { options.merge!(strip: false) }

        it 'returns the String' do
          expect(result).to eql value
        end
      end
    end
  end
end
