Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D7C6B724E
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Mar 2023 10:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCMJP5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Mar 2023 05:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCMJP4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Mar 2023 05:15:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8ABB746
        for <linux-pwm@vger.kernel.org>; Mon, 13 Mar 2023 02:15:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o5-20020a05600c510500b003ec0e4ec6deso4298333wms.3
        for <linux-pwm@vger.kernel.org>; Mon, 13 Mar 2023 02:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678698953;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5FHHSr/bQjBDy3HwdZXbbXCk/HhY0MHE1EY7OEHrtY=;
        b=k/eBzQaDLiI+ppbciswnLUk1/Q/nI3F0q7VKQTg1HM+YOZDTSH2mJvjZ45HvlR3WIp
         jj172mCZ/I36shWovWfENe/QWsX1LOQJLZtnQBWgrhVSohvVtx9zcEImLpEFMVAnXb7j
         J0jfU2xljLsntw1HSoQjaxkeN7LDWtONsXiIobTlDi/CLs1VrCcea5WyG4k4u03mVSSm
         Ex2voRCD7hmy761rp+oUXWFxl0HrdsM3gKo8k6a6Sz3gvRlwmVH1m8UjYOg7UwoCG1G8
         A76J/JNZYJR1bkqAdbGbkfToTnu1qwo0Wi8ZNvk+SxaUHzlVWFX9SKExm3JVsr07xi+H
         I7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678698953;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F5FHHSr/bQjBDy3HwdZXbbXCk/HhY0MHE1EY7OEHrtY=;
        b=dqtoP/XfDG8Fyrqf7UIS1FP0p+nmc6y323xhpttfQm6cdAlY9KjS7U2qxoyobm1HK2
         aCQ2xaMrvfQuoIwcwvMrbbxX0MOYqtSt5wAjRzoku2s4MvGEAU2Bjl+gu4Z9zordCfGj
         aQsSgJulW+fhDxKUdwQmw59Hq4gAZ00Mvf9Ymc5/VQnj/cpiS0kYgcNIrkYTd6vNjS1r
         lHJkYJZXKrzfqWT3Pcp6KvoX0dJrFVqC7obCZTxGvJe5iYIMo5OEfQyU2P+CmjnhCteK
         FBeAhyt+1mAxEcSyQvq4MsWieq/m4K24VW0SRA617eY3r3GtM50UwpT7P4Y1B8yOHngU
         uPjA==
X-Gm-Message-State: AO0yUKV3yh6bx/7UEpsOmGx2n6iWnpALhXjURBFk7z0cMzctzld3c8xc
        IeTkz2zcEOrodmAel9wV6avdSA==
X-Google-Smtp-Source: AK7set/EUlnB+P4G1PeUvV4Uifr31ytj2e78GmoiTgxXdZ8bti6uHzbihraHjlE1c26MSH5PAFq0sA==
X-Received: by 2002:a05:600c:4f50:b0:3eb:32ff:da8 with SMTP id m16-20020a05600c4f5000b003eb32ff0da8mr10038843wmq.16.1678698952887;
        Mon, 13 Mar 2023 02:15:52 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c359600b003b47b80cec3sm9231715wmq.42.2023.03.13.02.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 02:15:52 -0700 (PDT)
References: <20230310191405.2606296-1-u.kleine-koenig@pengutronix.de>
 <CAFBinCCfqgBkHq2fFy=d+8C6nwq=wehu9nzePfwuY5ndfLMWoQ@mail.gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Munehisa Kamata <kamatam@amazon.com>, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: meson: Explicitly set .polarity in .get_state()
Date:   Mon, 13 Mar 2023 10:07:48 +0100
In-reply-to: <CAFBinCCfqgBkHq2fFy=d+8C6nwq=wehu9nzePfwuY5ndfLMWoQ@mail.gmail.com>
Message-ID: <1ja60h106q.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Sat 11 Mar 2023 at 22:00, Martin Blumenstingl <martin.blumenstingl@googl=
email.com> wrote:

> Hi Uwe,
>
> On Fri, Mar 10, 2023 at 8:14=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> [...]
>> There is a complicating fact, that the .apply() callback fakes support
>> for inversed polarity. This is not (and cannot) be matched by
>> .get_state(). As fixing this isn't easy, only point it out in a comment
>> to prevent authors of other drivers from copying that approach.
> If you have any suggestions on how to fix this then please let us know.
> I don't recall any board needing support for inverted PWM - but they
> may be out there somewhere...

AFAIK, PWM are essentially used for the SDIO 32k clock and voltage
regulators. I don't recall seeing anything else.

It should be safe to change polarity if necessary, except for the DVFS
PWM regulators maybe ? I fear that if we change the PWM setting it might
trigger a glitch on the supply and possibly stall the CPU.

That being said, I don't think there is any particular care regarding
that right now, so maybe it is fine.

>
>> Fixes: c375bcbaabdb ("pwm: meson: Read the full hardware state in meson_=
pwm_get_state()")
>> Reported-by: Munehisa Kamata <kamatam@amazon.com>
>> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
>
> Best regards,
> Martin

