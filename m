Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964532AB080
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Nov 2020 06:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgKIFKU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Nov 2020 00:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbgKIFKT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Nov 2020 00:10:19 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE30CC061A47
        for <linux-pwm@vger.kernel.org>; Sun,  8 Nov 2020 21:10:17 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w6so1484035pfu.1
        for <linux-pwm@vger.kernel.org>; Sun, 08 Nov 2020 21:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XgmwVftW1h6VXvLFHyQ3D2f7dAvQEabg59R1W+Mex10=;
        b=HyJFeNy9dRofz/VIB02kKnHQ0GZ5T+96JVvhYzk10jI5ctp9i7zGwjha0J9RvT7KoS
         2pc97Wdrzsn3PyolfwPehIR6O2LtT+VwOUIxiVaNxCqFhlkx612Ci8AYFO6PcqbGvQrV
         N6KFFNtsuGn9CFEnzWrff+eXgA4jRD0J1w1EFt+NwY3ZWJBjfZw9+PHLeLfm2io1Nn/V
         Kh/3YaDQmTGBwyacSRhSPhXy6GHls0BoTJcsdaXKvYkli5kqPDght02p1aMejDD0uQXp
         CmTemGtBgOzJfqUVfFZlkKFA7ogWF1ZmjSAhv8iADJbcpOm7EQ1TTBPscIh1rHcB20RM
         nMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XgmwVftW1h6VXvLFHyQ3D2f7dAvQEabg59R1W+Mex10=;
        b=Vh0GUAC1gG48NqXyV5phK9Q2AyCwpWaNE6E7+5CeC6ILSMYUCEWSskGL2rKpk6iShp
         a6asqVVDP0e4d6kV08j8ApIRGLz17RisMA2NKLDNe+OsKrB6GP16Kzl8m6X6LhbgBSrR
         nd6+SWa7p0M5Lh1jH0Zv3yFk6yOGaC7jbmURIANeP8uIPtdPm0pEEVroDfQIEEJTHoLg
         VYHgNr75b/Y6sh1OyLRWF/Gekf8YsGemQa/mieccV/0X3ObgjwnMERzYqZxWRQp+JP2y
         kO9VRX4sDxj1tfrK7e/CcII2aru9sTabLopTomO7nDQtmkrLoz8WeLFk2RHR5bq7wuRW
         f7PA==
X-Gm-Message-State: AOAM533aRpb5paie/tfVcjlUn38AiqDCwLaOl1kmv58nWwYU/jAZazHu
        F9Mkhl/hnZSHYViJiCFFJdKpKA==
X-Google-Smtp-Source: ABdhPJwnxG147TJFSih2GdY+A04gFXZv8tlsN8MpSlH/99hporLJc8G2uIV3/sv7vMfOI3DyYFWFvg==
X-Received: by 2002:a63:380b:: with SMTP id f11mr11374932pga.198.1604898617255;
        Sun, 08 Nov 2020 21:10:17 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id s23sm8781212pgl.47.2020.11.08.21.10.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 21:10:16 -0800 (PST)
Date:   Mon, 9 Nov 2020 10:40:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Frank Lee <tiny.windzz@gmail.com>,
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
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
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
Subject: Re: [PATCH v1 17/30] mmc: sdhci-tegra: Support OPP and core voltage
 scaling
Message-ID: <20201109051014.oa6bt4g3ctm2hnuy@vireshk-i7>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-18-digetx@gmail.com>
 <CAOh2x==sy1w7_oEV8=toC6uQnSN44wyOixbP_X0BrMsnm1AUFg@mail.gmail.com>
 <6fa54ce6-d5ae-d04f-7c77-b62c148d92b7@gmail.com>
 <20201106061513.uyys7njcqcdlah67@vireshk-i7>
 <a6926456-8bce-a438-bfaa-be334208f004@gmail.com>
 <CAEExFWsp0DWw1yO84e3vzr_YZkqkd+pyPfQQR3J2W6n3wTX4Jw@mail.gmail.com>
 <20201109050010.g47zojh6wafvwqva@vireshk-i7>
 <c584b301-e052-7f01-335d-8f9160865198@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c584b301-e052-7f01-335d-8f9160865198@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 09-11-20, 08:08, Dmitry Osipenko wrote:
> 09.11.2020 08:00, Viresh Kumar пишет:
> > On 06-11-20, 21:41, Frank Lee wrote:
> >> On Fri, Nov 6, 2020 at 9:18 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> >>>
> >>> 06.11.2020 09:15, Viresh Kumar пишет:
> >>>> Setting regulators for count as 0 doesn't sound good to me.
> >>>>
> >>>> But, I understand that you don't want to have that if (have_regulator)
> >>>> check, and it is a fair request. What I will instead do is, allow all
> >>>> dev_pm_opp_put*() API to start accepting a NULL pointer for the OPP
> >>>> table and fail silently. And so you won't be required to have this
> >>>> unwanted check. But you will be required to save the pointer returned
> >>>> back by dev_pm_opp_set_regulators(), which is the right thing to do
> >>>> anyways.
> >>>
> >>> Perhaps even a better variant could be to add a devm versions of the OPP
> >>> API functions, then drivers won't need to care about storing the
> >>> opp_table pointer if it's unused by drivers.
> >>
> >> I think so. The consumer may not be so concerned about the status of
> >> these OPP tables.
> >> If the driver needs to manage the release, it needs to add a pointer
> >> to their driver global structure.
> >>
> >> Maybe it's worth having these devm interfaces for opp.
> > 
> > Sure if there are enough users of this, I am all for it. I was fine
> > with the patches you sent, just that there were not a lot of users of
> > it and so I pushed them back. If we find that we have more users of it
> > now, we can surely get that back.
> > 
> 
> There was already attempt to add the devm? Could you please give me a
> link to the patches?
> 
> I already prepared a patch which adds the devm helpers. It helps to keep
> code cleaner and readable.

https://lore.kernel.org/lkml/20201012135517.19468-1-frank@allwinnertech.com/

-- 
viresh
