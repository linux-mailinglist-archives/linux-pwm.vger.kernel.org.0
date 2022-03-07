Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F21E4CF2F3
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Mar 2022 08:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiCGHwZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Mar 2022 02:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiCGHwY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Mar 2022 02:52:24 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D0060D8C
        for <linux-pwm@vger.kernel.org>; Sun,  6 Mar 2022 23:51:30 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BE2D03F614
        for <linux-pwm@vger.kernel.org>; Mon,  7 Mar 2022 07:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646639489;
        bh=XlVD8ETmzuRKAuObKkkpDzusQxU46RvngqfrRmzaIqs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=d9WMOdmpXo022B9dRdXwKYKSpmcrVKpfnfsQ4giZDQX4rgalNIcRs+LxwnQX5rhZK
         KD+k4EMsSEWyQlJ5ZitZjdZ7v0wrCMxGNivnXoH3so1CK41A6iC2uoDdGpvZe0G85O
         c8eYHc6EOZK+4i/9wi9OXNqXqKbeC/wG+ja1eWe1Ae/aEJskmOKSMyzNFaBtgnRUZr
         rTZtHxpr49GVWK1HbCIfyGEtLjjFanj9UpMZTnz2S2dzLfbuqzYJUNCxCK5KLEKa1s
         EMjGz4Q5C4f5POe2jHIFSjM2ksXFZ3dwH/uZxl4bLmX78/qfQl2RSLZsBbNVFnWHD4
         STude/jIR5Ang==
Received: by mail-ed1-f71.google.com with SMTP id h17-20020a05640250d100b004133863d836so8150526edb.0
        for <linux-pwm@vger.kernel.org>; Sun, 06 Mar 2022 23:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XlVD8ETmzuRKAuObKkkpDzusQxU46RvngqfrRmzaIqs=;
        b=r8lBAtB6VlEGe9qP3pSnn5iq7oz5yGTR+m6bgEofR1IMoOhu48kEm49oFYQXHezs0L
         gDxhJ2c3ml7coaQJ/ug1bNG6QKodMo23LkaIQ+u++CqsKrIexFBIuckZQTuEak3pd7Hu
         XeT0B9xgIkfgR0k62fKTYmRdNRTHn6/MKqwxy33NBlkfi5wdfZU7HMMFpdrFkgzZh+yk
         k2yt66PdGU2gfxBM06YfzJyNWl5rbJrnsVp9AuLzKX1NGX/rv0C5nzETi8yZ6es8KQZM
         e9DP2kh4gBFLRwuWWbHxB4hKGVjKxc/kMI2suKRRVyx1742ZUf5rnWUDB/2WeVY43w8a
         vEfw==
X-Gm-Message-State: AOAM530QyB784H9RyE9moEbIGGZEU5pvhN0jqxJU3NCvY2EympHEQv9X
        0VjCQniQadCMn+WwYrXAirhDGiMNFLIbRU5fReBK5vR0q9yFifp2SmfDc5CqkCK6geGxgMWanPX
        pzGQX/bZe/mizyPOJFUkPtjuaIKlesESMfa5D4Q==
X-Received: by 2002:a05:6402:16d6:b0:415:ed41:8606 with SMTP id r22-20020a05640216d600b00415ed418606mr10147097edx.12.1646639489421;
        Sun, 06 Mar 2022 23:51:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKLYHzHLgwcRR6YV+jIDam77Vs4E7ym+wLWv9MySUNujpMFX33hcbnUCj4pdEcEWM9PALIZQ==
X-Received: by 2002:a05:6402:16d6:b0:415:ed41:8606 with SMTP id r22-20020a05640216d600b00415ed418606mr10147089edx.12.1646639489280;
        Sun, 06 Mar 2022 23:51:29 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p4-20020a50d884000000b004128cf5fe2asm5793891edj.79.2022.03.06.23.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 23:51:28 -0800 (PST)
Message-ID: <bcf0567c-b17a-4c39-4a34-6da2d9edb20f@canonical.com>
Date:   Mon, 7 Mar 2022 08:51:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings:pwm:Add bindings doc for Sunplus SoC
 PWM Driver
Content-Language: en-US
To:     hammer hsieh <hammerh0314@gmail.com>
Cc:     thierry.reding@gmail.com,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com,
        "hammer.hsieh" <hammer.hsieh@sunplus.com>
References: <1646374812-2988-1-git-send-email-hammerh0314@gmail.com>
 <1646374812-2988-2-git-send-email-hammerh0314@gmail.com>
 <9113e319-58a2-fd90-6887-fb32eb21fd18@canonical.com>
 <CAOX-t55sXVg8Fj_G_xzxWTStxZXOwKo46=_R0LkfHnMS051KaQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAOX-t55sXVg8Fj_G_xzxWTStxZXOwKo46=_R0LkfHnMS051KaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 07/03/2022 05:18, hammer hsieh wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> 於 2022年3月4日 週五
> 下午11:01寫道：
>>
>> On 04/03/2022 07:20, Hammer Hsieh wrote:
>>> Add bindings doc for Sunplus SoC PWM Driver
>>
>> You miss spaces in the subject.
>>
> 
> ok, will modify it.
> 
>>>
>>> Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
>>> ---
>>> Changes in v2:
>>>  - Addressed all comments from Rob Herring.
>>>    modify author's mail match Signed-off-by.
>>>  - rebase kernel to 5.17 rc5
>>>
>>>  .../devicetree/bindings/pwm/pwm-sunplus.yaml       | 40 ++++++++++++++++++++++
>>>  MAINTAINERS                                        |  5 +++
>>>  2 files changed, 45 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml b/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
>>> new file mode 100644
>>> index 0000000..19fe5d5
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
>>> @@ -0,0 +1,40 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright (C) Sunplus Co., Ltd. 2021
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pwm/pwm-sunplus.yaml#
>>
>> Is it going to be one binding for all Sunplus SoCs? Existing and future?
>>
> 
> yes, that was my first plan.
> but not all sunplus SoCs use the same IP-based,
> so I will change file name form 'pwm-sunplus.yaml' to
> 'sunplus,sp7021-pwm.yaml' in  next patch.

Yes, that might be better approach,



Best regards,
Krzysztof
