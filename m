Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0869A2AE191
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Nov 2020 22:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbgKJVWk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Nov 2020 16:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732030AbgKJVWj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Nov 2020 16:22:39 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4923FC0613D1;
        Tue, 10 Nov 2020 13:22:39 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id f11so185782lfs.3;
        Tue, 10 Nov 2020 13:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O1QtVEkYEMqrGZnO3N+ikHLcN2K0lknqNXllLeFS2LQ=;
        b=pB7fl8izxNp5oNkWX4iV/qwkw0tyT6eKEwrQECXK3mUYSaC9dEomYF01GGhBeLvlre
         IkJSckgzCF8yZam1usa2Jo4Er2ja4k4zzkpSBew8MmEZXC96xHJQk3lRcxEA4qY/zn3W
         t0glRvmScD5cdr0KuSOI087ThfQ+eKd9+Bd5BsIwlT8LB6LgNr4a8o7RktG3DzW1JazY
         6R3B+PEEKEA2UjJmoBvax2MxASTpMaQOmZDx5sptHM2orbaZVCDc7unOWMlHObXXd0ce
         1Y+U7h50J/kqvEhDvKkpVnRdNbf+D8CYHfPRYUX90/q5RRdutqjkRkS4Og8de1BLbTKb
         Tsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O1QtVEkYEMqrGZnO3N+ikHLcN2K0lknqNXllLeFS2LQ=;
        b=XVOdfs43Jg1voGcMKtzsF4pTneUJMEbXOxKMAY7WZ1zms0bBfVK0781Z6SBLNiA6dm
         HJd5FBg+C0o2dTE4Sali7YdXFaAHlHQTlehhRJ2hGBP/KqUNm23sdOmSJYe80zYo4txB
         nj+1OrcIjA9a+k/so5weKcAsf77MqYeGZFJg5E2oeAT+EHOmvtlWA9cXnBUvs4JWgw5j
         0kqlD2C/LdkF3+IwkHbkjXw4OHqCR0CcrWtZriWcMuGigwl4Mma6YYcSXDBQ5XXQ0OHY
         reOMzCatHT4Dx63QsC5dlbZia6vzCGTF4EXjGC8y2XxIVsDmbZlqqYxQJQckI4okNEUq
         SBBg==
X-Gm-Message-State: AOAM531yfPuZUDOwAHXLTCYtf5r+XeXqP3/g4pbu18b+z1MnKrBT1H9G
        sTrUuNEuJTsJM6gDtwkxTzGic2QmEYE=
X-Google-Smtp-Source: ABdhPJzi09fmTClirVB+g1KeYq8cdhWhqFsNo1yJJvug6dXImrBFIfNq2x3V49HaEnjk9uCntp5yAg==
X-Received: by 2002:a19:2d59:: with SMTP id t25mr8865987lft.480.1605043357309;
        Tue, 10 Nov 2020 13:22:37 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id u3sm5575lfm.57.2020.11.10.13.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 13:22:36 -0800 (PST)
Subject: Re: [PATCH v1 07/30] soc/tegra: Add sync state API
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
 <20201104234427.26477-8-digetx@gmail.com> <20201110204727.GG2375022@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <71934373-8425-345b-7719-0903f846119f@gmail.com>
Date:   Wed, 11 Nov 2020 00:22:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201110204727.GG2375022@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

10.11.2020 23:47, Thierry Reding пишет:
...
> tegra_soc_for_each_device
> 
> I wonder if you copy/pasted this or if you got really lucky to mistype
> this all three times.

Copied of course :)

I added a special spell checking rule for this typo, but it does help
reliably.

...
>> +	terga_soc_for_each_device(soc_dev) {
>> +		do {
>> +			/*
>> +			 * Devices like display controller have multiple
>> +			 * instances with the same compatible. Hence we need
>> +			 * to walk up the whole tree in order to account those
>> +			 * multiple instances.
>> +			 */
>> +			np = of_find_compatible_node(prev_np, NULL,
>> +						     soc_dev->compatible);
>> +			of_node_put(prev_np);
>> +			prev_np = np;
>> +
>> +			if (of_device_is_available(np)) {
>> +				pr_debug("added %s\n", soc_dev->compatible);
>> +				soc_dev->sync_count++;
>> +			}
>> +		} while (np);
> 
> Maybe use for_each_compatible_node() for that inside loop?

Good point! I think there is actually an of_node_put() bug in current
variant, which for_each_compatible_node() would safe from.

>> +	}
>> +
>> +	return 0;
>>  }
>> +postcore_initcall_sync(tegra_soc_devices_init);
> 
> This is unfortunate. I recall having this discussion multiple times and
> one idea that has been floating around for a while was to let a driver
> bind against the top-level "bus" node. That has the advantage that it
> both anchors the code somewhere, so we don't have to play this game of
> checking for the SoC with soc_is_tegra(), and it properly orders this
> with respect to the child devices, so we wouldn't have to make this a
> postcore_initcall.
> 
> Might be worth looking at that again, but for now this seems okay.

Thanks
