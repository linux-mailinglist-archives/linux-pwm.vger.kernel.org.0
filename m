Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843944AE164
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Feb 2022 19:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbiBHSsI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Feb 2022 13:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385444AbiBHSsH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Feb 2022 13:48:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE193C06157B
        for <linux-pwm@vger.kernel.org>; Tue,  8 Feb 2022 10:48:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88294B81CE1
        for <linux-pwm@vger.kernel.org>; Tue,  8 Feb 2022 18:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EDAC004E1;
        Tue,  8 Feb 2022 18:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346083;
        bh=NOZKiLZ8SICy8tURJRYcaUEASF+7cKs/o7MVfPdHg9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NljL7/xLZ2AKlAqCPQJn7sQrdbvhwgUqdC1J/DOBloskqpw0vtJlEz2H3eaD1mdBq
         dX4yOArMkehTASdmPUxcVZHNlemdxWVEhTq24VDVM7NUSpoN2wK8wWs/i0+9G7bZxj
         yUsg93NXKzfdGfe2Pe8yGANP/fEfvCoLYPBAMibZ6khpKzrMZ96XdVSCVlG4b/WZ/5
         YZFFoo2oxTzOl1bvfI/BzrSvg800bG8FcKgMJvVT+/EBUwZ4z3tm1b9AAopyQppabu
         j0Pu66UFSt/pL7YQ7MGgml1NF/ntTB6HErsj7ItDUn+Vip3N8IsfbJsjsdd0kElM30
         F+6G8RLKCwQ6w==
Date:   Tue, 8 Feb 2022 11:47:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     kernel test robot <lkp@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/3] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <YgK63cI177ZeF5v1@dev-arch.archlinux-ax161>
References: <17dd231f496d09ed8502bdd505eaa77bb6637e4b.1644226245.git.baruch@tkos.co.il>
 <202202080410.R0qwqtXx-lkp@intel.com>
 <87ee4ddejv.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee4ddejv.fsf@tarshish>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Baruch,

On Tue, Feb 08, 2022 at 08:51:40AM +0200, Baruch Siach wrote:
> Hi test robot,
> 
> Thanks for testing and reporting.
> 
> On Tue, Feb 08 2022, kernel test robot wrote:
> 
> [snip]
> 
> >>> drivers/pwm/pwm-ipq.c:122:11: warning: result of comparison of constant 16000000000 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
> >            if (rate > 16ULL * GIGA)
> >                ~~~~ ^ ~~~~~~~~~~~~
> >    1 warning generated.
> 
> This clang warning is only enabled with W=1 (see commit
> afe956c577b). Not sure how to avoid it.
> 
> Is there a way to express this condition without making clang warn on
> platforms where ULONG_MAX == 2^32? Maybe cast to unsigned long long? Or
> should we just ignore this W=1 warning?

As far as I am aware, casting to unsigned long long would be an
appropriate way to fix this warning, as has been done in the following
patches in mainline:

c9ae8eed4463 ("media: omap3isp: avoid warnings at IS_OUT_OF_BOUNDS()")
4853396f03c3 ("memstick: avoid out-of-range warning")
7ff4034e910f ("staging: vc04_services: shut up out-of-range warning")
a2fa9e57a68c ("ARM: mvebu: avoid clang -Wtautological-constant warning")

The below diff fixes the warning for me with ARCH=hexagon allyesconfig:

diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
index 994027290bcb..7ea29468e76e 100644
--- a/drivers/pwm/pwm-ipq.c
+++ b/drivers/pwm/pwm-ipq.c
@@ -119,7 +119,7 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * period_ns is 1G or less. As long as rate is less than 16 GHz,
 	 * period_rate does not overflow. Make that explicit.
 	 */
-	if (rate > 16ULL * GIGA)
+	if ((unsigned long long)rate > 16ULL * GIGA)
 		return -EINVAL;
 	period_rate = period_ns * rate;
 	best_pre_div = IPQ_PWM_MAX_DIV;

Alternatively, you could widen rate to unsigned long long / u64 but I
don't know what kind of implications that has in this function but it
has been done in other places:

