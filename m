Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31175B8B72
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Sep 2022 17:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiINPKh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Sep 2022 11:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiINPK0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Sep 2022 11:10:26 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9883D5BB;
        Wed, 14 Sep 2022 08:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663168224; x=1694704224;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k0crXHCpRY7Ny0S26Bsc+YpoBbnEdJxoEgcWSdYzwLU=;
  b=emRBALQ90WU5TuH4amu8VCi//lY4XajUdQK5Ach/koiD34i4KMi6OAZy
   c7iWhDOc1vD/X9RF7OARiMis96n5CMddBi4xrE0i9fuE2RVQC8FCN6cNV
   5U0btwYghW3qpnmbz7TrMjpY8LFFWjtqI+ckAe4uITOBNWnYQ7aoHvbJd
   pAAR4aTLV9Lm6FsPsQNkGp6NaSXxHVti8IkcDgqUi4wq7tAL6P0GCypGU
   afO8W6U9yjmxKJeq4n7LeyJKwx+GFAkHOiobY/Ch/bQcFsqYZa/AuDpgN
   98shCGQm5bWibohSMhdVSUWdd05VJ/TWBxZxPnx+fLXyFoSLB4qn5++mc
   w==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654552800"; 
   d="scan'208";a="26180840"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 14 Sep 2022 17:10:22 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 14 Sep 2022 17:10:22 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 14 Sep 2022 17:10:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663168222; x=1694704222;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=k0crXHCpRY7Ny0S26Bsc+YpoBbnEdJxoEgcWSdYzwLU=;
  b=lPIY1o6T5AaKQaRsNV/HL09SXduaVLnkV/ykPHuQic0COhN56dTwXHSf
   cqUCL7G8oLRMTFYe6NQd42CwqPcB/KLPEOc8RVuOZeLygycUVVnUEJLZ0
   56U8ibhweyyOTuZ8OUUcP3twqya0v8lzYj2S+U8cqCsOXDN2KoCAY+0Uw
   Fwm82hnAYrzyB9MGoFBTVVHjBPK2dXmNZdYsIyOvErfCw608MO2XxA6rF
   mm4q0aV8u01RAc6VEYSMQsKSpZanWHY8Z/6HaMwIR92k4jsD7XZbexCCu
   CtaRFmXrsqSZPTRx6GfuQ15cGDisfTL2Fr5/9tsQrsN8DhChs36KSw9VK
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654552800"; 
   d="scan'208";a="26180839"
Subject: Re: Re: [PATCH v4 3/6] hwmon: pwm-fan: Add dedicated power switch function
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 14 Sep 2022 17:10:22 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id B0855280056;
        Wed, 14 Sep 2022 17:10:21 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Date:   Wed, 14 Sep 2022 17:10:19 +0200
Message-ID: <15897013.uLZWGnKmhe@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220830135013.GA229925@roeck-us.net>
References: <20220523110513.407516-1-alexander.stein@ew.tq-group.com> <20220523110513.407516-4-alexander.stein@ew.tq-group.com> <20220830135013.GA229925@roeck-us.net>
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

thanks for your review.

