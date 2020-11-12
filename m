Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDE62B0ADA
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 17:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgKLQ7l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 11:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgKLQ7l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 11:59:41 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C78C0613D1;
        Thu, 12 Nov 2020 08:59:40 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y16so7019915ljk.1;
        Thu, 12 Nov 2020 08:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xt95colZf33mgot8tELeNlRansGBvck/Mt4yELIIDqY=;
        b=fHDLJ02XfofqPoW/m/ty+7VMDDU5x/EGpHV/+Yy5G1qvgpLWH4Bj6qirnIfR2GOFHY
         H2rsWty5fFNMq6aCx6XdDWhpV6BR3+tvp61A5zWYd6mxO3JGE39IAl69QXwXp/OPSLOc
         dbjrfCbzaQBa8KcMu6SiyVtP5+MIJvDirOdjY9sY049RqEx6eY2eqm19yoWcz95sPsLg
         NScSb7Br1t6cH2J6CRqeJIQlDccMferVM5GcIzWR9yGjzpka13Dd7CaUaJF4CwdiAUzW
         byu4iX3gr3BVLIGe/LU4yPecdAgxDUtNUIthKeuggKFO5txc0jODLiR2lG9aCqUdXeXb
         ScEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xt95colZf33mgot8tELeNlRansGBvck/Mt4yELIIDqY=;
        b=Quc5cZb8N4+lSjAXByxBevRjhOn/VQ2Thrux0j8xs6bVFAUTeqtv9SgrxK5/4P/ZQm
         BM0ABVbCKLlQDSG2C3qu62ywTK8eWCuERI9B84iBATWsv8ujKu5EMW8HFnd4I3vvxnSf
         Bszh8r3WtDjMFk1JZfaKCI3DWQuSalenbqtbgdcbM95CNeS1kTehqRXC9zQcvdtbgwAC
         cYh4RaeIuuCJQtjuOvErAXiH0gcfZhrMniJIu//GRgzwDjWF1lVwEnlpGDm7V4u5bwWy
         RkTNUnYqRT6cpl4BdnatDzQkwe0raEEu0zaPEf4ryEXsHq0QH5V750YBoBctnljBU3W9
         5viA==
X-Gm-Message-State: AOAM532B78c8CxzTjvVOmWdO915+aRw58/d2m59OVUEwXXbc7SvDqQ63
        jbYG3IstePgOaAwD/vqnB4B0dvICp2E=
X-Google-Smtp-Source: ABdhPJyl96aYzliFwkLljLShw56ErRaoK0Xab1vQjJi14A44PY75rTZLE8QOeBZnDRsExRlkCgmYqg==
X-Received: by 2002:a2e:8315:: with SMTP id a21mr166883ljh.29.1605200379012;
        Thu, 12 Nov 2020 08:59:39 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id t5sm691068lfc.75.2020.11.12.08.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 08:59:38 -0800 (PST)
Subject: Re: [PATCH v1 11/30] drm/tegra: dc: Support OPP and SoC core voltage
 scaling
To:     Mark Brown <broonie@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
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
 <72ae6462-13df-9fcb-510e-8e57eee0f035@gmail.com>
 <20201111115534.GA4847@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dd26eb18-8ac4-22a6-29b0-dbbe5fa6075b@gmail.com>
Date:   Thu, 12 Nov 2020 19:59:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201111115534.GA4847@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

11.11.2020 14:55, Mark Brown пишет:
> On Wed, Nov 11, 2020 at 12:23:41AM +0300, Dmitry Osipenko wrote:
>> 10.11.2020 23:32, Mark Brown пишет:
> 
>>>>> +	if (!device_property_present(dc->dev, "core-supply"))
>>>>> +		return;
> 
>>>> This is a potentially heavy operation, so I think we should avoid that
>>>> here. How about you use devm_regulator_get_optional() in ->probe()? That
>>>> returns -ENODEV if no regulator was specified, in which case you can set
>>>> dc->core_reg = NULL and use that as the condition here.
> 
>>> Or enumerate the configurable voltages after getting the regulator and
>>> handle that appropriately which would be more robust in case there's
>>> missing or unusual constraints.
> 
>> I already changed that code to use regulator_get_optional() for v2.
> 
> That doesn't look entirely appropriate given that the core does most
> likely require some kind of power to operate.

We will need to do this because older DTBs won't have that regulator and
we want to keep them working.

Also, some device-trees won't have that regulator anyways because board
schematics isn't available, and thus, we can't fix them.

>> Regarding the enumerating supported voltage.. I think this should be
>> done by the OPP core, but regulator core doesn't work well if
>> regulator_get() is invoked more than one time for the same device, at
>> least there is a loud debugfs warning about an already existing
> 
> I don't understand why this would be an issue - if nothing else the core
> could just offer an interface to trigger the check.

It's not an issue, I just described what happens when device driver
tries to get a regulator twice.

There was an issue once that check is added to the regulator core code.
But perhaps not worth to discuss it for now because I don't remember
details.

>> directory for a regulator. It's easy to check whether the debug
>> directory exists before creating it, like thermal framework does it for
>> example, but then there were some other more difficult issues.. I don't
>> recall what they were right now. Perhaps will be easier to simply get a
>> error from regulator_set_voltage() for now because it shouldn't ever
>> happen in practice, unless device-tree has wrong constraints.
> 
> The constraints might not be wrong, there might be some board which has
> a constraint somewhere for 
> 

In this case board's DT shouldn't specify unsupportable OPPs.
