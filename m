Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3E638C8BD
	for <lists+linux-pwm@lfdr.de>; Fri, 21 May 2021 15:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhEUNyt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 May 2021 09:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbhEUNys (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 May 2021 09:54:48 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D82C061763
        for <linux-pwm@vger.kernel.org>; Fri, 21 May 2021 06:53:23 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so7483216wmk.1
        for <linux-pwm@vger.kernel.org>; Fri, 21 May 2021 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=or2n56rchUUN+O0Ey3IVBmf3hNw4ShOy6t6olT7Yts8=;
        b=kXvV09+x2hRrzcATNswB8+rrGsAVBOokL9TwVkrtw8xXa9K4ik9WqPLHHBDppD1mwp
         7VQ613T1gisYwYQ+QOBfOnLhM0exnAbNgRcuXXMYd4/cNU5nOgRuCtEocCGoOQM+R5dH
         gpiDYfU2AuIkHnIiI+b/F+/+Hfe3zGwqeuZPxK+zSizY1LF9pAkseLT30IclfRycC0zl
         J4pPu++Qz3A/TeJSS1XsRNhLPjSYtLgkpKN5THHd589XPhx1hbWQOCWv8Z8dVvz0tOVg
         K9zAYcLTHpkwdfS5yUWVMKH24cY+yKBuBqmjZa2WxuQY+sPGeUZWZxZ8rwBN45D8fS7O
         Fb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=or2n56rchUUN+O0Ey3IVBmf3hNw4ShOy6t6olT7Yts8=;
        b=N/0taIAqDKuMNmiC35ItppRovg7N7O6aGn8a5eSRNsI+kSN/GDLLcEiWfJ0zPcBfSi
         0CAGyAYFiUQAJ5SqmSO42qDVih4rQ0wTRA7+JA+U2VLWmB7NZ4YVejX3AkZJcPR5WqIK
         1FepcbqeCSM3o5lsVeDA7UFaHmYwvyrJoSDROVlX7NxCnIA/3681OfGfNkIKOi60X6GL
         BotxgNtPOD8kXBDdDiAJJKjtkd4PqJ5EfvakUdIB7bAar87fnHfwcRbnQ0Dotm71Po0y
         mWekLwRN1jg00QsGs2A54/E5YCuvuno0hFeifux4v3wytXuO/aClAUjPai3meb7md4bc
         CTpg==
X-Gm-Message-State: AOAM531RSgSwi1bYl8GFN5y+I8/AOoMhz3JiId/RfFCgaaE9bVEF1OYl
        GI62LHpPSWa+kGfMcDD0oR0qdQ==
X-Google-Smtp-Source: ABdhPJwN7lE7w0omdAhf4mqhxLHo8pWY3JTt0XBG0Zpfm4KWIl26MB8LtrMB/fF2hgz/ZaTk3X0SQw==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr8873126wmi.36.1621605202105;
        Fri, 21 May 2021 06:53:22 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id c64sm3596361wma.15.2021.05.21.06.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 06:53:21 -0700 (PDT)
Date:   Fri, 21 May 2021 14:53:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "David A. Schleef" <ds@schleef.org>,
        Mori Hess <fmhess@users.sourceforge.net>,
        Truxton Fulton <trux@linode1.truxton.com>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 5/6] comedi: drivers: ni_mio_common: Move
 'range_ni_E_ao_ext' to where it is used
Message-ID: <20210521135319.GH2549456@dell>
References: <20210520122538.3470259-1-lee.jones@linaro.org>
 <20210520122538.3470259-6-lee.jones@linaro.org>
 <c69d39a0-bf9e-857d-93ba-73e2884fa4ad@mev.co.uk>
 <20210521072635.GY2549456@dell>
 <20210521115431.GK1955@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210521115431.GK1955@kadam>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 21 May 2021, Dan Carpenter wrote:

