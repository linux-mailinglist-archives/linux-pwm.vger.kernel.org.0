Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356D47DAC56
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Oct 2023 13:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjJ2MKO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Oct 2023 08:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2MKN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Oct 2023 08:10:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DD1BE;
        Sun, 29 Oct 2023 05:10:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF153C433C8;
        Sun, 29 Oct 2023 12:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698581408;
        bh=Tt2zBbYMPZAuRK60SLouG6hIoBx1BUwr3/PJQYhilQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTJcwgTpcvNVi65l6K3LPvwFBNlhbcf85N51LlceLdolMoiwtQGiPq3oLQrjEtSRr
         UZpwqUZCJijXj/AXm2QdBq8sSiHFV8zPDzJ69kvN1NeIsl9OAuCnYTRTCz3kAx4xP/
         IEekay5Z70j4Ct03QyuwStvWsumtnwCgArrs9nhk=
Date:   Sun, 29 Oct 2023 13:10:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] pwm: samsung: Document new member .channel in struct
 samsung_pwm_chip
Message-ID: <2023102946-chain-resource-ae1d@gregkh>
References: <20231012210228.1009473-2-u.kleine-koenig@pengutronix.de>
 <169720375693.285367.8034783567173304872.b4-ty@gmail.com>
 <20231013172750.nxcw2ftihpemnymx@pengutronix.de>
 <20231024145524.7qkzrrdm6zg5hfji@pengutronix.de>
 <fa624966-176a-47d1-937d-8384fda06513@linaro.org>
 <20231024164627.ejcqrtbhvohduvpg@pengutronix.de>
 <c3495c6d-72e3-493b-99ed-47e8cd3f1108@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3495c6d-72e3-493b-99ed-47e8cd3f1108@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Oct 29, 2023 at 12:07:02PM +0100, Krzysztof Kozlowski wrote:
> On 24/10/2023 18:46, Uwe Kleine-König wrote:
> > On Tue, Oct 24, 2023 at 04:58:22PM +0200, Krzysztof Kozlowski wrote:
> >> On 24/10/2023 16:55, Uwe Kleine-König wrote:
> >>> Hello,
> >>>
> >>> On Fri, Oct 13, 2023 at 07:27:50PM +0200, Uwe Kleine-König wrote:
> >>>> On Fri, Oct 13, 2023 at 03:29:35PM +0200, Thierry Reding wrote:
> >>>>> On Thu, 12 Oct 2023 23:02:29 +0200, Uwe Kleine-König wrote:
> >>>>>> Fixes: 4c9548d24c0d ("pwm: samsung: Put per-channel data into driver data")
> >>>>>
> >>>>> Applied, thanks!
> >>>>>
> >>>>> [1/1] pwm: samsung: Document new member .channel in struct samsung_pwm_chip
> >>>>>       commit: 4bb36d126cb3147d6bbfd00242a5b846dacad595
> >>>>
> >>>> You might want to change 4c9548d24c0d to e3fe982b2e4e now that you
> >>>> rewrote your for-next branch.
> >>>
> >>> This is still open. I wonder there is no automated check that warns if
> >>> there is a Fixes: line in next that doesn't refer to an ancestor.
> >>
> >> I am using Greg's/Stephen's scripts in commit hooks:
> >> https://github.com/krzk/tools/blob/master/linux/git-hooks-post-commit
> >> https://github.com/krzk/tools/blob/master/linux/verify_fixes.sh
> > 
> > Skimming throud the verify_fixes script I'd say the following addition
> > to verify_fixes should do:
> > 
> > diff --git a/linux/verify_fixes.sh b/linux/verify_fixes.sh
> > index f22384bb6bb8..12e73da82dd4 100755
> > --- a/linux/verify_fixes.sh
> > +++ b/linux/verify_fixes.sh
> > @@ -100,6 +100,13 @@ verify_fixes()
> >  				continue
> >  			fi
> >  
> > +			if ! git merge-base --is-ancestor "$sha" "$c"; then
> > +				printf '%s%s\t\t- %s\n' "$commit_msg" "$fixes_msg" 'Target SHA should be an ancestor of your tree'
> > +				commit_msg=''
> > +				error=1
> > +				continue
> > +			fi
> > +
> >  			if [ "${#sha}" -lt 12 ]; then
> >  				msg="${msg:+${msg}${nl}}${tab}${tab}- SHA1 should be at least 12 digits long${nl}${tab}${tab}  Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11${nl}${tab}${tab}  or later) just making sure it is not set (or set to \"auto\")."
> >  			fi
> > 
> 
> Thanks Uwe for the snippet. I went further and it allowed to simplify
> checking for commit in Linus' tree.
> 
> Cc, Greg, Stephen,
> Maybe you will find it useful to update your scripts as well (I forked
> from yours):
> https://github.com/krzk/tools/commit/39d2c71a72f5d4f30d0752e45b9bcc09b75b5026
> 
> https://github.com/krzk/tools/commit/0061331501fac2f4b24709adb0ec5cf267bcb661#diff-0100377e067a4cd4cb89c0f0ae8732d3e814ed25e816a392bf2e0855a392adbcL11

Thanks, I've applied this to my tree, let's see how it works out.

greg k-h
