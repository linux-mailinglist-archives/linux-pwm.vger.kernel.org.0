Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532203EF7A9
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Aug 2021 03:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbhHRBpJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Aug 2021 21:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbhHRBpI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Aug 2021 21:45:08 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02015C061764;
        Tue, 17 Aug 2021 18:44:34 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q21so2057451ljj.6;
        Tue, 17 Aug 2021 18:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XoDVcVB/VE1dBlO9x4lpVsT9geXPOq4o0WU/0sRPebc=;
        b=Gmnqy4jfwBqsDu9LBGxLpx1nvtIhZFSGaBcJVbAwo50K4s+mgQjS0okbtwsUutyxB8
         crURnbnyrk/mMjC5uyqR+Vc4wyXpn+d+boHXA+Xp1BhvXFshKYhg804UtoJM30j71C4u
         J2Oi65VGe0ZWSvpPAE+ZMPCxHmZODECsKuoOcPsZnVV2NTW6mY508lzEbTu7b+WV31F0
         mOmEp6hyujXqYoE04beg1akt/TvZfGMnEmyffvJhfR2jN5IueeSUVfQm+Kv43WgZBbPE
         A1/FPF7q3EFR+MQEP/OCrx/s1N0zxIrfUMfTscncRBAeQA/ySJ/MFa/6tQu2m5wzNNQY
         1kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XoDVcVB/VE1dBlO9x4lpVsT9geXPOq4o0WU/0sRPebc=;
        b=V5xl8b7pmh2RfLExq4xbFPgpMnaYrCgFuA0wqzBaNFhrHU/SwbMWC5WhfMAnKO4UQj
         +xSxN+ZkAkueikfrJ0qlKOZidmq5uFSJyZRpZooXpk4N3RPkaY4HVCVjPSsRj6nPgya3
         JMxM/Xvf/qefNkenFg/GM5r/rJJDZ3QbrXYAYqsFs1Kq+slKTfmIYWV4EusVouxIFuXH
         zqtArQfTn3HMlMH681M4M4UGdihW4jSDYfQP/fvAZP8ehPyXMo5M7f0CW2sL/w4GylW7
         D6Y7YEIoMeYxBHFXTsM2cAS51tCmaEn8TmYFFMEWeIlEvEIVfoUy9i+dn3RhZFuCHc1f
         h0BQ==
X-Gm-Message-State: AOAM532MeXPdYTK4JNT306EPKexfpYBozOrJaXtXCaWCfbvLepxVmCeX
        nLxtnuQLeTrArJUaBJjBH8yr28ean+4=
X-Google-Smtp-Source: ABdhPJzBCF6cJbZHRHPrIUVUUUZ+kASYBl6l8+zSZcW0/IKHSG28sW6dmnWvQHlNaXqEE5KMF+anLw==
X-Received: by 2002:a2e:5307:: with SMTP id h7mr5878272ljb.154.1629251072136;
        Tue, 17 Aug 2021 18:44:32 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id y14sm288752ljm.39.2021.08.17.18.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 18:44:31 -0700 (PDT)
Subject: Re: [PATCH v8 06/34] dt-bindings: clock: tegra-car: Document new
 tegra-clocks sub-node
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
 <20210817012754.8710-7-digetx@gmail.com>
 <YRxfGtWPXeSQXuHo@robh.at.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <06128217-92e1-9b66-64ea-91855d041121@gmail.com>
Date:   Wed, 18 Aug 2021 04:44:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRxfGtWPXeSQXuHo@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

18.08.2021 04:15, Rob Herring пишет:
>> +  tegra-clocks:
>> +    description: child nodes are the output clocks from the CAR
>> +    type: object
>> +
>> +    patternProperties:
>> +      "^[a-z]+[0-9]+$":
>> +        type: object
>> +        properties:
>> +          compatible:
>> +            allOf:
>> +              - items:
>> +                  - enum:
>> +                      - nvidia,tegra20-sclk
>> +                      - nvidia,tegra30-sclk
>> +                      - nvidia,tegra30-pllc
>> +                      - nvidia,tegra30-plle
>> +                      - nvidia,tegra30-pllm
>> +              - const: nvidia,tegra-clock
> You are saying the first string must be both one of the enums and 
> 'nvidia,tegra-clock'. You don't get an error because your pattern 
> doesn't match 'sclk'.
> 

Could you please rephrase or clarify? If pattern doesn't match 'sclk',
then it must match any other enum. I'm not sure what you're meaning.

The 'nvidia,tegra-clock' actually could be removed since it's
superfluous now. I'll consider the removal in v9.
