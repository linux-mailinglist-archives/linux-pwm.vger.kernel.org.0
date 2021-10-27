Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A041343D1B9
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Oct 2021 21:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243700AbhJ0TfE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 Oct 2021 15:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243694AbhJ0TfD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 27 Oct 2021 15:35:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA123C061570;
        Wed, 27 Oct 2021 12:32:37 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so8447098lfu.5;
        Wed, 27 Oct 2021 12:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OTBdPJFa+ah3P9FuQhKUL9RznqjaKHz1+CuZIYV3wsc=;
        b=agih9qYZmYcntiWOtjjpqFInO/NVgVrWGE905q2yfSEyyV2BoggudSRC0uWF+1avff
         7h8uADNMgxE72KU5FMyuapAtk8t88XRt2jfl54CZfqYvfnhCV75du+zNwvIkpk3yCgVL
         5o9kX2dk8r96+D9juLvJdGhh7jbf4BxzAJXKAEQRsRoc3C6FmbCmEAsyjnlucSt2pWtU
         83u5VeuC3bsmPi7byNO1u5d3lYPRedAvTMiCRtXBDeyQCqpUwvSHd2PVm0VgcshYs06T
         bsc+rK79JJB2gmNcE8cTUf426Ht1SndEa2i1Np6mV8Ss5aEDyzIPzgP6y8adlqO2cjBC
         Qp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OTBdPJFa+ah3P9FuQhKUL9RznqjaKHz1+CuZIYV3wsc=;
        b=swytmm9GqTNoiVEB0sjt8W1+egJtPJWbQlQQ+sgQGn414UHhJljPu3+4A0QgiX2nL8
         qcPVDUqRkOiAJ0lmpJdQzDGyMXMH0bTdh8rLYoBoLU4Fd4VCaid51z68mjFH1JLEE2BZ
         8drkT9jab2dwT76tT7SxEfnv0WkKwoXo/BHJP6aFo1VwlK3vCYY6TkHJeXtZSKifHz70
         IrkEl7v7yu0at4dvkU/sPVUztIk/GjpK1aTN9rHfe+qYxIsjQJRuUxnlVm2RW7+lodOy
         KHvBQITrRd1zMBEGay9y0afhUqaLG3LrKCBhZFGjb9lM3M+renxA05LUS8Qbe/IUeFA5
         s/+g==
X-Gm-Message-State: AOAM533JRFbYKM07uXdLww7TrNVEsJj78b53DFNv+nRkbzGv0CuAgPGv
        Mu+Fmyfrhsp4YlCfF1HprWk=
X-Google-Smtp-Source: ABdhPJyaiRz/Ui6iA1xiTx91a3t+RwtvYGxJT3StDDfm32LrCKRStVdKsTDTbJW/siFtx98e9FjJ2w==
X-Received: by 2002:a05:6512:1510:: with SMTP id bq16mr31326351lfb.268.1635363156058;
        Wed, 27 Oct 2021 12:32:36 -0700 (PDT)
Received: from [192.168.2.145] (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.googlemail.com with ESMTPSA id t3sm81030lfc.216.2021.10.27.12.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 12:32:35 -0700 (PDT)
Subject: Re: [PATCH v14 01/39] soc/tegra: Enable runtime PM during OPP
 state-syncing
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20211025224032.21012-1-digetx@gmail.com>
 <20211025224032.21012-2-digetx@gmail.com>
 <CAPDyKFr7VY73cQugSA5n-p_oXf43o1M-7s3-M+fnk0656h25UA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8076eee8-ac8b-90a7-b87a-35e40d7300fb@gmail.com>
Date:   Wed, 27 Oct 2021 22:32:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFr7VY73cQugSA5n-p_oXf43o1M-7s3-M+fnk0656h25UA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

27.10.2021 18:06, Ulf Hansson пишет:
> On Tue, 26 Oct 2021 at 00:45, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> GENPD core now can set up domain's performance state properly while device
>> is RPM-suspended. Runtime PM of a device must be enabled during setup
>> because GENPD checks whether device is suspended and check doesn't work
>> while RPM is disabled. Instead of replicating the boilerplate RPM-enable
>> code around OPP helper for each driver, let's make OPP helper to take care
>> of enabling it.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Just a minor nitpick, see below. Nevertheless feel free to add:
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Kind regards
> Uffe
> 
>> ---
>>  drivers/soc/tegra/common.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
>> index cd33e99249c3..d930a2b4facc 100644
>> --- a/drivers/soc/tegra/common.c
>> +++ b/drivers/soc/tegra/common.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/export.h>
>>  #include <linux/of.h>
>>  #include <linux/pm_opp.h>
>> +#include <linux/pm_runtime.h>
>>
>>  #include <soc/tegra/common.h>
>>  #include <soc/tegra/fuse.h>
>> @@ -43,6 +44,7 @@ static int tegra_core_dev_init_opp_state(struct device *dev)
>>  {
>>         unsigned long rate;
>>         struct clk *clk;
>> +       bool rpm_enabled;
>>         int err;
>>
>>         clk = devm_clk_get(dev, NULL);
>> @@ -57,8 +59,22 @@ static int tegra_core_dev_init_opp_state(struct device *dev)
>>                 return -EINVAL;
>>         }
>>
>> +       /*
>> +        * Runtime PM of the device must be enabled in order to set up
>> +        * GENPD's performance properly because GENPD core checks whether
>> +        * device is suspended and this check doesn't work while RPM is
>> +        * disabled.
>> +        */
>> +       rpm_enabled = pm_runtime_enabled(dev);
>> +       if (!rpm_enabled)
>> +               pm_runtime_enable(dev);
> 
> This makes sure the OPP vote below gets cached in genpd for the
> device. Instead, the vote is done the next time the device gets
> runtime resumed.

Thanks, I'll extend the code's comment with this text in v15.

I also noticed that won't hurt to add extra sanity check of whether RPM
indeed got enabled since it could be disabled multiple times in a
nesting fashion.

> I don't have an issue doing it like this, but at the same time it does
> remove some flexibility for the drivers/subsystem that calls
> tegra_core_dev_init_opp_state().
> 
> Isn't it better to leave this to be flexible - or you prefer to have
> it done like this for everybody?

All the current users of the helper function want this behaviour by
default. It's unlikely that we will ever have a user that will want
different bahaviour, but even then it won't be a problem to add extra
flag to struct tegra_core_opp_params to specify that special case.
