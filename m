Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288101ED425
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2020 18:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgFCQWK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 Jun 2020 12:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgFCQWK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Jun 2020 12:22:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9448EC08C5C0
        for <linux-pwm@vger.kernel.org>; Wed,  3 Jun 2020 09:22:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y17so3005944wrn.11
        for <linux-pwm@vger.kernel.org>; Wed, 03 Jun 2020 09:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BZTt9T276lsrO3O2MXYW5PMWTwEiJDQfaeAB8AhUwDY=;
        b=V9esgvRMiX+uE7jBQs7Z2nfLwpGjXWG6BjJXMHdZ1HLSfUowXsFUI6fFn+lO3HzrKu
         i+6QEFdUw4rM2I1FuLZSuXHcgTztzj5efPLTzFSrVRn6H8Z28lG3jNZDKFKbadqWQcV8
         vdFpwIRV4F40onnd8qbZCeiGWUQGpWEzhnVmY3x4c3TzUZzvg2TYM6uCRc5RIPkeX7bd
         inbM8ORyowDwGfPXhGnmc2mBM+ZwNqS2Bsh0Qc9wrztTc7CiNasVixhTu45RlkvfVw1z
         f5vrCd/g4P3kU/r1b7jP97KcJrq3pzkhZ04DuCgcG4J9YFf5DYpu0AHn9a82hJdcChny
         f/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BZTt9T276lsrO3O2MXYW5PMWTwEiJDQfaeAB8AhUwDY=;
        b=RYyhnS+07lKw5wgd8HCzbAe3HMBJbVX5PtUeOc9BNoFXQMxDQp0pFShRTXvOdBcNvQ
         PsuPabcwgwbDMPfw2gn4dlG+ey+ntOy0ZR1gqmrdwYwg+kY0qfLLy7QAamBrlWAszAfK
         TCwDIejXTGcriCC2T2V7BgsfUbO9wHPx12GTZqtJwVSL4spXbBx/PSZ0ibeidmYooCEs
         3+1hgfq7ZdkaYp5i+9sKeNs9/Sep8+Hbs3Rg69oGC8n7GsBkHWo3epRorixe0rTNDN/p
         u58B/u3Diyrn6XnZ6PTf6T8+Rd53PpAdcwTOTLHu6QaxDVtFkz3nQYEKXfOZC/im4q2k
         cryQ==
X-Gm-Message-State: AOAM530Tc9p+ToZTh87ftybkddwIkJZvD+Av2Tf1opnMNDALLo9IdWHZ
        KJILwgXWZruGdX19+U3NC28ayw==
X-Google-Smtp-Source: ABdhPJzxXi4R+aChLFfTPTX3y6BdsYDxLXgDy59uHMHOOcsucSlQoUqXaTtAvm1/+LwgilyNALZfKw==
X-Received: by 2002:adf:f611:: with SMTP id t17mr227845wrp.69.1591201326194;
        Wed, 03 Jun 2020 09:22:06 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id x8sm4088043wrs.43.2020.06.03.09.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 09:22:05 -0700 (PDT)
Date:   Wed, 3 Jun 2020 17:22:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Lee Jones as reviewer for the PWM
 subsystem
Message-ID: <20200603162204.GO3714@dell>
References: <20200602123241.3363904-1-thierry.reding@gmail.com>
 <20200603123718.6fwsbpnkbjlpq2bz@taurus.defre.kleine-koenig.org>
 <20200603144224.GC3478467@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200603144224.GC3478467@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 03 Jun 2020, Thierry Reding wrote:

> On Wed, Jun 03, 2020 at 02:37:18PM +0200, Uwe Kleine-König wrote:
> > On Tue, Jun 02, 2020 at 02:32:41PM +0200, Thierry Reding wrote:
> > > Lee has kindly offered his help in sharing the patch review workload for
> > > the PWM subsystem. If this works out well between Lee, Uwe and myself it
> > > may be a good idea to maintain the subsystem as a group.
> > > 
> > > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > > ---
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index e64e5db31497..b8889bed5d1e 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -13736,6 +13736,7 @@ F:	drivers/media/rc/pwm-ir-tx.c
> > >  PWM SUBSYSTEM
> > >  M:	Thierry Reding <thierry.reding@gmail.com>
> > >  R:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > +M:	Lee Jones <lee.jones@linaro.org>
> > 
> > I'm bit surprised that Lee got M: which I have a R:. The commit log
> > talks about reviewer not maintainer.
> > 
> > While I'm not sure that there is a practical difference it makes me a
> > bit sad.
> 
> That was not the intention. According to the notes at the top of the
> MAINTAINERS file, recipients on M: lines will be added in the To:
> header, while R: lines will be added in the Cc: header. That's really
> the only difference.
> 
> In practical terms this may be helpful for filtering where email where
> you are on the To: line can be prioritized over those where you are on
> the Cc: line.

Exactly right.

It's a common misconception that M: means 'Maintainer'.  It doesn't.
M: simply means "Mail-to".  It has nothing to do with maintainership
levels/hierarchy and everything to do with mail filtering.

Nothing to be sad about.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
