package morrisMen;
import htmlHelper.tools.DivertTrace;
import morrisMen.MorrisNode;
function main(){
    var divertTrace = new DivertTrace();
    var board = new NineMorrisBoard( 100., 100., 30. );
    board.generate();
    trace( board.morrisNodes );
}