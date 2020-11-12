Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21502B0E97
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 20:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgKLT5c (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 14:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgKLT5b (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 14:57:31 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB4FC0613D1;
        Thu, 12 Nov 2020 11:57:30 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w142so10250668lff.8;
        Thu, 12 Nov 2020 11:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l+LuZmtMkfC1n7/lE6H/SI0Mh1Ao1np2jN9R6QXqrls=;
        b=Vfp4HTDvElJiGNz7xUATaYIB0Kf/mwtOmML2qqUG/J50tlFR5tGxj0224JRQCzivCv
         ulm772+iaJuiLtROs/b8uk5/vQA3IPRSNmbCaHG7e/zwzGgzfdDFCXQVjOsz/2OzAj98
         wmtD3ZpVrIRFkQm2ZyuBjOqILQ5VwslfmsUFgz95ERTTn5y+YasJEGAErk2Y0c/QB/90
         oGc0l00u8obJBUXZzPwCdZ9MBc11lwToP3XEUiaHH2/TanhPrzbdU+D21A5vJmd77mmF
         2U5W+k52Fs6mvPbZhFOLsrhNNLeCiVwZv2Tntv4g1m5P6jS8Tx3WHcMnsPh3Id7qYned
         6kOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l+LuZmtMkfC1n7/lE6H/SI0Mh1Ao1np2jN9R6QXqrls=;
        b=jceJCqVvYf7QggBYep1PGWP8zDBeehHtNkPHvonZPDMuz4d4W0S0bCsVZGVkIWDDkV
         JgzvmCTcN5cQM03BZOcOmzlVVxY2/L/QbYRYTPoyVoJP2MD20JxSh/i/7ZAwRPsbEh1v
         wkKk4/AT8FPVadrWyYfWZo18xKflnN+DP24SZlCmbGLQ77vwhnrMdrOKD5OM7996O1Ux
         Ay/TRsDFK82qt7p2y+UF/IwPjZwGzWlzp26t8GMR1kKxyWoDG6P0qBM3OQCPF+FIG4zQ
         /QDheHnzrgPo/+2IAo0tYb5m4Oc9BX9rjDDPkoX+hbGdw7pFeeHmTtPdZm+W+cmy1sue
         w8gw==
X-Gm-Message-State: AOAM532ljgPUl1qUCYq5XRwq24k/RzvuSwqiQC9K/7yekUUJW1fcpxx9
        zqJ6vWqulmOO5EtDyWrg/FEQf7ppkZI=
X-Google-Smtp-Source: ABdhPJwLlfap7vVw06tsOwrbyXWtHxJypoIY/5r/AmEyZ8iOyfm8iKxwmR6HX9kZNQ7Nvd0sVyxhmg==
X-Received: by 2002:a19:7d8:: with SMTP id 207mr432803lfh.376.1605211049107;
        Thu, 12 Nov 2020 11:57:29 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id q27sm845579lfd.261.2020.11.12.11.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 11:57:28 -0800 (PST)
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
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
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20201104234427.26477-1-digetx@gmail.com>
 <CAPDyKFr7qTU2RPhA_ZrbCayoTTNUEno1zdmvmv+8HBe-Owrfeg@mail.gmail.com>
 <cd147ab0-1304-a491-7a56-ee6199c02d32@gmail.com>
 <2716c195-083a-112f-f1e5-2f6b7152a4b5@gmail.com>
 <CAPDyKFqUMsH9dCZ=OYqfdLt==+-8NjK9n=S5jGGNXZu6Y9q=2w@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1f7e90c4-6134-2e2b-4869-5afbda18ead3@gmail.com>
Date:   Thu, 12 Nov 2020 22:57:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqUMsH9dCZ=OYqfdLt==+-8NjK9n=S5jGGNXZu6Y9q=2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

11.11.2020 14:38, Ulf Hansson пишет:
> On Sun, 8 Nov 2020 at 13:19, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 05.11.2020 18:22, Dmitry Osipenko пишет:
>>> 05.11.2020 12:45, Ulf Hansson пишет:
>>> ...
>>>> I need some more time to review this, but just a quick check found a
>>>> few potential issues...
>>>
>>> Thank you for starting the review! I'm pretty sure it will take a couple
>>> revisions until all the questions will be resolved :)
>>>
>>>> The "core-supply", that you specify as a regulator for each
>>>> controller's device node, is not the way we describe power domains.
>>>> Instead, it seems like you should register a power-domain provider
>>>> (with the help of genpd) and implement the ->set_performance_state()
>>>> callback for it. Each device node should then be hooked up to this
>>>> power-domain, rather than to a "core-supply". For DT bindings, please
>>>> have a look at Documentation/devicetree/bindings/power/power-domain.yaml
>>>> and Documentation/devicetree/bindings/power/power_domain.txt.
>>>>
>>>> In regards to the "sync state" problem (preventing to change
>>>> performance states until all consumers have been attached), this can
>>>> then be managed by the genpd provider driver instead.
>>>
>>> I'll need to take a closer look at GENPD, thank you for the suggestion.
>>>
>>> Sounds like a software GENPD driver which manages clocks and voltages
>>> could be a good idea, but it also could be an unnecessary
>>> over-engineering. Let's see..
>>>
>>
>> Hello Ulf and all,
>>
>> I took a detailed look at the GENPD and tried to implement it. Here is
>> what was found:
>>
>> 1. GENPD framework doesn't aggregate performance requests from the
>> attached devices. This means that if deviceA requests performance state
>> 10 and then deviceB requests state 3, then framework will set domain's
>> state to 3 instead of 10.
>>
>> https://elixir.bootlin.com/linux/v5.10-rc2/source/drivers/base/power/domain.c#L376
> 
> As Viresh also stated, genpd does aggregate the votes. It even
> performs aggregation hierarchy (a genpd is allowed to have parent(s)
> to model a topology).

Yes, I already found and fixed the bug which confused me previously and
it's working well now.

>> 2. GENPD framework has a sync() callback in the genpd.domain structure,
>> but this callback isn't allowed to be used by the GENPD implementation.
>> The GENPD framework always overrides that callback for its own needs.
>> Hence GENPD doesn't allow to solve the bootstrapping
>> state-synchronization problem in a nice way.
>>
>> https://elixir.bootlin.com/linux/v5.10-rc2/source/drivers/base/power/domain.c#L2606
> 
> That ->sync() callback isn't the callback you are looking for, it's a
> PM domain specific callback - and has other purposes.
> 
> To solve the problem you refer to, your genpd provider driver (a
> platform driver) should assign its ->sync_state() callback. The
> ->sync_state() callback will be invoked, when all consumer devices
> have been attached (and probed) to their corresponding provider.
> 
> You may have a look at drivers/cpuidle/cpuidle-psci-domain.c, to see
> an example of how this works. If there is anything unclear, just tell
> me and I will try to help.

Indeed, thank you for the clarification. This variant works well.

>> 3. Tegra doesn't have a dedicated hardware power-controller for the core
>> domain, instead there is only an external voltage regulator. Hence we
>> will need to create a phony device-tree node for the virtual power
>> domain, which is probably a wrong thing to do.
> 
> No, this is absolutely the correct thing to do.
> 
> This isn't a virtual power domain, it's a real power domain. You only
> happen to model the control of it as a regulator, as it fits nicely
> with that for *this* SoC. Don't get me wrong, that's fine as long as
> the supply is specified only in the power-domain provider node.
> 
> On another SoC, you might have a different FW interface for the power
> domain provider that doesn't fit well with the regulator. When that
> happens, all you need to do is to implement a new power domain
> provider and potentially re-define the power domain topology. More
> importantly, you don't need to re-invent yet another slew of device
> specific bindings - for each SoC.
> 
>>
>> ===
>>
>> Perhaps it should be possible to create some hacks to work around
>> bullets 2 and 3 in order to achieve what we need for DVFS on Tegra, but
>> bullet 1 isn't solvable without changing how the GENPD core works.
>>
>> Altogether, the GENPD in its current form is a wrong abstraction for a
>> system-wide DVFS in a case where multiple devices share power domain and
>> this domain is a voltage regulator. The regulator framework is the
>> correct abstraction in this case for today.
> 
> Well, I admit it's a bit complex. But it solves the problem in a
> nicely abstracted way that should work for everybody, at least in my
> opinion.

The OPP framework supports both voltage regulator and power domain,
hiding the implementation details from drivers. This means that OPP API
usage will be the same regardless of what approach (regulator or power
domain) is used for a particular SoC.

> Although, let's not exclude that there are pieces missing in genpd or
> the opp layer, as this DVFS feature is rather new - but then we should
> just extend/fix it.

Will be nice to have a per-device GENPD performance stats.

Thierry, could you please let me know what do you think about replacing
regulator with the power domain? Do you think it's a worthwhile change?

The difference in comparison to using voltage regulator directly is
minimal, basically the core-supply phandle is replaced is replaced with
a power-domain phandle in a device tree.

The only thing which makes me feel a bit uncomfortable is that there is
no real hardware node for the power domain node in a device-tree.
