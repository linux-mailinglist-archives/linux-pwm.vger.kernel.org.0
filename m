Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4255238C0B3
	for <lists+linux-pwm@lfdr.de>; Fri, 21 May 2021 09:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhEUH2D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 May 2021 03:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbhEUH2C (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 May 2021 03:28:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A803EC061574
        for <linux-pwm@vger.kernel.org>; Fri, 21 May 2021 00:26:38 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y14so17913549wrm.13
        for <linux-pwm@vger.kernel.org>; Fri, 21 May 2021 00:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wHJsiC5bAPMJ/JK2F8/kAPqQTZHzq5ny0YRHjZNAtPg=;
        b=D9Q+TP0/xYt4iQ45TGcwC580vJ0ZoowBEIqSbX9KoF301h+z+xAJAjXYNPkmhcmO3e
         zgy8E4COS7RDsbiucJ8FlmM7gnHuo/tVxwxKnSuTnfWx7uRMZFWkONcGL/Z4kp67mBFd
         +BnwEy2t7VMOC5CB1PKqSyOdh022za9V8pMv7R+5xMLKhsHhnU+5ObBAXKY4z8y/z96D
         j8VsK3FcOyNuElRe11Uw4MSYYWTFG/lDwZJudfhwDtpsZ7558q8GbrerDk67+Nwb0u3F
         8ztbk2Uyee+zWrCrQoirq+/r9tPtihNRW9BEl1cAAPqcqBxrsYTnsNaI3S9qaJGvh07Y
         N4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wHJsiC5bAPMJ/JK2F8/kAPqQTZHzq5ny0YRHjZNAtPg=;
        b=LR692mm702u62RB7+fz/Vy6yz4yPgrZOdOm1Olb2NZsWV+Bf0BEtJh5PaPc9BaKxSU
         /IrRehkFeWVVkJq+wtujeqX1JRxTpdtk9zUK42Cv93UAlqN4yrJbaQI2uAyLEyrSZLki
         ozos37oVCU2piTJyDfe6YwH47a2m8C59aerbggymtP9+OKdG6VN7fwhl+2GHNMJstEdk
         BwpDVylHfPlQI+DX+UaXTUpe3K1lwsyA4FclpILqcpf3wDuhUZfVdFsRNeBQ5ySzek68
         9JMAJYixiLOfQaXJs6oXL4NiFwqhZDyeIxMis8kc/6e16sT/eF0rzU7JoZe4jluYQslb
         Gp9w==
X-Gm-Message-State: AOAM530IURFUV+me/8aHJA/w6lq3M8XO8W8ZKufY8RFdef//Kt1IOMRf
        iEJ0JcpYVomr+4Y5NaU7IXgbrQ==
X-Google-Smtp-Source: ABdhPJzESohZioxALYLgYLF5Uhkx1nAY0R/4gNgHpibC0XIoL2X2pIn9HQvSnSr0YfBD+4gAM9qgjg==
X-Received: by 2002:a5d:688d:: with SMTP id h13mr7927610wru.362.1621581997336;
        Fri, 21 May 2021 00:26:37 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id c6sm1032177wru.50.2021.05.21.00.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 00:26:36 -0700 (PDT)
Date:   Fri, 21 May 2021 08:26:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     linux-kernel@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "David A. Schleef" <ds@schleef.org>,
        Mori Hess <fmhess@users.sourceforge.net>,
        Truxton Fulton <trux@truxton.com>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 5/6] comedi: drivers: ni_mio_common: Move
 'range_ni_E_ao_ext' to where it is used
Message-ID: <20210521072635.GY2549456@dell>
References: <20210520122538.3470259-1-lee.jones@linaro.org>
 <20210520122538.3470259-6-lee.jones@linaro.org>
 <c69d39a0-bf9e-857d-93ba-73e2884fa4ad@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c69d39a0-bf9e-857d-93ba-73e2884fa4ad@mev.co.uk>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 20 May 2021, Ian Abbott wrote:

> On 20/05/2021 13:25, Lee Jones wrote:
> > ... and mark it as __maybe_unused since not all users of the
> > header file reference it.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >   drivers/staging/comedi/drivers/ni_mio_common.c:163:35: warning: ‘range_ni_E_ao_ext’ defined but not used [-Wunused-const-variable=]
> > 
> > Cc: Ian Abbott <abbotti@mev.co.uk>
> > Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: "David A. Schleef" <ds@schleef.org>
> > Cc: Mori Hess <fmhess@users.sourceforge.net>
> > Cc: Truxton Fulton <trux@truxton.com>
> > Cc: linux-staging@lists.linux.dev
> > Cc: linux-pwm@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/comedi/drivers/ni_mio_common.c | 9 ---------
> >   drivers/comedi/drivers/ni_stc.h        | 9 ++++++++-
> >   2 files changed, 8 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/comedi/drivers/ni_mio_common.c b/drivers/comedi/drivers/ni_mio_common.c
> > index 4f80a4991f953..37615b4e2c10d 100644
> > --- a/drivers/comedi/drivers/ni_mio_common.c
> > +++ b/drivers/comedi/drivers/ni_mio_common.c
> > @@ -160,15 +160,6 @@ static const struct comedi_lrange range_ni_M_ai_628x = {
> >   	}
> >   };
> > -static const struct comedi_lrange range_ni_E_ao_ext = {
> > -	4, {
> > -		BIP_RANGE(10),
> > -		UNI_RANGE(10),
> > -		RANGE_ext(-1, 1),
> > -		RANGE_ext(0, 1)
> > -	}
> > -};
> > -
> >   static const struct comedi_lrange *const ni_range_lkup[] = {
> >   	[ai_gain_16] = &range_ni_E_ai,
> >   	[ai_gain_8] = &range_ni_E_ai_limited,
> > diff --git a/drivers/comedi/drivers/ni_stc.h b/drivers/comedi/drivers/ni_stc.h
> > index fbc0b753a0f59..0822e65f709dd 100644
> > --- a/drivers/comedi/drivers/ni_stc.h
> > +++ b/drivers/comedi/drivers/ni_stc.h
> > @@ -1137,6 +1137,13 @@ struct ni_private {
> >   	u8 rgout0_usage;
> >   };
> > -static const struct comedi_lrange range_ni_E_ao_ext;
> > +static const struct comedi_lrange __maybe_unused range_ni_E_ao_ext = {
> > +	4, {
> > +		BIP_RANGE(10),
> > +		UNI_RANGE(10),
> > +		RANGE_ext(-1, 1),
> > +		RANGE_ext(0, 1)
> > +	}
> > +};
> >   #endif /* _COMEDI_NI_STC_H */
> > 
> 
> The "ni_stc.h" header is also included by "ni_mio_cs.c" which doesn't need
> `range_ni_E_ao_ext` (admittedly, it was already pulling in a "tentative"
> definition of the variable).
> 
> Thinking about it, I think it's probably better to move `range_ni_E_ao_ext`
> from "ni_mio_common.c" into *both* "ni_atmio.c" and "ni_pcimio.c" (I think
> we can live with the small amount of duplication), and to remove the
> tentative definition from "ni_stc.h".

Happy to rework.

Am I taking this or Uwe's suggestion?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
