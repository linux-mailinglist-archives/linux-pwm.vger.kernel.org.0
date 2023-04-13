Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909236E1661
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Apr 2023 23:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjDMVSE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Apr 2023 17:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDMVSD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2023 17:18:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BEB30FD
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 14:18:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k36-20020a05600c1ca400b003f0a7c483feso1903549wms.4
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 14:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681420681; x=1684012681;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvgvENO7OsEfYlpi3gro7VWSzf69fgGUrOZS9U5Yybg=;
        b=bywSUA59UtCpqINbFrwRKWQFGwdz582hwMpd7vmBWBhXvHaPuePnAvx2oOd+evSK2I
         y/0Sss9v77EeEGp3lwV6wJu1IWiEW+vcqFKiG7GcpI43YffN1h/4XJqzFaBnXivEqcP0
         oAe9UV/PSCdK8AbWcnAR3rer+ifFZw4ZxnKkIBOEpyQjrA72a9tkzYIikMgHZKyCV6Hb
         FxtxePLtZuvvf7mbkG9egGVIqasvzUD37aXJZoz03Mh/xtElda59S+6XitMM+w8l9fhQ
         C3iMctBlSLz6raKKoVbCI4Aibm5UcYEARt39zIhrTSpxj4bhK+zR6s3mRpvDtgH+mogy
         hcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681420681; x=1684012681;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvgvENO7OsEfYlpi3gro7VWSzf69fgGUrOZS9U5Yybg=;
        b=QWSNMh9TaHIfVAgsSYDDKnYFRTwlgDwTlND7ms0GDYa5tkoGbdA+rWS/pNBCdIPUMc
         fbMc3WI/UY/DZfE/mYmDVAR9n7LeF+ZOloqN+UI4lIFytwtLms7otxS+uphNMESJLk1s
         iaSHLGaq7bp+8Sk8GwIGWlQ3rTQvA4dB0Z9QjHtffaoVUDqpQ8gBh1RzC0We84c+KuXn
         dFygsNSsPLr00KUwbDl1DAtxyQCSl+NZ7F9w3Mbvbf2S0H/CdFpRa93jWFzbRxH13Jxw
         oSiF+aMdvIWTF6JLPLrjVSx24tZfBVzZuVAOb/Ae41ViEWG0XBiEphrYLsE8Q/PvZCEY
         i3lg==
X-Gm-Message-State: AAQBX9e1u3m3KHquBjhUn5Wc9KoB9wKlw7jc5+BSb0jkp5roYoAZRllv
        oTH6F+LlgDOROsjbH09qqpQ=
X-Google-Smtp-Source: AKy350YZ2DOjKsCluMWuSo39HVU0l8eCuZ/vjttpc3RrNgfx8YujWylw5m4NYGCPIzZSFPo32lg4wA==
X-Received: by 2002:a7b:cd9a:0:b0:3ee:526f:b15e with SMTP id y26-20020a7bcd9a000000b003ee526fb15emr2598277wmj.23.1681420680413;
        Thu, 13 Apr 2023 14:18:00 -0700 (PDT)
Received: from ?IPV6:2a01:c22:738e:4400:f580:be04:1a64:fc5e? (dynamic-2a01-0c22-738e-4400-f580-be04-1a64-fc5e.c22.pool.telefonica.de. [2a01:c22:738e:4400:f580:be04:1a64:fc5e])
        by smtp.googlemail.com with ESMTPSA id f10-20020a7bc8ca000000b003f09f44c7bcsm2719313wml.33.2023.04.13.14.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 14:18:00 -0700 (PDT)
Message-ID: <61c1266c-407f-6d26-d9aa-1f9a0fc02e12@gmail.com>
Date:   Thu, 13 Apr 2023 23:17:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
References: <29973c8a-2b14-3d0c-bee8-8aff36c265e3@gmail.com>
 <f7291bab-eb51-3f2d-4eb4-78f6330242ef@gmail.com>
 <CAFBinCDs=EQo8-HSSbaprfJB+93sz+Ng1H=MX3hBG_00PTko3g@mail.gmail.com>
 <ZDfGJM24xZbfSur5@orome>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v3 3/4] pwm: meson: change clk/pwm gate from mask to bit
In-Reply-To: <ZDfGJM24xZbfSur5@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 13.04.2023 11:06, Thierry Reding wrote:
> On Wed, Apr 12, 2023 at 10:47:05PM +0200, Martin Blumenstingl wrote:
>> Hi Heiner,
>>
>> On Wed, Apr 12, 2023 at 9:23 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>
>>> Change single-bit values from mask to bit. This facilitates
>>> CCF initialization for the clock gate in a follow-up patch.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> #
>> meson8b-odroidc1, sm1-x96-air
>>
>> [...]
>>>  #define REG_MISC_AB            0x8
>>> -#define MISC_B_CLK_EN          BIT(23)
>>> -#define MISC_A_CLK_EN          BIT(15)
>>> +#define MISC_B_CLK_EN          23
>>> +#define MISC_A_CLK_EN          15
>>>  #define MISC_CLK_DIV_MASK      0x7f
>>>  #define MISC_B_CLK_DIV_SHIFT   16
>>>  #define MISC_A_CLK_DIV_SHIFT   8
>>>  #define MISC_B_CLK_SEL_SHIFT   6
>>>  #define MISC_A_CLK_SEL_SHIFT   4
>>>  #define MISC_CLK_SEL_MASK      0x3
>>> -#define MISC_B_EN              BIT(1)
>>> -#define MISC_A_EN              BIT(0)
>>> +#define MISC_B_EN              1
>>> +#define MISC_A_EN              0
>> Personally I'm fine with this change but it's not how I would have done it:
>> - I would have kept the BIT() macro for MISC_{A,B}_EN
>> - then I would have renamed MISC_{A,}_CLK_EN to
>> MISC_{A,B}_CLK_EN_SHIFT (to be consistent with _SHIFT of the mux and
>> divider) and drop the BIT() macro there (like you did)
>>
>> This is possibly/likely personal preference, so my suggestion is to
>> wait for some more feedback.
> 
> It looks like these aren't used outside the meson_pwm_per_channel_data
> array, so why bother with a #define (and any potential inconsistencies)
> in the first place?
> 
I think we follow a common pattern here and first define constants for all
registers and bits/fields. Having the register layout defined in one place
makes it easier to check it against the chip datasheet.
However I'm not sure whether this is what you were referring to.

> Thierry

