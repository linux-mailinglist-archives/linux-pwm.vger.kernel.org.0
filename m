Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19993F0761
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Aug 2021 17:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbhHRPE7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Aug 2021 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbhHRPE4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Aug 2021 11:04:56 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDDEC061764;
        Wed, 18 Aug 2021 08:04:21 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y6so5710956lje.2;
        Wed, 18 Aug 2021 08:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xr9jfom6cWdr34E1fd8HPE7h7ktRyhvZRNFf4lj4jAQ=;
        b=d7vWQtfYNwjvKTlX+D7cGmxzglW4/UcbCP3k883yPwOnxzLjUO0MPLUtr+mkpWt1Oi
         P6esNY3xCKInvn9sKG4XBfONscW0AIoeu5bJLV5ZTKWBGLAhdZ64HG8UcVIz6r2nfQQl
         Yrxf+zPusVZGvFkC4QytKocyFHnvXnTinlNufGur7yB83siMoPE+NlIFcdErvMFOvaRm
         djF5sqCwTodRZH48kqlk0WysuoONIiF9oO3KYSPg+WVHw6iqzbFtFUS7q02t5k20ekd+
         45EsBKWTuCNLNfcORCVLawHr8Q3kMXd1Bq4Pg8JARvc5KVV1TVghp79Rl7Nr3fufWiW5
         iqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xr9jfom6cWdr34E1fd8HPE7h7ktRyhvZRNFf4lj4jAQ=;
        b=ogNq+EgYAb+XlHXYgS5K51twqfMoa5mFXm6EGIGvvINYEA/B0bq8rd+Ls9HsfLHNku
         TqcZL253G4RJ6E6teHTckfJUv3a9nQoOe/PTKemrPM2M6xTQN4o5I9gMVarmMSvsyER3
         60mVnq04ZQqjjG4QeFRDi/RAp50JhXbZQnV3leYdpDU0+ACFyGiKhwA1jT158RmdIsJm
         LY9gNlKHapZsIXt1CjfXCyN7iMV4crInBf5ledInD5NYbWANgZ3rzxKiyPYHiBxGRYDC
         2/vP0gduRX4ewSjCTclVGl9JejvhLHmBUo1oiEyNfz4IT2l8kIPaLmdWIExdFAYzuTKy
         OSYw==
X-Gm-Message-State: AOAM531nRdI6OUh1dOEpJ32uGWhWugMaXJBt3d4uzgFKtCP8pSXPu6/G
        4Qdet6zbArPpX8t+Jk5Bgmx98yhi558=
X-Google-Smtp-Source: ABdhPJyyQVKytu447MFJPeps/ZgloBzDSSZ92Nm3+pCI6+S9Y81A/uwqWMGjetCbs6/mNtqN/r95BQ==
X-Received: by 2002:a2e:99da:: with SMTP id l26mr8197284ljj.339.1629299059349;
        Wed, 18 Aug 2021 08:04:19 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id q5sm517822lfb.78.2021.08.18.08.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 08:04:18 -0700 (PDT)
Subject: Re: [PATCH v8 06/34] dt-bindings: clock: tegra-car: Document new
 tegra-clocks sub-node
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
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
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-7-digetx@gmail.com>
 <YRxfGtWPXeSQXuHo@robh.at.kernel.org>
 <06128217-92e1-9b66-64ea-91855d041121@gmail.com>
 <YR0QrFGZs6iQv1N3@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <659df86d-4fa1-b541-3d0d-8a1622fe7068@gmail.com>
Date:   Wed, 18 Aug 2021 18:04:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR0QrFGZs6iQv1N3@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

18.08.2021 16:52, Thierry Reding пишет:
> On Wed, Aug 18, 2021 at 04:44:30AM +0300, Dmitry Osipenko wrote:
>> 18.08.2021 04:15, Rob Herring пишет:
>>>> +  tegra-clocks:
>>>> +    description: child nodes are the output clocks from the CAR
>>>> +    type: object
>>>> +
>>>> +    patternProperties:
>>>> +      "^[a-z]+[0-9]+$":
>>>> +        type: object
>>>> +        properties:
>>>> +          compatible:
>>>> +            allOf:
>>>> +              - items:
>>>> +                  - enum:
>>>> +                      - nvidia,tegra20-sclk
>>>> +                      - nvidia,tegra30-sclk
>>>> +                      - nvidia,tegra30-pllc
>>>> +                      - nvidia,tegra30-plle
>>>> +                      - nvidia,tegra30-pllm
>>>> +              - const: nvidia,tegra-clock
>>> You are saying the first string must be both one of the enums and 
>>> 'nvidia,tegra-clock'. You don't get an error because your pattern 
>>> doesn't match 'sclk'.
>>>
>>
>> Could you please rephrase or clarify? If pattern doesn't match 'sclk',
>> then it must match any other enum. I'm not sure what you're meaning.
> 
> "sclk" doesn't match "^[a-z]+[0-9]+$" because it's missing at least one
> digit at the end. Perhaps that last + was supposed to be *?

Ah, the regex pattern. Yes, I forgot to update it.

>> The 'nvidia,tegra-clock' actually could be removed since it's
>> superfluous now. I'll consider the removal in v9.
> 
> It also looks like your schema was meant to be something like:
> 
> 	compatible:
> 	  - items:
> 	      - enum:
> 	          - nvidia,tegra20-sclk
> 	          - nvidia,tegra30-sclk
> 	          - nvidia,tegra30-pllc
> 	          - nvidia,tegra30-plle
> 	          - nvidia,tegra30-pllm
> 	      - const: nvidia,tegra-clock
> 
> Note how the const: element is indented one more level. Now this means:
> one of the enumeration values, followed by the constant value. That
> matches what the example has.
> 
> That said, I agree that nvidia,tegra-clock seems a bit useless. There's
> really no such thing as a generic clock, they're all different in some
> way.

It's a leftover from older versions of this patchset, I'll remove it.
