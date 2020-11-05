Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821AC2A80A5
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 15:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgKEOSb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Nov 2020 09:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbgKEOSa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Nov 2020 09:18:30 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FE6C0613CF;
        Thu,  5 Nov 2020 06:18:30 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id l28so2502565lfp.10;
        Thu, 05 Nov 2020 06:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a5y+ASdbJF7UbQ+vp77BCT2KDi+gpOYaKC8ivtEOGj0=;
        b=g4l+hVmvZJ+r32x9EsssFNsZ5oXkz9HqijwiMWB20Hs8LV8tDeXO5wDP2AG/Ia3GaI
         Hwuea13bqdIIKnem0td0/UpNjHWgB9DVjy6hdPRCWVbFoNJzj4M0fZUFU/7RNBU4rt3k
         kc9tlA0jovLN0Gusx603CbzP46guXz28PiRbiR3kuvvviuP6Rb5iGKwNBBBKtt9lmPld
         D87eVIe2ld++drVrg0eJZY1aSlqZ4dpJU4tfJCdDrFPZ7eVkJFF2a93Zl0nVR6L6/l3m
         hrI6o51kHJEVFgIEDT2hWkgqUBcql4bZDnxqmeku7yRtNmSh5zeKlfoGUV2h+Y+8tAdf
         yy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a5y+ASdbJF7UbQ+vp77BCT2KDi+gpOYaKC8ivtEOGj0=;
        b=MH2/VWRm0UMjx6uGhpDHinf4zjncdaO5oC8dypzRnBITedBjZSPTmI+WpOynSr2lvF
         dhjVaNMzSRfgy24FKK1VBylF9YH8vIWJQ+F+rnnEOJ2dg8CyUFSAPNGLOgtf0v11Rp3h
         jF8GyePCS6PnW4tWJq5W+Qg49vrsMy0qdegZTWd8qUUTDNiHmPa9aIZwJuI5VNWDVoWn
         59CHi9SGY2ra1O0TUCyxla8QibtFtH9KvulLO6+CDQK44r3hpICVoHIR79zg7jcWIrk4
         EJDPvMKLh8zDy+2RXLUkKMt0OVqNPP7EZuFubuXTq+8fYMI18MMyjzvyGkyYh8UraB91
         4ygg==
X-Gm-Message-State: AOAM530JlbJKMr1gjMyJN0VFoYS2aRqC7oRP1CzC7VvwzUXC0v6gcrIy
        /wNjuBPyQGzsnvq/xuVp5JrwtoH86eQ=
X-Google-Smtp-Source: ABdhPJwoANVa5YaT/Dinn/I6WAD0v1YZJaRBuao5eyb3VmVXegLCD7snX/bqOHRg8V3ordcvrgDQ6A==
X-Received: by 2002:a19:ad04:: with SMTP id t4mr1028403lfc.577.1604585908263;
        Thu, 05 Nov 2020 06:18:28 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.googlemail.com with ESMTPSA id q4sm162676ljp.103.2020.11.05.06.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 06:18:27 -0800 (PST)
Subject: Re: [PATCH v1 17/30] mmc: sdhci-tegra: Support OPP and core voltage
 scaling
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
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
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-18-digetx@gmail.com>
 <CAOh2x==sy1w7_oEV8=toC6uQnSN44wyOixbP_X0BrMsnm1AUFg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6fa54ce6-d5ae-d04f-7c77-b62c148d92b7@gmail.com>
Date:   Thu, 5 Nov 2020 17:18:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAOh2x==sy1w7_oEV8=toC6uQnSN44wyOixbP_X0BrMsnm1AUFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

05.11.2020 12:58, Viresh Kumar пишет:
>> +static void sdhci_tegra_deinit_opp_table(void *data)
>> +{
>> +       struct device *dev = data;
>> +       struct opp_table *opp_table;
>> +
>> +       opp_table = dev_pm_opp_get_opp_table(dev);
> So you need to get an OPP table to put one :)
> You need to save the pointer returned by dev_pm_opp_set_regulators() instead.

This is intentional because why do we need to save the pointer if we're
not using it and we know that we could get this pointer using OPP API?
This is exactly the same what I did for the CPUFreq driver [1] :)

[1]
https://elixir.bootlin.com/linux/v5.10-rc2/source/drivers/cpufreq/tegra20-cpufreq.c#L97

>> +       dev_pm_opp_of_remove_table(dev);
>> +       dev_pm_opp_put_regulators(opp_table);
>> +       dev_pm_opp_put_opp_table(opp_table);
>> +}
>> +
>> +static int devm_sdhci_tegra_init_opp_table(struct device *dev)
>> +{
>> +       struct opp_table *opp_table;
>> +       const char *rname = "core";
>> +       int err;
>> +
>> +       /* voltage scaling is optional */
>> +       if (device_property_present(dev, "core-supply"))
>> +               opp_table = dev_pm_opp_set_regulators(dev, &rname, 1);
>> +       else
> 
>> +               opp_table = dev_pm_opp_get_opp_table(dev);
> Nice. I didn't think that someone will end up abusing this API and so made it
> available for all, but someone just did that. I will fix that in the OPP core.

The dev_pm_opp_put_regulators() handles the case where regulator is
missing by acting as dev_pm_opp_get_opp_table(), but the
dev_pm_opp_set_regulators() doesn't do it. Hence I don't think this is
an abuse, but the OPP API drawback.

> Any idea why you are doing what you are doing here ?

Two reasons:

1. Voltage regulator is optional, but dev_pm_opp_set_regulators()
doesn't support optional regulators.

2. We need to balance the opp_table refcount in order to use OPP API
without polluting code with if(have_regulator), hence the
dev_pm_opp_get_opp_table() is needed for taking the opp_table reference
to have the same refcount as in the case of the dev_pm_opp_set_regulators().

I guess we could make dev_pm_opp_set_regulators(dev, count) to accept
regulators count=0 and then act as dev_pm_opp_get_opp_table(dev), will
it be acceptable?
