Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281A62AB07F
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Nov 2020 06:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgKIFKU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Nov 2020 00:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbgKIFKU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Nov 2020 00:10:20 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A62CC0613CF;
        Sun,  8 Nov 2020 21:10:19 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id o24so2039314ljj.6;
        Sun, 08 Nov 2020 21:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F8bnoTfMLfQuAGNjcxWowIscN/dz6R46GaHzllMg8J0=;
        b=QYMCKqr7RGvgYQCWbQWS7P62qghK9GYhJHOPC6o3qWYxnmx01eOxLC3P9oE915gwvt
         Fh3WypXWmqFr5JDzFvcPizJHaUlaojEYEUSbCYiCwkjs4V93aOmdN+Fgb69PJ6NqE2Gw
         PU1tJC6S9ZO6C2E/cEJiZ7Ugx4M8B/quGev7CODiOs60KgtrPSL8dsbQi1bSJBrgItSj
         sS++FruzLvRC0nDuMK2bw7Tv77TCae5RwbeUbWYjmokvQPKApEWrKpR+CACc3lpJArf0
         NYbmiYM7C+3HAkDJKFrl7LPc7SxMra13YtbJE8XKMrd/eT1ThSFtS/0QhWfQ+88xkHzq
         O9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F8bnoTfMLfQuAGNjcxWowIscN/dz6R46GaHzllMg8J0=;
        b=m/sgWz/85zYduSGwnru5nzGXWA1xTwhxwmzdy7/G75yfV95shvs9/0+lKYzRI3A+ig
         xWeRqHHXg1F5q00D2GAFh++uK5rKiEyLizxOyXn2wuTHNQMQ2j3RUbve8pgMi4Wy6ZCZ
         xe8peNRpN7wOQMMG3U486pxU3YzHOe634nSTQb5aPHQ5GiKqqudT8KLYmAhqIl8Xo9zY
         hNYh6W6Lr/+t4niXtUbKGtV7FbwhJLVa7t8V/cz24RwdrngXlaXuG1eJIAz9vLT2xkWC
         Le1ZZ0+Rm0N83AOQKbScaXLpYLmTML16SiI1oQIhhr+nzpuuahEoaLN+AAX7z7g1EmSc
         xILg==
X-Gm-Message-State: AOAM532S0XibXizrdjk2T9o320Gn3O4v86gDKtK5Op3bhwB2x2nCtjez
        YUQiEW8QBJ7vfCT9p7/cwkseaWcnrnc=
X-Google-Smtp-Source: ABdhPJzn+t/fz27158UyX7xdQtkSIJERw+NXYwjCpA/tjOndB+43X/qkcsxZZqHz/vcErD/wbcazTQ==
X-Received: by 2002:a2e:6a0f:: with SMTP id f15mr272519ljc.375.1604898617889;
        Sun, 08 Nov 2020 21:10:17 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id r9sm1547587ljd.23.2020.11.08.21.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 21:10:17 -0800 (PST)
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20201104234427.26477-1-digetx@gmail.com>
 <CAPDyKFr7qTU2RPhA_ZrbCayoTTNUEno1zdmvmv+8HBe-Owrfeg@mail.gmail.com>
 <cd147ab0-1304-a491-7a56-ee6199c02d32@gmail.com>
 <2716c195-083a-112f-f1e5-2f6b7152a4b5@gmail.com>
 <20201109044354.ljd5pomhob6b7u5v@vireshk-i7>
 <713b319e-bb7b-4743-59f0-b9892c3da92d@gmail.com>
Message-ID: <aba1fcac-74b8-f370-ab45-312975da66e6@gmail.com>
Date:   Mon, 9 Nov 2020 08:10:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <713b319e-bb7b-4743-59f0-b9892c3da92d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

09.11.2020 07:47, Dmitry Osipenko пишет:
> 09.11.2020 07:43, Viresh Kumar пишет:
>> On 08-11-20, 15:19, Dmitry Osipenko wrote:
>>> I took a detailed look at the GENPD and tried to implement it. Here is
>>> what was found:
>>>
>>> 1. GENPD framework doesn't aggregate performance requests from the
>>> attached devices. This means that if deviceA requests performance state
>>> 10 and then deviceB requests state 3, then framework will set domain's
>>> state to 3 instead of 10.
>>
>> It does. Look at _genpd_reeval_performance_state().
>>
> 
> Thanks, I probably had a bug in the quick prototype and then overlooked
> that function.
> 

If a non-hardware device-tree node is okay to have for the domain, then
I can try again.

What I also haven't mentioned is that GENPD adds some extra complexity
to some drivers (3d, video decoder) because we will need to handle both
new GENPD and legacy Tegra specific pre-genpd era domains.

I'm also not exactly sure how the topology of domains should look like
because Tegra has a power-controller (PMC) which manages power rail of a
few hardware units. Perhaps it should be

  device -> PMC domain -> CORE domain

but not exactly sure for now.
