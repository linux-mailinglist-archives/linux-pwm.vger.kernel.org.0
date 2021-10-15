Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC4142E5B6
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Oct 2021 03:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhJOBEZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Oct 2021 21:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhJOBEV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Oct 2021 21:04:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BCDC061753;
        Thu, 14 Oct 2021 18:02:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x27so34830638lfu.5;
        Thu, 14 Oct 2021 18:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mv5Z6Sdks/z0PRafNWu7V1r7LCkQQrDbmE+ZfMmHLqw=;
        b=H60RnvlX2azwNGf02ab1Oyj8wVvv7xw4MWUErTGrxY7uhb1rctVozCIO8sCS81VzVS
         hOZVQcmidgo6srorYYEKXtrCX+uka5RufIHO9FB8YjYtosAd1tV7yduYszwn7XqHY8T3
         P2XSvit2SOy5d04RRrtHtjjy0pTszcQ+avWKslDagv90QnM8kxz9GqKKNEWsuZkwk0oG
         RI0hyWIS7l6XKbWqVyVn0ypJq/EzThrBHBqQNDqP1p+HoYYDahsR4SOJzmb7tEtGttAs
         Wv2t95lbRv4BVqh+KbIj7b+IMF63pQ6o3e7MjI+Qa1vL14XEfbtvpEfBnM3DX3ZKeOzd
         j7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mv5Z6Sdks/z0PRafNWu7V1r7LCkQQrDbmE+ZfMmHLqw=;
        b=KG9b7jUsnSLEQL22bKZ75gAPD8cDejEMNuEyAj+5pM1X85J0/dAuhtagheoTmF3li4
         /nqMAJFDIDb09ZYin+8GOyNmo98+SHn7ITC39b82zi8i7rxEnLXS2MkR7rANv9F+vyjA
         YPtU0W82GXXmxOrIUjh14mSmY3zyQFBQmo3hsjy9BsQSnfsvLmYcYEcMpPSjZEccL61A
         wbfqAmXwxYggSHZb8YjTp2YymxiOjqlul6E0OLVKa+gapsy4U3jowm5YejWagVnsSRbB
         pxGOlelSX6r9W3dU+i3ySFZy8eGPi8zik0viaVgDKvxSyQ3g0RxGDeVcRWBqGRL3WIzK
         sNBQ==
X-Gm-Message-State: AOAM532+eBifjjMJKcvqhvgI4IzR6gzKfHGVJUWgHyiwCEl4I0X34QWu
        feIGuA5b07Vpy4Uc0k8cuUfh3pomKo0=
X-Google-Smtp-Source: ABdhPJwI0m+5o/4/ErJJ6urO1/gJpgb5iHK/zkQpI7uZEJJsVGNazonwuMOVf2cdk0laSZAgpG/4Tw==
X-Received: by 2002:ac2:443b:: with SMTP id w27mr8198374lfl.63.1634259732934;
        Thu, 14 Oct 2021 18:02:12 -0700 (PDT)
Received: from [192.168.2.145] (79-139-176-16.dynamic.spd-mgts.ru. [79.139.176.16])
        by smtp.googlemail.com with ESMTPSA id x145sm357902lff.155.2021.10.14.18.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 18:02:12 -0700 (PDT)
Subject: Re: [PATCH v12 05/35] dt-bindings: clock: tegra-car: Document new
 clock sub-nodes
To:     Stephen Boyd <sboyd@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Peter Chen <peter.chen@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
References: <20210920181145.19543-1-digetx@gmail.com>
 <20210920181145.19543-6-digetx@gmail.com>
 <163425700766.1688384.4481739110941660602@swboyd.mtv.corp.google.com>
 <4090acf8-c8af-d98c-2121-9fd105365e55@gmail.com>
 <163425874534.1688384.5636050222516713710@swboyd.mtv.corp.google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <97b2e36d-b380-8565-8409-3884ab4ca11e@gmail.com>
Date:   Fri, 15 Oct 2021 04:02:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <163425874534.1688384.5636050222516713710@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

15.10.2021 03:45, Stephen Boyd пишет:
> Quoting Dmitry Osipenko (2021-10-14 17:43:49)
>> 15.10.2021 03:16, Stephen Boyd пишет:
>>> Quoting Dmitry Osipenko (2021-09-20 11:11:15)
>>>> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
>>>> index 459d2a525393..f832abb7f11a 100644
>>>> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
>>>> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
>>>> @@ -42,6 +42,36 @@ properties:
>>>>    "#reset-cells":
>>>>      const: 1
>>>>  
>>>> +patternProperties:
>>>> +  "^(sclk)|(pll-[cem])$":
>>>> +    type: object
>>>> +    properties:
>>>> +      compatible:
>>>> +        enum:
>>>> +          - nvidia,tegra20-sclk
>>>> +          - nvidia,tegra30-sclk
>>>> +          - nvidia,tegra30-pllc
>>>> +          - nvidia,tegra30-plle
>>>> +          - nvidia,tegra30-pllm
>>>> +
>>>> +      operating-points-v2: true
>>>> +
>>>> +      clocks:
>>>> +        items:
>>>> +          - description: node's clock
>>>> +
>>>> +      power-domains:
>>>> +        maxItems: 1
>>>> +        description: phandle to the core SoC power domain
>>>
>>> Is this done to associate the power domain with a particular clk? And an
>>> OPP table with a particular clk?
>>
>> Yes
>>
> 
> Ok. Can Ulf/Viresh review this patch series?

They already did, please see v13 [1].

[1] https://lore.kernel.org/lkml/20210926224058.1252-1-digetx@gmail.com/
