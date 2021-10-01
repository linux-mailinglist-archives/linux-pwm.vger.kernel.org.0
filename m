Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D913541F59D
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Oct 2021 21:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354684AbhJATRS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 1 Oct 2021 15:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhJATRR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 1 Oct 2021 15:17:17 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBDEC061775;
        Fri,  1 Oct 2021 12:15:32 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g41so42283748lfv.1;
        Fri, 01 Oct 2021 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=niNmxAk0ssHAm3Elvv3RJuw0kSncCioQpK+Dv1hLMfQ=;
        b=ompAaqfUP2nwflwfZymbIWdbQcFcOFoC+2uqB/pw0Y1WeA0ZFgZBrXXroc1D9iZE/3
         r+IPUa14hP8aLxdvlyxUGLG/sRpD1eVdY6HINGphhODSA8qi/WKmBF/Y4qJmjtqG9i5c
         QteCTEwJ3FXZQIQOvZg/gr4YarMpWJqOQByuYB3PUiBYUJEXrfcuahtdb4hIBH9fyTNN
         mNv1yfewQHiWqoHrX0awqEd0Tl6wD/YvrU5uk1BErj6tECORNnLLUEEmHb+sWMY3uVV3
         Di3gYCH1EFMU7aOskMvk2sJ93QZxwOrUh/JeZf7kFffGHX478Gg8fj5Vh9nZ5d15M/9/
         cQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=niNmxAk0ssHAm3Elvv3RJuw0kSncCioQpK+Dv1hLMfQ=;
        b=jgiltYdEn9VV6EpxeD3Cc9Ww0mRwmqcceWht5OiYSwz2br8hlK+/uiFnDGiVpx+bEg
         bbmUrJO7YWE6BSyyDCkBn5uovhjOuiN1v0GYhTDOONcGrH7ZD4Rp0LZdwPJra9BY2bAj
         tF8trH6Ut8GDSRJ+Uf/TES9vHatzHZRGCEgH7RVo/kiPLt+u7J15hD3esmma2BOCoWSo
         Kura87ogU+bWGoqJxeqixAOcMowu25ZSt8y9saAknWf8vwq9nYYv9kkvykoffv9U6nDf
         RlqZn8NKHcIw2jb+eRroFsfDiPEnt76oOeXA3AXucTjZ32GPFDrtaeSx15TWAms83L3R
         uk+w==
X-Gm-Message-State: AOAM531yEm8Wt7gzw65anzwhic/CpnA5wvmhYwNH4rdhLFTSNZrCwmfq
        d92qTPMYHjolrwHJbqjny6o=
X-Google-Smtp-Source: ABdhPJy3ghoTNAi0Jb2SiS3hsWYw15h3Vk93zN4ib7q8hKhDd5DWUUMwX4Q7U3/o0nn9oofd85xS+Q==
X-Received: by 2002:a2e:4e11:: with SMTP id c17mr13093513ljb.19.1633115730771;
        Fri, 01 Oct 2021 12:15:30 -0700 (PDT)
Received: from [192.168.2.145] (79-139-163-198.dynamic.spd-mgts.ru. [79.139.163.198])
        by smtp.googlemail.com with ESMTPSA id d6sm820684lfi.137.2021.10.01.12.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 12:15:30 -0700 (PDT)
Subject: Re: [PATCH v13 02/35] soc/tegra: Add
 devm_tegra_core_dev_init_opp_table_common()
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
References: <20210926224058.1252-1-digetx@gmail.com>
 <20210926224058.1252-3-digetx@gmail.com>
 <CAPDyKFrtE75Tf-vefM0isj52PJ5_v525AjqU2TMUpc4__rYLhA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ab874e0c-903a-fc3b-d33b-54a7a9f0e109@gmail.com>
Date:   Fri, 1 Oct 2021 22:15:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrtE75Tf-vefM0isj52PJ5_v525AjqU2TMUpc4__rYLhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

01.10.2021 15:50, Ulf Hansson пишет:
> On Mon, 27 Sept 2021 at 00:42, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> Only couple drivers need to get the -ENODEV error code and majority of
>> drivers need to explicitly initialize the performance state. Add new
>> common helper which sets up OPP table for these drivers.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  include/soc/tegra/common.h | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/include/soc/tegra/common.h b/include/soc/tegra/common.h
>> index af41ad80ec21..5b4a042f60fb 100644
>> --- a/include/soc/tegra/common.h
>> +++ b/include/soc/tegra/common.h
>> @@ -39,4 +39,28 @@ devm_tegra_core_dev_init_opp_table(struct device *dev,
>>  }
>>  #endif
>>
>> +/*
>> + * This function should be invoked with the enabled runtime PM of the device
>> + * in order to initialize performance state properly. Most of Tegra devices
>> + * are assumed to be suspended at a probe time and GENPD require RPM to be
>> + * enabled to set up the rpm-resume state, otherwise device is active and
>> + * performance state is applied immediately. Note that it will initialize
>> + * OPP bandwidth if it's wired in a device-tree for this device, which is
>> + * undesirable for a suspended device.
>> + */
>> +static inline int
>> +devm_tegra_core_dev_init_opp_table_common(struct device *dev)
>> +{
>> +       struct tegra_core_opp_params opp_params = {};
>> +       int err;
>> +
>> +       opp_params.init_state = true;
>> +
>> +       err = devm_tegra_core_dev_init_opp_table(dev, &opp_params);
>> +       if (err != -ENODEV)
>> +               return err;
>> +
>> +       return 0;
>> +}
> 
> Just want to share a few thoughts around these functions.
> 
> So, I assume it's fine to call
> devm_tegra_core_dev_init_opp_table_common() or
> devm_tegra_core_dev_init_opp_table() from consumer drivers during
> ->probe(), as long as those drivers are tegra specific, which I assume
> all are in the series!?

That is correct, all drivers are tegra-specific in this series. External
devices are attached to the internal SoC devices and this series is
about the SoC power management.

> My point is, a cross SoC consumer driver that needs to initiate OPP
> tables can get rather messy, if it would need to make one specific
> function call per SoC.
> 
> That said, I hope we can tackle this as a separate/future problem, so
> the series can get merged as is.

Yes, as we already have seen, it's not an easy problem to make PD core
to handle it in a generic way. If there will be a similar demand from
other SoCs, then we may try to solve that problem again.
