require 'rails_helper'

RSpec.describe Tube, type: :model do
  let(:tube) { FactoryBot.build(:tube) }
 
  describe 'internal methods' do
    it 'should calculate F1' do
      value_f1 = tube.f_1

      expect(value_f1).to eq(2)
    end
    it 'should calculate F2' do
      value_f2 = tube.f_2

      expect(value_f2).to eq(0.125)
    end
    it 'should calculate F3' do
      value_f3 = tube.f_3

      expect(value_f3).to eq(13.25)
    end
    it 'should calculate F4' do
      value_f4 = tube.f_4

      expect(value_f4).to eq(104.07)
    end
    it 'should calculate F5' do
      value_f5 = tube.f_5

      expect(value_f5[0]).to eq(1.62)
      expect(value_f5[1]).to eq("Terphane lg 50 MM-EP 36µ")
    end
    it 'should calculate F6_7' do
      value_f6_7 = tube.f6_7

      expect(value_f6_7[0]).to eq(478.70)
      expect(value_f6_7[1]).to eq(408.96)
      expect(value_f6_7[2]).to eq(98.35)
      expect(value_f6_7[3]).to eq(516.88)
    end
    it 'should calculate F8_9' do
      value_f8_9 = tube.f8_9

      expect(value_f8_9[0]).to eq(40)
      expect(value_f8_9[1]).to eq(217)
      expect(value_f8_9[2]).to eq(139)
      expect(value_f8_9[3]).to eq(396)
    end
    it 'should calculate F10' do
      value_f10 = tube.f_10

      expect(value_f10[0]).to eq(120)
      expect(value_f10[1]).to eq(38)
      expect(value_f10[2]).to eq(434)
     
    end
    it 'should calculate F11' do
      value_f11 = tube.f_11

      
      expect(value_f11[0]).to eq(4.09)
      expect(value_f11[1]).to eq(0.278)
      expect(value_f11[2]).to eq(4.17)
    end
    it 'should calculate F12' do
      value_f12 = tube.f_12

      expect(value_f12).to eq(42)
    end
    it 'should calculate F13' do
      value_f13 = tube.f_13

            
      expect(value_f13[0]).to eq(10.96)
      expect(value_f13[1]).to eq(1.644 )
      expect(value_f13[2]).to eq(0.548)
    end
    it 'should MAKE the calculation' do
      value_calculation = tube.calculation

            
      expect(value_calculation[0].round()).to eq(2735.79.round())
      expect(value_calculation[1].round()).to eq(790.43.ceil())
      expect(value_calculation[2].round()).to eq(132.17.round())
      expect(value_calculation[3].round()).to eq(397.32.round())
      expect(value_calculation[4].round()).to eq(8.12.round())
      expect(value_calculation[5].round()).to eq(0.1.round())
      expect(value_calculation[6].round()).to eq(98.00.round())
      expect(value_calculation[7].round()).to eq(325.93.round())
      expect(value_calculation[8].round()).to eq(192.07.round())
      expect(value_calculation[9].round()).to eq(4.95.round())
      expect(value_calculation[10].round()).to eq(16.33.round())
      expect(value_calculation[11].round()).to eq(64.96.round())
      expect(value_calculation[12].round()).to eq(8.39.round())
      expect(value_calculation[13].round()).to eq(0.1.round())
      expect(value_calculation[14].round()).to eq(24.27.round())
      expect(value_calculation[15].round()).to eq(420.round())
      expect(value_calculation[16].round()).to eq(4799.41.round())


     
     
    end
    it 'should calculate Prix MP' do
      value_price_mp = tube.price_mp

      expect(value_price_mp.round()).to eq(4799)
    end
    it 'should calculate  MO'do
      value_mo = tube.mo

      expect(value_mo).to eq(42)
    end

    it 'should calculate Prix Total' do
      value_price_total = tube.price_total

      expect(value_price_total.round()).to eq(5219)
    end


    it 'should calculate Prix M/MP ' do
      value_price_mmp = tube.price_mmp

      expect(value_price_mmp.round()).to eq(5645.76.round())
    end
    it 'should calculate Prix M0 ' do 
      value_price_mo = tube.price_mo_method

      expect(value_price_mo).to eq(419.95.round())
    end
    it 'should calculate Prix TOTAL 'do
      value_price_total_big = tube.price_total_big

      expect(value_price_total_big.round() ).to eq(6066)
    end
    it 'should calculate Prix MG COM ' do
      value_price_mgcom = tube.price_mgcom

      expect(value_price_mgcom.round(1)).to eq(7582.5)
    end

    it 'should calculate Prix Prix Unit ' do
      value_price_unit = tube.price_unit

      expect(value_price_unit.round()).to eq(583)
    end  
  end
end
