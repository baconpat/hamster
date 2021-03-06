require 'spec_helper'

require 'hamster/list'

describe Hamster::List do

  [
    [[], :car, nil],
    [["A"], :car, "A"],
    [["A", "B", "C"], :car, "A"],
    [["A", "B", "C"], :cadr, "B"],
    [["A", "B", "C"], :caddr, "C"],
    [["A", "B", "C"], :cadddr, nil],
    [["A", "B", "C"], :caddddr, nil],
    [[], :cdr, Hamster.list],
    [["A"], :cdr, Hamster.list],
    [["A", "B", "C"], :cdr, Hamster.list("B", "C")],
    [["A", "B", "C"], :cddr, Hamster.list("C")],
    [["A", "B", "C"], :cdddr, Hamster.list],
    [["A", "B", "C"], :cddddr, Hamster.list],
  ].each do |values, method, expected|

    describe "##{method}" do

      it "is responded to" do
        Hamster.list.respond_to?(method).should == true
      end

      describe "on #{values.inspect}" do

        before do
          @original = Hamster.list(*values)
          @result = @original.send(method)
        end

        it "preserves the original" do
          @original.should == Hamster.list(*values)
        end

        it "returns #{expected.inspect}" do
          @result.should == expected
        end

      end

    end

  end

end
