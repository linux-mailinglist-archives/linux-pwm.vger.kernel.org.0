Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C251ED44A
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2020 18:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgFCQZT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 Jun 2020 12:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgFCQZT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Jun 2020 12:25:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E7BC08C5C0
        for <linux-pwm@vger.kernel.org>; Wed,  3 Jun 2020 09:25:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id p5so3009616wrw.9
        for <linux-pwm@vger.kernel.org>; Wed, 03 Jun 2020 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YMEw1+MtRCGZkmgn+Usn7TWAQhA9MgW+een02J0qmK8=;
        b=MJmnDlCBNWOi6w2ZsS99qao5rUdMfwKOfJPecxeOskXJNTNStWdYOGADQ5qaNxCcF1
         viqNIp/3577z5TWxiZ39nsG/K+IgYCd6CbW40wL4zOpw201gXgaA5FmElfm1u/1kV1a4
         zLhaDsvg5nodK6COdAZmFYKmE6i/L3NwOaVFFh2AS+i+4TMVGFWhPTMY9k5wBkz9bELp
         X6TW65hebK8oZ2u8cxs6TbldDOvCxZgrd4XYL7prvt4rjGvJdrsCQQyiSegLCpPUZSf9
         Aa6fZjo9zECRiGw+NuyU18vFjKUs7uixQuU8rHIHY9Q1JAeweJxN1avAR6K83xEnB34l
         c+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YMEw1+MtRCGZkmgn+Usn7TWAQhA9MgW+een02J0qmK8=;
        b=XsUL27kxSw1pbqJGq42QKV6M9fxWPGQDBk2moKeEt5H2nfuROAnWObqqJ1bj0WTrwx
         0ZzkVVU91uQkQK2Viu3AcSYd9FOMrSqwfsflLXZbR65O8lDoQtlff9DepM7ITnitWnY0
         2aQWq41lVimRMqMOdlWJlSwaY8IVXercBEg3ijp1oFQAiodrBmSTV/KAUu5BGdn703LB
         fZF8n3JER8ws9jlzNuzLRBg6+9M/iLwDnyz7UPkXp/B9UYP3Al1zhQR/heZGIZmkN99y
         jLzid09grGIjvjKTez/Mw5k3gYeQW2Q5838z4hNP0s7vbkI0NuRWC2FqRXA/amln9mCB
         0CGQ==
X-Gm-Message-State: AOAM530Mx6pnT6f76nY4OmTKSa+yvkMc0GbUfWDx7S0kgZKHPcCFuoC2
        BwayKA/JbWjCgZzK0F3QIulxgmtF1Jw=
X-Google-Smtp-Source: ABdhPJwJd+KWFFKbZ6Ey2JsNsRWwzjHpsUxFPiQ+cDs750BuWAqkTUF3wybInCk3glKi7yUteixWPA==
X-Received: by 2002:a5d:690b:: with SMTP id t11mr256722wru.213.1591201517633;
        Wed, 03 Jun 2020 09:25:17 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id u14sm3692472wmd.0.2020.06.03.09.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 09:25:16 -0700 (PDT)
Date:   Wed, 3 Jun 2020 17:25:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Lee Jones as reviewer for the PWM
 subsystem
Message-ID: <20200603162515.GP3714@dell>
References: <20200602123241.3363904-1-thierry.reding@gmail.com>
 <20200603123718.6fwsbpnkbjlpq2bz@taurus.defre.kleine-koenig.org>
 <20200603144224.GC3478467@ulmo>
 <20200603162204.GO3714@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200603162204.GO3714@dell>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 03 Jun 2020, Lee Jones wrote:

> On Wed, 03 Jun 2020, Thierry Reding wrote:
> 
> > On Wed, Jun 03, 2020 at 02:37:18PM +0200, Uwe Kleine-König wrote:
> > > On Tue, Jun 02, 2020 at 02:32:41PM +0200, Thierry Reding wrote:
> > > > Lee has kindly offered his help in sharing the patch review workload for
> > > > the PWM subsystem. If this works out well between Lee, Uwe and myself it
> > > > may be a good idea to maintain the subsystem as a group.
> > > > 
> > > > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > > > ---
> > > >  MAINTAINERS | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index e64e5db31497..b8889bed5d1e 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -13736,6 +13736,7 @@ F:	drivers/media/rc/pwm-ir-tx.c
> > > >  PWM SUBSYSTEM
> > > >  M:	Thierry Reding <thierry.reding@gmail.com>
> > > >  R:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > > +M:	Lee Jones <lee.jones@linaro.org>
> > > 
> > > I'm bit surprised that Lee got M: which I have a R:. The commit log
> > > talks about reviewer not maintainer.
> > > 
> > > While I'm not sure that there is a practical difference it makes me a
> > > bit sad.
> > 
> > That was not the intention. According to the notes at the top of the
> > MAINTAINERS file, recipients on M: lines will be added in the To:
> > header, while R: lines will be added in the Cc: header. That's really
> > the only difference.
> > 
> > In practical terms this may be helpful for filtering where email where
> > you are on the To: line can be prioritized over those where you are on
> > the Cc: line.
> 
> Exactly right.
> 
> It's a common misconception that M: means 'Maintainer'.  It doesn't.
> M: simply means "Mail-to".  It has nothing to do with maintainership
> levels/hierarchy and everything to do with mail filtering.

Although maybe someone should tell scripts/get_maintainer.pl that!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
