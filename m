Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300AA6E2AB4
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Apr 2023 21:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjDNTje (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Apr 2023 15:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNTje (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Apr 2023 15:39:34 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F0149EA
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 12:39:32 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50685f1b6e0so655768a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1681501171; x=1684093171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOUCnEhiDn9WO9Wj97pnKuh3/rJWPv57bu1ARRp0RwI=;
        b=HJQS/icdi5x4jS91dUpb6gdjgmoP4TP+3VSr6r0POjnslRTT3xdJ/vnI4VLpa7iC0o
         DL3YTmT8GbneLc/Gbr1VA4xT8I7Id/yP3h1ziUI2C7iNUyaD+M4moC7UlGqC4qvF39d5
         YW1bxwKmyhOGtUQvm+O1saExy+zMR+ILlNZ+wiCGv+EUKb+x1X7blDWEos8pPvQS2UMq
         hnwGfet1tT71lOQDWT+UDixuiMdl8Wb7ka2s6UDNIsCEc/trlQYNmxBjkPIQ1scJIZm2
         MAT/o0b/bHLZCYIq/A1pu874es6mabUYsxWx1PCE8C+jpkXrahpYi/GP04uLqa9ZfbGf
         cBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681501171; x=1684093171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOUCnEhiDn9WO9Wj97pnKuh3/rJWPv57bu1ARRp0RwI=;
        b=J7IYJAAcLtspfczYTWqEoQ7MjRYdZeG/laYyAjgmgldzultQ1NNJoQdHJ2mDxBYTTz
         T+eHk/y6+cq6LY2qLQtvKTt1gt/wz0KW0t6CZZxOvD3cBQoAcaZ2B6e5nmpLzdk6SoGz
         XBHpx9dypxfdiDlN2DyKLoTa/gn0h+YXEJmMMu9IjMrO9ZApW6KPJtO+h1WP1KUzN7tx
         O1/XFhlbvVY3lr+MR9BNwEBWQHn2UIiyX1RaTyRbdmut+9X65M7VtzWF0zfo2vN4IpJr
         ZxrvQ9H6MmjwC1bCvm4qD4P1SlqGWnvXl2vEet//ogVvtZA39XG5TiJSyy6ROYOI+wpB
         fAtg==
X-Gm-Message-State: AAQBX9cUw08EQBcdjAEJTjahg0YV83n5BqH/eODYTzL5XoKzyRD7wIvO
        qTkKnqKRHWzdCacMrNGzrokdkULTDxjUMzdXqoc=
X-Google-Smtp-Source: AKy350aOcGRUdnjHrdFZhalOBxp4kTr1zQnbUAi69XwVgFFazQRQ74ID+kdnjS8NgtA1ov6R2/PZCLHq6F6LZmQcYA0=
X-Received: by 2002:a05:6402:1489:b0:506:8dba:bd71 with SMTP id
 e9-20020a056402148900b005068dbabd71mr935285edv.27.1681501171316; Fri, 14 Apr
 2023 12:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com> <cb79d313-c7a2-42e9-639a-63cb5366521a@gmail.com>
In-Reply-To: <cb79d313-c7a2-42e9-639a-63cb5366521a@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 14 Apr 2023 21:39:20 +0200
Message-ID: <CAFBinCCzMdQZ4mDF7SEZKHc01MPSepxdzYa+j7G-qDXe5-kBVA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] pwm: meson: make full use of common clock framework
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Heiner,

On Thu, Apr 13, 2023 at 7:55=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
[...]
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Unfortunately I have some bad news and I need to take back my Tested-by :-(
Previously my test was: cycle through all available CPU frequencies
while stressing the CPU.
My assumption was: if the system doesn't lock up everything's fine
because we have a high enough voltage.

This evening however I got a memory corruption error while trying to
log in via UART - which I thought was strange.
So I connected my logic analyzer to my Odroid-C1 and did some experiments:

period =3D 30518, duty cycle =3D 15259 (typically used for the 32kHz
output to the SDIO wifi chip)
before your patches / after applying your patches:
PWM: duty cycle: 50.000000% / 50.000000%
PWM: period: 30.6 =C2=B5s / 30.5 =C2=B5s
Timing: Time: 15.292 =C2=B5s (65.395 kHz) / 15.250 =C2=B5s (65.574 kHz)
Timing: Average: 15.296 =C2=B5s (65.377 kHz) / 15.264 =C2=B5s (65.513 kHz)
driver debug messages with your patches applied:
fin_freq: 850000000 Hz
period=3D30518 cnt=3D25940
duty=3D15259 duty_cnt=3D12970

Then I tried period =3D 12218, duty cycle =3D 0 (typically used for the
highest CPU voltage):
before your patches / after applying your patches:
PWM: duty cycle: 0.338983% / n/a (constant low output)
PWM: period: 12.3 =C2=B5s / n/a
Timing: Time: 12.250 =C2=B5s (81.633 kHz) / n/a
Timing: Average: 6.148 =C2=B5s (162.668 kHz) / n/a
driver debug messages with your patches applied:
fin_freq: 850000000 Hz
period=3D12218 cnt=3D10385

Finally I tried period =3D 12218, duty cycle =3D 12218 (typically used for
the lowest CPU voltage):
before your patches / after applying your patches:
PWM: duty cycle: 99.661017% / n/a (constant low output)
PWM: period: 12.3 =C2=B5s / n/a
Timing: Time: 12.250 =C2=B5s (81.633 kHz) / n/a
Timing: Average: 6.148 =C2=B5s (162.668 kHz) / n/a
driver debug messages with your patches applied:
fin_freq: 850000000 Hz
period=3D12218 cnt=3D10385

After seeing the constant low output with period 12218 I realized that
my previous test was no good: the CPU was fed the highest possible
voltage all the time.
It's not clear to me why period 12218 would give no PWM output at all
while period 30518 works fine.
I did an experiment by removing CLK_SET_RATE_PARENT from the divider's
init.flags -> now XTAL (24MHz) is the only possible clock (it's the
hardware default). It does indeed bring back the exact same results as
before (where the XTAL clock was also used; with the changes from this
series FCLK_DIV3 is now chosen, which runs at 850MHz).

Do you have any idea what could cause this?
The FCLK_DIV3 input seems to work as otherwise period 30518 would also not =
work.
The calculated values also look sane, so it's not that we have some
32-bit overflow (as I'm testing on a 32-bit Meson8b SoC).


Best regards,
Martin
