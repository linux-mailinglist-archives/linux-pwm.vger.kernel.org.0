Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A2C42E553
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Oct 2021 02:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhJOAp7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Oct 2021 20:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbhJOAp6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Oct 2021 20:45:58 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603BAC061570;
        Thu, 14 Oct 2021 17:43:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u21so31217511lff.8;
        Thu, 14 Oct 2021 17:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mXlN19lUOdObPkezfYAL1BJvV5sdk9SnJ7WWJzToUFE=;
        b=iPhw22hb1ndCbJ6f3z6jDDU25OfgCtQvcMEMlYqE6RhSONXRPkBqjq2iIHzMJ9dE7v
         0EvnD8COMjP7f/9VaiVWB/uB7GhdewII9Pozl5ZYeg6blX0TjojG9oeJ9/kSqaNk9PqK
         CXPDSfcXnxrfHB2d/OZM5xOru20KWvBAvReWtsxrrn7FyBQdewSA+1Zjj8RSveTfNkDN
         2MLWkuU2tleNYdToYr12SJbVZ4+HSn/s++uIZcuPHbrRdvWn+0eL4gR832lDZ426zwE6
         ajzhVIWKtwCZckiYAlM/TLkYD0Wef3Y2fKV44UmpwLWNC0KFYBpa4oGQw7n0TIbursCh
         OXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mXlN19lUOdObPkezfYAL1BJvV5sdk9SnJ7WWJzToUFE=;
        b=Bk7ZT2nFEnTwR3qDr3tF4uqwQ0rHgUpq81T2fT9GuzU5QoCz3BOLH3azTh1U7kOj2r
         lCnGlPGYWvlzc//s1aYjfH0dRIwQRXo8qvPnNwvKNUxT3GWCxSOxX6NOeuL7OKMUBaZn
         DAZLASw2GYZ95HbjeyCoJlL5hzDOnegUfAlOu9rLcqNtJuGWtLmvFnRbfc1NCkuF4HET
         srV/YWH+HOqp63Zfpz9s3dl6VkQi2GnG6cFSENMpwpmkt/O6RPfhTKC6F7TE7LeUZ2JA
         8dZthq84u5we+fJmpq/ZVDdYpHDdkJxLtt29zbs06G1fuBrx9CfzffqOMQuCMGjD48ht
         L15g==
X-Gm-Message-State: AOAM533oqLhmdiBTUmFGyFrteHnieV1VYIsH2cl7r9lG63bBzSCowPtz
        orbyTwYSKLPEldjsFmBYBgM=
X-Google-Smtp-Source: ABdhPJz+j3ZrhF+t+OqqMV5oruL99gBhJ85C+0YAA7Njrymq7zFv+r++lAR13NAeJJ0A+zRcVSzJ4w==
X-Received: by 2002:a05:651c:11c5:: with SMTP id z5mr9340948ljo.123.1634258630581;
        Thu, 14 Oct 2021 17:43:50 -0700 (PDT)
Received: from [192.168.2.145] (79-139-176-16.dynamic.spd-mgts.ru. [79.139.176.16])
        by smtp.googlemail.com with ESMTPSA id u15sm401868lji.21.2021.10.14.17.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 17:43:50 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4090acf8-c8af-d98c-2121-9fd105365e55@gmail.com>
Date:   Fri, 15 Oct 2021 03:43:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <163425700766.1688384.4481739110941660602@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

15.10.2021 03:16, Stephen Boyd пишет:
> Quoting Dmitry Osipenko (2021-09-20 11:11:15)
>> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
>> index 459d2a525393..f832abb7f11a 100644
>> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
>> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
>> @@ -42,6 +42,36 @@ properties:
>>    "#reset-cells":
>>      const: 1
>>  
>> +patternProperties:
>> +  "^(sclk)|(pll-[cem])$":
>> +    type: object
>> +    properties:
>> +      compatible:
>> +        enum:
>> +          - nvidia,tegra20-sclk
>> +          - nvidia,tegra30-sclk
>> +          - nvidia,tegra30-pllc
>> +          - nvidia,tegra30-plle
>> +          - nvidia,tegra30-pllm
>> +
>> +      operating-points-v2: true
>> +
>> +      clocks:
>> +        items:
>> +          - description: node's clock
>> +
>> +      power-domains:
>> +        maxItems: 1
>> +        description: phandle to the core SoC power domain
> 
> Is this done to associate the power domain with a particular clk? And an
> OPP table with a particular clk?

Yes

