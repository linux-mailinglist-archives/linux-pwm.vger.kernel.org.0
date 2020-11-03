Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F642A3EBE
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Nov 2020 09:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgKCISM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Nov 2020 03:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgKCISL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Nov 2020 03:18:11 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5534FC0613D1
        for <linux-pwm@vger.kernel.org>; Tue,  3 Nov 2020 00:18:09 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c18so11780184wme.2
        for <linux-pwm@vger.kernel.org>; Tue, 03 Nov 2020 00:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/edCXZUFfihGmHNvnOzrknWY0if2bRaWAwxnqXloHpM=;
        b=VB0d1PYNrUWOVVMzdvtNjsEg8eByiPibAgRntMtTaj1Ev2p3XH7YmoDLCX0C5gFKta
         R/fn7cqKIrRx+Q0Y/RmjzMwUK2Hiuu7SRHzpMp9NSXD6T23VL+u4u3pfmhfaHgbzJQqR
         GXT9sPgph0bbEg3G7Nw40Tl9jqk9kvt+C+qfABu3n5uUcABMwpxYsKf0zXE9syvTNuwA
         9PPHWXJXAupCcDgVpI+4GMkmZtzCCJ89VYBgwlFcSijdEdJ/Z1NL2y0EkEMPa77FfwsB
         UdGbp2RXHgHgyVvM6OnyJZVwkb/ubCIsw/4zG/xgdGwsD2j8nQZZcIXbruQkiC+Y+L4K
         o2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/edCXZUFfihGmHNvnOzrknWY0if2bRaWAwxnqXloHpM=;
        b=WNYEfGTBOx5XKJlmQgnvfSpiDDgUKUSbLycwtkmLRNguX00MC97PWQ480ymXYsNZ1q
         smdw2klqgkKsw3Q9S+RVa3BDQ6QDJ0XpiyoUUgq9K/3UdE+4bM6nLxJ/Cm1pFA3JNy96
         hrc+KJ3GRMTXGjTfrLTkIXiQSe+miaDIO1FDBiT5fWnFZTIDabehnjxtqDkhCa/8BRH6
         ub1GWK3UxK0knNyWFxJgqnily7gXqghO/56+31UGl5fN7nZ+5iXRTWclAgK/jhCdklGQ
         JPw2lX1UKngrqHdzFw3sbX4frScTDH8Qkf6tbAaR8B5DBhVuWVQhxoWjF+rmyMx/9y47
         eJTQ==
X-Gm-Message-State: AOAM533bCm59nEMBSTvgsLvGayn1Wq/2Mj/ByIknRbXs1IB7Fqu0Rh8q
        p33FHTrci2YmEQhpAUEl7i8RBg==
X-Google-Smtp-Source: ABdhPJxV+yWMitPSKuyLiV2L7RSj7sQUg14/CyXiMzxXpfb7nk7DrTlhfo6ayX010cFsjMUZT4AwWA==
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr2159753wmf.37.1604391488060;
        Tue, 03 Nov 2020 00:18:08 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t199sm2094362wmt.46.2020.11.03.00.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 00:18:07 -0800 (PST)
Date:   Tue, 3 Nov 2020 08:18:05 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: ab8500: Add error message if pwmchip_add() fails
Message-ID: <20201103081805.GG4488@dell>
References: <20200812075214.499-1-u.kleine-koenig@pengutronix.de>
 <20200812081139.GC4354@dell>
 <20201022192253.5c2c2jmxtsji2fnh@pengutronix.de>
 <20201026093300.GB3926206@dell>
 <20201103080039.fuoupa3p5tz3jrws@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103080039.fuoupa3p5tz3jrws@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 03 Nov 2020, Uwe Kleine-König wrote:

> On Mon, Oct 26, 2020 at 09:33:00AM +0000, Lee Jones wrote:
> > On Thu, 22 Oct 2020, Uwe Kleine-König wrote:
> > 
> > > On Wed, Aug 12, 2020 at 09:11:39AM +0100, Lee Jones wrote:
> > > > On Wed, 12 Aug 2020, Uwe Kleine-König wrote:
> > > > 
> > > > > pwmchip_add() doesn't emit an error message, so add one in the driver.
> > > > 
> > > > Maybe placing one there would be a good idea.
> > > > 
> > > > It would certainly cut down on a lot of superfluous strings.
> > > 
> > > Hmm, I'm not convinced. Do you want to work on that? If not I suggest to
> > > still apply the patch as currently it is justified.
> > 
> > I haven't looked at implementing it.  Does it look difficult/
> 
> Probably it isn't, needs just some endurance to actually do it. (And I
> won't invest that in the near future, also because I'm not convinced
> that the result is beneficial.)

I'll add it to my TODO list.

In the mean time, don't let this halt the patch.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
