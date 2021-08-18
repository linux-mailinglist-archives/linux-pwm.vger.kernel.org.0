Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1623EF7DA
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Aug 2021 04:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhHRCFi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Aug 2021 22:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhHRCFh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Aug 2021 22:05:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9DFC061764;
        Tue, 17 Aug 2021 19:05:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z2so1237790lft.1;
        Tue, 17 Aug 2021 19:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X8+ZsfkkdhFJ3lNlK7e7T4FVUdx6tvIJ9KJHYwNXX0E=;
        b=psE/+Zb/PlhPOXdD9k7AaCLwlvP8OKK2CxCpqtTva5uF/wv+Xtz6ZZdtrMlAsRQDtg
         7rJ1+OFJG70Mh6foE8c/wWZu0py55FepYDWxIbDuoVTxTgBuzT8ZcFjpgV0uw7z0bwOq
         i9HHUiAj3Xqbast6UUZ8gmBgbXw0U4LpmOyNFm67RejtBHQP2jypUFUUKW0xIcMgMKcL
         ChJSL/bQlQM0gRznLB21YUo8/DgwCsLyw/I/zDvt4ajeJqQnSAPqYHVtMBJYBP0KBvdo
         65wfts0XEWuHOf4x7WBr50M1S1Ive7NyVGoWeMXJtbq5mjMMdP45+6N1n0CRVKczG1XI
         jxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X8+ZsfkkdhFJ3lNlK7e7T4FVUdx6tvIJ9KJHYwNXX0E=;
        b=nIFaXjtJgRKn12nQMXlgWtjIg0O4k7TSmlvjzrsk1Cn42u2rp0rMQhuM+lxT8uvuOq
         pmPOHMSE2ddHa1qaltQvYkxdy1KjLYkRyUpGggnv3MB0xfDe4NcP5pjIg7HmL3miZDvD
         x/OsqS/X8Q8BcwdihhgWP1JfZQpcgcML13oAO0yB5DS1NouzoPPSa3Xi63dWIVK8oU3o
         tnCIpXpjAINkxyV3mjfmEEMi0KsFJNCa52eVtYwvqh/unIJCutgw7gJqao0sLOf6oBvm
         wvdy31qrugL7ap8bbGQWpMzPcs8GORRlSBAJnesPnt4Ab0wyGFxaUACKyLp3bVxabkkb
         LY3Q==
X-Gm-Message-State: AOAM5302pOY/937Fs8CHosz17DxDCSdkAAn0neuo2JbfjqwUnWdU+Ay0
        abOdsrT64BD1+NtHECPhp5l5yVXRaJI=
X-Google-Smtp-Source: ABdhPJwwMJ2c/iB7oqJvPztbQr932HvMGogZlivLLNy//t0lEE4kjZGF01UFpJ8GCXlQsFh175I2Fw==
X-Received: by 2002:a05:6512:3771:: with SMTP id z17mr4806675lft.46.1629252301306;
        Tue, 17 Aug 2021 19:05:01 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id z7sm350800lft.302.2021.08.17.19.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 19:05:00 -0700 (PDT)
Subject: Re: [PATCH v8 09/34] dt-bindings: host1x: Document Memory Client
 resets of Host1x, GR2D and GR3D
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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
 <20210817012754.8710-10-digetx@gmail.com>
 <YRxfWJJ6+1GgVs33@robh.at.kernel.org>
 <fa9a1fb7-8a87-de1a-e40a-fdc4f4d05d57@gmail.com>
Message-ID: <9deced25-b184-7b5b-cebf-0ad82bd959db@gmail.com>
Date:   Wed, 18 Aug 2021 05:04:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fa9a1fb7-8a87-de1a-e40a-fdc4f4d05d57@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

18.08.2021 04:37, Dmitry Osipenko пишет:
> 18.08.2021 04:16, Rob Herring пишет:
>> On Tue, Aug 17, 2021 at 04:27:29AM +0300, Dmitry Osipenko wrote:
>>> Memory Client should be blocked before hardware reset is asserted in order
>>> to prevent memory corruption and hanging of memory controller.
>>>
>>> Document Memory Client resets of Host1x, GR2D and GR3D hardware units.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  .../bindings/display/tegra/nvidia,tegra20-host1x.txt          | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
>>> index 62861a8fb5c6..07a08653798b 100644
>>> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
>>> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
>>> @@ -18,6 +18,7 @@ Required properties:
>>>  - resets: Must contain an entry for each entry in reset-names.
>>>    See ../reset/reset.txt for details.
>>>  - reset-names: Must include the following entries:
>>> +  - mc
>>>    - host1x
>>
>> New entries should be at the end. Order matters.
> 
> Indeed, order matters. In this case it matters by the hardware because
> memory reset must be asserted before the controller's reset. We rely on
> it in the code of the GENPD driver. Hence it's the intended order in
> this patch.
> 

Although, my bad. It should be to reorder items here, it's not a GENPD
binding.
