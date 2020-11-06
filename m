Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158632A9720
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Nov 2020 14:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbgKFNlT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Nov 2020 08:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgKFNlS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2020 08:41:18 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C823C0613CF;
        Fri,  6 Nov 2020 05:41:18 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id k3so1952187ejj.10;
        Fri, 06 Nov 2020 05:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YxlySBEtfM8plnPwR3qjjCyIfVvwbfiGqCyLIXMcAVY=;
        b=bNf+JFTJi7loW9QoZYLAj1mxw3CAaxrBETbasN+Ksr6IIFCVZiJMenzWRn6BdIG2XL
         LE/DALyZRKTHE60zpb6rAGkpZS6ag4kod9Asip/bpyt1ceCPadTaepJK+Gfa90DfJA+K
         4kyTY7NRg33tum1uhTSN3RxZYArP87cMPJc/Ey8qgbT4UjgPCbUkb2txF28Io8BM66m0
         QJg9/oupqK9QNybaSr+lQoGE6U7DltDxFzsFb2C5GdrkTTaolp386Psm1DmeKWJOkDYo
         T+6SOSVHbmE67mhYkgbO2p1yXjMNl7d7gmvfb/yWOBvoTyT0IQeOw7ugR5S1p/uEdY3h
         0fJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YxlySBEtfM8plnPwR3qjjCyIfVvwbfiGqCyLIXMcAVY=;
        b=cvKnb1r469TwJzl4GFVmKxS6wXLC90/AQ15XpREwMzO40N8o05KBlS9v0cIgYED9W+
         YekD3JZTlrcEIba/Sh96uuiHTPnb6MDNbltMmlQTwoJuOW8ltb+7Wq2IzmiQMWJDxxvf
         Whj6B7qwmaJ+5wjVuM/9iUgKdztQU0e5nE3ufRIu9HJ8Gwl4LgIkYv4Ipo9+tQyyYL8Q
         ndcg8jrDU+PMVb/IS5l4rFjg7XeAkmLhLfKFG+YrX9w1Fhl65+jeOxA0suYZWoFFQJ5M
         Z8NTubrIanwGtjM9xjUMokBu78E79dNAJp+hIKvMGQjpi43ztZJabUh8dRQviT7KxqOk
         suSg==
X-Gm-Message-State: AOAM5339TKOxzNcnh24+IVjzt/TBZUMZBkKj25VlRjm9CQSaQe7+kMqf
        0Goxf3+fyAo7eRCAqlJORF2JC2rvjrGwris+WzU=
X-Google-Smtp-Source: ABdhPJwedRmD3YJS+mk5L/dYqDNvjdIvAR1tRZGg45jYDZepuD2Hi9ud9Rcyv7zuPeXIuZjSxTVK7dd4xN347lIHCio=
X-Received: by 2002:a17:906:6d83:: with SMTP id h3mr2014952ejt.481.1604670076814;
 Fri, 06 Nov 2020 05:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20201104234427.26477-1-digetx@gmail.com> <20201104234427.26477-18-digetx@gmail.com>
 <CAOh2x==sy1w7_oEV8=toC6uQnSN44wyOixbP_X0BrMsnm1AUFg@mail.gmail.com>
 <6fa54ce6-d5ae-d04f-7c77-b62c148d92b7@gmail.com> <20201106061513.uyys7njcqcdlah67@vireshk-i7>
 <a6926456-8bce-a438-bfaa-be334208f004@gmail.com>
In-Reply-To: <a6926456-8bce-a438-bfaa-be334208f004@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 6 Nov 2020 21:41:05 +0800
Message-ID: <CAEExFWsp0DWw1yO84e3vzr_YZkqkd+pyPfQQR3J2W6n3wTX4Jw@mail.gmail.com>
Subject: Re: [PATCH v1 17/30] mmc: sdhci-tegra: Support OPP and core voltage scaling
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
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

On Fri, Nov 6, 2020 at 9:18 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 06.11.2020 09:15, Viresh Kumar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Setting regulators for count as 0 doesn't sound good to me.
> >
> > But, I understand that you don't want to have that if (have_regulator)
> > check, and it is a fair request. What I will instead do is, allow all
> > dev_pm_opp_put*() API to start accepting a NULL pointer for the OPP
> > table and fail silently. And so you won't be required to have this
> > unwanted check. But you will be required to save the pointer returned
> > back by dev_pm_opp_set_regulators(), which is the right thing to do
> > anyways.
>
> Perhaps even a better variant could be to add a devm versions of the OPP
> API functions, then drivers won't need to care about storing the
> opp_table pointer if it's unused by drivers.

I think so. The consumer may not be so concerned about the status of
these OPP tables.
If the driver needs to manage the release, it needs to add a pointer
to their driver global structure.

Maybe it's worth having these devm interfaces for opp.

Yangtao
