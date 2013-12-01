#require 'active_support/concern'
#
#module DefaultScopeModule
#
#  def self.included base
#
#    base.class_eval do
#
#      def extended base
#
#        puts base
#
#      end
#
#    end
#
#  end
#
#end
#
#ActiveRecord::Base.send(:include, DefaultScopeModule)
#
#puts User2.all
#puts User3.all



module SubclassCatcher

  def self.included base

    base.class_eval do

      def self.inherited(subclass)

        # puts "ActiveRecord::Base subclass: " + subclass.to_s

        # everytime there is al class evaluation, do:
        subclass.class_eval do

          # add the default scope to the model
          # default_scope where(:id => 1)

          def self.default_scope

              # if the current request has scope

              # if current controller has the target models defined in yml

              # then define default scope

              puts "called default scope!"

          end

        end

      end

    end

  end

end

#class Shine
#  def self.inherited(subclass)
#      puts "shine"
#  end
#end
#
#class Kek < Shine
#
#end

#
ActiveRecord::Base.send(:include, SubclassCatcher)

# remove class definition from memory,
# because inherited is only called when class method is defined
#Object.send(:remove_const, :Kek)
#Object.send(:remove_const, :Shine)

#Object.send(:remove_const, :User2)