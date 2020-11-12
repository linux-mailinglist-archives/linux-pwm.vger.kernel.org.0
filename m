Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F8C2B0DA8
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 20:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgKLTQS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 14:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKLTQS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 14:16:18 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AE6C0613D1;
        Thu, 12 Nov 2020 11:16:18 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id p12so7512741ljc.9;
        Thu, 12 Nov 2020 11:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jhfgYY14US6m4wxn2OreBeb6CQeVO8DRDGhHQIgAX+o=;
        b=JFNyFw3LyyoB90fZPGzibsAizgKSOjs+HqVe40YhbRGey2zTAPm90qOBN8X1CJVzoO
         M3SYYsbwVohly2d/++o0SchoujkkkZR3dQt9ALW0Nr5as8bdsOwP9tSGe6IWLUkjDbLQ
         195IBsC4Go1c1FjWE4ifCXQMePRx9EASGLxk3zkSi25VwJ40hSyML0Ad1Owq7P06AL8m
         dFmcJl1TYbfZeVB79l6ZTjRGThpjEH8gcPMSD2d7MgbQCdIrxVuQr31nNcK/3J9UPz8n
         C+0AtkGaTIthUSxYky3m4HNI/HHnDyM1MWHC5gE8hZrjpfxfX3nJfxmyVs2Ix2MChWKO
         Ve6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jhfgYY14US6m4wxn2OreBeb6CQeVO8DRDGhHQIgAX+o=;
        b=Che0jVDu7B8pE34x8sdEtldRwr4yRFc9htl3oWuEdv5HFYW07SyEBbaUappE26lyq1
         +KKTYbSqQT5UWBEyYgw+xV3etiqb8a9RTqbgNHnngJZz7wLvg+UXu4iRgP8Vv71EuYeP
         DeKQk2cwl2TGcYpdtA5zzwIgYq6hhWk77uWf5lO54sJ5OB1PZhPoj0IohATBBJId8t0J
         tYHKyB6OofjpvmopZE6RyLVL2YtxCIIQLyCwxRxxCwK67AEd/Lq15OWtt4vy2VV/eKMl
         vzCMYfU0bAqAxu7m3qO7fxlqxkr8+IDNJQ4uH/v1tzUkGG+HQdT99NJxHx7yUgba4pEZ
         pHHg==
X-Gm-Message-State: AOAM532IXPzQwSn9E/XMsdGNfvsio7CJk8PepONetZi+QtmbgLx/uvx5
        DbVq2lY3ms0UnvEvcxYM9U9c9RipKLk=
X-Google-Smtp-Source: ABdhPJzE5qPV9KbGM96b/lBJNsGC5IOm8d97RUP9808EMVCjf5Dc6sywu66SXsgtyXC8GPiqUvektg==
X-Received: by 2002:a05:651c:95:: with SMTP id 21mr428933ljq.307.1605208576330;
        Thu, 12 Nov 2020 11:16:16 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id z19sm721401lfd.128.2020.11.12.11.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 11:16:15 -0800 (PST)
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
 <dd26eb18-8ac4-22a6-29b0-dbbe5fa6075b@gmail.com>
 <20201112171600.GD4742@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b4b06c1d-c9d4-43b2-c6eb-93f8cb6c677d@gmail.com>
Date:   Thu, 12 Nov 2020 22:16:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201112171600.GD4742@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

12.11.2020 20:16, Mark Brown пишет:
> On Thu, Nov 12, 2020 at 07:59:36PM +0300, Dmitry Osipenko wrote:
>> 11.11.2020 14:55, Mark Brown пишет:
>>> On Wed, Nov 11, 2020 at 12:23:41AM +0300, Dmitry Osipenko wrote:
> 
>>>> I already changed that code to use regulator_get_optional() for v2.
> 
>>> That doesn't look entirely appropriate given that the core does most
>>> likely require some kind of power to operate.
> 
>> We will need to do this because older DTBs won't have that regulator and
>> we want to keep them working.
> 
>> Also, some device-trees won't have that regulator anyways because board
>> schematics isn't available, and thus, we can't fix them.
> 
> This is what dummy supplies are for?

But it's not allowed to change voltage of a dummy regulator, is it
intentional?

>>>> Regarding the enumerating supported voltage.. I think this should be
>>>> done by the OPP core, but regulator core doesn't work well if
>>>> regulator_get() is invoked more than one time for the same device, at
>>>> least there is a loud debugfs warning about an already existing
> 
>>> I don't understand why this would be an issue - if nothing else the core
>>> could just offer an interface to trigger the check.
> 
>> It's not an issue, I just described what happens when device driver
>> tries to get a regulator twice.
> 
>> There was an issue once that check is added to the regulator core code.
>> But perhaps not worth to discuss it for now because I don't remember
>> details.
> 
> So there's no known obstacle to putting enumeration of supported
> voltages into the OPP core then?  I'm a bit confused here.

It's an obstacle if both OPP and device driver need to get the same
regulator. Like in the case of this DRM driver, which need to control
the voltage instead of allowing OPP core to do it.

Please notice that devm_tegra_dc_opp_table_init() of this patch doesn't
use dev_pm_opp_set_regulators(), which would allow OPP core to filter
out unsupported OPPs. But then OPP core will need need to get an already
requested regulator and this doesn't work well.

>>>> directory for a regulator. It's easy to check whether the debug
>>>> directory exists before creating it, like thermal framework does it for
>>>> example, but then there were some other more difficult issues.. I don't
>>>> recall what they were right now. Perhaps will be easier to simply get a
>>>> error from regulator_set_voltage() for now because it shouldn't ever
>>>> happen in practice, unless device-tree has wrong constraints.
> 
>>> The constraints might not be wrong, there might be some board which has
>>> a constraint somewhere for 
> 
>> In this case board's DT shouldn't specify unsupportable OPPs.
> 
> Ah, so each board duplicates the OPP tables then, or there's an
> expectation that if there's some limit then they'll copy and modify the
> table?  If that's the case then it's a bit redundant to do filtering
> indeed.

I think this is not strictly defined. Either way will work, although
perhaps it should be more preferred that unsupported OPPs aren't present
in a device-tree.
