package morrisMen;
import morrisMen.MorrisNode;
@:structInit
class NineMorrisBoard {
    var sx:     Float; // 100
    var sy:     Float; // 100
    var inaWid: Float; // 30
    public var morrisNodes = new Array<MorrisNode>();
    public function new( sx: Float, sy: Float, inaWid: Float ){
        this.inaWid = inaWid;
        this.sx = sx;
        this.sy = sy;
    }
    public function generate(){
        var inaGap = inaWid/2;
        var midWid = inaWid*3;
        var midGap = midWid/2;
        var outWid = midWid*3;
        var outGap = outWid/2;

        var dx = 0.;
        var dy = 0.;
        // top row
        dx = sx;
        dy = sy;
        var ma: MorrisNode = { pos: { x: dx, y: dy }, name: 'ma' };
        dx += outGap;
        var mb: MorrisNode = { pos: { x: dx, y: dy }, name: 'mb' };
        ma.addFriend( mb );
        dx += outGap;
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
        dx = sx + midGap;
        dy = sy + midGap;
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
        var dx = sx + midWid;
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
        var dy = sy + outWid;
        var mv: MorrisNode = { pos: { x: dx, y: dy }, name: 'mv' };
        mj.addFriend( mv );
        dx += outGap;
        var mw: MorrisNode = { pos: { x: dx, y: dy }, name: 'mw' };
        mw.addFriends( [ mt, mv ] );
        dx += outGap;
        var mx: MorrisNode = { pos: { x: dx, y: dy }, name: 'mx' };
        mx.addFriends( [ mo, mw ] );
        
        morrisNodes = [ ma, mb, mc
                      , md, me, mf
                      , mg, mh, mi
                      , mj, mk, ml, mm, mn, mo
                      , mp, mq, mr
                      , ms, mt, mu
                      , mv, mw, mx ];
    }

}