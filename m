Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3EC2A8F4C
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Nov 2020 07:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKFGPT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Nov 2020 01:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgKFGPS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2020 01:15:18 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDB1C061A4A
        for <linux-pwm@vger.kernel.org>; Thu,  5 Nov 2020 22:15:17 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id x23so186943plr.6
        for <linux-pwm@vger.kernel.org>; Thu, 05 Nov 2020 22:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=F6tmY/1EFEb7yGiRngVYTKYYAOLMtuHBKlHb/X3FBro=;
        b=HzLmr6JaFIcMravMY3wIPry/F1073BkN3VM3cd8Gi2O7jw7et61EBNfNlEzqqyIEDr
         O9QiSB84NaObwQzvoVVuxKeOGt8VndPGxRzphlfH+7cLMvRgCXLb/PtEMTpcP1H83oxY
         b+191SXYF8ylE2gKUBgugVqSge7yMZjugqqrlBWgxtA673su21UfCt+IML3oDpN4vxti
         8gs+7/IuMoCGcBYg+3V7fWv1iCZUsugnMa0A4fQsRR3hvDwRfUGjQ+Urs3m1MNcObuQw
         SCG2Y8JOLZc95bYGIDT0kkK9vrovP4jkrz7oM7qStmXfzFjQgjgOi7MZJht8PgCtGzrM
         RfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=F6tmY/1EFEb7yGiRngVYTKYYAOLMtuHBKlHb/X3FBro=;
        b=UcXAxWbuuv1b4atZDbYx7l/LzPJgMLv+ZFAuJL/jtOAqzVcHEJDVFUWsmBqbbQ3TDJ
         6BiybTH/OX1kkn+lQ4NGOlUUdorvjuHtb1CcxtZQMzbezrTzp+LsvZzHrh88wEMokazm
         8EjJKHiqi2eJFfG5B6byGx4MBMInKE6gnbHHWfpSpJg9GbwHkbVxmp5djIs6lRByDVOe
         cBtFwApHWq2vyiY6hEQt8rXfjd9Ym4ibfRuswRDlFjfbtgHC7gbeE/8cVxODetGbh4nw
         iHrnoVT9LLCo9Ffj64aj9kscC/e9Jx1MoNnmeI7enxFthk/nBb0BcZQY1dA6Qq66HLru
         ESGg==
X-Gm-Message-State: AOAM532RxbcXLp9TokYGULUR3IeiGe5pA+xfAf5hOSgQ48oWsGigWcq4
        +LNUIrFNmJWXdw74xkuyud+riw==
X-Google-Smtp-Source: ABdhPJxg63tT7kf2/vWsP55uyoDC2lQuTRCTVcejh0K/L0eGZvU7H1zdtru1IjirtMh06PtAF/i6Ug==
X-Received: by 2002:a17:902:9a83:b029:d6:e05e:c7e9 with SMTP id w3-20020a1709029a83b02900d6e05ec7e9mr430546plp.49.1604643317224;
        Thu, 05 Nov 2020 22:15:17 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id h16sm703800pjz.10.2020.11.05.22.15.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 22:15:15 -0800 (PST)
Date:   Fri, 6 Nov 2020 11:45:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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
Message-ID: <20201106061513.uyys7njcqcdlah67@vireshk-i7>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-18-digetx@gmail.com>
 <CAOh2x==sy1w7_oEV8=toC6uQnSN44wyOixbP_X0BrMsnm1AUFg@mail.gmail.com>
 <6fa54ce6-d5ae-d04f-7c77-b62c148d92b7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fa54ce6-d5ae-d04f-7c77-b62c148d92b7@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 05-11-20, 17:18, Dmitry Osipenko wrote:
> 05.11.2020 12:58, Viresh Kumar пишет:
> >> +static void sdhci_tegra_deinit_opp_table(void *data)
> >> +{
> >> +       struct device *dev = data;
> >> +       struct opp_table *opp_table;
> >> +
> >> +       opp_table = dev_pm_opp_get_opp_table(dev);
> > So you need to get an OPP table to put one :)
> > You need to save the pointer returned by dev_pm_opp_set_regulators() instead.
> 
> This is intentional because why do we need to save the pointer if we're
> not using it and we know that we could get this pointer using OPP API?

Because it is highly inefficient and it doesn't follow the rules set
by the OPP core. Hypothetically speaking, the OPP core is free to
allocate the OPP table structure as much as it wants, and if you don't
use the value returned back to you earlier (think of it as a cookie
assigned to your driver), then it will eventually lead to memory leak.

> This is exactly the same what I did for the CPUFreq driver [1] :)

I will strongly suggest you to save the pointer here and do the same
in the cpufreq driver as well.

> >> +static int devm_sdhci_tegra_init_opp_table(struct device *dev)
> >> +{
> >> +       struct opp_table *opp_table;
> >> +       const char *rname = "core";
> >> +       int err;
> >> +
> >> +       /* voltage scaling is optional */
> >> +       if (device_property_present(dev, "core-supply"))
> >> +               opp_table = dev_pm_opp_set_regulators(dev, &rname, 1);
> >> +       else
> > 
> >> +               opp_table = dev_pm_opp_get_opp_table(dev);

To make it further clear, this will end up allocating an OPP table for
you, which it shouldn't have.

> > Nice. I didn't think that someone will end up abusing this API and so made it
> > available for all, but someone just did that. I will fix that in the OPP core.

To be fair, I allowed the cpufreq-dt driver to abuse it too, which I
am going to fix shortly.

> The dev_pm_opp_put_regulators() handles the case where regulator is
> missing by acting as dev_pm_opp_get_opp_table(), but the
> dev_pm_opp_set_regulators() doesn't do it. Hence I don't think this is
> an abuse, but the OPP API drawback.

I am not sure what you meant here. Normally you are required to call
dev_pm_opp_put_regulators() only if you have called
dev_pm_opp_set_regulators() earlier. And the refcount stays in
balance.

> > Any idea why you are doing what you are doing here ?
> 
> Two reasons:
> 
> 1. Voltage regulator is optional, but dev_pm_opp_set_regulators()
> doesn't support optional regulators.
> 
> 2. We need to balance the opp_table refcount in order to use OPP API
> without polluting code with if(have_regulator), hence the
> dev_pm_opp_get_opp_table() is needed for taking the opp_table reference
> to have the same refcount as in the case of the dev_pm_opp_set_regulators().

I am going to send a patchset shortly after which this call to
dev_pm_opp_get_opp_table() will fail, if it is called before adding
the OPP table.

> I guess we could make dev_pm_opp_set_regulators(dev, count) to accept
> regulators count=0 and then act as dev_pm_opp_get_opp_table(dev), will
> it be acceptable?

Setting regulators for count as 0 doesn't sound good to me.

But, I understand that you don't want to have that if (have_regulator)
check, and it is a fair request. What I will instead do is, allow all
dev_pm_opp_put*() API to start accepting a NULL pointer for the OPP
table and fail silently. And so you won't be required to have this
unwanted check. But you will be required to save the pointer returned
back by dev_pm_opp_set_regulators(), which is the right thing to do
anyways.

-- 
viresh
