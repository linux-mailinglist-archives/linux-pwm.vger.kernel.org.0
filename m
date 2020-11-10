Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847402AE19D
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Nov 2020 22:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbgKJVXr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Nov 2020 16:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJVXq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Nov 2020 16:23:46 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307FDC0613D1;
        Tue, 10 Nov 2020 13:23:45 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id j205so162194lfj.6;
        Tue, 10 Nov 2020 13:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z3y2+cM5+FqYhQiui9sx/NyVq3rbzN6lwK3hqYhLaV8=;
        b=MW7uaSPUscsvLgXHTARFkRHWLwcumbFgh/LvDj5UKi+RX8auOx189mq2TdUmSsRTNi
         XRn4kbwyuLHjtSYaHwe+spIMfuNWREoRSQl6/bBzCt2bgTA+kpefEAHIuAZonduQ4l+g
         boLidEBfR0POZlIShVqthNjwQRWsm8yKic8lAIVEbN1P1xWEDJvlT8mHP1yNXcudhsTQ
         NwLdoSYLmCTwy8iOSWENTf2hnQlDzEZVLZ0k3G26fETZVVs3Gtz6DL86Q9wj+mQAUQYw
         dZ5ZkUU0jA7OLM1kL0DCUAatZ5ABr+OPjrZDaTqVyRlDanl6LP0kTq90IsKr6kgrNGY/
         G3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z3y2+cM5+FqYhQiui9sx/NyVq3rbzN6lwK3hqYhLaV8=;
        b=nxB5yLZze6XvZgyF7Xh8eBG8Ijl7ETiKYadms8g7ENwN5C6LH1lpKWHbioKvMAVM3x
         6+PL/CWTYr7Tt2mu5zCSEcXwQgVG8kzythokKhAJ3HvIEH8iNXnt57Prpukr6jOpAQaU
         2PhtPYwqI38+badmOzkeIPem939q4HPD8SW6qtvALJzBA1wYVbOR6vxKitSzoGDqvWah
         8jEmpq5MfRx7cHl2S2rF5GqZk+oB6NapK6E19A+yqK4pQaiVtF9OmRekEfgh1Pwb9xCc
         AdjVwrtm8/w9F65jVDtY7dJ2uu03NArNTZXfMdKd+dH/aM0TjUdkTxAc3j5nl1nbfD1n
         jGnA==
X-Gm-Message-State: AOAM531GXsy2KJ2UruY+95iKUmqEHGA94YW7xQEWSW/g8QAn4LaMzten
        LJ6VXQtm5fsSJ8BB103LDobnDEoa1iY=
X-Google-Smtp-Source: ABdhPJxu+BBnt3e7PE9coUJuXY67nqcK2aWRMSusUxlgbN4K8B9Bg3GI+cjuRM7DUdJ8ilqOcn0l0Q==
X-Received: by 2002:ac2:46f3:: with SMTP id q19mr872398lfo.76.1605043423538;
        Tue, 10 Nov 2020 13:23:43 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id b25sm6087lfa.32.2020.11.10.13.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 13:23:42 -0800 (PST)
Subject: Re: [PATCH v1 11/30] drm/tegra: dc: Support OPP and SoC core voltage
 scaling
To:     Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
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
 <20201110203257.GC5957@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <72ae6462-13df-9fcb-510e-8e57eee0f035@gmail.com>
Date:   Wed, 11 Nov 2020 00:23:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201110203257.GC5957@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

10.11.2020 23:32, Mark Brown пишет:
> On Tue, Nov 10, 2020 at 09:29:45PM +0100, Thierry Reding wrote:
>> On Thu, Nov 05, 2020 at 02:44:08AM +0300, Dmitry Osipenko wrote:
> 
>>> +	/*
>>> +	 * Voltage scaling is optional and trying to set voltage for a dummy
>>> +	 * regulator will error out.
>>> +	 */
>>> +	if (!device_property_present(dc->dev, "core-supply"))
>>> +		return;
> 
>> This is a potentially heavy operation, so I think we should avoid that
>> here. How about you use devm_regulator_get_optional() in ->probe()? That
>> returns -ENODEV if no regulator was specified, in which case you can set
>> dc->core_reg = NULL and use that as the condition here.
> 
> Or enumerate the configurable voltages after getting the regulator and
> handle that appropriately which would be more robust in case there's
> missing or unusual constraints.
> 

I already changed that code to use regulator_get_optional() for v2.

Regarding the enumerating supported voltage.. I think this should be
done by the OPP core, but regulator core doesn't work well if
regulator_get() is invoked more than one time for the same device, at
least there is a loud debugfs warning about an already existing
directory for a regulator. It's easy to check whether the debug
directory exists before creating it, like thermal framework does it for
example, but then there were some other more difficult issues.. I don't
recall what they were right now. Perhaps will be easier to simply get a
error from regulator_set_voltage() for now because it shouldn't ever
happen in practice, unless device-tree has wrong constraints.
