Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99303EF90A
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Aug 2021 06:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhHREMm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Aug 2021 00:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhHREMl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Aug 2021 00:12:41 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8005DC061764;
        Tue, 17 Aug 2021 21:12:07 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id w4so1066552ljh.13;
        Tue, 17 Aug 2021 21:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dMTTYDqSJMZu388pZDsE0iPTn5UycM6CSLQvWN7EXiM=;
        b=oQvzSg1jZXl+3O5uWNXSIj0EIiigE3D8tdhxfqAYJH6UqgsCzmL3hP6cSREL6xokAp
         5KKoBF6NlIdSV51xYA8rOXF7SiPPUFEsJnNMVx/Mj1G+zfMpWhRPLIe9M8DhtO6iPc1S
         p2IPm0+QPqq1JCeEdyb3YV8sJWla7reBX08TZVdwmZTeasDkEcg8u8nsshUvr36URZPn
         TsiBBjquSJBmTUeTPM4bWFxBpZ+SJu/UDOougRzNQhHeIs1d4mB022t1K5UV5mIhOyHv
         D9ODeTS1/BkXQUvCftgq3yLT1B2G++QLewhjit+yDz2z/g1qknqoAwH4qRPZOYrgDn/j
         MmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dMTTYDqSJMZu388pZDsE0iPTn5UycM6CSLQvWN7EXiM=;
        b=afWUSVwXvkRUMbd/2YfXjkOPMALNYUIC9VhzWSGzgNoV0dNV6XtWw2MYaz89tipRWA
         p9w5pYOldL9cnvgZH5nA0nRpjlmRW8z9Bmd1ZRqbuYpARspbUmXox4YpCYAqpihO7R9B
         VfT9+Vz/qgRyigsCny7zy3wxpqgChlavdrR5b7PD4junUjtLq0Bh4EgTkscM0P8MGrhv
         1HmKWSQMGLn/kkogxKG6nMv5dGmVx2s6Dxc1m/rN82c6CHteG5WwXXvy1NgVNBujVCXg
         9A7QsDRXYn4Ai6zp/3C66SvYiP/0JkaDFxxPF03V9R2bowq8n+F+kAkP0j0SN6TjLrrN
         hJhA==
X-Gm-Message-State: AOAM532KMSUVTe12OkK4G/GKZQZ0VCtt4neh1sSgzqagpK9vuhaqex+N
        mDzdjp7V0630dqwAzu8rHVsDEEi2/zo=
X-Google-Smtp-Source: ABdhPJygrWrrk6YBOzsJmDVVKkQ3PCLKwObyA1oxnH+eZ3W64yk1hEef6yD4M/Yl5d3DG6PdHy9Hjg==
X-Received: by 2002:a2e:9e8e:: with SMTP id f14mr5999025ljk.468.1629259925795;
        Tue, 17 Aug 2021 21:12:05 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id m16sm373567lfh.243.2021.08.17.21.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 21:12:05 -0700 (PDT)
Subject: Re: [PATCH v8 01/34] opp: Add dev_pm_opp_sync() helper
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-2-digetx@gmail.com>
 <20210817075515.vyyv7z37e6jcrhsl@vireshk-i7>
 <710261d9-7ae3-5155-c0a2-f8aed2408d0b@gmail.com>
 <20210818035533.ieqkexltfvvf2p4n@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5b2a80c1-9743-e633-6257-ede94c8a274c@gmail.com>
Date:   Wed, 18 Aug 2021 07:12:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818035533.ieqkexltfvvf2p4n@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

18.08.2021 06:55, Viresh Kumar пишет:
> On 17-08-21, 18:49, Dmitry Osipenko wrote:
>> 17.08.2021 10:55, Viresh Kumar пишет:
>> ...
>>>> +int dev_pm_opp_sync(struct device *dev)
>>>> +{
>>>> +	struct opp_table *opp_table;
>>>> +	struct dev_pm_opp *opp;
>>>> +	int ret = 0;
>>>> +
>>>> +	/* Device may not have OPP table */
>>>> +	opp_table = _find_opp_table(dev);
>>>> +	if (IS_ERR(opp_table))
>>>> +		return 0;
>>>> +
>>>> +	if (!_get_opp_count(opp_table))
>>>> +		goto put_table;
>>>> +
>>>> +	opp = _find_current_opp(dev, opp_table);
>>>> +	ret = _set_opp(dev, opp_table, opp, opp->rate);
>>>
>>> And I am not sure how this will end up working, since new OPP will be
>>> equal to old one. Since I see you call this from resume() at many
>>> places.
>>
>> Initially OPP table is "uninitialized" and opp_table->enabled=false,
>> hence the first sync always works even if OPP is equal to old one. Once
>> OPP has been synced, all further syncs are NO-OPs, hence it doesn't
>> matter how many times syncing is called.
>>
>> https://elixir.bootlin.com/linux/v5.14-rc6/source/drivers/opp/core.c#L1012
> 
> Right, but how will this work from Resume ? Won't that be a no-op ?

The first resume initializes the OPP state on sync, all further syncs on
resume are no-ops.
