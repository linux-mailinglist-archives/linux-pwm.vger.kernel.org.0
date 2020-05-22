Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE181DE33E
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2020 11:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgEVJhn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 05:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgEVJhn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 05:37:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A874FC061A0E
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 02:37:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k13so9538866wrx.3
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 02:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+JaGmfrUHhcQkFEPqWe0bVFYz2Arc5TLSoXsPeih+bY=;
        b=NDE9gcYyqD5IEt9rXJkmi/wEyz9UCuTNGRlh7pxa3vfQZLtnrb0Yh6gbJ7K6nO2Kbz
         c8NLy66N6aIhVAMZ2J3zCgJdhK7UhUWk9L5TDQgwBIqSRGfqXc4vnv0QPE17Mbq7BJHA
         JSgLgqn/MxflMn9nvVXvv6xtxhn7uGAXsmEXNSqaSte/pQtBqJWAexAp4asgLGlwA8++
         SWWkv9B8ybyPTREFSvSpyERKSYj7WfhANiXUaEx0o6zPF+PPc+pcLDQa8r2+SDEfMUPL
         sTvz5RTqFljDfVi1YilfsOw8kY0yIwFeJ1KuotodP28/DK7TfAaYGU70lvBCsraWTuUP
         3/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+JaGmfrUHhcQkFEPqWe0bVFYz2Arc5TLSoXsPeih+bY=;
        b=Xyo9OqaV2p8k6+bNcLqN/Lt79Cziq9nqMo8ennMFG+WE4JFmjnQKHUWiVCohuhzf3C
         ASjjuHRgcYVDukg//R+oqArGEmiV4mCE1NfESWMNIidFr7EXxw46KshoN6wqWVLpqVk2
         id1NMh8tp9xKuS4AACnSWHf6S0ugS96Mxs6XfjG2AYOkgvNXpwDgzg7WFqu3ds9n3nV+
         UAmyRho32QHxShwoHcGytSXEfGy8Tfxcst2xP+UHPg3b8QkhED1ax3U9J1CVm2jjxYkp
         CUj2hjODIsHkAFPlwscZgDho6LRvZlozwcWM4Nq2OubyxgNpuQYPFMsXuHfBdm9Eg0Qp
         eFOQ==
X-Gm-Message-State: AOAM530RgB17WyYbd93HEA2dQdNiNHS97UV9DdmsMZFAATKyUEepmBR2
        TUG3Ppz+IvzB+71JYVXS7ZB08w==
X-Google-Smtp-Source: ABdhPJzoncU+lNgmINUvGoMOt+KFP+k6Tci7J6tYcLGnKlR7Ymv0eheScbKLeM/5XEl62TSRKym5IQ==
X-Received: by 2002:a5d:4cd1:: with SMTP id c17mr870054wrt.199.1590140261310;
        Fri, 22 May 2020 02:37:41 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id c140sm9479234wmd.18.2020.05.22.02.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 02:37:40 -0700 (PDT)
Date:   Fri, 22 May 2020 10:37:38 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v14 04/11] pwm: clps711x: Cast period to u32
 before use as divisor
Message-ID: <20200522093738.cko5rj4wrxfd4hxu@holly.lan>
References: <cover.1589330178.git.gurus@codeaurora.org>
 <1d6918c3fc2976bdbdb687bf54a2ef09fc1558db.1589330178.git.gurus@codeaurora.org>
 <20200521101934.j5ivjky4e6byveut@holly.lan>
 <20200521202525.GA24026@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521202525.GA24026@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, May 21, 2020 at 01:25:25PM -0700, Guru Das Srinagesh wrote:
> On Thu, May 21, 2020 at 11:19:34AM +0100, Daniel Thompson wrote:
> > On Wed, May 20, 2020 at 03:55:57PM -0700, Guru Das Srinagesh wrote:
> > > Since the PWM framework is switching struct pwm_args.period's datatype
> > > to u64, prepare for this transition by typecasting it to u32.
> > > 
> > > Also, since the dividend is still a 32-bit number, any divisor greater
> > > than the numerator will cause the quotient to be zero, so return 0 in
> > > that case to efficiently skip the division.
> > > 
> > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > ---
> > >  drivers/pwm/pwm-clps711x.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)> > > 
> > > diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> > > index 924d39a..da771b1 100644
> > > --- a/drivers/pwm/pwm-clps711x.c
> > > +++ b/drivers/pwm/pwm-clps711x.c
> > > @@ -43,7 +43,10 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
> > >  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
> > >  {
> > >  	/* Duty cycle 0..15 max */
> > > -	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > > +	if (pwm->args.period > (v * 0xf))
> > > +		return 0;
> > 
> > This doesn't look right to me.
> > 
> > DIV_ROUND_CLOSEST() does rounded division and the short circuit doesn't
> > implement that.
> 
> My initial patch [1] was to simply use DIV64_U64_ROUND_CLOSEST(), but I
> got review feedback to add a short-circuit (same thread, [2]). I feel
> like I should skip the short-circuiting and type casting and simply just
> use DIV64_U64_ROUND_CLOSEST() - what do you think?

A trivial review of pwm-clps711x.c suggests that the period is always
32-bit anyway so why not just throw away the short circuit entirely and
replace with a comment saying that CLPS711X has a hard coded period
that is always >1000000000 ?


Daniel.
