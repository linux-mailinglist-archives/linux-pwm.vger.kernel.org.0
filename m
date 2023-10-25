Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2E17D60CB
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Oct 2023 06:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjJYESY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Oct 2023 00:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjJYESV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Oct 2023 00:18:21 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F071B128
        for <linux-pwm@vger.kernel.org>; Tue, 24 Oct 2023 21:18:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c5720a321aso47703581fa.1
        for <linux-pwm@vger.kernel.org>; Tue, 24 Oct 2023 21:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698207497; x=1698812297; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Brd8GKY25UMovr2lsG9TvdPpEmwQAUXbZxdfbbkQOpE=;
        b=FlKaqcyVdAYJtXjhaJt/N2OrkFr4S6OUbh0ngCT+jV1hCUGmqFFjUQXEOE9DFKD4FE
         zEAIbgWTQDVb5SvLWhglvVWwsaI6RfkHOgEyTkou+boHN3eT/qiSsDz4FPj2xs9g13ua
         l2ASkiI0fre3XU0YViPHhtPiXDfdVHJBV8bPJIB5QkDFO4EZ3zrNJ+1kPOGcQrnFOcGF
         gsFTzupCHOGFDr/ZSRRSGMJvgwafyYPWp9CtEKz63tuCGPKPpV2QYyKqnkLYRU+j/SSC
         pwPfwga59DsWpxDVCFLk2QRmj3GZEwMnyUS94i7EAy3pnzL32FO0GG15q1tQvnH1gMcB
         nfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698207497; x=1698812297;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Brd8GKY25UMovr2lsG9TvdPpEmwQAUXbZxdfbbkQOpE=;
        b=JnBL+ISa5BGhwUw0o3kNKbnOlg80pUQzFGvLZCyr1mJKdG88E5BqeOegRUDf3/LgAa
         mUZAE05rSmvx3YBlNQvxcNX6sT5QbauypeTIgzu2LJ8gCaa4zBj3PvreNrvHgSBCYTTC
         4Id4DNTjc9DWh8jGdNipox6w80fIzOkyIUdIM7I/4JqKSL77bxDbkIak6WjqYF3aO65L
         f4dEsjR3Mbym4ax5uEXElAJxpIoN1uskUI1Blgt1pxmTP5odkyJ0zTT/48nPRhASl/WZ
         z/pybSpEYqHrxVNZDd8Okxr3el2R++HQs59Y6vegsg7QLf3ydEfUdDLeWHa/oH2GQcQW
         tcdA==
X-Gm-Message-State: AOJu0YysPG4TVjSruGZrVcFC/AMTTQZGLDZmLGknsrgvdEPZyZ22g5My
        fvv6FhftF//PJaMIbvJOnAWDNg==
X-Google-Smtp-Source: AGHT+IHK9MNBEXuKit4Dyq67gtZ3P+f3+x9ngQPQaqjPnQ9oZd4mGeNK5F+gV0c1lFk5HL0q/K6iHQ==
X-Received: by 2002:a2e:9691:0:b0:2bf:f32a:1f64 with SMTP id q17-20020a2e9691000000b002bff32a1f64mr10173412lji.18.1698207497173;
        Tue, 24 Oct 2023 21:18:17 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q16-20020adfea10000000b00326dd5486dcsm11165440wrm.107.2023.10.24.21.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 21:18:16 -0700 (PDT)
Date:   Wed, 25 Oct 2023 07:18:13 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pwm: samsung: Fix a bit test
Message-ID: <0d61bf0a-3aca-466c-9198-e937e81b5328@kadam.mountain>
References: <917e3890-7895-4b1c-bcee-4eecb3b7fe09@moroto.mountain>
 <20231024211157.xv3vzqlmxmxwgvle@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024211157.xv3vzqlmxmxwgvle@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Oct 24, 2023 at 11:11:57PM +0200, Uwe Kleine-König wrote:
> Hello Dan,
> 
> On Tue, Oct 17, 2023 at 05:04:08PM +0300, Dan Carpenter wrote:
> > This code has two problems.  First, it passes the wrong bit parameter to
> > test_bit().  Second, it mixes using PWMF_REQUESTED in test_bit() and in
> > open coded bit tests.
> > 
> > The test_bit() function takes a bit number.  In other words,
> > "if (test_bit(0, &flags))" is the equivalent of "if (flags & (1 << 0))".
> > Passing (1 << 0) to test_bit() is like writing BIT(BIT(0)).  It's a
> > double shift bug.
> > 
> > In pwm_samsung_resume() these issues mean that the flag is never set and
> > the function is essentially a no-op.
> > 
> > Fixes: 4c9548d24c0d ("pwm: samsung: Put per-channel data into driver data")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > From static analysis and not tested.
> > 
> >  drivers/pwm/pwm-samsung.c | 2 +-
> >  include/linux/pwm.h       | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> > index 10fe2c13cd80..acf4a0d8d990 100644
> > --- a/drivers/pwm/pwm-samsung.c
> > +++ b/drivers/pwm/pwm-samsung.c
> > @@ -630,7 +630,7 @@ static int pwm_samsung_resume(struct device *dev)
> >  		struct pwm_device *pwm = &chip->pwms[i];
> >  		struct samsung_pwm_channel *chan = &our_chip->channel[i];
> >  
> > -		if (!(pwm->flags & PWMF_REQUESTED))
> > +		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
> >  			continue;
> >  
> >  		if (our_chip->variant.output_mask & BIT(i))
> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > index e3b437587b32..3eee5bf367fb 100644
> > --- a/include/linux/pwm.h
> > +++ b/include/linux/pwm.h
> > @@ -41,8 +41,8 @@ struct pwm_args {
> >  };
> >  
> >  enum {
> > -	PWMF_REQUESTED = 1 << 0,
> > -	PWMF_EXPORTED = 1 << 1,
> > +	PWMF_REQUESTED = 0,
> > +	PWMF_EXPORTED  = 1,
> 
> I'd want s/  / / here. Or even not assign explicit values at all?
> 

I feel like the 0 and 1 add value.  But sure, I can remove the extra
space.  You're right that trying to align stuff is potentially going to
cause pain in the future.

> >  };
> >  
> >  /*
> 
> I'd say these are two separate issues, with the one in pwm-samsung being
> bad and the one in <linux/pwm.h> "only" ugly.
> 
> I wonder how I could get the samsung part wrong. All current usages of
> PMWF_REQUESTED (and also PWMF_EXPORTED) use test_bit (et al). Grepping
> through history pwm-pca9685.c got this wrong in a similar way for some
> time, but otherwise it was always used correctly.
> 
> The definition of the flags in <linux/pwm.h> is ugly since 
> f051c466cf69 ("pwm: Allow chips to support multiple PWMs") from 2011!
> 
> @Dan: Would you split the patch in two please?

Sure.

regards,
dan carpenter