> On Fri, May 21, 2021 at 08:26:35AM +0100, Lee Jones wrote:
> > On Thu, 20 May 2021, Ian Abbott wrote:
> > 
> > > On 20/05/2021 13:25, Lee Jones wrote:
> > > > ... and mark it as __maybe_unused since not all users of the
> > > > header file reference it.
> > > > 
> > > > Fixes the following W=1 kernel build warning(s):
> > > > 
> > > >   drivers/staging/comedi/drivers/ni_mio_common.c:163:35: warning: ‘range_ni_E_ao_ext’ defined but not used [-Wunused-const-variable=]
> > > > 
> > > > Cc: Ian Abbott <abbotti@mev.co.uk>
> > > > Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > > Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> > > > Cc: Lee Jones <lee.jones@linaro.org>
> > > > Cc: "David A. Schleef" <ds@schleef.org>
> > > > Cc: Mori Hess <fmhess@users.sourceforge.net>
> > > > Cc: Truxton Fulton <trux@truxton.com>
> > > > Cc: linux-staging@lists.linux.dev
> > > > Cc: linux-pwm@vger.kernel.org
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >   drivers/comedi/drivers/ni_mio_common.c | 9 ---------
> > > >   drivers/comedi/drivers/ni_stc.h        | 9 ++++++++-
> > > >   2 files changed, 8 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/comedi/drivers/ni_mio_common.c b/drivers/comedi/drivers/ni_mio_common.c
> > > > index 4f80a4991f953..37615b4e2c10d 100644
> > > > --- a/drivers/comedi/drivers/ni_mio_common.c
> > > > +++ b/drivers/comedi/drivers/ni_mio_common.c
> > > > @@ -160,15 +160,6 @@ static const struct comedi_lrange range_ni_M_ai_628x = {
> > > >   	}
> > > >   };
> > > > -static const struct comedi_lrange range_ni_E_ao_ext = {
> > > > -	4, {
> > > > -		BIP_RANGE(10),
> > > > -		UNI_RANGE(10),
> > > > -		RANGE_ext(-1, 1),
> > > > -		RANGE_ext(0, 1)
> > > > -	}
> > > > -};
> > > > -
> > > >   static const struct comedi_lrange *const ni_range_lkup[] = {
> > > >   	[ai_gain_16] = &range_ni_E_ai,
> > > >   	[ai_gain_8] = &range_ni_E_ai_limited,
> > > > diff --git a/drivers/comedi/drivers/ni_stc.h b/drivers/comedi/drivers/ni_stc.h
> > > > index fbc0b753a0f59..0822e65f709dd 100644
> > > > --- a/drivers/comedi/drivers/ni_stc.h
> > > > +++ b/drivers/comedi/drivers/ni_stc.h
> > > > @@ -1137,6 +1137,13 @@ struct ni_private {
> > > >   	u8 rgout0_usage;
> > > >   };
> > > > -static const struct comedi_lrange range_ni_E_ao_ext;
> > > > +static const struct comedi_lrange __maybe_unused range_ni_E_ao_ext = {
> > > > +	4, {
> > > > +		BIP_RANGE(10),
> > > > +		UNI_RANGE(10),
> > > > +		RANGE_ext(-1, 1),
> > > > +		RANGE_ext(0, 1)
> > > > +	}
> > > > +};
> > > >   #endif /* _COMEDI_NI_STC_H */
> > > > 
> > > 
> > > The "ni_stc.h" header is also included by "ni_mio_cs.c" which doesn't need
> > > `range_ni_E_ao_ext` (admittedly, it was already pulling in a "tentative"
> > > definition of the variable).
> > > 
> > > Thinking about it, I think it's probably better to move `range_ni_E_ao_ext`
> > > from "ni_mio_common.c" into *both* "ni_atmio.c" and "ni_pcimio.c" (I think
> > > we can live with the small amount of duplication), and to remove the
> > > tentative definition from "ni_stc.h".
> > 
> > Happy to rework.
> > 
> > Am I taking this or Uwe's suggestion?
> 
> You should probably take Ian's suggestion because he is the maintainer

I think you missed my point.

Now there are 2 options; I'd like Ian to tell me which one to implement.

> and I really doubt Uwe's will build.  :P  But Uwe is right that
> including .c files is ugly.

No one is disputing that. :)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
