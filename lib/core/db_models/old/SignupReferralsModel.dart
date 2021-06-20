import 'package:fielder_models/core/db_models/old/schema/signupReferralsSchema.dart';

class SignupReferralsModel{

 num queuePosition;
 num successfulReferrals;
 String workerReferralLink;

 SignupReferralsModel(
      {this.queuePosition, this.successfulReferrals, this.workerReferralLink});

 factory SignupReferralsModel.fromMap(Map map){
   if(map != null){
     try{
       return SignupReferralsModel(
         queuePosition: map[SignupReferralsSchema.queuePosition],
         successfulReferrals: map[SignupReferralsSchema.successfulReferrals] ,
         workerReferralLink: map[SignupReferralsSchema.workerReferralLink],
       );
     }catch(e){
       print("signup referral model catch $e");
       return null;
     }
   }
   return null;
 }
}