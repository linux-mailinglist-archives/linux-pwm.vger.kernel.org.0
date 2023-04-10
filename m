Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FC96DCD58
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Apr 2023 00:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjDJWP3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Apr 2023 18:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDJWP2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Apr 2023 18:15:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F241BD
        for <linux-pwm@vger.kernel.org>; Mon, 10 Apr 2023 15:15:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id qa44so15410309ejc.4
        for <linux-pwm@vger.kernel.org>; Mon, 10 Apr 2023 15:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1681164925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hfj7/mw500k5uSlkcGcb+oM3JnnDYjZ70qofUQEdXQ=;
        b=hIhZ9xj5hQb2Xh/2rQL9QRO56kRJGEia2ysvhYsVwsunfOBUTYwCP9kGDxsszzNRLO
         Ub+dY3tHKpfO6guJJr9g7DwPOYls4dzJLYrwsUZHI/zSAI0dW6sm7E8ZCt9GrvVMM0DP
         AaM6rM/WXYpBY/brImhdu0Jd84MfScnvNWm9c5HdB7rqCITwAVXyxfbbM2e0p7tCrn0p
         ct2PgpzbkdUzL6teRP6ZkMld26vjtTiXUqLmRc2nQjZ7GFHrVlPzifSeTBQS4qR1q4TF
         3V34hgeVWiBI376KZXogsyIoZg3wk7HR7+DYqmgLUUmlxzbjfKpZV1BcBaFA8r2OPjvX
         Fo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681164925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hfj7/mw500k5uSlkcGcb+oM3JnnDYjZ70qofUQEdXQ=;
        b=LDxgP4xt8ysGvITTh6/sglEeYMWOGtDnLG2GAXZaBY70sqy/qL/OqN2E0JA9qDHRDr
         3YeqlGkSUOyFmRItu9RsWi0z6oERLatGAA6nak23oStIyRORUPUb1agz2Fd8fFb8jUcj
         cAiHW3CAveFI6Y3Npb369v90+G2eugzbqyswToLrWq7Hhp2A1p6Qty1/v03lsg5eK3sq
         pk5wqRLm1Z0qXXRDy2x/BaflyEfH4Yip6RajFiY9Z50q777MZcaiZ94g29umr2WGVyD1
         dwxHtpngCVHfQFsKNDIPqMsm2/y+EVe1FlGMXh8Vcs/wwWWOGwT0kBrw5WHvZksSKXjE
         O0gA==
X-Gm-Message-State: AAQBX9fn80MxyfFlEnHj+KOa4IGq+xIZVSx6mt38ydb2qo65yKel9kPf
        37K39sJMQe46hn2aoEOHj4pxodRAwj3fUbj5z9Tq6cAo
X-Google-Smtp-Source: AKy350a5qqn/pJ4fLRWDXQqKSK2V40WfFfi/EV0aULAfXD+oNJpf7SkkA6LhPVJwCunzAJkaegEJihN+2tn1+mlz5p4=
X-Received: by 2002:a17:906:2a48:b0:920:da8c:f7b0 with SMTP id
 k8-20020a1709062a4800b00920da8cf7b0mr4364666eje.6.1681164925575; Mon, 10 Apr
 2023 15:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <275c72a8-b9cb-e675-f1c0-4da658c3f98e@gmail.com>
In-Reply-To: <275c72a8-b9cb-e675-f1c0-4da658c3f98e@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 11 Apr 2023 00:15:14 +0200
Message-ID: <CAFBinCBw3KdTTAx+nm6sphOgU-vx2qFswofnwU8ZgxckE+hH2g@mail.gmail.com>
Subject: Re: [PATCH 0/2] pwm: meson: make full use of common clock framework
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Heiner,

On Sat, Apr 8, 2023 at 10:40=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
[...]
> I don't have hw with the old PWM block, therefore I couldn't test this
> patch. With the not yet included extension for the new PWM block
> (channel->clock directly coming from get_clk(external_clk)) I didn't
> notice any problem. My system uses PWM for the CPU voltage regulator
> and for the SDIO 32kHz clock.
I do have some issues with my Odroid-C1 board (it doesn't detect the
eMMC anymore, while u-boot does).
This unfortunately means that I currently cannot test 32-bit SoC
support at the moment as I am running out of time for today.
I'll bisect this issue in the next few days and then continue with
testing. So sorry that this is taking longer than expected.


Best regards,
Martin
