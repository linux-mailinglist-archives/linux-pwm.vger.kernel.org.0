Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF083F09FC
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Aug 2021 19:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhHRRLu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Aug 2021 13:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhHRRLm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Aug 2021 13:11:42 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A168FC061764;
        Wed, 18 Aug 2021 10:11:06 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i28so6143423lfl.2;
        Wed, 18 Aug 2021 10:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jqE9ClhGb0c32X3v7BncGGF0woKsX2XgQIGx9qgWIH0=;
        b=pzxMEO2UMuT/mHPfPLSjCbX3ZOkDKV6nZIXJP5/zPjCNpAmYvVuFYDC5xhuzIXGAng
         k06Q5T/VtECFuIzWKjrForzIl4lzYGT5926+k7EPC9XdDRz2131oKSvSnQpNDCIjUZeV
         vAmDMRNzl3coOfWSZz4CU+fD10VCYBpA5I6tzFaCdMPL/E4hBdGPJ8T64iETHNj36g5/
         4Zr7nRwBnt0A/FIqmj1kKX08k9xT8d+vmEYX1QK+8VovTTlsqt2R6xS22Go2zElhhlPR
         euQHMQkRAQQ2VSVWBb0NpqmpPCycMssSiywU+Zr1oEUGDcugw9A5VFVSxFxuj21XbpAw
         m+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jqE9ClhGb0c32X3v7BncGGF0woKsX2XgQIGx9qgWIH0=;
        b=dGzsMHHXKiSmbMVeU78bpMPsi6QTWsLew0z0frcF/rj/GTaJLcOrujiRz6f8/LnUck
         GBMpgmcciF07Z9A/OXBDwEl1EhBR8dzZW+4ue2v7LrWhLbi5M7Yv0zx9ZCyqg9YAHIk4
         tMt6sNVxAeBbJNmloJZW++hqVxHNsWAKNZQpnPiKRY1knj+8na7jbJfYSyXBvvh5Zr8B
         3p67VoLf9a7To+/JnU4nVp0tdLfiHaTef/C1wsQ4AlLOW2q1sdH7zTQFuZJqXaaw5Bwx
         D3/JXQbi5RpfhfdFUB+eH1SkbhXr+td1ULLNXq3ur/N6VTuuSUW7e1m9NuLvvYTjaO+n
         tcjg==
X-Gm-Message-State: AOAM532rB1TBMhMEh0k2nz8PmrZstJcq7N1Y1t4/P7DkYGhVhI7gjdAV
        oD9LXBhkOFxQUVwtuS3Tt1IAVJjOVGA=
X-Google-Smtp-Source: ABdhPJx8mXn6y5y5nU5HWp3Gqd9IJG4zaBOIqyrwTbYskADisL9LhAfipeaTsyrerunkulv/neb4gw==
X-Received: by 2002:a05:6512:2149:: with SMTP id s9mr6957434lfr.365.1629306664851;
        Wed, 18 Aug 2021 10:11:04 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id x191sm25857lff.29.2021.08.18.10.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 10:11:04 -0700 (PDT)
Subject: Re: [PATCH v8 07/34] clk: tegra: Support runtime PM and power domain
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
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
 <20210817012754.8710-8-digetx@gmail.com> <YR0UBi/ejy+oF4Hm@orome.fritz.box>
 <da7356cb-05ee-ba84-8a7c-6e69d853a805@gmail.com>
 <YR04YHGEluqLIZeo@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ad99db08-4696-1636-5829-5260f93dc681@gmail.com>
Date:   Wed, 18 Aug 2021 20:11:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR04YHGEluqLIZeo@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

18.08.2021 19:42, Thierry Reding пишет:
> On Wed, Aug 18, 2021 at 06:05:21PM +0300, Dmitry Osipenko wrote:
>> 18.08.2021 17:07, Thierry Reding пишет:
>>> On Tue, Aug 17, 2021 at 04:27:27AM +0300, Dmitry Osipenko wrote:
>>> [...]
>>>> +struct clk *tegra_clk_register(struct clk_hw *hw)
>>>> +{
>>>> +	struct platform_device *pdev;
>>>> +	struct device *dev = NULL;
>>>> +	struct device_node *np;
>>>> +	const char *dev_name;
>>>> +
>>>> +	np = tegra_clk_get_of_node(hw);
>>>> +
>>>> +	if (!of_device_is_available(np))
>>>> +		goto put_node;
>>>> +
>>>> +	dev_name = kasprintf(GFP_KERNEL, "tegra_clk_%s", hw->init->name);
>>>> +	if (!dev_name)
>>>> +		goto put_node;
>>>> +
>>>> +	pdev = of_platform_device_create(np, dev_name, NULL);
>>>> +	if (!pdev) {
>>>> +		pr_err("%s: failed to create device for %pOF\n", __func__, np);
>>>> +		kfree(dev_name);
>>>> +		goto put_node;
>>>> +	}
>>>> +
>>>> +	dev = &pdev->dev;
>>>> +	pm_runtime_enable(dev);
>>>> +put_node:
>>>> +	of_node_put(np);
>>>> +
>>>> +	return clk_register(dev, hw);
>>>> +}
>>>
>>> This looks wrong. Why do we need struct platform_device objects for each
>>> of these clocks? That's going to be a massive amount of platform devices
>>> and they will completely mess up sysfs.
>>
>> RPM works with a device. It's not a massive amount of devices, it's one
>> device for T20 and four devices for T30.
> 
> I'm still not sure I understand why we need to call RPM functions on a
> clock. And even if they are few, it seems wrong to make these platform
> devices.

Before clock is enabled, we need to raise core voltage. After clock is
disabled, the voltage should be dropped. CCF+RPM takes care of handling
this for us.

> Perhaps they can be simple struct device:s instead? Ideally they would
> also be parented to the CAR so that they appear in the right place in
> the sysfs hierarchy.

Could you please clarify what do you mean by 'simple struct device:s'?
These clock devices should be OF devices with a of_node and etc,
otherwise we can't use OPP framework.

We don't have driver for CAR to bind. I guess we could try to add a
'dummy' CAR driver that will create sub-devices for the rpm-clocks, is
this what you're wanting?
