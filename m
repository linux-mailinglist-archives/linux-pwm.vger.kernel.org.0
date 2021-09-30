Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7C941DC02
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Sep 2021 16:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351782AbhI3OKm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 Sep 2021 10:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240149AbhI3OKl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Sep 2021 10:10:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1A0C06176A;
        Thu, 30 Sep 2021 07:08:58 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b15so25730137lfe.7;
        Thu, 30 Sep 2021 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FbYwtZf63HA1feBdReYPazjfCwECYf7J/LcnagkS5eU=;
        b=qRQIo8RwUav2UmTra9oF6epGn59qVcbfkWvdDGVDc/I3VvWeddwr1dqwKGHN43kWcO
         DaknpPTwDGNSY0qj/vuZMQ+EkFjjT/DDyA8yAVbb5t8+cbMVH3ESCPkcYm04Ck8YWr43
         zrplPFlPo+zCWrz4Vd8LF+IXnAG5rtwSZu7cV47thKqF865BwfegPZ11umUl0wvxpi3u
         69cI9QAnuHM4T4curizIUlc+msZ3JMRXmJ23U1OoUXyP/pCpqx5znnf8RaSyTf/Iij/X
         R01C7FPFx014oNqZOzPeCr4tdIky5Bmc4sGwQxivsb0fd368heHcy8U6CVbuaHa44hXZ
         JOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FbYwtZf63HA1feBdReYPazjfCwECYf7J/LcnagkS5eU=;
        b=6510RLwK4zaHnLALzQPRb0fZ+jorJGzDatK7CXwDY9b1RcOwBxjZs7DyYa1SW6hfvm
         NEGOcBL7VqUM9q3PVlA1rIan8r1Rz2pMgzMrHDCiiyXTcMJMJWCJBZxdPGZFfkDvYTm4
         0Pq0whB+bTFhUOtBg5t4ikc5S/y+DELxnDA2UlowqMU6ULT8E59xOOiVx5qJL5ahl7zz
         wausMrfD/z/RPsEtitd5lETeRuNBCht6cmsWQeDppOtpkhKDShxuf3lG1IdpXvZ2Xw0j
         /bns4RO6yly2xe/UlyBaPlhrXknmzgbU7tCKxcOXEj3x8hM+YJW4tZ7sSetfpvqnGa4Y
         UO4A==
X-Gm-Message-State: AOAM532RfvOoTB/pMV4xxJhBxRMAYcg5gRdF4lI6uYoL3/mCPi007YSY
        dhxVHCcwRGgvtExMVPBmNbI=
X-Google-Smtp-Source: ABdhPJw2MpyVxuwrGHjgPVIzNI4sHyolChi3D2RfJQLhexFRsDLjbr061I9VfMnIzN8pIMuESKq7Kw==
X-Received: by 2002:a2e:5046:: with SMTP id v6mr6445920ljd.368.1633010931799;
        Thu, 30 Sep 2021 07:08:51 -0700 (PDT)
Received: from [192.168.2.145] (46-138-80-108.dynamic.spd-mgts.ru. [46.138.80.108])
        by smtp.googlemail.com with ESMTPSA id r22sm357824lji.5.2021.09.30.07.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 07:08:51 -0700 (PDT)
Subject: Re: [PATCH v13 16/35] usb: chipidea: tegra: Add runtime PM and OPP
 support
To:     Peter Chen <peter.chen@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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
References: <20210926224058.1252-1-digetx@gmail.com>
 <20210926224058.1252-17-digetx@gmail.com> <20210930140630.GA6697@Peter>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e8eb0f29-2ffb-b1d8-34bf-7dff1e8ba1f8@gmail.com>
Date:   Thu, 30 Sep 2021 17:08:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210930140630.GA6697@Peter>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

30.09.2021 17:06, Peter Chen пишет:
> On 21-09-27 01:40:39, Dmitry Osipenko wrote:
>> The Tegra USB controller belongs to the core power domain and we're going
>> to enable GENPD support for the core domain. Now USB controller must be
>> resumed using runtime PM API in order to initialize the USB power state.
>> We already support runtime PM for the CI device, but CI's PM is separated
>> from the RPM managed by tegra-usb driver. Add runtime PM and OPP support
>> to the driver.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/usb/chipidea/ci_hdrc_tegra.c | 53 ++++++++++++++++++++++++----
>>  1 file changed, 46 insertions(+), 7 deletions(-)
...
> 
> I got below compile error if only compile this file, I think previous patches
> should include the definition, if that, feel free to add my ack to this
> patch.
> 
> Acked-by: Peter Chen <peter.chen@kernel.org>
> 
> drivers/usb/chipidea/ci_hdrc_tegra.c:308:8: error: implicit declaration of function ‘devm_tegra_core_dev_init_opp_table_common’;
> did you mean ‘devm_tegra_core_dev_init_opp_table’? [-Werror=implicit-function-declaration]
>   308 |  err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
>       |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |        devm_tegra_core_dev_init_opp_table

That's correct, devm_tegra_core_dev_init_opp_table_common() is added by
an earlier patch of this series. Thank you!
