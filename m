Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5E42B9489
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Nov 2020 15:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgKSOWt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Nov 2020 09:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgKSOWt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Nov 2020 09:22:49 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A62C0613CF;
        Thu, 19 Nov 2020 06:22:47 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id e139so8515559lfd.1;
        Thu, 19 Nov 2020 06:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZvOd3z2dVnB5SZQwK/dvDpMXJ4eITwmefRvuKa9tb0Q=;
        b=Y21dZRMZ+kNYHUNLiNCHQoS5QxGFMKf7KaEd+6a06G/hQ1bejJXAcijD6xiDcBiBUn
         JS4yWyB2+zZqqxEzarQ7y2NC3cKCRKUZ2CchFnZU6Kn5vLrutkvXtu+Lq1OFhxgn8Epp
         UuLT88qmv67A3sWVg1l8Ws05tNM98wJWDlT1hgGfbwXfCiTxIVlprvN48xiVZLuFi3Cn
         KI3oT4rlzLRHtD8EKwZRS29BsqsZh07SrjWWBHtLowX/toS83Dhlqd9OCn9mvofvfXic
         DHhrzPVHyIWzxM0YW/p1ZFuzvZaox6YeG/KIcRnpB6NKJzCgXsklV6r9OCr7nnEUUhRd
         hptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZvOd3z2dVnB5SZQwK/dvDpMXJ4eITwmefRvuKa9tb0Q=;
        b=i7ba6A/r1lx38CySMfQ+TDUl7Ug5P1w27iAO+JNLA3mdxNi6OJU0Dyqalbxsw01iB0
         VAsNVwAXW1PqPUXXSjGz0epzuBBCbtyiUFWhin0O2XLXgQRzlY1akQvQtW/ko39PobAl
         YqRKgEYYe3YFDLqG9cjS0d36YmKabjvOpUI6c76OKGdqYg3fS5LkGKk6O+yUnTz3eRHz
         PWSciz9HMFkctnmfRE7e4I7307OLnlqaz8QPpkNVd/aym1Zj/CRTKjfv3D9eULG/nYuE
         2fZ5e3RZt0B5qhOLiz610v07pBXK8W2tBlr9mbSx1CHjsYAJC6p0df7hm4FpmuX71rKU
         978w==
X-Gm-Message-State: AOAM530du4USguA/p3pLaUicqA2meLa3ozpjxZ7O2FXF+na2ZDg6G4DO
        96bNH1Rf87fJcnpUjW52tmsWQdbw810=
X-Google-Smtp-Source: ABdhPJyUwmqVByndGgJFiM7woqjbf8UJz72yW3W4B1Jv93hEMk1YatxireTGBSQxqAyLLyxkuXCkKw==
X-Received: by 2002:a19:844a:: with SMTP id g71mr6446029lfd.414.1605795766096;
        Thu, 19 Nov 2020 06:22:46 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id m16sm3851652lfa.57.2020.11.19.06.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 06:22:45 -0800 (PST)
Subject: Re: [PATCH v1 11/30] drm/tegra: dc: Support OPP and SoC core voltage
 scaling
To:     Mark Brown <broonie@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
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
        linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20201112171600.GD4742@sirena.org.uk>
 <b4b06c1d-c9d4-43b2-c6eb-93f8cb6c677d@gmail.com>
 <20201112200123.GF4742@sirena.org.uk>
 <ce9e2d9f-917e-fb8a-7323-f3bf1a367e9d@gmail.com>
 <20201113142937.GB4828@sirena.org.uk>
 <7f066805-97d9-088f-e89d-a554fe478574@gmail.com>
 <20201113161550.GC4828@sirena.org.uk>
 <3beaa12b-4a50-a3b6-fc43-ebb5ce7a8db7@gmail.com>
 <20201113172859.GF4828@sirena.org.uk>
 <74cfc6a9-3f59-d679-14b7-51102a6f11b3@gmail.com>
 <20201116133311.GB4739@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <332ab946-daee-bb83-24ab-0bda4fd8e1ef@gmail.com>
Date:   Thu, 19 Nov 2020 17:22:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201116133311.GB4739@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

16.11.2020 16:33, Mark Brown пишет:
> On Sun, Nov 15, 2020 at 08:42:10PM +0300, Dmitry Osipenko wrote:
>> 13.11.2020 20:28, Mark Brown пишет:
> 
>>>> What should we do?
> 
>>> As I keep saying the consumer driver should be enumerating the voltages
>>> it can set, if it can't find any and wants to continue then it can just
>>> skip setting voltages later on.  If only some are unavailable then it
>>> probably wants to eliminate those specific OPPs instead.
> 
>> I'm seeing a dummy regulator as a helper for consumer drivers which
>> removes burden of handling an absent (optional) regulator. Is this a
>> correct understanding of a dummy regulator?
> 
>> Older DTBs don't have a regulator and we want to keep them working. This
>> is equal to a physically absent regulator and in this case it's an
>> optional regulator, IMO.
> 
> No, you are failing to understand the purpose of this code.  To
> reiterate unless the device supports operating with the supply
> physically absent then the driver should not be attempting to use
> regulator_get_optional().  That exists specifically for the case where
> the supply may be absent, nothing else.  The dummy regulator is there
> precisely for the case where the system does not describe supplies that
> we know are required for the device to function, it fixes up that
> omission so we don't need to open code handling of this in every single
> consumer driver.

The original intention of regulator_get_optional() is clear to me, but
nothing really stops drivers from slightly re-purposing this API, IMO.

Drivers should be free to assume that if regulator isn't defined by
firmware, then it's physically absent if this doesn't break anything. Of
course in some cases it's unsafe to make such assumptions. I think it's
a bit unpractical to artificially limit API usage without a good reason,
i.e. if nothing breaks underneath of a driver.

> Regulators that are present but not described by the firmware are a
> clearly different case to regulators that are not physically there,
> hardware with actually optional regulators will generally require some
> configuration for this case.
> 

I have good news. After spending some more time on trying out different
things, I found that my previous assumption about the fixed-regulator
was wrong, it actually accepts voltage changes, i.e. regulator consumer
doesn't get a error on a voltage-change. This is exactly what is needed
for the OPP core to work properly.

This means that there is no need to add special quirks to work around
absent regulators, we will just add a fixed regulator to the DTs which
don't specify a real regulator. The OPP core will perform voltage
checking and filter out unsupported OPPs. The older DTBs will continue
to work as well.
