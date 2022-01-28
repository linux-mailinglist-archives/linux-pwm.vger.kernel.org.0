Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DCF4A0408
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Jan 2022 00:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbiA1XEG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jan 2022 18:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiA1XEF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jan 2022 18:04:05 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DA3C061714;
        Fri, 28 Jan 2022 15:04:05 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a25so11078364lji.9;
        Fri, 28 Jan 2022 15:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wYEgoZfpKoqG+5ywN2NTLN3ocA7SB43quho7NrzlcRU=;
        b=L+HJVHxgnWIvJJCp8rDWMfd2SQtd5ZqRh1d6eu36jRNZFPIkvlrDjh9xy6Sl9iYuEX
         iYlGcnyGV1pxi1rXdyJY4A8/23aJgh0hU/Po8jyGIaUVBiTBFBbSFkqFeTK+K57m2ZGE
         UqJEVUyz3J1X81VV2VpBcKlAVwhfSc6hBJQ1tZZLxbWaYwYRdSpkpXoSe8sz5rDY6QAw
         KF4YIBfcc2hvhHMG9RY31wvDxAupq/DYO5oV7394ULTE4XlG4FQF9eVugzau7WkCjDoA
         oyWRaJnyzNt7zXmWzvRvfTSOgxUXalqyA2iwuBqd7oYT3bLrzT1zr3BOPud8TjOtvdgj
         ZwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wYEgoZfpKoqG+5ywN2NTLN3ocA7SB43quho7NrzlcRU=;
        b=M5N1m2dpplmgjrfUpYeKwpn9hGCVjkGlaYXkv6q/+0bb+8Kq64vpo3tE8scVbtaDj3
         LukC07kopvF7Y/TLYcI8aLhcYpatJjnPsbcfuS8L2hOwGEqalvgPkvgtRIaSRVzyBr4x
         1+RqYIc/kMJOkDo9xPVfIdhnl8sTFAyVMyCQE5Nu4drfoaS1yHUZByMtHQp82xQtbIKM
         BQ23IAoectHN9Xo6uCnPpMOgR4+L+8gBUSDCnz7rAV7xzgyT223csExQ87birsDewa32
         zPbetk8Hj442x7X+7NEoEd5WIHQ7FKiGHdamJPMtO+1jHa1qQXYg5zf3nnsECX4FPIpm
         nW+g==
X-Gm-Message-State: AOAM531CmQ/ZbplUY+aDN5PBBbio5oyfKxoHcOvY/uX9yoHKkWYQYOgs
        +L70C0aT8too08x0sRH451w=
X-Google-Smtp-Source: ABdhPJwiVo/uSXQZ/cC6Fab0/D/UNev2UYpbI1VIp7bzNN0NTqqaQYBzm7iqXnGGRS7dPA2hVjRRuA==
X-Received: by 2002:a2e:b8c7:: with SMTP id s7mr6349002ljp.49.1643411043062;
        Fri, 28 Jan 2022 15:04:03 -0800 (PST)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id q7sm2482539lfg.221.2022.01.28.15.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 15:04:02 -0800 (PST)
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: Add multicolor PWM LED bindings
To:     =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>
Cc:     sven@svenschwermer.de, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de
References: <20220126104844.246068-1-sven@svenschwermer.de>
 <20220126104844.246068-2-sven@svenschwermer.de>
 <00d8de09-360e-4e0f-1496-642ba1cbf863@gmail.com>
 <20220128213609.7a60e9fe@thinkpad>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <09b46d05-5dd0-a585-2ca3-0bc04e613343@gmail.com>
Date:   Sat, 29 Jan 2022 00:04:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220128213609.7a60e9fe@thinkpad>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 1/28/22 9:36 PM, Marek Behún wrote:
> On Thu, 27 Jan 2022 22:24:21 +0100
> Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> 
>> Hi Sven,
>>
>> On 1/26/22 11:48 AM, sven@svenschwermer.de wrote:
>>> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
>>>
>>> This allows to group multiple PWM-connected monochrome LEDs into
>>> multicolor LEDs, e.g. RGB LEDs.
>>>
>>> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
>>> ---
>> [...]
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/leds/common.h>
>>> +
>>> +    rgb-led {
>>> +        compatible = "pwm-leds-multicolor";
>>> +
>>> +        multi-led {
>>> +          color = <LED_COLOR_ID_RGB>;
>>> +          function = LED_FUNCTION_INDICATOR;
>>> +          max-brightness = <65535>;
>>
>> It doesn't make much sense to have such a big resolution of global
>> multi color brightness. 255 will be sufficient.
> 
> If the PWM supports it, why not?
> On Omnia the default is 255, and since it is PWM, the change from 0/255
> to 1/255 is much bigger then from, say, 15/255 to 16/255. So if 1/255
> is too bright, you are then unable to set it less bright. I think 1024
> or ever 65535 makes sense with PWMs.

With values other than 255 we will not achieve 24-bit RGB, which is one
problem, and the other one is non-linear brightness that can be achieved
with PWM. So probably we would need to add an additional note in the
documentation [0], saying that changing global brightness allows to
preserve combined LED hue only when all sub-leds are linear, and that it
will not be the case for PWM LEDs.

And I propose to change multi-led 'color' DT property value from
LED_COLOR_ID_RGB to LED_COLOR_ID_MULTI to avoid the impression that it
will work as traditional 24-bit RGB.

[0] Documentation/leds/leds-class-multicolor.rst

-- 
Best regards,
Jacek Anaszewski
