Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2436DE615
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Apr 2023 23:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDKVAN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Apr 2023 17:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDKVAM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Apr 2023 17:00:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFF010DF
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 14:00:10 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso1497086wmo.0
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681246809; x=1683838809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2kZBhq9UoxWuSE0Pmv7xAqI5PwLYRQSgkjur3rAZ18=;
        b=AZf254wGAK9r6weRXgfjjx5NNiqe7EJ+oyXHs9VvaL4m7DL61tbFuoKHNQMfEl2ajK
         y5cKFD9za/EcbxDwksxy58ZFSELZUk4vvpYobqQ//p+NUjfVU2mHFW2+xLBjxcNnrkKs
         jYcu9v29Xr/gzc+pTzWjxC0Ao57m1S4TP7NWLnkJSJeOPGn929b7M9XpB0RDFBoRb0yC
         xF5jR9qkn4yCCTx8YmLen5AYVZpV0iq9+yKWnkU6Ofzj6f8HfInM3DAe0e1/mSu6ciVg
         SQza365MpY2O1NmFLaoOf9V1foZOsYB9jd5QJpNQm8MVEPbSz3DDHotzUeTmtm1B3pP5
         9fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681246809; x=1683838809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2kZBhq9UoxWuSE0Pmv7xAqI5PwLYRQSgkjur3rAZ18=;
        b=dccxVd4fOjzs2wIr8kTc8FXj6NNMdFrGoztiKAACSMDuYUsqEKaBHvV5Pz5ZzUtUGm
         C+sWlFrZCWI4NA4J8bG7N6UqKoqd67JwQUs9wkWszxdMUN6wdF4YBnc796JlICOaMSEE
         bv3w698bHsWLnxHDAexvNPuhg+dE17okHu2aXdyz+n7o7YhcXtsl0LMm89ib0XZ+U1W/
         s75pUgKn63qMNhPzGOkkS1vzLo5T0zLUg7cXX3gD8eeE0JFLIiQqCUC/M5dcjdFTSjNu
         S9tWU6MhSJx0FRnuIoxBXI86+L3/v8+jZEEIDAtQ0hrdiF697KTZCFURXZtLNkZ+YcSl
         EG1g==
X-Gm-Message-State: AAQBX9f+/J3arfBmRHm3XSzgx+HzD/RKDDfbcDfu3I4ftwPsH4QQDzM+
        gVAk/dZupmVQM6ehO/P9AQc=
X-Google-Smtp-Source: AKy350YxU62L9HsurjLKnWNXqG0tvvJbkuiioYDY/lqmzJjUpIfJV9f0KgZ5dHO6SO7aYaDC+DmkBw==
X-Received: by 2002:a05:600c:28f:b0:3dc:4b87:a570 with SMTP id 15-20020a05600c028f00b003dc4b87a570mr11095014wmk.35.1681246808555;
        Tue, 11 Apr 2023 14:00:08 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c4bb:c200:90e3:4731:63e4:d333? (dynamic-2a01-0c23-c4bb-c200-90e3-4731-63e4-d333.c23.pool.telefonica.de. [2a01:c23:c4bb:c200:90e3:4731:63e4:d333])
        by smtp.googlemail.com with ESMTPSA id w16-20020a05600c475000b003f092f0e0a0sm3303233wmo.3.2023.04.11.14.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 14:00:08 -0700 (PDT)
Message-ID: <81dea141-da5d-51e2-1349-7bd434547d9f@gmail.com>
Date:   Tue, 11 Apr 2023 23:00:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 4/4] pwm: meson: make full use of common clock
 framework
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
References: <0f087629-810d-f0e0-bf0b-05ca5defc16d@gmail.com>
 <05e3b9de-ee38-97b6-7f39-5b6f7de1674f@gmail.com>
 <CAFBinCAdXE+3VrPJAoik_0TFW6TsB0033s+fTYUTNehPrn=PZg@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAFBinCAdXE+3VrPJAoik_0TFW6TsB0033s+fTYUTNehPrn=PZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 11.04.2023 21:48, Martin Blumenstingl wrote:
> On Tue, Apr 11, 2023 at 9:26 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> [...]
>> +               init.name = name;
>> +               init.ops = &clk_gate_ops;
>> +               init.flags = CLK_SET_RATE_PARENT;
> As much as I don't want it: I think we need CLK_IGNORE_UNUSED here as well :-(
> On GXBB, GXL and GXM SoCs the board design typically uses PWM
> regulators (like the boards using 32-bit SoCs as well as newer boards
> using G12A or later SoCs).
> This means: if we enable that PWM controller and one of the channels
> is firmware managed and the other isn't then we can end up disabling
> the clock - taking away VCCK (which supplies the CPU) or VDDEE (which
> supplies GPU and various other components).

I see your point, good to know. Eventually it may be an option to
mark such firmware-managed pwm channels in DT.
I'll wait for potential additional feedback until tomorrow, then I'll
submit a version incl. the two small changes to address your remarks.

> I'd be happy if there are other suggestions around this though.
> 
> 
> Best regards,
> Martin

