Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7646E4AD1E5
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Feb 2022 08:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiBHHFA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Feb 2022 02:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiBHHE5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Feb 2022 02:04:57 -0500
Received: from mx.tkos.co.il (guitar.tcltek.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A69C0401EF
        for <linux-pwm@vger.kernel.org>; Mon,  7 Feb 2022 23:04:55 -0800 (PST)
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id D4955440F82;
        Tue,  8 Feb 2022 09:04:29 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1644303870;
        bh=CoMpoM4K1lZgIZZ/gT4uGOcMYzm4yu3oXE6YWk7Pl3E=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=iuQ/CUexAXl4o9mo57d2MTUi6AjojpLmZvL5XX9otbayEhRWQNIfkFbt0jRjjXMMj
         +xHUsWbFYc1Sw5vD+0krknkTYdyJ/xl4IPW0vgIP/bPsIR12j8lTgrC6Xzi1z0neZ+
         WlIKKmv83YCdDwvxGFnQTq4VvOl+cw9o1c+m39r1wJBIWKnfQPDegSRkP3sZSqZs4y
         1p6ZkuOUN4GQesMTzqoZdoOorf79tOtm22lQ4NQ85U93vAh1EOgsaBmcuQFI/R+YR7
         esKK/LbJGgeMRImEg7aTKt4PrkeAbdCoJyKpy5M7++6JDyxj/9Q2dT/JAjnGsL93tt
         9sP3cctqL/8qw==
References: <17dd231f496d09ed8502bdd505eaa77bb6637e4b.1644226245.git.baruch@tkos.co.il>
 <202202080410.R0qwqtXx-lkp@intel.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     kernel test robot <lkp@intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K?= =?utf-8?Q?=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/3] pwm: driver for qualcomm ipq6018 pwm block
Date:   Tue, 08 Feb 2022 08:51:40 +0200
In-reply-to: <202202080410.R0qwqtXx-lkp@intel.com>
Message-ID: <87ee4ddejv.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi test robot,

Thanks for testing and reporting.

On Tue, Feb 08 2022, kernel test robot wrote:

[snip]

>>> drivers/pwm/pwm-ipq.c:122:11: warning: result of comparison of constant 16000000000 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
>            if (rate > 16ULL * GIGA)
>                ~~~~ ^ ~~~~~~~~~~~~
>    1 warning generated.

This clang warning is only enabled with W=1 (see commit
afe956c577b). Not sure how to avoid it.

Is there a way to express this condition without making clang warn on
platforms where ULONG_MAX == 2^32? Maybe cast to unsigned long long? Or
should we just ignore this W=1 warning?

baruch

> vim +122 drivers/pwm/pwm-ipq.c
>
>     99	
>    100	static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>    101				 const struct pwm_state *state)
>    102	{
>    103		struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(chip);
>    104		unsigned int pre_div, pwm_div, best_pre_div, best_pwm_div;
>    105		unsigned long rate = clk_get_rate(ipq_chip->clk);
>    106		u64 period_ns, duty_ns, period_rate;
>    107		u64 min_diff;
>    108	
>    109		if (state->polarity != PWM_POLARITY_NORMAL)
>    110			return -EINVAL;
>    111	
>    112		if (state->period < DIV64_U64_ROUND_UP(NSEC_PER_SEC, rate))
>    113			return -ERANGE;
>    114	
>    115		period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
>    116		duty_ns = min(state->duty_cycle, period_ns);
>    117	
>    118		/*
>    119		 * period_ns is 1G or less. As long as rate is less than 16 GHz,
>    120		 * period_rate does not overflow. Make that explicit.
>    121		 */
>  > 122		if (rate > 16ULL * GIGA)
>    123			return -EINVAL;
>    124		period_rate = period_ns * rate;
>    125		best_pre_div = IPQ_PWM_MAX_DIV;
>    126		best_pwm_div = IPQ_PWM_MAX_DIV;
>    127		/*
>    128		 * We don't need to consider pre_div values smaller than
>    129		 *
>    130		 *                              period_rate
>    131		 *  pre_div_min := ------------------------------------
>    132		 *                 NSEC_PER_SEC * (IPQ_PWM_MAX_DIV + 1)
>    133		 *
>    134		 * because pre_div = pre_div_min results in a better
>    135		 * approximation.
>    136		 */
>    137		pre_div = div64_u64(period_rate,
>    138				(u64)NSEC_PER_SEC * (IPQ_PWM_MAX_DIV + 1));
>    139		min_diff = period_rate;
>    140	
>    141		for (; pre_div <= IPQ_PWM_MAX_DIV; pre_div++) {
>    142			u64 remainder;
>    143	
>    144			pwm_div = div64_u64_rem(period_rate,
>    145					(u64)NSEC_PER_SEC * (pre_div + 1), &remainder);
>    146			/* pwm_div is unsigned; the check below catches underflow */
>    147			pwm_div--;
>    148	
>    149			/*
>    150			 * Swapping values for pre_div and pwm_div produces the same
>    151			 * period length. So we can skip all settings with pre_div >
>    152			 * pwm_div which results in bigger constraints for selecting
>    153			 * the duty_cycle than with the two values swapped.
>    154			 */
>    155			if (pre_div > pwm_div)
>    156				break;
>    157	
>    158			/*
>    159			 * Make sure we can do 100% duty cycle where
>    160			 * hi_dur == pwm_div + 1
>    161			 */
>    162			if (pwm_div > IPQ_PWM_MAX_DIV - 1)
>    163				continue;
>    164	
>    165			if (remainder < min_diff) {
>    166				best_pre_div = pre_div;
>    167				best_pwm_div = pwm_div;
>    168				min_diff = remainder;
>    169	
>    170				if (min_diff == 0) /* bingo */
>    171					break;
>    172			}
>    173		}
>    174	
>    175		/* config divider values for the closest possible frequency */
>    176		config_div_and_duty(pwm, best_pre_div, best_pwm_div,
>    177				    rate, duty_ns, state->enabled);
>    178	
>    179		return 0;
>    180	}
>    181	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
