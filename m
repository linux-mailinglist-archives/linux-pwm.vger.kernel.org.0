Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA843F2345
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Aug 2021 00:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbhHSWh7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Aug 2021 18:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbhHSWhx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Aug 2021 18:37:53 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45A7C061575;
        Thu, 19 Aug 2021 15:37:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d4so16130573lfk.9;
        Thu, 19 Aug 2021 15:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nAS9qcnivKqgeAIIut8h1WFAVA13oxF52QRobcHq7Xc=;
        b=a4XV4VjRWxo1kHnGEwcEOxFKRCM6deOw4lOM9Uon818SGJgn0YPFw4DdKti64wBV9H
         ZocBdzpcFtuEYqk3Wa8+HUMj2ko6agOMxjv09whIIThddMbYROGGAAS4Plcpv1Z18cgY
         5sKTsW0BmphWVrS/Tiinzv52JEwYHnlvjz/kC/ONQmk2H2QZrW0O70369IiptcK6UmEd
         XneH4My93CRKDRkqsBmuCdSoAuWcBI3J8xEuCJKQTSLx7Jnn2Qku3bl3B0b4iwQ7W5+X
         bMdlKDDR1RyjIOyTN2oZCz5u+iQg+iw/06K9i+IzAB7AjGsFZejlDhk+M4jSdmwerMgk
         ecRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nAS9qcnivKqgeAIIut8h1WFAVA13oxF52QRobcHq7Xc=;
        b=DwiSUa9a4uiiaLqygFuoMgS+IfwNjh4DFWc/E9l+eJnH6ahXnqx2hPvZsxUUoqBRYy
         MuEK0niGgUgmgC2jyzU1CZvSEW/zgJidGUDFrc67pGb2wt8X2wKRlUC4yVWoJR0eXgee
         yaAdHbXydQTyywGt+9jP+64bosQlr0+ss61atdmEHjYjj5wxqBPSgCRc3G4juqiWa67j
         cZEfDrthqICCJoWd25/S/EEH76hKFeE5Tr5/IaYoRfF/BZ/IOTqUYE6HRdT7Sk7L7mQQ
         Wi6O71sgcip9ACyvC5hUtA2ojdR/dnSjPj3MfMSTUXW9rgzPHd78Yb0LUILIz8UWp5IC
         ZMBg==
X-Gm-Message-State: AOAM533j7150g+DhauoY2PMMStGz1biw+CuoZj02oBeERMRt5bOXc9e3
        PoufT5sJiO7R6hCt1B1LOVOa8FFW1yU=
X-Google-Smtp-Source: ABdhPJwuMIWgok5xoSqa52pUigQi/FuENEcCid7QFl2xNGsNEC360zffkjPyNHa+eJldf8U6/MOiRQ==
X-Received: by 2002:a05:6512:b8e:: with SMTP id b14mr12930460lfv.449.1629412634809;
        Thu, 19 Aug 2021 15:37:14 -0700 (PDT)
Received: from [192.168.2.145] (46-138-120-72.dynamic.spd-mgts.ru. [46.138.120.72])
        by smtp.googlemail.com with ESMTPSA id b19sm437171lff.121.2021.08.19.15.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 15:37:14 -0700 (PDT)
Subject: Re: [PATCH v8 20/34] mmc: sdhci-tegra: Add runtime PM and OPP support
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
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
 <20210817012754.8710-21-digetx@gmail.com> <YR6O9Om+HzMMG8AR@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <05b7ff28-4c01-fb56-deeb-595a5797394b@gmail.com>
Date:   Fri, 20 Aug 2021 01:37:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR6O9Om+HzMMG8AR@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

19.08.2021 20:03, Thierry Reding пишет:
> On Tue, Aug 17, 2021 at 04:27:40AM +0300, Dmitry Osipenko wrote:
>> The SDHCI on Tegra belongs to the core power domain and we're going to
>> enable GENPD support for the core domain. Now SDHCI must be resumed using
>> runtime PM API in order to initialize the SDHCI power state. The SDHCI
>> clock rate must be changed using OPP API that will reconfigure the power
>> domain performance state in accordance to the rate. Add runtime PM and OPP
>> support to the SDHCI driver.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/mmc/host/sdhci-tegra.c | 146 ++++++++++++++++++++++++---------
>>  1 file changed, 105 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
>> index 387ce9cdbd7c..a3583359c972 100644
>> --- a/drivers/mmc/host/sdhci-tegra.c
>> +++ b/drivers/mmc/host/sdhci-tegra.c
>> @@ -15,6 +15,8 @@
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>>  #include <linux/pinctrl/consumer.h>
>> +#include <linux/pm_opp.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/regulator/consumer.h>
>>  #include <linux/reset.h>
>>  #include <linux/mmc/card.h>
>> @@ -24,6 +26,8 @@
>>  #include <linux/gpio/consumer.h>
>>  #include <linux/ktime.h>
>>  
>> +#include <soc/tegra/common.h>
>> +
>>  #include "sdhci-pltfm.h"
>>  #include "cqhci.h"
>>  
>> @@ -123,6 +127,12 @@
>>  					 SDHCI_TRNS_BLK_CNT_EN | \
>>  					 SDHCI_TRNS_DMA)
>>  
>> +enum {
>> +	TEGRA_CLK_BULK_SDHCI,
>> +	TEGRA_CLK_BULK_TMCLK,
>> +	TEGRA_CLK_BULK_NUM,
>> +};
>> +
>>  struct sdhci_tegra_soc_data {
>>  	const struct sdhci_pltfm_data *pdata;
>>  	u64 dma_mask;
>> @@ -171,6 +181,8 @@ struct sdhci_tegra {
>>  	bool enable_hwcq;
>>  	unsigned long curr_clk_rate;
>>  	u8 tuned_tap_delay;
>> +
>> +	struct clk_bulk_data clocks[TEGRA_CLK_BULK_NUM];
> 
> This doesn't seem worth it to me. There's a lot of churn in this driver
> that's only needed to convert this to the clk_bulk API and it makes the
> code a lot more difficult to read, in my opinion.
> 
> It looks like the only benefit that this gives us is that runtime
> suspend and resume become a few lines shorter.

The driver probe code looks cleaner with that. You should be looking at
the final result and not at the patch to see it.
