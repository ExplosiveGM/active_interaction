require 'spec_helper'

describe ActiveInteraction::DateCaster do
  include_context 'casters'
  it_behaves_like 'a caster'

  describe '.prepare(key, value, options = {}, &block)' do
    context 'with a Date' do
      let(:value) { Date.today }

      it 'returns the Date' do
        expect(result).to eql value
      end
    end

    context 'with a valid String' do
      let(:value) { '2001-01-01' }

      it 'parses the String' do
        expect(result).to eql Date.parse(value)
      end

      context 'with options[:format]' do
        let(:value) { '01012001' }

        before { options.merge!(format: '%m%d%Y') }

        it 'parses the String' do
          expect(result).to eql Date.strptime(value, options[:format])
        end
      end
    end

    context 'with an invalid String' do
      let(:value) { 'not a valid Date' }

      it 'raises an error' do
        expect { result }.to raise_error ActiveInteraction::InvalidValue
      end

      context 'with options[:format]' do
        before { options.merge!(format: '%m%d%Y') }

        it 'raises an error' do
          expect { result }.to raise_error ActiveInteraction::InvalidValue
        end
      end
    end
  end
end