95c58291ee70 ("drm/msm/submit: fix overflow check on 64-bit architectures")
cfd6fb45cfaf ("crypto: ccree - avoid out-of-range warnings from clang")
335aea75b0d9 ("drm/amdgpu: fix warning for overflow check")
844b85dda2f5 ("ARM: keystone: fix integer overflow warning")

While the warning is currently under W=1, I think it is one that we
would like to turn on at some point so fixing instances as they come up
helps us get closer to that goal.

Cheers,
Nathan

> > vim +122 drivers/pwm/pwm-ipq.c
> >
> >     99	
> >    100	static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >    101				 const struct pwm_state *state)
> >    102	{
> >    103		struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(chip);
> >    104		unsigned int pre_div, pwm_div, best_pre_div, best_pwm_div;
> >    105		unsigned long rate = clk_get_rate(ipq_chip->clk);
> >    106		u64 period_ns, duty_ns, period_rate;
> >    107		u64 min_diff;
> >    108	
> >    109		if (state->polarity != PWM_POLARITY_NORMAL)
> >    110			return -EINVAL;
> >    111	
> >    112		if (state->period < DIV64_U64_ROUND_UP(NSEC_PER_SEC, rate))
> >    113			return -ERANGE;
> >    114	
> >    115		period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
> >    116		duty_ns = min(state->duty_cycle, period_ns);
> >    117	
> >    118		/*
> >    119		 * period_ns is 1G or less. As long as rate is less than 16 GHz,
> >    120		 * period_rate does not overflow. Make that explicit.
> >    121		 */
> >  > 122		if (rate > 16ULL * GIGA)
> >    123			return -EINVAL;
> >    124		period_rate = period_ns * rate;
> >    125		best_pre_div = IPQ_PWM_MAX_DIV;
> >    126		best_pwm_div = IPQ_PWM_MAX_DIV;
> >    127		/*
> >    128		 * We don't need to consider pre_div values smaller than
> >    129		 *
> >    130		 *                              period_rate
> >    131		 *  pre_div_min := ------------------------------------
> >    132		 *                 NSEC_PER_SEC * (IPQ_PWM_MAX_DIV + 1)
> >    133		 *
> >    134		 * because pre_div = pre_div_min results in a better
> >    135		 * approximation.
> >    136		 */
> >    137		pre_div = div64_u64(period_rate,
> >    138				(u64)NSEC_PER_SEC * (IPQ_PWM_MAX_DIV + 1));
> >    139		min_diff = period_rate;
> >    140	
> >    141		for (; pre_div <= IPQ_PWM_MAX_DIV; pre_div++) {
> >    142			u64 remainder;
> >    143	
> >    144			pwm_div = div64_u64_rem(period_rate,
> >    145					(u64)NSEC_PER_SEC * (pre_div + 1), &remainder);
> >    146			/* pwm_div is unsigned; the check below catches underflow */
> >    147			pwm_div--;
> >    148	
> >    149			/*
> >    150			 * Swapping values for pre_div and pwm_div produces the same
> >    151			 * period length. So we can skip all settings with pre_div >
> >    152			 * pwm_div which results in bigger constraints for selecting
> >    153			 * the duty_cycle than with the two values swapped.
> >    154			 */
> >    155			if (pre_div > pwm_div)
> >    156				break;
> >    157	
> >    158			/*
> >    159			 * Make sure we can do 100% duty cycle where
> >    160			 * hi_dur == pwm_div + 1
> >    161			 */
> >    162			if (pwm_div > IPQ_PWM_MAX_DIV - 1)
> >    163				continue;
> >    164	
> >    165			if (remainder < min_diff) {
> >    166				best_pre_div = pre_div;
> >    167				best_pwm_div = pwm_div;
> >    168				min_diff = remainder;
> >    169	
> >    170				if (min_diff == 0) /* bingo */
> >    171					break;
> >    172			}
> >    173		}
> >    174	
> >    175		/* config divider values for the closest possible frequency */
> >    176		config_div_and_duty(pwm, best_pre_div, best_pwm_div,
> >    177				    rate, duty_ns, state->enabled);
> >    178	
> >    179		return 0;
> >    180	}
> >    181	
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
> -- 
>                                                      ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
> 