Am Dienstag, 30. August 2022, 15:50:13 CEST schrieb Guenter Roeck:
> On Mon, May 23, 2022 at 01:05:10PM +0200, Alexander Stein wrote:
> > This handles enabling/disabling the regulator in a single function, while
> > keeping the enables/disabled balanced. This is a preparation when
> > regulator is switched from different code paths.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > 
> >  drivers/hwmon/pwm-fan.c | 52 +++++++++++++++++++++++++++++------------
> >  1 file changed, 37 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> > index 96b10d422828..04af24268963 100644
> > --- a/drivers/hwmon/pwm-fan.c
> > +++ b/drivers/hwmon/pwm-fan.c
> > @@ -35,6 +35,7 @@ struct pwm_fan_ctx {
> > 
> >  	struct pwm_device *pwm;
> >  	struct pwm_state pwm_state;
> >  	struct regulator *reg_en;
> > 
> > +	bool regulator_enabled;
> > 
> >  	bool enabled;
> >  	
> >  	int tach_count;
> > 
> > @@ -85,6 +86,29 @@ static void sample_timer(struct timer_list *t)
> > 
> >  	mod_timer(&ctx->rpm_timer, jiffies + HZ);
> >  
> >  }
> > 
> > +static int pwm_fan_switch_power(struct pwm_fan_ctx *ctx, bool on)
> > +{
> > +	int ret = 0;
> > +
> > +	if (!ctx->reg_en)
> > +		return ret;
> > +
> > +	if (ctx->regulator_enabled && on) {
> > +		ret = 0;
> 
> ret is already 0 here.
> 
> > +	} else if (!ctx->regulator_enabled && on) {
> > +		ret = regulator_enable(ctx->reg_en);
> > +		if (ret == 0)
> > +			ctx->regulator_enabled = true;
> > +	} else if (ctx->regulator_enabled && !on) {
> > +		ret = regulator_disable(ctx->reg_en);
> > +		if (ret == 0)
> > +			ctx->regulator_enabled = false;
> > +	} else if (!ctx->regulator_enabled && !on) {
> > +		ret = 0;
> 
> ret is already 0 here.

Ok, I'll remove both branches, setting ret to 0 again. I just wanted to keep 
the branches for all possibilities, but no heard feelings here.

> > +	}
> > +	return ret;
> > +}
> > +
> > 
> >  static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
> >  {
> >  
> >  	struct pwm_state *state = &ctx->pwm_state;
> > 
> > @@ -316,7 +340,9 @@ static int pwm_fan_of_get_cooling_data(struct device
> > *dev,> 
> >  static void pwm_fan_regulator_disable(void *data)
> >  {
> > 
> > -	regulator_disable(data);
> > +	struct pwm_fan_ctx *ctx = data;
> > +
> > +	pwm_fan_switch_power(ctx, false);
> 
> You can directly pass 'data' as argument here; there is no need
> for the extra variable.

Nice, thanks. Will do so.

Best regards,
Alexander

> >  }
> >  
> >  static void pwm_fan_pwm_disable(void *__ctx)
> > 
> > @@ -360,13 +386,13 @@ static int pwm_fan_probe(struct platform_device
> > *pdev)> 
> >  		ctx->reg_en = NULL;
> >  	
> >  	} else {
> > 
> > -		ret = regulator_enable(ctx->reg_en);
> > +		ret = pwm_fan_switch_power(ctx, true);
> > 
> >  		if (ret) {
> >  		
> >  			dev_err(dev, "Failed to enable fan supply: 
%d\n", ret);
> >  			return ret;
> >  		
> >  		}
> >  		ret = devm_add_action_or_reset(dev, 
pwm_fan_regulator_disable,
> > 
> > -					       ctx->reg_en);
> > +					       ctx);
> > 
> >  		if (ret)
> >  		
> >  			return ret;
> >  	
> >  	}
> > 
> > @@ -512,12 +538,10 @@ static int pwm_fan_disable(struct device *dev)
> > 
> >  			return ret;
> >  	
> >  	}
> > 
> > -	if (ctx->reg_en) {
> > -		ret = regulator_disable(ctx->reg_en);
> > -		if (ret) {
> > -			dev_err(dev, "Failed to disable fan supply: 
%d\n", ret);
> > -			return ret;
> > -		}
> > +	ret = pwm_fan_switch_power(ctx, false);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to disable fan supply: %d\n", ret);
> > +		return ret;
> > 
> >  	}
> >  	
> >  	return 0;
> > 
> > @@ -539,12 +563,10 @@ static int pwm_fan_resume(struct device *dev)
> > 
> >  	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> >  	int ret;
> > 
> > -	if (ctx->reg_en) {
> > -		ret = regulator_enable(ctx->reg_en);
> > -		if (ret) {
> > -			dev_err(dev, "Failed to enable fan supply: 
%d\n", ret);
> > -			return ret;
> > -		}
> > +	ret = pwm_fan_switch_power(ctx, true);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to enable fan supply: %d\n", ret);
> > +		return ret;
> > 
> >  	}
> >  	
> >  	if (ctx->pwm_value == 0)




