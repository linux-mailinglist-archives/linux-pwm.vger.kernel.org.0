Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEC8918CBFC
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2020 11:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCTKyI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Mar 2020 06:54:08 -0400
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:51724 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726806AbgCTKyH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Mar 2020 06:54:07 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2020 06:54:07 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id A381418025DD6
        for <linux-pwm@vger.kernel.org>; Fri, 20 Mar 2020 10:47:24 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 73F96182CF66A;
        Fri, 20 Mar 2020 10:47:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3871:4250:4321:5007:6119:7903:10004:10400:10848:11026:11232:11473:11658:11914:12296:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21617:21740:21990:30045:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: plant48_233358f93502b
X-Filterd-Recvd-Size: 2147
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Mar 2020 10:47:21 +0000 (UTC)
Message-ID: <f957b11abb70457e7bd8c2652d41e7f07024e301.camel@perches.com>
Subject: Re: [PATCH v11 08/12] pwm: stm32-lp: Use %llu format specifier for
 period
From:   Joe Perches <joe@perches.com>
To:     Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Date:   Fri, 20 Mar 2020 03:45:35 -0700
In-Reply-To: <5ea1fa27dd036ce732c1c7a1a5d84362752a911f.1584667964.git.gurus@codeaurora.org>
References: <cover.1584667964.git.gurus@codeaurora.org>
         <5ea1fa27dd036ce732c1c7a1a5d84362752a911f.1584667964.git.gurus@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 2020-03-19 at 18:41 -0700, Guru Das Srinagesh wrote:
> Since the PWM framework is switching struct pwm_args.period's
> datatype to u64, prepare for this transition by using the right
> specifier for printing a 64-bit value.
[]
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
[]
> @@ -61,7 +61,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	do_div(div, NSEC_PER_SEC);
>  	if (!div) {
>  		/* Clock is too slow to achieve requested period. */
> -		dev_dbg(priv->chip.dev, "Can't reach %u ns\n",	state->period);
> +		dev_dbg(priv->chip.dev, "Can't reach %llu ns\n", state->period);
>  		return -EINVAL;
>  	}

Doesn't this introduce a warning now without the
actual change to the type of state->period?

Likely these patches should either not be separated
or this should also use a cast to avoid introducing
intermediate compilation warnings.


