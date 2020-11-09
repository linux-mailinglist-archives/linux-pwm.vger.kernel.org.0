Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A262AB696
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Nov 2020 12:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgKILVD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Nov 2020 06:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKILVD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Nov 2020 06:21:03 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09993C0613CF;
        Mon,  9 Nov 2020 03:21:03 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id cq7so8110153edb.4;
        Mon, 09 Nov 2020 03:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hU4WYD1KmzG04cSTRa81VB9nMC6JMAr9+qywRmieORQ=;
        b=ivffncbNBnvqFvOVxqcWbV0hPq/Ltibmf3GHl94bopcm/216grQ+BQGVZlOIbgv5Pf
         xRNJDqDwIXSwamLbX/p1iygsqawMVvm49RJRIt4tNEMYHQhPpV2SHeOUzuPYfilWXW2T
         pXypFoju2q10dY4x8VsUNVYWKxHAG9MXjfu3yRhrULwAAouCksLlQxBPC7WijFUkOd8M
         9rKkcE0TzPGW+Qms+6P/Fg+rjYuLtH/qjYB9Y1dHamslXZILFUGfnOVA2vHYW7hhV+gv
         tCS0061lKBfO0r7PmZ7sDLio7MMRqxS8zSw/E9vOQXqVzyolJ3sIV+5Qu+KLzXO5iK0O
         FyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hU4WYD1KmzG04cSTRa81VB9nMC6JMAr9+qywRmieORQ=;
        b=eAOEJN2iQukVZu0KnPumTJiaOgk9KJOVKYi8/WKzEZjAwEZNFIO8wOT0h/Q5U3hWKa
         r/vS6T0+43KFZQm3hBfv+MlHtXlFqD2CCHOKdcYwGhI/AtgyNfIsM2HPkIoNa8zj81HR
         igIVoaUK0kunj424GhoQLxXur85YJ/3D2nXm7tUgZis8x6HtZZHsJwFB//iwdaFRLOTU
         Zcm91JgDWWNUvZUT5rPjJsCuUSOl7ei2dYbYUqOEpSVWdZt5SbIsoiqWf+UmOAAj3V1i
         Wh7725yeQoCXgvjxWPAM3RIlku/A4uBw2pmWnO2go7UgTnfAj8dmM1ctyyRN+8ptlc5j
         WilA==
X-Gm-Message-State: AOAM532rGavMzOVMHuLUyJS6FBmNsHx/slH6YrWEXsvH+m6ouIoVFshI
        tcXWuIX+VjNiMmd72X0mQCgLQYhr9s2BgdV7FmI=
X-Google-Smtp-Source: ABdhPJxAkJymNqSjR/UljeVLidNDy9Sfi8sdqcClNPJ1jY4tyCrPXVk2ZYZfzUyF8oKh+J89CmDSjJgzBHin8AZGsnU=
X-Received: by 2002:a50:ef1a:: with SMTP id m26mr5734314eds.144.1604920861806;
 Mon, 09 Nov 2020 03:21:01 -0800 (PST)
MIME-Version: 1.0
References: <6fa54ce6-d5ae-d04f-7c77-b62c148d92b7@gmail.com>
 <20201106061513.uyys7njcqcdlah67@vireshk-i7> <a6926456-8bce-a438-bfaa-be334208f004@gmail.com>
 <CAEExFWsp0DWw1yO84e3vzr_YZkqkd+pyPfQQR3J2W6n3wTX4Jw@mail.gmail.com>
 <20201109050010.g47zojh6wafvwqva@vireshk-i7> <c584b301-e052-7f01-335d-8f9160865198@gmail.com>
 <20201109051014.oa6bt4g3ctm2hnuy@vireshk-i7> <4476fed9-a356-b7f1-32ee-935343e23038@gmail.com>
 <20201109053546.xupmmsx5qccn46tr@vireshk-i7> <33a7ad95-a8cf-7b88-0f78-09086c1a4adf@gmail.com>
 <20201109055320.5y5gf2whwast2mi4@vireshk-i7>
In-Reply-To: <20201109055320.5y5gf2whwast2mi4@vireshk-i7>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 9 Nov 2020 19:20:50 +0800
Message-ID: <CAEExFWuF82B3bPn8T8_vkHODNwP89MDrNOqu-MhObzqTfiYODw@mail.gmail.com>
Subject: Re: [PATCH v1 17/30] mmc: sdhci-tegra: Support OPP and core voltage scaling
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        driver-dev <devel@driverdev.osuosl.org>,
        linux-pwm@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-usb@vger.kernel.org,
        "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Nov 9, 2020 at 1:53 PM Viresh Kumar <viresh.kumar@linaro.org> wrote=
:
>
> On 09-11-20, 08:44, Dmitry Osipenko wrote:
> > 09.11.2020 08:35, Viresh Kumar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > On 09-11-20, 08:19, Dmitry Osipenko wrote:
> > >> Thanks, I made it in a different way by simply adding helpers to the
> > >> pm_opp.h which use devm_add_action_or_reset(). This doesn't require =
to
> > >> add new kernel symbols.
> > >
> > > I will prefer to add it in core.c itself, and yes
> > > devm_add_action_or_reset() looks better. But I am still not sure for
> > > which helpers do we need the devm_*() variants, as this is only usefu=
l
> > > for non-CPU devices. But if we have users that we can add right now,
> > > why not.
> >
> > All current non-CPU drivers (devfreq, mmc, memory, etc) can benefit fro=
m it.
> >
> > For Tegra drivers we need these variants:
> >
> > devm_pm_opp_set_supported_hw()
> > devm_pm_opp_set_regulators() [if we won't use GENPD]
> > devm_pm_opp_set_clkname()
> > devm_pm_opp_of_add_table()
>
> I tried to look earlier for the stuff already merged in and didn't
> find a lot of stuff where the devm_* could be used, maybe I missed
> some of it.
>
> Frank, would you like to refresh your series based on suggestions from
> Dmitry and make other drivers adapt to the new APIs ?

I am glad to do this.=EF=BC=9A=EF=BC=89

Yangtao
