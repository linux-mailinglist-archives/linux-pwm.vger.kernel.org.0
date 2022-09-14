Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2363E5B8B56
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Sep 2022 17:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiINPHG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Sep 2022 11:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiINPGy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Sep 2022 11:06:54 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC037755D;
        Wed, 14 Sep 2022 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663168012; x=1694704012;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1U5b5xba0bGX2WvCyPjQbyhmhiLuuTYENn1IHzIT6BA=;
  b=XdpfJwODmmCnvCqsD33BPA5g5NEeJUctUzJYly+UVz+S1TVGLHZXHvsp
   rGVn1JAAzSbnFRgUq1NSsVtSQzOHSLC2h8bpR2LOcTbLFKHd7XsaC3b5W
   p+czvf2Rk1a8cSYm3ZMg7LImdmO6POCAkRjxC7u9d0imVlLVYYKrnT8n8
   E0+2KpS4tc6pMUelvqyDlg5Q0vyJKROmSppM2VIfxIXiRfKtyP0TSmA4U
   ImsEAwuA7iTUgQ3L+GB4L4ipJjwonZnzeEpG4hGc9UiMDSDQOuGSvm+g6
   xeXHbBsQ7dqDlLbK77ejXIlgm4jPl/J+/4kaLTKc5QDlnKKHBPBziEOTK
   A==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654552800"; 
   d="scan'208";a="26180751"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 14 Sep 2022 17:06:49 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 14 Sep 2022 17:06:49 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 14 Sep 2022 17:06:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663168009; x=1694704009;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=1U5b5xba0bGX2WvCyPjQbyhmhiLuuTYENn1IHzIT6BA=;
  b=mQJ38+DJZBRdO34q2VLdwzIJz9FvV9dgh/d0IlnTrXE3EGd8lRQrKGM6
   2FOaEAx9El6hR1N8hkMn2jkx7KduIfU1afzuBST8zjAQW4twstj5J/9RT
   D1aLLUJ4S0vwVTd788J+J93k9mKm97M7mpr9yol1uY6y6rtQd4nbaVUV1
   32/9kaM0D2W6+WJ1rfST7wS68dtIBGCtD+wqP48rRBNXzvqt4K0FjQZhK
   hJ03CTj+7w0MiNBTu9JcqzrcsgsO+VX9F2u69xKcM5UGZ5K12py/Mnww8
   slm3dKkwwBtkEB+jplUYnVm2bcXya8/yuBVLXAFEvvySCT4MRW6QzK4em
   g==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654552800"; 
   d="scan'208";a="26180750"
Subject: Re: Re: [PATCH v4 2/6] hwmon: pwm-fan: Simplify enable/disable check
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 14 Sep 2022 17:06:49 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 6D758280056;
        Wed, 14 Sep 2022 17:06:49 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Date:   Wed, 14 Sep 2022 17:06:47 +0200
Message-ID: <4626851.tdWV9SEqCh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220830134338.GA229551@roeck-us.net>
References: <20220523110513.407516-1-alexander.stein@ew.tq-group.com> <20220523110513.407516-3-alexander.stein@ew.tq-group.com> <20220830134338.GA229551@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Guenter,

thanks for your feedback.

