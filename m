Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765522D5FCE
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Dec 2020 16:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391500AbgLJPeF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Dec 2020 10:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391390AbgLJOla (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Dec 2020 09:41:30 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A78C061793
        for <linux-pwm@vger.kernel.org>; Thu, 10 Dec 2020 06:40:48 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id o8so5761993ioh.0
        for <linux-pwm@vger.kernel.org>; Thu, 10 Dec 2020 06:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d4LZazcEk4MFX1qHLGHiKS1Th2EI2Tgbz/+dKarKOJU=;
        b=e6z/NFYeQUVhfdYZqe5DejzSFYW4cHjElw6aAgjnK8eSZ9+ruf8dLLyI5y7rRQAtsQ
         1VEel+RGMX9uzSP4P7Pgf5oQkyQ3q2yr/LdAYXIOgjYk29efEnt2xd3efk+2xKH1VQkO
         tT6cwts1CW76AUBWhNXO11t/0I0fQrXtNzbR+rhlte3I+GXuSra0B00RljRzZHqD1MeY
         frGfNIHe1Y7FfO3zucoSAEfrtK71Mjce8ySwaLCLkjynjOv7FSgP/1lnsKTGuOPDUBb4
         7l8OADqABeEZ1XTJqWBRzmWUFvvdGfgPPxfZdRIKr+9wj44HyWK19MUydpHxBu71nso4
         QbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d4LZazcEk4MFX1qHLGHiKS1Th2EI2Tgbz/+dKarKOJU=;
        b=kl9Eos4/1LGQBWa88Ykk+mm5wmPW93ceY20cQFOPE+AbwecHDLYsKH6dTFtaKdS96B
         f1i1g1PfMGE2pkgl+kUJ0z4gT7DrrSPwgqZhFfx/VbjjlCTAjftZyq0lUBWhQRp0QxMG
         uUDwVvoKzNnKh7RPsZFJqTbloT+OMJwVCMMYmIO9V6DYqLDtKUuvkXNs0L9UyRwCp2Hn
         6IaJYNpkg0GkVUfbrmOYOK/5fb5VI87lqv9xFhUsV6g7bxbDjNfd5xtV/jmLEG5kT+OF
         f7C0221Q1JjoC9o9VwheD5e8n2arrXE6+QNf/R7eDvsJD1YFqcjj/Ovn5wa64hZj3vy5
         9KpA==
X-Gm-Message-State: AOAM530g15GhRvpMr9oHOA3VAAh57wVQCW33SyiAix260VWnWaIS4VsW
        4f5w6OHSvg+hpUNe7n3wKOTHYnV7CgWgAERlwGs8WC7PVpRzPQ==
X-Google-Smtp-Source: ABdhPJwlq+TsPSvE8TskLkr0+AmZHyi24uQRirb4JJ2onz25/t1Egdli2Vn1XItnxRoQrIZjEB6ykw00LzqN2pi75Pc=
X-Received: by 2002:a05:6638:1027:: with SMTP id n7mr8943390jan.35.1607611247949;
 Thu, 10 Dec 2020 06:40:47 -0800 (PST)
MIME-Version: 1.0
References: <20201208044022.972872-1-bjorn.andersson@linaro.org>
 <20201210015136.GA18407@dragon> <20201210130453.regjkemfneqbelsi@pengutronix.de>
In-Reply-To: <20201210130453.regjkemfneqbelsi@pengutronix.de>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Thu, 10 Dec 2020 22:40:36 +0800
Message-ID: <CAAQ0ZWQEhitxNCKBjTNGcv5E+yqwjfbb5GCLoctpJM7u4Zpp=A@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Implement the pwm_chip
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Thu, Dec 10, 2020 at 9:05 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> > > @@ -111,6 +118,8 @@
> > >
> > >  #define SN_LINK_TRAINING_TRIES             10
> > >
> > > +#define SN_PWM_GPIO                        3
> >
> > So this maps to the GPIO4 described in sn65dsi86 datasheet.  I'm
> > wondering if it's more readable to define the following SHIFT constants
> > (your code), and use GPIO_MUX_GPIO4_SHIFT >> 2 where you need GPIO
> > offset?
> >
> > #define  GPIO_MUX_GPIO1_SHIFT 0
> > #define  GPIO_MUX_GPIO2_SHIFT 2
> > #define  GPIO_MUX_GPIO3_SHIFT 4
> > #define  GPIO_MUX_GPIO4_SHIFT 6
> >
> > If you agree, you may consider to integrate this patch beforehand:
> >
> > https://github.com/shawnguo2/linux/commit/7cde887ffb3b27a36e77a08bee366=
6d14968b586
>
> My preferred way here would be to add a prefix for the other constants.
> It (IMHO) looks nicer and
>
>         GPIO_INPUT_SHIFT
>
> looks like a quite generic name for a hardware specific definition.

While this looks like a reasonable argument, I also like the naming
choice for these constants in the beginning for that distinction
between registers and bits.  And changing the names the other way
around means there will be a much bigger diffstat, which I would like
to avoid.  I suggest let's just focus on what really matters here -
keep the naming consistent, so that people do not get confused when
they want to add more constants in there.

Shawn

> (Even if up to now there is no other code location using this name.)
