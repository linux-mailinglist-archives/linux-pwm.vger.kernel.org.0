Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028F03EEF7B
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 17:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbhHQPxJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Aug 2021 11:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbhHQPtk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Aug 2021 11:49:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56440C061764;
        Tue, 17 Aug 2021 08:49:07 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c24so42184417lfi.11;
        Tue, 17 Aug 2021 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fG8UNioj9Gykdv3jKLDDqlFZPR9Bq4ObXeUmu51BqTw=;
        b=qCj8PB2xsh0Gwhg/Mz8T/C3RsrPHTbLP+N4lR2Yg2TB3ET2WkMAO1wgbBYR2q7lO68
         Pc49VlqXQ3dpjJrNlM2C3tPYEqqyhTGSf8sYJWR5lp0WvXn++4GF++0cA3bUAvac9XRG
         g9ViFPs99qgAUHDXdueeQwSgYGDFI/IeqfENUgVVD/rI4Q1ZQoN06DvNSee5A4aKmCOu
         S+uE5zA5q9Snqs4dlpyOLydNmfB2J5W4GujW2PkG6xWyoiPHtLSNJ/LrYoAzYXP3c7VD
         AfB16sdCF6PcILWyGV5dGRZGFQ3HUP80m2Rig47x3ImvxaecyvAZWvXPV2nsoVl7dQ3l
         YRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fG8UNioj9Gykdv3jKLDDqlFZPR9Bq4ObXeUmu51BqTw=;
        b=SYtUaG6iFKawqLK6TmhuAeX53aJ1ZVkzJFP+l9dDNvucHvL5n4xUm+Aoq7YV6sTJfb
         D0uvw5SHwZAV32fkkaXm/NN8MIARNV7EVaiuTs6Qtesf8KUumg2SvfowwZrBiMIBGfFl
         gER0JH8Z7cJktGjDKO2OQCYG1O0Ih6VQ2p7/Oali5bUo+kfFwoFgaQp13ft5UU6Lda2N
         kB0hhO7JUm8EP+jW5Nv27jLGtdyXGN1OGaHMBpyIKoVSACW//pzvNn2VhgyiuAZ7bNHG
         rciqQ9xhbFvqQVi/y5b+/75YOJDzRyYhpsRZ4lVyUARqY5UIzGGXRrh4v9VQs06Hnhea
         86rg==
X-Gm-Message-State: AOAM533sWkDiy/YVa0Yb8xc/95xXu2CGazuPIREgUaM7ODHDU4XC7YMh
        bdYmXDNp+INORDkz8qQsnAisvRusO1E=
X-Google-Smtp-Source: ABdhPJxH1hLTa5AxArOQ97RRWFvJ/qFdnD++u1srz4ssoaY8ztFeO7SrfDBXxb0r5VIrFxPoMPyxwA==
X-Received: by 2002:a19:7603:: with SMTP id c3mr2817435lff.543.1629215345270;
        Tue, 17 Aug 2021 08:49:05 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id k1sm221767lfg.187.2021.08.17.08.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 08:49:04 -0700 (PDT)
Subject: Re: [PATCH v8 01/34] opp: Add dev_pm_opp_sync() helper
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-2-digetx@gmail.com>
 <20210817075515.vyyv7z37e6jcrhsl@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <710261d9-7ae3-5155-c0a2-f8aed2408d0b@gmail.com>
Date:   Tue, 17 Aug 2021 18:49:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210817075515.vyyv7z37e6jcrhsl@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

17.08.2021 10:55, Viresh Kumar пишет:
...
>> +int dev_pm_opp_sync(struct device *dev)
>> +{
>> +	struct opp_table *opp_table;
>> +	struct dev_pm_opp *opp;
>> +	int ret = 0;
>> +
>> +	/* Device may not have OPP table */
>> +	opp_table = _find_opp_table(dev);
>> +	if (IS_ERR(opp_table))
>> +		return 0;
>> +
>> +	if (!_get_opp_count(opp_table))
>> +		goto put_table;
>> +
>> +	opp = _find_current_opp(dev, opp_table);
>> +	ret = _set_opp(dev, opp_table, opp, opp->rate);
> 
> And I am not sure how this will end up working, since new OPP will be
> equal to old one. Since I see you call this from resume() at many
> places.

Initially OPP table is "uninitialized" and opp_table->enabled=false,
hence the first sync always works even if OPP is equal to old one. Once
OPP has been synced, all further syncs are NO-OPs, hence it doesn't
matter how many times syncing is called.

https://elixir.bootlin.com/linux/v5.14-rc6/source/drivers/opp/core.c#L1012

> what exactly are you trying to do here ? Those details would be good
> to have in commit log as well, I haven't really followed V7 of your
> series.

I'm initializing voltage/power state of OPP table in accordance to the
clock rate, bumping voltage before clock is enabled by device driver.
I'll improve the commit message.

An alternative to the explicit syncing could be something like a new
dev_pm_opp_resume/suspend helpers that will take care of
enabling/disabling the OPP table clock/etc and syncing the OPP state
with h/w.
