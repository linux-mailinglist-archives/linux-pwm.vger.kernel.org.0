Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C92B3F3BD6
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Aug 2021 19:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhHURqk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 21 Aug 2021 13:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhHURqj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 21 Aug 2021 13:46:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F8DC061575;
        Sat, 21 Aug 2021 10:45:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id o1so9488502lft.9;
        Sat, 21 Aug 2021 10:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IUNZGcwEvLiT98uruvqOHnHGgaNyFWtPLETI2dPthCw=;
        b=p08OD/GPPXR4tm7RkNA9toKvQsVUl8L8J4oVZmC67OE0wZNQVqTaUco2HrwrnDiQ5w
         YuB7XIX+XHBkQHFFdAzLyF2BxZCm+jSnFq4FsCUAM2T1sDn/9oxf4t2nPY94dg8ZOy02
         4ifXdf59PODf4caGN1F1ErdH+dIo7YXjnB5cY+HfdftEYqOCt2+nTokc6UD388Ko2qxo
         MvhYOSvGDT1/FsQM/l16oRX1i1OGSNP7dXhT5bdzGaUHSnydnyQWWVAxmDtcpnGU6hl9
         akWPj9WfjbxtYLM0nKZbQdHyelXHGLCzov3c1u9xeUbYJI6bez6nJO7fiBHU51tlE3bJ
         Ui+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IUNZGcwEvLiT98uruvqOHnHGgaNyFWtPLETI2dPthCw=;
        b=qqFGmoBoIw84QNZ9w88K4/RJ31ckx4Fv0oQTXBKAmJgvZBIx520WQnH53m+dcuOfow
         l4jjnfsh9La0yoDydZFbJNof+kY6C7mB/KkwOrkXOyn4m3MhTQwyb7K7aXua6nSp31nt
         fXDz3XHmPB6bOkRQFYFMIfgQBZwpVv43xstG9x/0l5dU75UV4F7hipo+eLJ6SJU+itG8
         0d5KA4JFCP/EV6KbbSnO5CLIsbHfGbeAr2L1to4LcBwCKT/joG8TF03QJPQQvAR/NK4N
         AiuJiCD3iKgnsNVfk2RNROsGZxETVAQSG1UL7T3kLR1DDEEm2KRrAOfhjg4Ic3xi2Aua
         7NgA==
X-Gm-Message-State: AOAM530X5LPERNJHDJISktdFwMhxChVRZ1j9RTmncw0zOXhisUuMj4b8
        YF3i435PqXVHywY0Xy+76Z3248zVuEA=
X-Google-Smtp-Source: ABdhPJwQTUwfeBc8x+Qc/XgoFvNgZwRj7DA1ImLYu2aN3NoNJ/vJapVfLwS/Dwin1R3kajnXi5wLGA==
X-Received: by 2002:ac2:4839:: with SMTP id 25mr19053893lft.455.1629567957530;
        Sat, 21 Aug 2021 10:45:57 -0700 (PDT)
Received: from [192.168.2.145] (46-138-120-72.dynamic.spd-mgts.ru. [46.138.120.72])
        by smtp.googlemail.com with ESMTPSA id e19sm868158ljj.28.2021.08.21.10.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 10:45:56 -0700 (PDT)
Subject: Re: [PATCH v8 07/34] clk: tegra: Support runtime PM and power domain
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-8-digetx@gmail.com> <YR0UBi/ejy+oF4Hm@orome.fritz.box>
 <da7356cb-05ee-ba84-8a7c-6e69d853a805@gmail.com>
 <YR04YHGEluqLIZeo@orome.fritz.box>
 <ad99db08-4696-1636-5829-5260f93dc681@gmail.com>
 <YR6Mvips3HAntDy0@orome.fritz.box>
 <e17bbe8d-7c0f-fc3d-03c7-d75c54c24a43@gmail.com>
 <YR+VDZzTihmpENp6@orome.fritz.box>
 <CAPDyKFpJ+TK0w1GZEA7G=rtAjq5ipmVR4P0wy7uHiEGVWRk5yA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <89ea1694-be9e-7654-abeb-22de0ca5255a@gmail.com>
Date:   Sat, 21 Aug 2021 20:45:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpJ+TK0w1GZEA7G=rtAjq5ipmVR4P0wy7uHiEGVWRk5yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

20.08.2021 16:08, Ulf Hansson пишет:
...
>> I suppose if there's really no good way of doing this other than
>> providing a struct device, then so be it. I think the cleaned up sysfs
>> shown in the summary above looks much better than what the original
>> would've looked like.
>>
>> Perhaps an additional tweak to that would be to not create platform
>> devices. Instead, just create struct device. Those really have
>> everything you need (.of_node, and can be used with RPM and GENPD). As I
>> mentioned earlier, platform device implies a CPU-memory-mapped bus,
>> which this clearly isn't. It's kind of a separate "bus" if you want, so
>> just using struct device directly seems more appropriate.
> 
> Just a heads up. If you don't use a platform device or have a driver
> associated with it for probing, you need to manage the attachment to
> genpd yourself. That means calling one of the dev_pm_domain_attach*()
> APIs, but that's perfectly fine, ofcourse.
> 
>>
>> We did something similar for XUSB pads, see drivers/phy/tegra/xusb.[ch]
>> for an example of how that was done. I think you can do something
>> similar here.

We need a platform device because we have a platform device driver that
must be bound to the device, otherwise PMC driver state won't be synced
since it it's synced after all drivers of devices that reference PMC
node in DT are probed.
