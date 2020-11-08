Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0D2AAAF7
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Nov 2020 13:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgKHMTW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 8 Nov 2020 07:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgKHMTV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 8 Nov 2020 07:19:21 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0198C0613CF;
        Sun,  8 Nov 2020 04:19:20 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l2so8264578lfk.0;
        Sun, 08 Nov 2020 04:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2sZ4icayrxxDWpa2xJypEQHGIoro/hg/XjsXfIMVIO0=;
        b=rFpONZz/Kl33uh/dizvuNJQR2av8Rv5uFlJ5DePIU/DxOtnlMkNpGoI3JXUj2MWsEF
         ir6IGHMPuOz5Ha0JkEbKS4xflgVuaxejRvr3J7nUUQOCUdjtzTtB+/2LCSIwZ1YYD/TJ
         lKE8uooAVEPA5V7sGNiXi7IF5izcclg1E7XOW+XQRLEz/SOzhIs5xZCH9hY7R371YhQJ
         LdeTxesJm0/t9nWD/LlBWtdARIzCuiHjTsZN8sOpocViLXo7UpaGVp/CBzAK20Ddkauz
         tbH9apGbBjlfs/0xTDfRayemP603Ij5uZuDJzOs53HjDllldmig65ToOUo4o93xa8AYC
         tAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2sZ4icayrxxDWpa2xJypEQHGIoro/hg/XjsXfIMVIO0=;
        b=a0VrwSjIo7DPx418VgQPnP7O7neTTCqu0icPt2WzwWobZaZX1emMwqLA2mUVDMX658
         52FSjkV2QnBRR4J78NbYum7oKX0gTvu2Dw9twhUdkxnlfVUTX1rGhgpUELBgHg3qIL61
         scNfR/wW9t5p1secyzgnGI8+dgkBPJNAdTJf+qVWH4ejy5/GudXp2ObX6C3QgYvdOrkU
         PwIbCk/kDjaTc09rRblXGAqkasN4vEsF58vS5kOtsrc/wuiu8TCvVOMqcd/nBIefEvi0
         7+d70o5zJ6ENSEwPttjK9P08P15Ds7UStyF7yq5yWzRZHYY8VnLsh+qMqDFtTtx86CBF
         1JXg==
X-Gm-Message-State: AOAM532WNQm7NkHr9PMosQY1fp/5mdNCTavtHa/F9S0seojw693xnAA6
        eQg4GAvPsnQi0Y+/Emf2qficb/gmkfA=
X-Google-Smtp-Source: ABdhPJx2JpfTMAfVNhGgqvUuTHG0na3AuqFBXgT3nmIXEBqvHyuzg1Il4cTfxq8l0jMElMVqEADDJg==
X-Received: by 2002:a05:6512:3250:: with SMTP id c16mr469413lfr.404.1604837959047;
        Sun, 08 Nov 2020 04:19:19 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id d26sm1479402ljj.102.2020.11.08.04.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 04:19:18 -0800 (PST)
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
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
Message-ID: <2716c195-083a-112f-f1e5-2f6b7152a4b5@gmail.com>
Date:   Sun, 8 Nov 2020 15:19:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cd147ab0-1304-a491-7a56-ee6199c02d32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

05.11.2020 18:22, Dmitry Osipenko пишет:
> 05.11.2020 12:45, Ulf Hansson пишет:
> ...
>> I need some more time to review this, but just a quick check found a
>> few potential issues...
> 
> Thank you for starting the review! I'm pretty sure it will take a couple
> revisions until all the questions will be resolved :)
> 
>> The "core-supply", that you specify as a regulator for each
>> controller's device node, is not the way we describe power domains.
>> Instead, it seems like you should register a power-domain provider
>> (with the help of genpd) and implement the ->set_performance_state()
>> callback for it. Each device node should then be hooked up to this
>> power-domain, rather than to a "core-supply". For DT bindings, please
>> have a look at Documentation/devicetree/bindings/power/power-domain.yaml
>> and Documentation/devicetree/bindings/power/power_domain.txt.
>>
>> In regards to the "sync state" problem (preventing to change
>> performance states until all consumers have been attached), this can
>> then be managed by the genpd provider driver instead.
> 
> I'll need to take a closer look at GENPD, thank you for the suggestion.
> 
> Sounds like a software GENPD driver which manages clocks and voltages
> could be a good idea, but it also could be an unnecessary
> over-engineering. Let's see..
> 

Hello Ulf and all,

I took a detailed look at the GENPD and tried to implement it. Here is
what was found:

1. GENPD framework doesn't aggregate performance requests from the
attached devices. This means that if deviceA requests performance state
10 and then deviceB requests state 3, then framework will set domain's
state to 3 instead of 10.

https://elixir.bootlin.com/linux/v5.10-rc2/source/drivers/base/power/domain.c#L376

2. GENPD framework has a sync() callback in the genpd.domain structure,
but this callback isn't allowed to be used by the GENPD implementation.
The GENPD framework always overrides that callback for its own needs.
Hence GENPD doesn't allow to solve the bootstrapping
state-synchronization problem in a nice way.

https://elixir.bootlin.com/linux/v5.10-rc2/source/drivers/base/power/domain.c#L2606

3. Tegra doesn't have a dedicated hardware power-controller for the core
domain, instead there is only an external voltage regulator. Hence we
will need to create a phony device-tree node for the virtual power
domain, which is probably a wrong thing to do.

===

Perhaps it should be possible to create some hacks to work around
bullets 2 and 3 in order to achieve what we need for DVFS on Tegra, but
bullet 1 isn't solvable without changing how the GENPD core works.

Altogether, the GENPD in its current form is a wrong abstraction for a
system-wide DVFS in a case where multiple devices share power domain and
this domain is a voltage regulator. The regulator framework is the
correct abstraction in this case for today.
