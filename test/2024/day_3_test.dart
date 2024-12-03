import 'package:aoc/year_2024/year_2024.dart';
import 'package:test/test.dart';

void main() {
  final aoc = Aoc2024Day3();
  group('Day 3 test suite', () {
    test('scan for valid muls in string', () {
      final input =
          'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))';

      final validInstructions = aoc.primaryInputParser(input);

      expect(validInstructions.length, 4,
          reason: 'there are 4 valid mul instructions occurrences');
    });

    test('test case to handle one input', () {
      final input =
          'xmul(2)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))';

      final validInstructions = aoc.primaryInputParser(input);

      expect(validInstructions.length, 3,
          reason: 'there are 3 valid mul instructions occurrences');
    });

    test('handle case where input is 4 numbers', () {
      final input =
          'xmul(27474,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))';

      expect(aoc.primaryInputParser(input).length, 3,
          reason: 'there are 3 valid instructions');
    });

    test('test sample for task one', () {
      final input =
          'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))';

      expect(aoc.call(input, 0), 161, reason: 'sample prompt result');
    });

    test(
        "handle new do and don't instructions for determining whether to perform operation or not",
        () {
      var input =
          "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))";

      expect(aoc.secondaryInputParser(input).length, 2,
          reason: 'only two valid mul from sample');
    });

    test('summation logic with trimming works', () {
      var input =
          "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))";

      expect(aoc.call(input, 1), 48, reason: 'result from sample');
    });

    test("no valid group with don't instruction test", () {
      final input =
          "don't()'when()(;'?how()]'mul(978,210)#&when()how()):%?^]mul(395,664)'mul(912,244){),@:?'who()";

      final validInputs = aoc.secondaryInputParser(input);
      print(validInputs);

      expect(validInputs.length, 0, reason: 'there are no valid inputs');
    });

    test('test case for several corresponding dont', () {
      final input =
          r"~%mul(944,505)why()?$*?from(953,19)do()mul(260,781)),don't()@from(20,864):^#}from()mul(904,64)}>mul(32,251) ]-'%+%/mul(537,614)why()what()select()^&where()what(761,969)<mul(394,510)how()who()what()>mul(666,129)when()]}($>when()-<mul(906,339),,how()~mul(172,337):-what()mul(961,996)where()%$}'/don't()who()~*@?)(,mul(200,564)'?%]#~!who()mul(446,6)&*^{mul(206,389)[mul(668,856)>@;don't()@*from()from()how() '#mul(671,116)where(),what()&]+from())$*mul(725,537))who()<*<+from()where()mul(209,705)/!!#mul(631,654);)>*#/}mul-how():}{]from()<mul(410,570)>^%where(){'<;who() mul(916,187),mul(627,593),>)+?why()<+?mul(772,583);;why()@mul(676,125)from()(where()where()what()mul(315,458)&'%%?$mul(967,658)from()mul(639,853)}>who()mul(569,506) what()what()what()'}<]%mul(674,667)[+how()where()select()&why()>&'mul(619,606)who()who(){from()<~[?/mul(257,454)(*&]@[ ]+don't()%:%why()+>&#(-mul(524,120)},mul(68,702)!mul(734,878):where(),#mul(363,999)!$~#&from()^<*how()mul(583,385)mul(609,453)who()mul(198,289)mul(456,335))select()when():}'mul(152,156)]&who()?~what():'mul(595,969)from();why()when()*+#why()from()!don't()'when()(;'?how()]'mul(978,210)#&when()how()):%?^]mul(395,664)'mul(912,244){),@:?'who();";

      final validInputs = aoc.secondaryInputParser(input);
      print(validInputs);
      expect(
        validInputs.length,
        2,
        reason:
            'there are only 2 valid operations, all before the first don\'t',
      );
    });
  });
}