Am Dienstag, 30. August 2022, 15:43:38 CEST schrieb Guenter Roeck:
> On Mon, May 23, 2022 at 01:05:09PM +0200, Alexander Stein wrote:
> > Instead of comparing the current to the new pwm duty to decide whether to
> > enable the PWM, use a dedicated flag. Also apply the new PWM duty in any
> > case. This is a preparation to enable/disable the regulator dynamically.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > 
> >  drivers/hwmon/pwm-fan.c | 37 +++++++++++++++++++++++++++++--------
> >  1 file changed, 29 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> > index 831878daffe6..96b10d422828 100644
> > --- a/drivers/hwmon/pwm-fan.c
> > +++ b/drivers/hwmon/pwm-fan.c
> > @@ -29,10 +29,13 @@ struct pwm_fan_tach {
> > 
> >  };
> >  
> >  struct pwm_fan_ctx {
> > 
> > +	struct device *dev;
> > +
> > 
> >  	struct mutex lock;
> >  	struct pwm_device *pwm;
> >  	struct pwm_state pwm_state;
> >  	struct regulator *reg_en;
> > 
> > +	bool enabled;
> > 
> >  	int tach_count;
> >  	struct pwm_fan_tach *tachs;
> > 
> > @@ -85,14 +88,21 @@ static void sample_timer(struct timer_list *t)
> > 
> >  static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
> >  {
> >  
> >  	struct pwm_state *state = &ctx->pwm_state;
> > 
> > -	unsigned long period;
> > 
> >  	int ret;
> > 
> > -	period = state->period;
> > -	state->duty_cycle = DIV_ROUND_UP(ctx->pwm_value * (period - 1),
> > MAX_PWM);
> > +	if (ctx->enabled)
> > +		return 0;
> > +
> > 
> >  	state->enabled = true;
> >  	ret = pwm_apply_state(ctx->pwm, state);
> > 
> > +	if (ret) {
> > +		dev_err(ctx->dev, "failed to enable PWM\n");
> > +		goto err;
> 
> There is no reason for this goto. Just return directly.

Sure, will do so.

> > +	}
> > 
> > +	ctx->enabled = true;
> > +
> > 
> > +err:
> >  	return ret;
> >  
> >  }
> > 
> > @@ -100,26 +110,36 @@ static int pwm_fan_power_off(struct pwm_fan_ctx
> > *ctx)
> > 
> >  {
> >  
> >  	struct pwm_state *state = &ctx->pwm_state;
> > 
> > +	if (!ctx->enabled)
> > +		return 0;
> > +
> 
> ctx->enabled will initially be false. How is it known that pwm is
> disabled when the driver is loaded ? At the very least that warrants
> an explanation.

I'm not sure what you are concerned about. The PWM is enabled in probe 
unconditionally, calling __set_pwm(ctx, MAX_PWM).

> >  	state->enabled = false;
> >  	state->duty_cycle = 0;
> >  	pwm_apply_state(ctx->pwm, state);
> 
> This code is a bit inconsistent with pwm_fan_power_on(). Why check for
> error there, but not here ?

You are right, make sense to check in both functions.

Thanks and best regards
Alexander

> > +	ctx->enabled = false;
> > +
> > 
> >  	return 0;
> >  
> >  }
> >  
> >  static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
> >  {
> > 
> > +	struct pwm_state *state = &ctx->pwm_state;
> > +	unsigned long period;
> > 
> >  	int ret = 0;
> >  	
> >  	mutex_lock(&ctx->lock);
> > 
> > -	if (ctx->pwm_value == pwm)
> > -		goto exit_set_pwm_err;
> > 
> > -	if (pwm > 0)
> > +	if (pwm > 0) {
> > +		period = state->period;
> > +		state->duty_cycle = DIV_ROUND_UP(pwm * (period - 1), 
MAX_PWM);
> > +		ret = pwm_apply_state(ctx->pwm, state);
> > +		if (ret)
> > +			goto exit_set_pwm_err;
> > 
> >  		ret = pwm_fan_power_on(ctx);
> > 
> > -	else
> > +	} else {
> > 
> >  		ret = pwm_fan_power_off(ctx);
> > 
> > -
> > +	}
> > 
> >  	if (!ret)
> >  	
> >  		ctx->pwm_value = pwm;
> > 
> > @@ -326,6 +346,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
> > 
> >  	mutex_init(&ctx->lock);
> > 
> > +	ctx->dev = &pdev->dev;
> > 
> >  	ctx->pwm = devm_of_pwm_get(dev, dev->of_node, NULL);
> >  	if (IS_ERR(ctx->pwm))
> >  	
> >  		return dev_err_probe(dev, PTR_ERR(ctx->pwm), "Could not 
get PWM\n");




