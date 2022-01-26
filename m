Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591D249D47A
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jan 2022 22:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiAZV03 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jan 2022 16:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiAZV01 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jan 2022 16:26:27 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E20CC061747;
        Wed, 26 Jan 2022 13:26:26 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x23so1531695lfc.0;
        Wed, 26 Jan 2022 13:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uMgRCvZXgTQsC5uLKUTLh7AlqDc/eRPo2Oj35RP14+A=;
        b=EoyL7Lm3UZtCFAuPYOYF5b3ZOOE6HYtr4Qk/rySj2L8dJNCxY7GU5oNUxRYzx0Ec6y
         TQjzxQPuJk3F/ozWFDA5Ix7YPrx0Vwi9mc4mrEryUh4v9Sv5jiyhs5V3Gec3Akqyf3ye
         304XHiC6NFDU/XSYKs+cttkI9GCtyx+Wf0ygImV0HuhgI27aqNAnXEjMJ+yGGB7ZG+Da
         Go6MdR7prl0zVVRYWBBNWcWj2ppkB3WU1vpVTwzd4KmOPSjm5DzKqyEDlPDZhri4zF6b
         QoI1omZd5nlaVwFijMvDpac7hlO/omzII1KBu3+REApvweAXmFUZn+Y+bYRy6GFgxD3M
         iX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uMgRCvZXgTQsC5uLKUTLh7AlqDc/eRPo2Oj35RP14+A=;
        b=sXVK0zl/Y+3xIJJao6O/PNLX5cLxomjkKfOfAD8FILgsRBVJy0x3HLhkz+PccbHmq7
         PWZD5jh54x9E/rXIMZUpcodwr4actnFuWuzyz5sihG15w9WFcmelh4I4RWcUvO+/J+LF
         meQia0xUdzqHCiRNU6IRziWdIfYTo+/kRAt3pkkhMNe0QGm5GdoIA5YGlvUQOg3feVcq
         GbTVlGAOhvXmkiqrmxQgTINhjzXJTVBEwMS+URJesplFTzn4p+Oyua9NVmhqcnJ7yoH2
         VhvsxIUvRhPlfLmCmfQIRTEqt5jXxK9hH7ssU6EnZR+0GWMTIZBKmNFHPtoi0C3FWCAN
         Lkug==
X-Gm-Message-State: AOAM5319rt7jC+L8/cLUIePCc5g6dpo7TDMHR2L4+gIpO3j2rtpvqW0Q
        qkMdqn5Alrl99mQhALcaCCo=
X-Google-Smtp-Source: ABdhPJxkhkfSovSMdAR4dU3hxYsZXihvHfcXVtab8drHG97zE1tXAk94uR6MpRQ8d3Ei7Fnc59SSuw==
X-Received: by 2002:a05:6512:33c8:: with SMTP id d8mr595823lfg.41.1643232384736;
        Wed, 26 Jan 2022 13:26:24 -0800 (PST)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id e7sm1951288lfb.17.2022.01.26.13.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 13:26:24 -0800 (PST)
Subject: Re: [RFC PATCH 0/2] Multicolor PWM LED support
To:     Sven Schwermer <sven@svenschwermer.de>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org
References: <20220125092239.2006333-1-sven@svenschwermer.de>
 <a147897a-2823-ad45-d727-0b96f48b4da3@gmail.com>
 <70bfabe5-7f53-5c80-e1de-dc73e85232de@svenschwermer.de>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <609c58de-67ee-3c1d-512b-66bad482addb@gmail.com>
Date:   Wed, 26 Jan 2022 22:26:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <70bfabe5-7f53-5c80-e1de-dc73e85232de@svenschwermer.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Sven,

On 1/26/22 8:51 AM, Sven Schwermer wrote:
> Hi Jacek,
> 
> Thank you for your feedback!
> 
> On 1/25/22 23:31, Jacek Anaszewski wrote:
> 
>>>    1. Currently, the max-brightness property is expected as a 
>>> property to
>>>       the multi-led node. That seems consistent with the existing
>>>       multicolor class code, but I'm wondering whether it would make
>>>       sense to have a max-brigthness for the individual LEDs as well?
>>
>> For the proper mixed color calculation all sub-leds should have
>> the same max_brightness as the global max_brightness.
>>
>> Look at how sub-led intensities are calculated in
>> led_mc_calc_color_components().
>>
>> See also [0] and [1].
> 
> OK, thanks. That makes sense.
> 
>>>    2. The current multi-led node definition calls for a node index which
>>>       would in turn require the reg property to be set within the node.
>>>       In this context, that doesn't seem to make sense. Should this
>>>       requirement be lifted from leds-class-multicolor.yaml?
>>
>> reg is required for all DT nodes with address unit in the name.
>> If you skipped the address unit, then reg would be also not required.
> 
> Yes, I realize this. However, leds-class-multicolor.yaml [0] requires 
> the address unit: "^multi-led@([0-9a-f])$"

This is only an example and nothing prevents you from dropping address
unit in leds-pwm-multicolor DT bindings. We don't have common DT parser
for multicolor LEDs and it will be hard to come up with something that
will fit neatly for all possible LED controllers anyway.

Dropping address unit from leds-class-multicolor.yaml would be too much
since it is useful in some cases, see e.g. [2].

[2] Documentation/devicetree/bindings/leds/leds-lp50xx.yaml

-- 
Best regards,
Jacek Anaszewski
