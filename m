Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635322AB06D
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Nov 2020 06:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgKIFJC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Nov 2020 00:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgKIFJC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Nov 2020 00:09:02 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D62C0613CF;
        Sun,  8 Nov 2020 21:09:02 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w142so3659815lff.8;
        Sun, 08 Nov 2020 21:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FeL/6AVX9ZUMu7dDHuIXkGUemXJf7ZARpxKlL5RCoNQ=;
        b=HASuQOXkF1RZA3cFoj4FpQvKgZV2Q1/lr5KDfeyQiu7UzOUcgR2MLIo0A9WjcfOmav
         ata3slrLCP7pYpjJJpH3hsWHJQhWDFD2MnuhKZ/K2Wi3PTDjn+6YANdF7+WLjyyARswK
         xjvHnNgEGoDtms4JWbiH/Eldmfj6//odfOM4UJkGJg1nbiyF9x+dhfPodAtsd68AVRQt
         aYvz1hbhU2LBNUEhS+Pd+SfaNp7EwpvEEKUFSYkSpU0qD7E4OjNohzH6JLJrfeYiaYh+
         TKX+gaGoXyq8SLKOzNJ4iFAJkgcC2xWjpa2lrpe34n1HFP7FxGpRlfeKBkcE/EIUJsh1
         aq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FeL/6AVX9ZUMu7dDHuIXkGUemXJf7ZARpxKlL5RCoNQ=;
        b=Em/A75Ib06pzgRU50JcxNMu2yyS/a3HT6ls4eo5Vxe2CnG+9vTRC0PsV0nnrNBdqp7
         F+JodYi9H2r7+v0TEWvB5VBHXTQ38eEKNFOSlZdNli1iFgtoeF3fKaOUbQTNVIy7C68Y
         g2nnDtA0ajBSBGGJPI/s9S3FrB0iaoYdLm8LMWFheLQGVDamUQqXSeR3dslqvzhodVTY
         +JdKu3YRmEs5mFnkc+Gno1CA7TUgHQw75Y78dceuLWfLq9gNTot4hEYbiuTy775Ob/RR
         pGvN6mSn98WVF8eFXntSN0xgG8h2CXL4UF/5872XDCRHUS+p4aIM0KskOirYb+bMhZnp
         B9/A==
X-Gm-Message-State: AOAM532KOCmbWnuJ2rCqfujbBTaDQEaIUNORGZiNc3ojmhc0hGScUj0M
        gqtPhujQsOy+gZHGy+M9rQdz3h6byDc=
X-Google-Smtp-Source: ABdhPJyKFQooKNzB6MtWOkwlVNrBylRoyZRaTFBouH4KLXv0r9LDeU3fC845u6KgAdZQGxa4Rr9biQ==
X-Received: by 2002:a19:c714:: with SMTP id x20mr2310703lff.537.1604898540523;
        Sun, 08 Nov 2020 21:09:00 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id w22sm1662291ljm.20.2020.11.08.21.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 21:08:59 -0800 (PST)
Subject: Re: [PATCH v1 17/30] mmc: sdhci-tegra: Support OPP and core voltage
 scaling
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Frank Lee <tiny.windzz@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        driver-dev <devel@driverdev.osuosl.org>,
        linux-pwm@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-usb@vger.kernel.org,
        "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-18-digetx@gmail.com>
 <CAOh2x==sy1w7_oEV8=toC6uQnSN44wyOixbP_X0BrMsnm1AUFg@mail.gmail.com>
 <6fa54ce6-d5ae-d04f-7c77-b62c148d92b7@gmail.com>
 <20201106061513.uyys7njcqcdlah67@vireshk-i7>
 <a6926456-8bce-a438-bfaa-be334208f004@gmail.com>
 <CAEExFWsp0DWw1yO84e3vzr_YZkqkd+pyPfQQR3J2W6n3wTX4Jw@mail.gmail.com>
 <20201109050010.g47zojh6wafvwqva@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c584b301-e052-7f01-335d-8f9160865198@gmail.com>
Date:   Mon, 9 Nov 2020 08:08:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201109050010.g47zojh6wafvwqva@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

09.11.2020 08:00, Viresh Kumar пишет:
> On 06-11-20, 21:41, Frank Lee wrote:
>> On Fri, Nov 6, 2020 at 9:18 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>
>>> 06.11.2020 09:15, Viresh Kumar пишет:
>>>> Setting regulators for count as 0 doesn't sound good to me.
>>>>
>>>> But, I understand that you don't want to have that if (have_regulator)
>>>> check, and it is a fair request. What I will instead do is, allow all
>>>> dev_pm_opp_put*() API to start accepting a NULL pointer for the OPP
>>>> table and fail silently. And so you won't be required to have this
>>>> unwanted check. But you will be required to save the pointer returned
>>>> back by dev_pm_opp_set_regulators(), which is the right thing to do
>>>> anyways.
>>>
>>> Perhaps even a better variant could be to add a devm versions of the OPP
>>> API functions, then drivers won't need to care about storing the
>>> opp_table pointer if it's unused by drivers.
>>
>> I think so. The consumer may not be so concerned about the status of
>> these OPP tables.
>> If the driver needs to manage the release, it needs to add a pointer
>> to their driver global structure.
>>
>> Maybe it's worth having these devm interfaces for opp.
> 
> Sure if there are enough users of this, I am all for it. I was fine
> with the patches you sent, just that there were not a lot of users of
> it and so I pushed them back. If we find that we have more users of it
> now, we can surely get that back.
> 

There was already attempt to add the devm? Could you please give me a
link to the patches?

I already prepared a patch which adds the devm helpers. It helps to keep
code cleaner and readable.
