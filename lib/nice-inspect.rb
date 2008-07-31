class Object
  def nice_inspect( join_string = ",\n", indentation = 0 )
    if instance_variables.empty?
      inspect
    else
      outer_indentation = "    " * indentation
      inner_indentation = "    " * ( indentation + 1 )
      
      var_str = instance_variables.map { |var|
        val = instance_variable_get( var )
        "#{inner_indentation}#{var}=" + (
          val.respond_to?( :nice_inspect ) ?
          val.nice_inspect( join_string, indentation + 1 ) :
          val.inspect
        )
      }.join( join_string )
      outer_indentation + "#<#{self.class}\n" + var_str + "\n>"
    end
  end
end

class BigDecimal
    def nice_inspect( x1 = nil, x2 = nil )
        "%.2f" % [ self ]
    end
end

class Array
    def nice_inspect( join_string = ",\n", indentation = 0 )
        outer_indentation = "    " * indentation
        inner_indentation = "    " * ( indentation + 1 )
        
        outer_indentation +
        "[\n" +
            collect { |e|
                "    " * indentation +
                (
                    e.respond_to?( :nice_inspect ) ?
                    e.nice_inspect( join_string, indentation + 1 ) :
                    e.inspect
                )
            }.join( join_string ) +
        "\n" +
        outer_indentation +
        "]"
    end
end

class Date
    def nice_inspect( join_string = ",\n", indentation = 0 )
        "'#{to_s}'"
    end
end

class Hash
    def nice_inspect( join_string = ",\n", indentation = 0 )
        outer_indentation = "    " * indentation
        inner_indentation = "    " * ( indentation + 1 )

        outer_indentation +
        "{\n" +
            keys.sort_by { |k|
                k.respond_to?( :<=> ) ? k : k.to_s
            }.collect { |k|
                v = self[ k ]
                inner_indentation +
                k.inspect + " => " + (
                    v.respond_to?( :nice_inspect ) ?
                    v.nice_inspect( join_string, indentation + 1 ) :
                    v.inspect
                )
            }.join( join_string ) +
        "\n" +
        outer_indentation +
        "}"
    end
end

class String
    def nice_inspect( *args )
      inspect
    end
end
