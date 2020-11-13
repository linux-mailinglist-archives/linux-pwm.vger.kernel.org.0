Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEB72B21AD
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Nov 2020 18:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgKMRNk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Nov 2020 12:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMRNk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Nov 2020 12:13:40 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8ACC0613D1;
        Fri, 13 Nov 2020 09:13:54 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 11so11601082ljf.2;
        Fri, 13 Nov 2020 09:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uHdzUd8NUNc0lpDwmppHgQMHGeLwwBEPsQiuUdFVMn0=;
        b=Vf9aLrdMygr+pSOB4syQyMMFa9s3Y8gg9aPfdkjSqO0uUp6X42pZjw6A0oiO8Qo79g
         VMYB6KWyUWYTFP9RCfvpj6vzwpPwW2W6oCelyU8g7orM2z47YMOnDHg3C2g50zzfEusG
         nqvrEWPVjXN4vLqhpx0/KIK4pqj8V71LUjcbnFJPdOHtrUJArcFLXTfdV2HqqJ/fhuLd
         vr4HQXG4TCfqEDnWPBvTd1hixQrQx+II8BCVSHa4t4TrMZyTNIez047wBg702EUCXj6X
         1iA+hxDZ1SNCWmtV7FjSRYfemkBuFRiPD2NRufuDZeWZswgy5d+Dy8jmCiBsIO+6SJAx
         soQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uHdzUd8NUNc0lpDwmppHgQMHGeLwwBEPsQiuUdFVMn0=;
        b=rVRDgvOf0bEMMb0CqQ+L0HbzzUNylTEQTMR3sPIDTci0bmywnuHRF7DV0r4m61JvkB
         4cwq+RD87pnzW3j3cYQ0NFj3w6eoJyXF9c39AG6JjVaRZw+EM+ZRxfTFBs91MGapriu4
         tpWQL/UWTtldxwmEnaJZJ2Xq+8txmmDJDw23RkJRkDqc4itkXuDvpI/nriWl/J0Uq03N
         KL6MPI5S0nroh5KVtmB0qM1tjEn0drwfPLwzlwA8YcK6AXZfdF4yHMJKWCTlTD3XaP7G
         HfN9Rgb2Pgy6LdXsPtfO3I6xdvOV5NUgJBvchI7Zu73jk0pTtGk6JyOckzfBJ74YPuSv
         5/4Q==
X-Gm-Message-State: AOAM53312YFbTzJn/WE8TkbN/RGdntjYHAJGxy+MxAUDw6Gb2K7X2gWQ
        xDc37NNoNLMOi+lI//u40YlhqZHN4Ao=
X-Google-Smtp-Source: ABdhPJyHpSg50GBIXMPXL7aP9qtANQ43u803+eBAONtCmTaJb6C6zR3PWcQF6qlWhad3UtWFiD81wQ==
X-Received: by 2002:a2e:3503:: with SMTP id z3mr1395526ljz.70.1605287631533;
        Fri, 13 Nov 2020 09:13:51 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id e10sm1617281lfn.115.2020.11.13.09.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 09:13:50 -0800 (PST)
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
References: <20201110203257.GC5957@sirena.org.uk>
 <72ae6462-13df-9fcb-510e-8e57eee0f035@gmail.com>
 <20201111115534.GA4847@sirena.org.uk>
 <dd26eb18-8ac4-22a6-29b0-dbbe5fa6075b@gmail.com>
 <20201112171600.GD4742@sirena.org.uk>
 <b4b06c1d-c9d4-43b2-c6eb-93f8cb6c677d@gmail.com>
 <20201112200123.GF4742@sirena.org.uk>
 <ce9e2d9f-917e-fb8a-7323-f3bf1a367e9d@gmail.com>
 <20201113142937.GB4828@sirena.org.uk>
 <7f066805-97d9-088f-e89d-a554fe478574@gmail.com>
 <20201113161550.GC4828@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3beaa12b-4a50-a3b6-fc43-ebb5ce7a8db7@gmail.com>
Date:   Fri, 13 Nov 2020 20:13:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201113161550.GC4828@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

13.11.2020 19:15, Mark Brown пишет:
> On Fri, Nov 13, 2020 at 06:55:27PM +0300, Dmitry Osipenko wrote:
>> 13.11.2020 17:29, Mark Brown пишет:
> 
>>> It's not clear if it matters - it's more a policy decision on the part
>>> of the driver about what it thinks safe error handling is.  If it's not
> 
>> If regulator_get() returns a dummy regulator, then this means that
>> regulator isn't specified in a device-tree. But then the only way for a
>> consumer driver to check whether regulator is dummy, is to check
>> presence of the supply property in a device-tree.
> 
> My point here is that the driver shouldn't be checking for a dummy
> regulator, the driver should be checking the features that are provided
> to it by the regulator and handling those.

I understand yours point, but then we need dummy regulator to provide
all the features, and currently it does the opposite.

> It doesn't matter if this is
> a dummy regulator or an actual regulator with limited features, the
> effect is the same and the handling should be the same.  If the driver
> is doing anything to handle dummy regulators explicitly as dummy
> regulators it is doing it wrong.

It matters because dummy regulator errors out all checks and changes
other than enable/disable, instead of accepting them. If we could add an
option for dummy regulator to succeed all the checks and accept all the
values, then it could become more usable.

>> We want to emit error messages when something goes wrong, for example
>> when regulator voltage fails to change. It's fine that voltage changes
>> are failing for a dummy regulator, but then consumer driver shouldn't
>> recognize it as a error condition.
> 
> If you're fine with that you should also be fine with any other
> regulator for which you failed to enumerate any voltages which you can
> set.

It's not fine.

In the case of this driver the dummy regulator should succeed instead of
failing.

>> The regulator_get_optional() provides a more consistent and
>> straightforward way for consumer drivers to check presence of a physical
>> voltage regulator in comparison to dealing with a regulator_get(). The
>> dummy regulator is nice to use when there is no need to change
>> regulator's voltage, which doesn't work for a dummy regulator.
> 
> To repeat you should *only* be using regulator_get_optional() in the
> case where the supply may be physically absent which is not the case
> here.
> 

Alright, but then we either need to improve regulator core to make dummy
regulator a bit more usable, or continue to work around it in drivers.
What should we do?
