Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B1E360648
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Apr 2021 11:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhDOJyv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Apr 2021 05:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhDOJyv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Apr 2021 05:54:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8F7C061756
        for <linux-pwm@vger.kernel.org>; Thu, 15 Apr 2021 02:54:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id v6so34647244ejo.6
        for <linux-pwm@vger.kernel.org>; Thu, 15 Apr 2021 02:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=B2Fqr5NrGo6XWgDU6JjQz47MwlJ8Kw/VR7rCvP0gwec=;
        b=hCRENN2JAum41BR5TkYhp6L24NUIe3pxdfzcxPO0KVaXXIqIf2TQKDO+GB2IDzqIGK
         XciSjNUeIld40SMwUdhukgeNrIxsUC/6R/PWz+cmpEd7RxjLCrmRy5XesTi0tFpErWgI
         F/PluSqlFZ2a/16bTLMmgAOs4NWxUVJGNK5dxQJziCvq1LNmjxwDQJpE82uAvL35Xomt
         aGqtY1efUEdxPOVFTj4LENYcv3u0ctHcsn4GROxEonIpUtuJKucqzHYjXd/zUepXKX+N
         bs82HbDF0MooZNm5n3hdPwXaeZ28apP5sNjs+9OH22oyf8R0pINTbL72DYvYJ03nPvhy
         cy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B2Fqr5NrGo6XWgDU6JjQz47MwlJ8Kw/VR7rCvP0gwec=;
        b=X3wp5y4zG4fhLeRiZn+XnLo/YgIaHEIB7IVyFvG5b1TePqYfrLS/buxLyLQiCrizVm
         +jMgh8/so68pUqq1e6nDeXjtfggbvcR2FpagA1v5xmiM8+/1A8HaSt7AabUIyCVnlKKo
         Bqnba1XoaF6bXfLo5QOtSkT8CV1efGOY6Cvlx/nNXI2y79WgkdCyLQj2Ex69YsKibQzc
         h2GgwiAVWXJICmo2/ZPSrBfPE2EUeP7Bq02g7JRU8myQlJOcJJCyJHzgyqOXcNobrw7C
         K+V6GeDoLutB+H5TbY7Ek479h1CA/n5C4Kect+7edTEYX+ClshHXL8HbnPxCZUXfADru
         asvA==
X-Gm-Message-State: AOAM530UUZmgMf7iTbc9x3YUCvaIlBruhdoU7HgnPZICXrx/g7+tG5/e
        m5uE/7DpOGS0u7GSuEPvhfoNMw==
X-Google-Smtp-Source: ABdhPJzVBz5Vc8f1H+FidST1MZgZUzJyMRWOEUDV3rKTyI8dZ7dAdCNzVfzORk/vWOA9oZhCIOzXCg==
X-Received: by 2002:a17:906:4fcd:: with SMTP id i13mr2516246ejw.341.1618480465538;
        Thu, 15 Apr 2021 02:54:25 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id e16sm1990440edu.94.2021.04.15.02.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:54:25 -0700 (PDT)
Date:   Thu, 15 Apr 2021 10:54:23 +0100
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
Subject: Re: [PATCH 55/57] staging: comedi: drivers: ni_mio_common: Move
 'range_ni_E_ao_ext' to where it is used
Message-ID: <20210415095423.GY4869@dell>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
 <20210414181129.1628598-56-lee.jones@linaro.org>
 <fd880e8e-a5fc-67ef-6ba4-f59592dee71d@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd880e8e-a5fc-67ef-6ba4-f59592dee71d@mev.co.uk>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 15 Apr 2021, Ian Abbott wrote:

> On 14/04/2021 19:11, Lee Jones wrote:
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
> >   drivers/staging/comedi/drivers/ni_mio_common.c | 9 ---------
> >   drivers/staging/comedi/drivers/ni_stc.h        | 9 ++++++++-
> >   2 files changed, 8 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/staging/comedi/drivers/ni_mio_common.c b/drivers/staging/comedi/drivers/ni_mio_common.c
> > index 4f80a4991f953..37615b4e2c10d 100644
> > --- a/drivers/staging/comedi/drivers/ni_mio_common.c
> > +++ b/drivers/staging/comedi/drivers/ni_mio_common.c
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
> > diff --git a/drivers/staging/comedi/drivers/ni_stc.h b/drivers/staging/comedi/drivers/ni_stc.h
> > index fbc0b753a0f59..0822e65f709dd 100644
> > --- a/drivers/staging/comedi/drivers/ni_stc.h
> > +++ b/drivers/staging/comedi/drivers/ni_stc.h
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
> I think it is better where it is for now with its fellow struct
> comedi_lrange variables, but feel free to mark it as __maybe_unused.

Can do.  Will fix.

> (Really, the #include "ni_mio_common.c" mess needs sorting out sometime.)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
