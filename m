Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317382427B3
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Aug 2020 11:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgHLJg0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Aug 2020 05:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgHLJgZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Aug 2020 05:36:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED96C06174A
        for <linux-pwm@vger.kernel.org>; Wed, 12 Aug 2020 02:36:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a14so1379195wra.5
        for <linux-pwm@vger.kernel.org>; Wed, 12 Aug 2020 02:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=D7oqUFNW38/IH0RQ/3p9O52C6wH5dsFdlpKUZdj8YEE=;
        b=Wy7Rfdn936JeITKEgwFnlKM7WS1NMekflVkwFN+KDcpKENV/RhLd5b8iWVuSfwuiiK
         SQjzCoM9odigpv/I/Ei42FIyh2++93T4dCcmfVZ5IwRv50nIcrPGRGYBegUHeP9dJ+O1
         A1jQcYmHtN0NBMNH7d0G4Fj9/3I0NF8McZX7ZtxCLaJ7Jdg41dPrqB5Y/9XmuYe/p4Nk
         wdgKa653EN9xc9HnEeMpJDlwZ/KU99BNGWLz8FIkSNYopm8SmYbhzWD9RSn4zcJj4c5D
         lpO4UEA43flDU7At+hnHRngmu0FNuOcrTynd7lpisQHihRV/odngpFNlkdX5ugDZSf5J
         b6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=D7oqUFNW38/IH0RQ/3p9O52C6wH5dsFdlpKUZdj8YEE=;
        b=WWvKFg2IpOM6fVYEdAnYxwBVe/e3XEfzOvwEIVdwmLEPI2TuqNqb092P4OWACL7kMa
         45eJdBIje3r7vS9X1dDG7VBgcH0PfmktzZYoPhuy4zRgLasfpFG/xdZmtJARQnMqo7h2
         uPulWMLxcfvn5yhzeMGHcSkUp9ZY0w8JUsP50/TiDEEpHNOUqPEm2CKFHMLnt4XtosOI
         Rih4OiS8w/9BaqYKAkLpbHgJjX0fNglZvGm0DlyDTNUWZ/bbJexa5X/zO4wAQOytwsEL
         hvtSvzoaDtQoXzqbeORW6yY7nIW5t3WUxrXDyfIJotv0xPWyCq95gCjDq/RAoVgEwhXM
         NVsg==
X-Gm-Message-State: AOAM533OBY0g5dQMgnT5mz85QWwP8BwrWhfvZXESNKqmE10QqTTlEey3
        CqvNFBQSHuNO6j8Kgr4W+V9GDA==
X-Google-Smtp-Source: ABdhPJwgEofAz3evIYl7zSpWTlyLh/rZUO36untj1LClj+uCJACGpB+ZpJUAfkRog3zywE5fgaXaXw==
X-Received: by 2002:a5d:5710:: with SMTP id a16mr35244499wrv.217.1597224984052;
        Wed, 12 Aug 2020 02:36:24 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id x204sm12220280wmg.2.2020.08.12.02.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 02:36:23 -0700 (PDT)
Date:   Wed, 12 Aug 2020 10:36:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pwm@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: atmel: Make use of dev_err_probe()
Message-ID: <20200812093621.GF4354@dell>
References: <20200812080259.4431-1-u.kleine-koenig@pengutronix.de>
 <20200812082002.GD4354@dell>
 <20200812083204.kktnid63j6vefsky@pengutronix.de>
 <20200812084728.GI3448@piout.net>
 <20200812092539.fbpapvrwxbmzfi65@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200812092539.fbpapvrwxbmzfi65@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 12 Aug 2020, Uwe Kleine-König wrote:

> Hello Alexandre,
> 
> On Wed, Aug 12, 2020 at 10:47:28AM +0200, Alexandre Belloni wrote:
> > On 12/08/2020 10:32:04+0200, Uwe Kleine-König wrote:
> > > On Wed, Aug 12, 2020 at 09:20:02AM +0100, Lee Jones wrote:
> > > > On Wed, 12 Aug 2020, Uwe Kleine-König wrote:
> > > > >  	atmel_pwm->clk = devm_clk_get(&pdev->dev, NULL);
> > > > >  	if (IS_ERR(atmel_pwm->clk))
> > > > > -		return PTR_ERR(atmel_pwm->clk);
> > > > > +		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->clk),
> > > > > +				     "Failed to get clock\n");
> > > > 
> > > > Isn't dev_err_probe() only useful for drivers handling -EPROBE_DEFER?
> > > 
> > > devm_clk_get() might return -EPROBE_DEFER.
> > 
> > If it did, you wouldn't be able to print this message.
> 
> Why that? It probably won't make it to the console immediately, but once
> the clk is available the log buffer should be pushed out, shouldn't it?
> 
> > I' not sure it is worth adding so many checks for errors that will
> > never happen.
> 
> I'm sure this train of thought is unsustainable. And people will copy
> this code to platforms where this assumption might even be more wrong
> than on at91. 

This driver was authored (and reviewed) with intricate knowledge of
the H/W.  The current code is optimal for this device.  This patch
regresses certain aspects such as binary size and code complexity.

Sorry, but it's a NACK from me, and sounds like one from Alexandre
too.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
