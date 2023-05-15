Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10478703EA9
	for <lists+linux-pwm@lfdr.de>; Mon, 15 May 2023 22:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245392AbjEOUcw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 May 2023 16:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245277AbjEOUcv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 May 2023 16:32:51 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36AED85C
        for <linux-pwm@vger.kernel.org>; Mon, 15 May 2023 13:32:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3078aa0b152so7095450f8f.3
        for <linux-pwm@vger.kernel.org>; Mon, 15 May 2023 13:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684182767; x=1686774767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+een/p0Ou4xLIJ2JP/3dkDdNQUrW7bUdZBp+xlR4Eow=;
        b=a2ydbiH0IDuT1qZ9C7P5xNT7cP0ixiWcyuKGMPFSF1zeHcG3tM4vYafA/Y+5r+eM/T
         KvNg60DlCHCtKh648iIwUeztt8b1Lv+WJsbG+37AWMGGenma4IHZmjvdh0Hy2rEb+eOE
         +kZXzc7oiDWLxLjmouWZUyUwdm0n0Zm5jBFTLD7S/QxU0oUhECBDxFOYwKbx8K2e3eVm
         ZiuNqor/yki8ldRgX7lP1k5/L4MgskkfkNvuiEEqOtSS3VYYHVtirCi2nlB2JdQL/Khq
         y/FH3iXCCJ4SBpbbq/3xpq2hYNHqhfpork2DO4CyBgKo7JVVZGSgbA/XQxcwZPvfuOFF
         SnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684182767; x=1686774767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+een/p0Ou4xLIJ2JP/3dkDdNQUrW7bUdZBp+xlR4Eow=;
        b=BGL2SOYwYIbRWSU2KUqkHa+iiGoeaLsWTn5cgdbbZ/lJoDhMo5rcoHxKZ76SJrmn6C
         2rJLCUgmOVHFUAMYYLt3cdmhWkPg3E8PSN6IZfiayx9wrLmt43DffQBQNEohP0+5+zb7
         l8YSKE9nz8/qey6nWiXTPlMQxlcKNpet6+0x81sitkR7nmEUmFp2D8cu04w+ggyf4w66
         fhdJnmzKmImbBTjtoqKt6icUT2EpLJtHmyB7E+vcwTNkyKM4qeKw1/R3P7clRi2svEz0
         rpxk7rfrwnhmC7RDsGtE/jJ4SkIdaB90+59IEdenbq5SrsAke9v6m3FkT7xY1N84xXKO
         Hq3w==
X-Gm-Message-State: AC+VfDwgqqWr23/GzGHgOsp9nX4FPeLc9hQAJFalh154ThOUfeAqGI+H
        Vop5ZU7bo7L4Oo3OAW6bRJo=
X-Google-Smtp-Source: ACHHUZ7oAEa4QeYDj9aFnVrfChSsMDlEBohSxF0u6Hy4t5M5NzJT6DzH6qlpgeKzWitAFHUk0voJXw==
X-Received: by 2002:adf:f7d1:0:b0:2ff:f37:9d0f with SMTP id a17-20020adff7d1000000b002ff0f379d0fmr23148872wrq.57.1684182766919;
        Mon, 15 May 2023 13:32:46 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bd61:5400:edba:ccd5:9cfc:1976? (dynamic-2a01-0c23-bd61-5400-edba-ccd5-9cfc-1976.c23.pool.telefonica.de. [2a01:c23:bd61:5400:edba:ccd5:9cfc:1976])
        by smtp.googlemail.com with ESMTPSA id m9-20020adfdc49000000b002fb60c7995esm250358wrj.8.2023.05.15.13.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 13:32:46 -0700 (PDT)
Message-ID: <f6b93fcc-ca5a-43ae-729d-38338ba411bc@gmail.com>
Date:   Mon, 15 May 2023 22:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pwm: pwm-meson: fix handling of period/duty if greater
 than UINT_MAX
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <1d1a8ede-e789-bc4d-2dcd-9d06d2df4061@gmail.com>
 <CAFBinCCeh1eUo1=pfqmp4F7UsuKZ--cja-16mCqBhV-cgodzqw@mail.gmail.com>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAFBinCCeh1eUo1=pfqmp4F7UsuKZ--cja-16mCqBhV-cgodzqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 08.05.2023 21:46, Martin Blumenstingl wrote:
> On Wed, May 3, 2023 at 9:58 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> state->period/duty are of type u64, and if their value is greater than
>> UINT_MAX, then the cast to uint will cause problems. Fix this by
>> changing the type of the respective local variables to u64.
>>
>> Fixes: b79c3670e120 ("pwm: meson: Don't duplicate the polarity internally")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Not sure about the process in pwm subsystem: When will these patches make
it to linux-next? Because I'd like to submit follow-ups with a dependency
only after pending patches have been applied.

