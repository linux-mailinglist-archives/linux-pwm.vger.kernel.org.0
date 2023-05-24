Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D1670FE49
	for <lists+linux-pwm@lfdr.de>; Wed, 24 May 2023 21:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjEXTLP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 May 2023 15:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjEXTLO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 May 2023 15:11:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2358194
        for <linux-pwm@vger.kernel.org>; Wed, 24 May 2023 12:11:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51190fd46c3so2513800a12.1
        for <linux-pwm@vger.kernel.org>; Wed, 24 May 2023 12:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684955468; x=1687547468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85PLd9OKU13wDsb8wLcpS9vIt9NW9f/X1/AhbPGEAG8=;
        b=b9FeqMxd6ZIzpLr4Pfztjzy+++imXnaOWtMlQq7c8pOVU+gAH+3oSlNynHD5v+PDoe
         CTe6TsNYuhuWALKHLrFAu3Wnr5CaAD76dHwjAWDVnkQjWwwZQJF4BiuxS8StJiLTXfNT
         Ujk5Q4f+RnukFXvO+YAu1bTG3boBQc2rnSksX0bcEBExgciYRzN8VvqVZOACBpmRyF8v
         xhfvIShOc2G0RXQDwy5GjFkOOMQ7PMJC1jbshW20bE8+jSisLBIyj8T6uaDRQcNsawod
         xmLEPFZz2sloHWOCTUsLVoKoXF8c9JFK2E/PYmn/AIl2acsHC4m3B7FDuDvAfgjycxCo
         VbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684955468; x=1687547468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85PLd9OKU13wDsb8wLcpS9vIt9NW9f/X1/AhbPGEAG8=;
        b=K6dNyaLHiKs4/l6w3x0JORZsqS4bg/QWMwb0zMvnYtbbcbU77S5Mx6t2euGk9aTz51
         vGVAELWFdSTPzEojeu+WS+G8a0rlDt/VC6shIQ6b19+/MCRWY9oQr+5pz1YDUZyTjyUa
         bzERqmwpNozFScsXV+rtlGPV4z/m0vhZc6dFzIci2hVu0qJmkwvITSJe/QDeYNOb5jOg
         Ird0k96Adj/LQvs1LRWB5ayNXN4hMyJlU91GqA1Pya00ZUY9VoxfcLbR9grdmE8PtCPd
         9adlrPX7BvmQ4Bf7atGgxK88IW5utAg55eEbnC+DwqvpScI6SLVt2LnNQyckflYifH4Y
         RvpQ==
X-Gm-Message-State: AC+VfDyC7ijBdzrv5Q6pbHw8aRJ1aSvXCVZdAvTDjCkWT/R2fZw/AREp
        Fgd+TY0wNkE0sXbaggzf2xY=
X-Google-Smtp-Source: ACHHUZ7EupZuYIVvL1viWsa0karFPihZ6a8yEROlmm/o2ClM0XYp84OVrrKqrymy/4ewZsy+XCS3Sg==
X-Received: by 2002:a17:907:6d81:b0:94d:69e0:6098 with SMTP id sb1-20020a1709076d8100b0094d69e06098mr19825586ejc.45.1684955468186;
        Wed, 24 May 2023 12:11:08 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c519:9c00:cd4b:d130:35c7:5e08? (dynamic-2a01-0c23-c519-9c00-cd4b-d130-35c7-5e08.c23.pool.telefonica.de. [2a01:c23:c519:9c00:cd4b:d130:35c7:5e08])
        by smtp.googlemail.com with ESMTPSA id b2-20020aa7c6c2000000b005066cadcc54sm212302eds.43.2023.05.24.12.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 12:11:07 -0700 (PDT)
Message-ID: <8e4b2ebb-9dd9-5d30-673e-7794a50fd8b1@gmail.com>
Date:   Wed, 24 May 2023 21:11:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pwm: pwm-meson: fix handling of period/duty if greater
 than UINT_MAX
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
References: <1d1a8ede-e789-bc4d-2dcd-9d06d2df4061@gmail.com>
 <CAFBinCCeh1eUo1=pfqmp4F7UsuKZ--cja-16mCqBhV-cgodzqw@mail.gmail.com>
 <f6b93fcc-ca5a-43ae-729d-38338ba411bc@gmail.com>
 <CAFBinCDdDcFaekrdC33_cO_TngRhMTgqgpFR2ELjEcavd-8SyA@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAFBinCDdDcFaekrdC33_cO_TngRhMTgqgpFR2ELjEcavd-8SyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 23.05.2023 22:51, Martin Blumenstingl wrote:
> On Mon, May 15, 2023 at 10:32 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 08.05.2023 21:46, Martin Blumenstingl wrote:
>>> On Wed, May 3, 2023 at 9:58 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>> state->period/duty are of type u64, and if their value is greater than
>>>> UINT_MAX, then the cast to uint will cause problems. Fix this by
>>>> changing the type of the respective local variables to u64.
>>>>
>>>> Fixes: b79c3670e120 ("pwm: meson: Don't duplicate the polarity internally")
>>>> Cc: stable@vger.kernel.org
>>>> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> Not sure about the process in pwm subsystem: When will these patches make
>> it to linux-next? Because I'd like to submit follow-ups with a dependency
>> only after pending patches have been applied.
> I'm also not sure. Personally I would take all patches that fix the
> existing driver code, bundle them into a series and re-send that
> (collecting all Reviewed-by, etc. along the way). The idea is to make
> Thierry's life easier as he just has to apply the series (no need to
> worry about the patch order, ...).

Sounds like a plan, I think I'll follow this suggestion.
