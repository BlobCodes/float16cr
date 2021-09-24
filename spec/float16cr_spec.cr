require "./spec_helper"

private macro should_eq_with_tolerance(num1, num2, divergence)
  begin
    num1 = {{num1}}
    num2 = {{num2}}
    num1.in?((num2-{{divergence}})..(num2+{{divergence}})).should eq(true)
  end
end

describe Float16 do
  it "initializes from Float32" do
    Float16.new(123.0_f32).unsafe_as(UInt16).should eq(0b0101011110110000)
    Float16.new(-23.4_f32).unsafe_as(UInt16).should eq(0b1100110111011001)

    Float16.new(Float32::NAN).unsafe_as(UInt16).should eq(0b0111111000000000)
    Float16.new(Float32::INFINITY).unsafe_as(UInt16).should eq(0b0111110000000000)
  end

  it "converts to Float32" do
    should_eq_with_tolerance(0b0101011110110000_u16.unsafe_as(Float16).to_f32, 123.0_f32, 1.0)
    should_eq_with_tolerance(0b1100110111011001_u16.unsafe_as(Float16).to_f32, -23.4_f32, 1.0)

    0b0111111000000000_u16.unsafe_as(Float16).to_f32.unsafe_as(UInt32).should eq(Float32::NAN.unsafe_as(UInt32))
    0b0111110000000000_u16.unsafe_as(Float16).to_f32.should eq(Float32::INFINITY)
  end

  it "supports arithmetic" do
    should_eq_with_tolerance(20.0.to_f16 + 23, 43, 1.0)
    should_eq_with_tolerance(20.0.to_f16 - 23, -3, 1.0)
    should_eq_with_tolerance(-500.to_f16 * 2.5, -1250, 5.0)
    should_eq_with_tolerance(-12345.to_f16 / 10_i64, -1234.5, 5.0)
    should_eq_with_tolerance(39.to_f16 % 2.0_f32, 1, 0.5)
    should_eq_with_tolerance(2.to_f16 ** 4_u8, 16, 2)

    should_eq_with_tolerance(20 + 23.to_f16, 43, 1.0)
    should_eq_with_tolerance(20.0 - 23.to_f16, -3, 1.0)
    should_eq_with_tolerance(-500 * 2.5.to_f16, -1250, 5.0)
    should_eq_with_tolerance(-12345 / 10.to_f16, -1234.5, 5.0)
    should_eq_with_tolerance(39.0 % 2.0.to_f16, 1, 0.5)
    should_eq_with_tolerance(2 ** 4.to_f16, 16, 2)

    should_eq_with_tolerance(-12345.to_f16.fdiv(10_i64), -1234.5, 5.0)
    should_eq_with_tolerance(-12345.fdiv(10.to_f16), -1234.5, 5.0)
  end

  it "supports to_s" do
    -23.0.to_f16.to_s.should eq("-23.0")
    65.75.to_f16.to_s.should eq("65.75")
  end

  it "initializes from String" do
    "-23.0".to_f16.should eq(-23)
    "65.75".to_f16.should eq(65.75)
  end

  it "supports conversions" do
    should_eq_with_tolerance(20.to_f16.to_i8, 20, 1)
    should_eq_with_tolerance(20.to_f16.to_u8, 20, 1)
    should_eq_with_tolerance(20.to_f16.to_i16, 20, 1)
    should_eq_with_tolerance(20.to_f16.to_u16, 20, 1)
    should_eq_with_tolerance(20.to_f16.to_i32, 20, 1)
    should_eq_with_tolerance(20.to_f16.to_u32, 20, 1)
    should_eq_with_tolerance(20.to_f16.to_i64, 20, 1)
    should_eq_with_tolerance(20.to_f16.to_u64, 20, 1)
    should_eq_with_tolerance(20.to_f16.to_i128, 20, 1)
    should_eq_with_tolerance(20.to_f16.to_u128, 20, 1)

    should_eq_with_tolerance(20.to_f16.to_f32, 20.0, 1)
    should_eq_with_tolerance(20.to_f16.to_f64, 20.0, 1)
  end

  it "supports clone" do
    i = 123.to_f16
    i.clone.should eq(i)
  end

  it "supports comparison" do
    (20.to_f16 > 19).should eq(true)
    (20.to_f16 < 21).should eq(true)
    (-120.to_f16 > -120.5).should eq(true)
    (-120.to_f16 < -119.5).should eq(true)

    (20.to_f16 < 19).should eq(false)
    (20.to_f16 > 21).should eq(false)
    (-120.to_f16 < -120.5).should eq(false)
    (-120.to_f16 > -119.5).should eq(false)

    (1.to_f16 == 1.to_f16).should eq(true)
    (1.to_f16 == 2.to_f16).should eq(false)
    (1.to_f16 != 2.to_f16).should eq(true)
    (1.to_f16 != 1.to_f16).should eq(false)
  end

  it "supports ceil" do
    20.5.to_f16.ceil.should eq(21)
    0.to_f16.ceil.should eq(0)
    -12.2.to_f16.ceil.should eq(-12)
  end

  it "supports floor" do
    20.5.to_f16.floor.should eq(20)
    0.to_f16.floor.should eq(0)
    -12.2.to_f16.floor.should eq(-13)
  end

  it "supports round_away" do
    20.5.to_f16.round_away.should eq(21)
    0.to_f16.round_away.should eq(0)
    -12.2.to_f16.round_away.should eq(-12)
    -12.5.to_f16.round_away.should eq(-13)
  end

  it "supports round_even" do
    20.5.to_f16.round_even.should eq(20)
    0.to_f16.round_even.should eq(0)
    -12.2.to_f16.round_even.should eq(-12)
  end

  it "supports trunc" do
    20.9.to_f16.trunc.should eq(20)
    0.to_f16.trunc.should eq(0)
    -12.2.to_f16.trunc.should eq(-12)
  end
end
