function asm_no_test
	sbt 'set test in assembly := {}' clean assembly
end
