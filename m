Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371B42AE17B
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Nov 2020 22:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgKJVRg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Nov 2020 16:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJVRf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Nov 2020 16:17:35 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E44DC0613D1;
        Tue, 10 Nov 2020 13:17:34 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id b17so3790877ljf.12;
        Tue, 10 Nov 2020 13:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vf5kUjShC7D4zxjBHAlcMmZpxwxqDm+lWkcny/PyTLU=;
        b=Bb6TkkCgyvh2gtRxC0/lZw/l5uChihV6xuDSvj+rng+LYcNWyxYb8WUqo9KsrKm3BS
         S8dKRCnLXwn/IGgp2WbbQ3DIv29EHR5Va7mjo4s2WaO63VgRRZfaasHdsQle99i7igTs
         +gGifF40vB3CE1jzC81DdjJtvR7W9V0IGwrUkQahhQhQhJMCAKLeoq5VMYX9c698zGhw
         tXh33thzdMaCXs1uut8wQPkGtgubi+1DOWac+ED56DYMUJzkOnN5q2pe0rlX4mcji/jG
         vpFko7ZNU5mM3vDGH+Db9LGIad7B2kJg7mDut+7PhHZNxAzGHTJDtIL8rYMi5kZkhVIk
         STKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vf5kUjShC7D4zxjBHAlcMmZpxwxqDm+lWkcny/PyTLU=;
        b=taRtUWryqLSDN8BTYmtGE+SbWqHlIfSbAly8bVJBxmPNrF9SQks7/mYRHmMgJ1eAJp
         eoQo4OwNtE9UiMaBna5hKCZ61DGvc4KOPl6WQtVqa9/kDnfqV4hy08ZbDrhTauVQCOUy
         b+ILHVUUt3kDkLapFtig6zqpXtLNAsS/E2vMawe+l5n6RJF5Bob+EUM7MjqrYeM+dMYF
         LQV1K6Y2shhB7cGsRPVHkjA6yp/uv1UjQYsdfVrqVL1zgAozVJCD3SDfIBL9+9Wdjybq
         jaHm/WEQxihaJQWOcC5XaUzDIxVpAVhguH6pEKx8sBAzWNGFoOmzwdGJsG7i6dd3kAig
         VFzQ==
X-Gm-Message-State: AOAM531VCy0IowRabNGAyNAkvH30KSpob/3ej7aL5+TfSvjrQV1ZiaMT
        5jQoZsZLptZSeKVTofWBV3koKviVJJs=
X-Google-Smtp-Source: ABdhPJwNwDYOAu/bhUmj7d89Tpyf84CZcga2xU2aTsm1UWGg6/U705pR3xmW2fAZuG66Gw6OXy/oSw==
X-Received: by 2002:a05:651c:1199:: with SMTP id w25mr4001382ljo.165.1605043051937;
        Tue, 10 Nov 2020 13:17:31 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id 201sm3281lfk.152.2020.11.10.13.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 13:17:31 -0800 (PST)
Subject: Re: [PATCH v1 11/30] drm/tegra: dc: Support OPP and SoC core voltage
 scaling
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
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
        linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-12-digetx@gmail.com> <20201110202945.GF2375022@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6bbec0aa-732a-2feb-684a-b1d8cc6a0471@gmail.com>
Date:   Wed, 11 Nov 2020 00:17:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201110202945.GF2375022@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

10.11.2020 23:29, Thierry Reding пишет:
>> +
>> +	dc->opp_table = dev_pm_opp_get_opp_table(dc->dev);
>> +	if (IS_ERR(dc->opp_table))
>> +		return dev_err_probe(dc->dev, PTR_ERR(dc->opp_table),
>> +				     "failed to prepare OPP table\n");
>> +
>> +	if (of_machine_is_compatible("nvidia,tegra20"))
>> +		hw_version = BIT(tegra_sku_info.soc_process_id);
>> +	else
>> +		hw_version = BIT(tegra_sku_info.soc_speedo_id);
>> +
>> +	hw_opp_table = dev_pm_opp_set_supported_hw(dc->dev, &hw_version, 1);
>> +	err = PTR_ERR_OR_ZERO(hw_opp_table);
> What's the point of this? A more canonical version would be:
> 
> 	if (IS_ERR(hw_opp_table)) {
> 		err = PTR_ERR(hw_opp_table);
> 		dev_err(dc->dev, ...);
> 		goto put_table;
> 	}
> 
> That uses the same number of lines but is much easier to read, in my
> opinion, because it is the canonical form.
> 

Your variant is much more difficult to read for me :/

I guess the only reason it could be "canonical" is because
PTR_ERR_OR_ZERO was added not so long time ago.

But don't worry, this code will be moved out in a v2 and it won't use
PTR_ERR_OR_ZERO.
