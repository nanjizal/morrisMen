package morrisMen;
import morrisMen.MorrisNode;
// See MorrisBoard.hx it has comments that show the boad layout.
@:structInit
class NineMorrisBoard {
    var sx:     Float; // 100
    var sy:     Float; // 100
    var inaWid: Float; // 30
    public var connections = new Array<MorrisConnection>();
    public var morrisNodes = new Array<MorrisNode>();
    public function new( sx: Float, sy: Float, inaWid: Float ){
        this.inaWid = inaWid;
        this.sx = sx;
        this.sy = sy;
    }
    public function generate(){
        var inaGap = inaWid/2;
        
        var largeGap = inaGap*3;
        var largeWid = largeGap*2;
        
        var midGap = inaGap*2;
        var midWid = midGap*2;

        var dx = 0.;
        var dy = 0.;
        // top row
        dx = sx;
        dy = sy;
        var ma: MorrisNode = { pos: { x: dx, y: dy }, name: 'ma' };
        dx += largeGap;
        var mb: MorrisNode = { pos: { x: dx, y: dy }, name: 'mb' };
        ma.addFriend( mb );
        dx += largeGap;
        var mc: MorrisNode = { pos: { x: dx, y: dy }, name: 'mc' };
        mb.addFriend( mc );
       
        // middle top row
        dx = sx + inaGap;
        dy = sy + inaGap;
        var md: MorrisNode = { pos: { x: dx, y: dy }, name: 'md' };
        dx += midGap;
        var me: MorrisNode = { pos: { x: dx, y: dy }, name: 'me' };
        me.addFriends( [ md, mb ] );
        dx += midGap;
        var mf: MorrisNode = { pos: { x: dx, y: dy }, name: 'mf' };
        md.addFriend( mf );
        
        // inner top row 
        dx = sx + midGap;
        dy = sy + midGap;
        var mg: MorrisNode = { pos: { x: dx, y: dy }, name: 'mg' };
        dx += inaGap;
        var mh: MorrisNode = { pos: { x: dx, y: dy }, name: 'mh' };
        mh.addFriends( [ mg, me ] );
        dx += inaGap;
        var mi: MorrisNode = { pos: { x: dx, y: dy }, name: 'mi' };
        mh.addFriend( mi );
        
        // whole middle row 
        dx = sx;
        dy = sy + largeGap;
        var mj: MorrisNode = { pos: { x: dx, y: dy }, name: 'mj' };
        ma.addFriend( mj );
        dx += inaGap;
        var mk: MorrisNode = { pos: { x: dx, y: dy }, name: 'mk' };
        mk.addFriends( [ mj, md ] );
        dx += inaGap;
        var ml: MorrisNode = { pos: { x: dx, y: dy }, name: 'ml' };
        mk.addFriend( ml );
    
        dx += inaWid;
        var mm: MorrisNode = { pos: { x: dx, y: dy }, name: 'mm' };
        mi.addFriend( mm );
        dx += inaGap;
        var mn: MorrisNode = { pos: { x: dx, y: dy }, name: 'mn' };
        mn.addFriends( [ mf, mn ] );
        dx += inaGap;
        var mo: MorrisNode = { pos: { x: dx, y: dy }, name: 'mo' };
        mo.addFriends( [ mc, mn ] );
        
        // inner bottom row
        var dx = sx + midGap;
        var dy = sy + midWid;
        var mp: MorrisNode = { pos: { x: dx, y: dy }, name: 'mp' };
        ml.addFriend( mp );
        dx += inaGap;
        var mq: MorrisNode = { pos: { x: dx, y: dy }, name: 'mq' };
        mp.addFriend( mq );
        dx += inaGap;
        var mr: MorrisNode = { pos: { x: dx, y: dy }, name: 'mr' };
        mr.addFriend( mr );
    
        // middle bottom row
        var dx = sx + inaGap;
        var dy = sy + inaGap + midWid;
        var ms: MorrisNode = { pos: { x: dx, y: dy }, name: 'ms' };
        ms.addFriend( mk );
        dx += midGap;
        var mt: MorrisNode = { pos: { x: dx, y: dy }, name: 'mt' };
        mt.addFriends( [ mq, ms ] );
        dx += midGap;
        var mu: MorrisNode = { pos: { x: dx, y: dy }, name: 'mu' };
        mu.addFriends( [ mn, mt ] );
        
        // bottom row 
        var dx = sx;
        var dy = sy + largeWid;
        var mv: MorrisNode = { pos: { x: dx, y: dy }, name: 'mv' };
        mj.addFriend( mv );
        dx += largeGap;
        var mw: MorrisNode = { pos: { x: dx, y: dy }, name: 'mw' };
        mw.addFriends( [ mt, mv ] );
        dx += largeGap;
        var mx: MorrisNode = { pos: { x: dx, y: dy }, name: 'mx' };
        mx.addFriends( [ mo, mw ] );
        
        morrisNodes = [ ma, mb, mc 
                      , md, me, mf
                      , mg, mh, mi
                      , mj, mk, ml, mm, mn, mo
                      , mp, mq, mr
                      , ms, mt, mu
                      , mv, mw, mx ];
                      
        connections = [ side( ma, mb ), side( mb, mc ) // top row hori
                      , side( ma, mj ), side( mc, mo ) // top vert
                      , side( mb, me ), side( me, mh ) // middle top vert
                      , side( md, me ), side( me, mf ) // mid row hori
                      , side( md, mk ), side( mf, mn ) // mid top vert
                      , side( mg, mh ), side( mh, mi ) // inner top hori
                      , side( mg, ml ), side( mi, mm ) // inner top vert
                      , side( mj, mk ), side( mk, ml ), side( mm, mn ), side( mn, mo ) // middle horrizontal
                      , side( ml, mp ), side( mr, mm )// inner bottom vert
                      , side( mp, mq ), side( mq, mr )// inner bottom hori
                      , side( mk, ms ), side( mn, mu )// mid bottom vert
                      , side( ms, mt ), side( mt, mu )// mid bottom hori
                      , side( mj, mv ), side( mo, mx )// bottom hori
                      , side( mq, mt ), side( mt, mw )// middle bottom vert
                      , side( mv, mw ), side( mw, mx )];
    }
    public inline
    function side( ma: MorrisNode, mb: MorrisNode ): MorrisConnection {
        var con: MorrisConnection =  { a: ma.pos3D, b: mb.pos3D };
        return con;
    }
}
