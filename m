Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5342B3758
	for <lists+linux-pwm@lfdr.de>; Sun, 15 Nov 2020 18:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgKORmO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 15 Nov 2020 12:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgKORmN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 15 Nov 2020 12:42:13 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D1BC0613D1;
        Sun, 15 Nov 2020 09:42:13 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 11so17223522ljf.2;
        Sun, 15 Nov 2020 09:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UVKCC93ChOuvLBPVNXzdjCLR1DncgSU1O2sv9PBzZK8=;
        b=q5EDuXURuPPC97beX3V4mv9fx74JwrX62zLJm1rDt1a+sWwxwm9Za//CQ5VL/nXjrQ
         F1ugiUrc/esQCDFKC5U2KoA6ZaEe/owvrZwUH7mf25fOxJ2YvnXFXC1xFThoEgEyFphu
         XPScDLPEiwTnKdO/9XxjUQTXzeoA/xM8oI2+jnfOSM0/xoRUQ9JdWDtomEJfnZ6EHfMA
         nJddJ9WZtVDRL7mWu19HOoCmf0b4YWsTPYtlkNcdwGUfu85PN4CMjKIsX3ct6YQa3Z4O
         bugIeCkPH9olbamWMqIQz1oLScq7TVl2OsKUr9I7A+ybQ7i4uc28VOzdHeIfKis3Tm4G
         nYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UVKCC93ChOuvLBPVNXzdjCLR1DncgSU1O2sv9PBzZK8=;
        b=Nt95L6vU1mI7CercisXNLvN5k8eOLsR4uUd8KaSONRlcQI/xnGttInCPSh+qQDsxef
         AgJCMK/LTkCBxUWOhRr7aU6o/Xos534Z65BSZAuG9WB46YsGB/nl9UpzNWT4WX8tOeWe
         kPdb3uoF2mjWOnn9+2pw1Wnqw1jW+vyBF2Z2Ucskiew1cKfbyKpBeshN1xnd3z/basaE
         mKK4l30/MoMvla1rw4MgedDE7nAOM9lzfQ54BkXwZKbDTemwHKuPBTufs/g9dHBEyxhG
         CMBsFbhOPMyFkCSqaZldwr7gEuy7Sen77KdDvHOJhXghiCCOTzJoOltgG80AY82IXQ6P
         UbVQ==
X-Gm-Message-State: AOAM531SFMU9dsBIC7Jo13ZLqw+pmPFI/ZS2NGHI7KQpsnscUEq3o/FC
        8duFZ4Kbn195s47osCS2kUKtv4hXJxI=
X-Google-Smtp-Source: ABdhPJyuQnfbXszJA+lutL0HEjR/H3Jr59VD1SbTiWXoWfrL+aJ7fZRGwBGxq4z49RBxglbs8TZqWw==
X-Received: by 2002:a2e:8553:: with SMTP id u19mr4934146ljj.85.1605462131879;
        Sun, 15 Nov 2020 09:42:11 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id q4sm2442852ljh.38.2020.11.15.09.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 09:42:11 -0800 (PST)
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
References: <20201111115534.GA4847@sirena.org.uk>
 <dd26eb18-8ac4-22a6-29b0-dbbe5fa6075b@gmail.com>
 <20201112171600.GD4742@sirena.org.uk>
 <b4b06c1d-c9d4-43b2-c6eb-93f8cb6c677d@gmail.com>
 <20201112200123.GF4742@sirena.org.uk>
 <ce9e2d9f-917e-fb8a-7323-f3bf1a367e9d@gmail.com>
 <20201113142937.GB4828@sirena.org.uk>
 <7f066805-97d9-088f-e89d-a554fe478574@gmail.com>
 <20201113161550.GC4828@sirena.org.uk>
 <3beaa12b-4a50-a3b6-fc43-ebb5ce7a8db7@gmail.com>
 <20201113172859.GF4828@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <74cfc6a9-3f59-d679-14b7-51102a6f11b3@gmail.com>
Date:   Sun, 15 Nov 2020 20:42:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201113172859.GF4828@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

13.11.2020 20:28, Mark Brown пишет:
> On Fri, Nov 13, 2020 at 08:13:49PM +0300, Dmitry Osipenko wrote:
>> 13.11.2020 19:15, Mark Brown пишет:
> 
>>> My point here is that the driver shouldn't be checking for a dummy
>>> regulator, the driver should be checking the features that are provided
>>> to it by the regulator and handling those.
> 
>> I understand yours point, but then we need dummy regulator to provide
>> all the features, and currently it does the opposite.
> 
> As could any other regulator?

Yes

>>> It doesn't matter if this is
>>> a dummy regulator or an actual regulator with limited features, the
>>> effect is the same and the handling should be the same.  If the driver
>>> is doing anything to handle dummy regulators explicitly as dummy
>>> regulators it is doing it wrong.
> 
>> It matters because dummy regulator errors out all checks and changes
>> other than enable/disable, instead of accepting them. If we could add an
>> option for dummy regulator to succeed all the checks and accept all the
>> values, then it could become more usable.
> 
> I'm a bit confused here TBH - I'm not sure I see a substantial
> difference between a consumer detecting that it can't set any voltages
> at all and the handling for an optional regulator.  Either way if it's
> going to carry on and assume that whatever voltage is there works for
> everything it boils down to setting a flag saying to skip the set
> voltage operation.  I think you are too focused on the specific
> implementation you currently have here.
> 
> We obviously can't just accept voltage change operations when we've no
> idea what the current voltage of the device is.
> 
>>> To repeat you should *only* be using regulator_get_optional() in the
>>> case where the supply may be physically absent which is not the case
>>> here.
>>
>> Alright, but then we either need to improve regulator core to make dummy
>> regulator a bit more usable, or continue to work around it in drivers.
>> What should we do?
> 
> As I keep saying the consumer driver should be enumerating the voltages
> it can set, if it can't find any and wants to continue then it can just
> skip setting voltages later on.  If only some are unavailable then it
> probably wants to eliminate those specific OPPs instead.

I'm seeing a dummy regulator as a helper for consumer drivers which
removes burden of handling an absent (optional) regulator. Is this a
correct understanding of a dummy regulator?

Older DTBs don't have a regulator and we want to keep them working. This
is equal to a physically absent regulator and in this case it's an
optional regulator, IMO.

Consumer drivers definitely should check voltages, but this should be
done only for a physical regulator.
