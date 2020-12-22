Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956272E078C
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Dec 2020 09:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgLVI4b (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Dec 2020 03:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgLVI4b (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Dec 2020 03:56:31 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172E4C061285
        for <linux-pwm@vger.kernel.org>; Tue, 22 Dec 2020 00:55:11 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id n4so11308756iow.12
        for <linux-pwm@vger.kernel.org>; Tue, 22 Dec 2020 00:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cL6fs/TC+AbTrexoVx8lc3glF76LL/64P3jqDOubqOU=;
        b=p3FaLdyA6wmA6mGKW1iwHZA4ndWfgjKfkiFbsqbgmkPhf9kbrHDYXaUXj/UHpqPOXz
         xKvfDKYwnoHivFcCrjy/OsKQhIrWrVnfMZVD6aSEQc0iJYvWZlMaPbWXZPBVRUo1DguN
         tc8H5RUL8YwPJScAZ40XpjLRF5kZpCZq+0CojwWmHcmYzopiuoqFZCJSM7Q7U1mwXHd0
         LbS0KzUzfZei7GmSL5fm7eUWiQXN6yn7oR1igzb7mwSXXLeEcbJlyR2iRSEPCVdsZ0+N
         en5MqOLGoU2PuBx0e0BxXUFOLDWc6ahV/suAGeElCchCVDSApjHIw8VunNtIQVlphsGI
         5XEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cL6fs/TC+AbTrexoVx8lc3glF76LL/64P3jqDOubqOU=;
        b=eHUVEteXL2kmVFB9JYQ2B+l6tE9ZKF8tC7RgfKngBCXpaZmGJHQSDURI3fAC28kmKS
         Zz/LcMXFG/JZzG/XrdOK+sYMJcRt6OgPY76C8OB57mDb2fBF3Q9riEsAmQxr5K/9hvsu
         Ym/urg6x9RFwyH0FVCbptuwxLjOfSMrkF0RfYrX8KO7+Hvpcvu9AVHcr00fOuxxC5upX
         bGXajnbTLe5qq7uBJ0NhLEnywvGgFG6D1X2/S4QHgcQx3YEzi6URU8sDj10HvpEx/cVy
         LWGN70fRPmfiClXG2HhInnlIuCzibJagoWMyvnLnKRe2LZL9p5/79k0GCfVq7naNk7ja
         qzsw==
X-Gm-Message-State: AOAM533k+boUmveTgS1NDAPzLMCos0LTwHDXFXp5JgvdI3XqHA2dyJEW
        Ng1aEg3ATGUg2Cd6qtD5vjFpUBuPZQzCe0KriAIayg==
X-Google-Smtp-Source: ABdhPJwuNazpKAOATKE0nNMW3rBUfq40/YWGzdym8cpzWqRYRMeOtvTbqo19OaXgrOTKauto0Mlknyht6Q0bCPx/Xog=
X-Received: by 2002:a6b:1454:: with SMTP id 81mr17362520iou.96.1608627309948;
 Tue, 22 Dec 2020 00:55:09 -0800 (PST)
MIME-Version: 1.0
References: <6fa54ce6-d5ae-d04f-7c77-b62c148d92b7@gmail.com>
 <20201106061513.uyys7njcqcdlah67@vireshk-i7> <a6926456-8bce-a438-bfaa-be334208f004@gmail.com>
 <CAEExFWsp0DWw1yO84e3vzr_YZkqkd+pyPfQQR3J2W6n3wTX4Jw@mail.gmail.com>
 <20201109050010.g47zojh6wafvwqva@vireshk-i7> <c584b301-e052-7f01-335d-8f9160865198@gmail.com>
 <20201109051014.oa6bt4g3ctm2hnuy@vireshk-i7> <4476fed9-a356-b7f1-32ee-935343e23038@gmail.com>
 <20201109053546.xupmmsx5qccn46tr@vireshk-i7> <33a7ad95-a8cf-7b88-0f78-09086c1a4adf@gmail.com>
 <20201109055320.5y5gf2whwast2mi4@vireshk-i7> <CAEExFWuF82B3bPn8T8_vkHODNwP89MDrNOqu-MhObzqTfiYODw@mail.gmail.com>
In-Reply-To: <CAEExFWuF82B3bPn8T8_vkHODNwP89MDrNOqu-MhObzqTfiYODw@mail.gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue, 22 Dec 2020 14:24:59 +0530
Message-ID: <CAKohpokBHcv34Qh1csHOF5w7utSNy8F_umMzv--pFuPTP9D4wg@mail.gmail.com>
Subject: Re: [PATCH v1 17/30] mmc: sdhci-tegra: Support OPP and core voltage scaling
To:     Frank Lee <tiny.windzz@gmail.com>
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
        DTML <devicetree@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 9 Nov 2020 at 16:51, Frank Lee <tiny.windzz@gmail.com> wrote:
> On Mon, Nov 9, 2020 at 1:53 PM Viresh Kumar <viresh.kumar@linaro.org> wro=
te:

> > > devm_pm_opp_set_supported_hw()
> > > devm_pm_opp_set_regulators() [if we won't use GENPD]
> > > devm_pm_opp_set_clkname()
> > > devm_pm_opp_of_add_table()
> >
> > I tried to look earlier for the stuff already merged in and didn't
> > find a lot of stuff where the devm_* could be used, maybe I missed
> > some of it.
> >
> > Frank, would you like to refresh your series based on suggestions from
> > Dmitry and make other drivers adapt to the new APIs ?
>
> I am glad to do this.=EF=BC=9A=EF=BC=89

Frank,

Dmitry has submitted a series with a patch that does stuff like this since =
you
never resent your patches.

http://lore.kernel.org/lkml/20201217180638.22748-14-digetx@gmail.com

Since you were the first one to get to this, I would still like to
give you a chance
to get these patches merged under your authorship, otherwise I would be goi=
ng
to pick patches from Dmitry.

--
viresh
