Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CF0360456
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Apr 2021 10:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhDOIet (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Apr 2021 04:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhDOIes (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Apr 2021 04:34:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A895EC061574
        for <linux-pwm@vger.kernel.org>; Thu, 15 Apr 2021 01:34:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g17so26288575edm.6
        for <linux-pwm@vger.kernel.org>; Thu, 15 Apr 2021 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZyVMtB+Nhk/j05dUGtiYl/caXyuaDDioIx3PMH1ZaCA=;
        b=naLW0P4Ai2XWFnG907DDslAfgqi9342d+6FeiQJtUOyeSNRjrH5JAohGjPG0vAIggy
         5Qc08B71vRYqy2ThHwu2Weat4a+ue/4GPnjsOMmjxL80uzNBL9BUYvfH3pRT/BmxEseS
         w96N1g5ikdayQRR5+tASLuh+MfPmeh4cOPQE1VMgHxqa29Yc/ZR9mOJFzRUrlLUj+l0b
         wIYV+X9mfzbBVRGihlNs1vPdVAaD32FnS5YQPq6IZr3Twhr4/okgEaosoFrXDJHWNXdB
         mbjCrnF05ThBG3U0a3FXnCFU/nc25cFAJjJT7k8raSYl5KqEjmN6yxHPI0eajix+AVL0
         AYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZyVMtB+Nhk/j05dUGtiYl/caXyuaDDioIx3PMH1ZaCA=;
        b=HjIjmWBDl0L+FnjA3HInE7qUlOTG9bI9pWnv6mGyS8UohvaAyyeaGwE6U8zhVBlT1U
         G9gZfiFE1mgknzho1VG9eD06EpfiXcY3XiyKO9sp3L/RvRu0ruhnPwCxMKym17ESTDlq
         Px2OQEObMQ8AzwyP/o4/lY4DWHsyxlZ1jMGBD7UvxR4OA0s1CCKuHirT6T5EH/c3g/1w
         Bp6xf4ZNaUHaBmwKhvuzLL1PYSPchgfCO3hol4JLEFrc1GjeEHd8GbbnKoqHvD1b2+MJ
         WakwUC7JbjhBrBJdzqsuUWO2GekDA+mH0GwPKLg1tuAgPaVjlSUFrpT7YKGC/U5Sx18J
         d9AQ==
X-Gm-Message-State: AOAM530LPPFeQOjVc/2DWVK7g2HZ1PlKhXDyoLq6fCZIL5YU+W6BFp94
        KSL4dsJvE/Hhu0HllCKgzcfYUw==
X-Google-Smtp-Source: ABdhPJwLmMWmf+ln8LvRE/mNvq23RtHXHlEDyfNtjD/7wInU0hwZ7xbtoSw2dnp+tn/FZturSlY2SQ==
X-Received: by 2002:a05:6402:485:: with SMTP id k5mr2721724edv.211.1618475663896;
        Thu, 15 Apr 2021 01:34:23 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id t14sm1358659ejj.77.2021.04.15.01.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:34:23 -0700 (PDT)
Date:   Thu, 15 Apr 2021 09:34:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "David A. Schleef" <ds@schleef.org>,
        Mori Hess <fmhess@users.sourceforge.net>,
        Truxton Fulton <trux@truxton.com>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 55/57] staging: comedi: drivers: ni_mio_common: Move
 'range_ni_E_ao_ext' to where it is used
Message-ID: <20210415083421.GV4869@dell>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
 <20210414181129.1628598-56-lee.jones@linaro.org>
 <20210415065535.eff56u7nhfhrcnl3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210415065535.eff56u7nhfhrcnl3@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 15 Apr 2021, Uwe Kleine-König wrote:

> Hello Lee,
> 
> nitpick: You move range_ni_E_ao_ext to the header. However that header
> doesn't use range_ni_E_ao_ext, so the subject is technically wrong.

It's implicitly used by the users of the header.

But I know what you mean.

I'll see if I can make the subject line a little more clear.

> On Wed, Apr 14, 2021 at 07:11:27PM +0100, Lee Jones wrote:
> > ... and mark it as __maybe_unused since not all users of the
> > header file reference it.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/staging/comedi/drivers/ni_mio_common.c:163:35: warning: ‘range_ni_E_ao_ext’ defined but not used [-Wunused-const-variable=]
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
> >  drivers/staging/comedi/drivers/ni_mio_common.c | 9 ---------
> >  drivers/staging/comedi/drivers/ni_stc.h        | 9 ++++++++-
> >  2 files changed, 8 insertions(+), 10 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
