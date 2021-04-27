package morrisMen;
import geom.matrix.Matrix1x4;
import geom.matrix.Matrix1x2;
import fracs.Rose;
@:forward
enum abstract Piece_( Int ) from Int to Int {
    var NONE;
    var PLAY0;
    var PLAY1;
    var PLAY2;
    var PLAY3;
}
abstract Piece( Piece_ ) from Piece_ to Piece_ {
    public function new( p: Piece_ ){
        this = p;
    }
    @:to
    public function toString(): String {
        var p: Piece_ = ( this: Piece );
        return switch( p ){
            case NONE: 'NONE';
            case PLAY0: "PLAY0";
            case PLAY1: "PLAY1";
            case PLAY2: "PLAY2";
            case PLAY3: "PLAY3";
        }
    }
}
@:structInit
class FriendMorris {
    // direction as compass rose
    public var rose: Rose;
    // other morris node
    public var morrisNode: MorrisNode;
    public function new( morrisNode: MorrisNode, rose: Rose ){
        this.morrisNode = morrisNode;
        this.rose       = rose;
    }
}
@:structInit
class MilData {
    public var mils: Array<Rose>;
    public var twos: Array<Rose>;
    public function new( mils: Array<Rose>, twos: Array<Rose> ){
        this.mils = mils;
        this.twos = twos;
    }
}
@:structInit
class MorrisNode {
    public var pos: Matrix1x2;
    public var pos3D: Matrix1x4;
    public var name: String;
    // Compass position
    public var friends = new Array<FriendMorris>();
    // lets assume max number is 4 for 2D and 6 for 3D ( unsure if feasible )
    public var contain: Piece;
    public function new( pos: Matrix1x2, name: String = '', contain: Piece = NONE ){
        this.pos     = pos;
        this.contain = contain;
        this.name    = name;
        pos3D = { x: pos.x, y: pos.y, z: 0.1, w: 1. };
    }
    public inline
    function pieceMatch( friend: MorrisNode ){
        return friend.contain == contain;
    }
    public
    function isEmpty(){
        return ( contain == NONE );
    }
    public
    function checkMatchRose(): MilData {
        var mils = new Array<Rose>();
        var twos = new Array<Rose>();
        if( contain != NONE ){
            var nextRose:   Rose;
            var friend:     FriendMorris;
            var nextFriend: FriendMorris;
            for( i in 0...friends.length ){
                friend = friends[ i ];
                if( pieceMatch( friend.morrisNode ) ){
                    nextRose = friend.rose;
                    nextFriend = friend.morrisNode.getFriendWithRose( nextRose, contain );
                    if( nextFriend == null ){
                        twos[ twos.length ] = nextRose;
                    } else {
                        mils[ mils.length ] = nextFriend.rose;
                    }
                }
                
            }
        }
        return { mils: mils, twos: twos };
    }
    public
    function getFriendWithRose( rose: Rose, piece: Piece = NONE ): Null<FriendMorris> {
        var nextRose: Rose;
        var friend: FriendMorris = null;
        var found = false;
        for( i in 0...friends.length ){
            friend = friends[i];
            nextRose = friend.rose;
            trace( friend.morrisNode.name );
            trace( 'rose ' + rose + ' nextRose ' + nextRose );
            if( rose == nextRose ){
                found == true; 
                break;
            }
        }
        return if( found ) {
            trace( friend.morrisNode );
            if( pieceMatch( friend.morrisNode ) ) {
                friend;
            } else {
                null;
            }
        } else {
            null;
        }
    }
    public
    function firstFriend(){
        return friends[0];
    }
    public
    function addFriends( all: Array<MorrisNode> ){
        var morrisNode: MorrisNode;
        for( i in 0...all.length ){
            morrisNode = all[ i ];
            addFriend( morrisNode );
        }
    }
    public
    function addFriend( morris: MorrisNode ){
        if( !hasFriend( morris ) ){
            var rose = calculateMorrisRose( morris );
            var newFriend: FriendMorris =  { morrisNode: morris, rose: rose };
            friends[ friends.length ] = newFriend;
            if( newFriend.morrisNode.hasFriend( this ) ){
                // don't add
            } else {
                newFriend.morrisNode.addFriend( this );
            }
        }
    }
    public
    function hasFriend( morris: MorrisNode ){
        var found = false;
        var friend: FriendMorris;
        if( morris != null ){
            for( i in 0...friends.length ){
                friend = friends[i];
                if( friend.morrisNode == morris ){
                    found = true;
                    break;
                }
            }
        }
        return found;
    }
    public 
    function calculateMorrisRose( morris: MorrisNode ): Rose {
        // calculate angle, not sure this is working correctly.
        var posNext: Matrix1x2 = morris.pos;
        var theta = Matrix1x2.thetaDifference( pos, posNext ); // need to check.
        var rose: Rose = theta;// - Math.PI/4;
        return rose;
    }
}
