Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9742426EA
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Aug 2020 10:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgHLIrz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Aug 2020 04:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgHLIrz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Aug 2020 04:47:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4354C06174A
        for <linux-pwm@vger.kernel.org>; Wed, 12 Aug 2020 01:47:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k20so1152734wmi.5
        for <linux-pwm@vger.kernel.org>; Wed, 12 Aug 2020 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HEmqqaN3Cptn/L0IIb8kkOMEzBZVzXOJaGYzubXHWzw=;
        b=bDwl1W60RUfxSBU1CsOOzrdayBpOEeVukAihfKDvYdaEbs9bwfNzoF+yG3bLOv+d5b
         4qLz31JZlxUFScwGi7Y12FISatc3Iy+Z8ZLzbM0ee2Kfd7WCsE8ki0ORp/2Mx3E36eBn
         OaRL5dwf6rTj7R80QjAmyUYE+qQFas43N+YXq5js1qZ3lzyjCVPt3CwDT9rQDudPRwxP
         VeKiVsjl7h8AKMnh+61Q7Qi0Ys/THfBCG0/0qZMO0yITgOIEa2BKE0/VdaOgKdbTmA72
         xP3hs6N4DR4ZdSQD4Z5y1vo04uforaPHmc09dL9VZot3bPBtqYN84unQLR1Px/UWgZgA
         /Dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HEmqqaN3Cptn/L0IIb8kkOMEzBZVzXOJaGYzubXHWzw=;
        b=d/BA7847a3iKbYfM5LkVZjK5xmw2fFyGAxWNgXJO9rbvP1eRD94H+MZuXHSFrDIaVA
         qfVg0ade/4PF4hANGZ1ZaFR1SlAsmlyM2oxuWtyMP3vctCciVnfk7XFQv12WbZY50zmi
         3uqzoA2tY9YHb7ga1ABlJV0+z+PtFPRoV3LUe7DzyOBi2TFRjcZRrdmPranO31xID1nZ
         Q2Rz7V2iru2VRK+xXTDF5xECrORaK9hJ9HzZIwj4gX1HI+HWFoGRhA/Gy5VGRnX0jPtt
         4gP8IdrNn9rSrznonNuB9UPDHm8X2pOmoZTkZd1mU7qRJgvyFqBL9NaLx8kdNPmI/5JO
         Uy/g==
X-Gm-Message-State: AOAM532c4ToAxb6BBWo+ZZbdLV4QMQ9mraztWxYwizl22/KoBQ5CshUS
        9h16NolToACndCdOxWdHb0n1Sw==
X-Google-Smtp-Source: ABdhPJyh37vQVUgd85vM81zAQaFrcRnGbXt1MJT0w5ezPWRgNGrnuOzi78A4o5HB6maWF9QDX6DFGA==
X-Received: by 2002:a1c:65d6:: with SMTP id z205mr7294055wmb.2.1597222073634;
        Wed, 12 Aug 2020 01:47:53 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id c17sm3099796wrc.42.2020.08.12.01.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 01:47:53 -0700 (PDT)
Date:   Wed, 12 Aug 2020 09:47:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: atmel: Make use of dev_err_probe()
Message-ID: <20200812084751.GE4354@dell>
References: <20200812080259.4431-1-u.kleine-koenig@pengutronix.de>
 <20200812082002.GD4354@dell>
 <20200812083204.kktnid63j6vefsky@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200812083204.kktnid63j6vefsky@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 12 Aug 2020, Uwe Kleine-König wrote:

> On Wed, Aug 12, 2020 at 09:20:02AM +0100, Lee Jones wrote:
> > On Wed, 12 Aug 2020, Uwe Kleine-König wrote:
> > 
> > > Add an error message for failure points that currently lack a message
> > > and convert dev_err to dev_err_probe() which does the right thing for
> > > -EPROBE_DEFER. Also slightly simplify the error handling.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/pwm/pwm-atmel.c | 24 +++++++++++-------------
> > >  1 file changed, 11 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> > > index 6161e7e3e9ac..aa0b36695dc7 100644
> > > --- a/drivers/pwm/pwm-atmel.c
> > > +++ b/drivers/pwm/pwm-atmel.c
> > > @@ -415,17 +415,18 @@ static int atmel_pwm_probe(struct platform_device *pdev)
> > >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >  	atmel_pwm->base = devm_ioremap_resource(&pdev->dev, res);
> > >  	if (IS_ERR(atmel_pwm->base))
> > > -		return PTR_ERR(atmel_pwm->base);
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->base),
> > > +				     "Failed to remap register space\n");
> > 
> > This is a regression.
> > 
> > devm_ioremap_resource() already emits and error message for !-ENOMEM.
> > 
> > -ENOMEM cases should fail silently.
> 
> ah right. Maybe dev_err_probe() should do this right, too?

Maybe, but you're still adding an unnecessary string to the kernel's
binary.  There was a bit push a little while back to cut down on
these.

> > >  	atmel_pwm->clk = devm_clk_get(&pdev->dev, NULL);
> > >  	if (IS_ERR(atmel_pwm->clk))
> > > -		return PTR_ERR(atmel_pwm->clk);
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->clk),
> > > +				     "Failed to get clock\n");
> > 
> > Isn't dev_err_probe() only useful for drivers handling -EPROBE_DEFER?
> 
> devm_clk_get() might return -EPROBE_DEFER.

Perhaps, but the author has chosen not to handle it specifically.

It's my understanding that dev_err_probe() was designed to simplify
error handling in .probe() whereas this patch seems to do the polar
opposite.

> > >  	ret = clk_prepare(atmel_pwm->clk);
> > > -	if (ret) {
> > > -		dev_err(&pdev->dev, "failed to prepare PWM clock\n");
> > > -		return ret;
> > > -	}
> > > +	if (ret)
> > > +		return dev_err_probe(&pdev->dev, ret,
> > > +				     "Failed to prepare PWM clock\n");
> > 
> > As above.
> 
> I only checked quickly and didn't find an instance where clk_prepare can
> return -EPROBE_DEFER, but even if it doesn't it works fine.

It's still misleading IMHO.  dev_err_probe()'s header details its
reason for existence.  This seems to be a square peg in a round hole
scenario.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
