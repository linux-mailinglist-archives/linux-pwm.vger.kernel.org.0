Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC3A2A945A
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Nov 2020 11:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgKFK3O (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Nov 2020 05:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFK3O (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2020 05:29:14 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BC5C0613CF
        for <linux-pwm@vger.kernel.org>; Fri,  6 Nov 2020 02:29:13 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id n15so775391wrq.2
        for <linux-pwm@vger.kernel.org>; Fri, 06 Nov 2020 02:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PX6YQ9Ax/t8zchEZbZqiCnlPU3E4zDd6Ej75X5ocHOE=;
        b=TcZ21H+KMV33i29KFAKCmxNQ9h26vZsacPQBa4iQ/48Si9R4X86/KJ9oyAaeHbC1qs
         ycnPNnayWJdO6Tpaz1HpO+574L94mEWsmTcgUxb1wWeHqJ7WNsFivQ5ZasYEaZpAdz7a
         wyomNTLWmxGMBCTB2ULNvL1utoL4V/lWcnzBS2qTg3LD46++Cc0pjLY9cdi3htmkVsvW
         NZDR3mHi0A66zvm9SsKi7/v3mcbZJx06OsCeUbpsrCTqXpef0lFi9q7kECvsCUciSaih
         2XPCclTuZZ4H/utl13Os582Ttf5oRRWEsOmYjKKaqzOGZokCGXnvwbFSV0BaqQSi2x72
         1igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PX6YQ9Ax/t8zchEZbZqiCnlPU3E4zDd6Ej75X5ocHOE=;
        b=U1VkjJDouQDnF5pWbP7FRn/7f2m+3AKjPtkdj6N9m9sFz5GDR9lcx0EtfF9sEr2Epu
         U/norQcU4ZU+GH6IDIMOUhUht4LP2XNRfh3AhJiNNufB5l29csCS9DyK/0lKWfIHvffI
         713xriM3PmRf8dbszWhOmlQy7FU7m0R1g5HdFiD8nlDLUfzachPFo+CrQgcajIDmSNK8
         y8YK/yPCCZIoTJLR4sCe24JPrTvlx2opYLna38gL9Nja/Zzg/zdRw4Nd9knT1VQWMcUF
         wD8yqkOkx5Ptd2qJCtiMcE7KVgdB/Xo8ZRWaGpagzLsu+z1wsDudqBQdpYZMXbXc5Wrc
         Eu0Q==
X-Gm-Message-State: AOAM533RQ+xTP6G5WWocaLj6MgBealfagxYnBjUkTnvDEh+4c0MGnYWH
        GX/lwFyUU+HLkZv46dqmBX+I/w==
X-Google-Smtp-Source: ABdhPJy3ZzLP+hECvW/fyCYcHL9WrPRv3wfPRAymRRldNKleCa0kEomY09x7lv2ngDmELuRGpnlROg==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr1860307wrr.304.1604658550603;
        Fri, 06 Nov 2020 02:29:10 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id a185sm1565964wmf.24.2020.11.06.02.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:29:09 -0800 (PST)
Date:   Fri, 6 Nov 2020 10:29:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Ajit Pal Singh <ajitpal.singh@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: sti: fix error handling
Message-ID: <20201106102908.GC2063125@dell>
References: <20201013081531.661528-1-uwe@kleine-koenig.org>
 <20201106082914.GX4488@dell>
 <20201106093435.4mlr6ujivvkzkd5z@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106093435.4mlr6ujivvkzkd5z@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 06 Nov 2020, Uwe Kleine-König wrote:

> Hello Lee,
> 
> On Fri, Nov 06, 2020 at 08:29:14AM +0000, Lee Jones wrote:
> > On Tue, 13 Oct 2020, Uwe Kleine-König wrote:
> > 
> > > This commit fixes several faults:
> > > 
> > >  - Iff a clk was returned by of_clk_get_by_name() it must be dereferenced
> > >    by calling clk_put().
> > >  - A clk that was prepared must be unprepared.
> > >  - The .remove callback isn't supposed to call pwm_disable().
> > >  - The necessary resources needed by the PWM must not be freed before
> > >    pwmchip_remove() was called.
> > > 
> > > Fixes: 378fe115d19d ("pwm: sti: Add new driver for ST's PWM IP")
> > > Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> > > ---
> > >  drivers/pwm/pwm-sti.c | 49 ++++++++++++++++++++++++++++++++-----------
> > >  1 file changed, 37 insertions(+), 12 deletions(-)
> > 
> > Sorry for the delay, this ended up in spam.
> > 
> > > diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> > > index 1508616d794c..f89f8cbdfdfc 100644
> > > --- a/drivers/pwm/pwm-sti.c
> > > +++ b/drivers/pwm/pwm-sti.c
> > > @@ -605,7 +605,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
> > >  	ret = clk_prepare(pc->pwm_clk);
> > >  	if (ret) {
> > >  		dev_err(dev, "failed to prepare clock\n");
> > > -		return ret;
> > > +		goto err_pwm_clk_prepare;
> > 
> > I would prefer these to indicate the intention, rather than were they
> > were called from.  So err_put_cpt_clk for this one, etc.
> 
> This might be subjective, but I like it better the way I did it. My
> pattern is:
> 
> 	ret = get_resource_A();
> 	if (ret)
> 		goto err_A;
> 
> 	ret = get_resource_B();
> 	if (ret)
> 		goto err_B;
> 
> 	...
> 
> 	put_resource_B();
> err_B:
> 	
> 	put_resource_A();
> err_A:
> 
> 	return ret;
> 
> This way just looking at on get_resource_$X block it is obvious that the
> picked label is right and in the error handling blocks that's obvious,
> too.
> 
> However with the (admittedly more common) style you prefer it is:
> 
> 	ret = get_resource_A();
> 	if (ret)
> 		goto return_ret; // or just: return ret
> 
> 	ret = get_resource_B();
> 	if (ret)
> 		goto put_A;
> 
> 	...
> 
> put_B:
> 	put_resource_B();
> 
> put_A:
> 	put_resource_A();
> 
> return_ret:
> 	return ret;
> 
> You have to check the previous block to see that put_A is right for
> the error path of get_resource_B(). In this trivial example you have to
> look back 6 instead of 2 lines. For more complex stuff it tends to be
> 3 lines for my approach (one more for the error message, and so still in
> the same logical block) but might be considerably bigger for the common
> approach. The usual amount of context in patches is 3 lines. And if you
> add another resource allocation between A and B you have to adapt the
> error path in B which is somewhat unrelated. So a patch adding A2 looks
> for my approach:
> 
> @@ ...
>  	if (ret)
>  		goto err_A;
>  
> +	ret = get_resource_A2();
> +	if (ret)
> +		goto err_A2;
> +
>  	ret = get_resource_B();
>  	if (ret)
>  		goto err_B;
> @@ ...
>  	put_resource_B();
>  err_B:
>  	
> +	put_resource_A2();
> +err_A2:
> +
>  	put_resource_A()
>  err_A:
>  
> Here you see that the right error label is used in the new error path
> and that it is placed correctly between err_B and err_A.
> 
> For your preferred approach the patch looks as follows:
> 
> @@ ...
>  	if (ret)
>  		goto return_ret;
>  
> +	ret = get_resource_A2();
> +	if (ret)
> +		goto put_A;
> +
>  	ret = get_resource_B();
>  	if (ret)
> -		goto put_A;
> +		goto put_A2;
>  
>  	...
> @@ ...
>  put_B: 
>  	put_resource_B();
>  
> +put_A2:
> +	put_resource_A2;
> +
>  put_A:
>  	put_resource_A();
>  
> Note you cannot see by just looking at the patch that goto put_A is
> right. (Well, if you assume that the old code is correct see that just
> before put_A B is freed which matches what just happens after your new
> get_resource_A2, but that's considerably more complicated.) Also you
> have to modify the goto for B.
> 
> This is in my eyes ugly enough to justify my preference.

Wow, you sure put a lot of effort into that. :)

I'll leave it up to ST and Thierry to have the final say.

> > > +err_pwmchip_add:
> > > +
> > > +	if (cdata->cpt_num_devs) {
> > 
> > No need for the evaluations, clk_*() calls are NULL safe.
> 
> Yes, I added that to match the allocation pattern. I don't feel strong

Right, but my point is, you don't have to.

It's added complexity/lines for no clear value.

I would personally simplify it all and remove them.

It also saves the ugliness of goto'ing into the middle of an if().

> here. (But as a side note: I don't like the gotos in .probe. They are
> not used to do (plain) error handling and so they complicate following
> the code flow.)

I think error handling is where gotos excel personally.
-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
