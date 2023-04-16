Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6430C6E3B87
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Apr 2023 21:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDPT07 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 16 Apr 2023 15:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjDPT06 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 16 Apr 2023 15:26:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731B82123
        for <linux-pwm@vger.kernel.org>; Sun, 16 Apr 2023 12:26:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id xd13so24913240ejb.4
        for <linux-pwm@vger.kernel.org>; Sun, 16 Apr 2023 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1681673215; x=1684265215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Zvi7xXB7d3Skv4cg+fSfi8Z0mY25ZNLv9NUpsbKDPk=;
        b=Oc2La1hoWCL76+LxZ4Ujn1RrJhAOCSMrKRsNeGKFPX3164juSeUPlFAIapK6YLfuxI
         gqtNqwcXPLpOH/9PmgZAGJF3N80ndnEk1P25LnakCHReCtDUQSmr5DoqjR/pmqy998mP
         5L5ZDzdiD3cl+Jj+iPMDGaQj8BJPK/TkZiecChXe00s512Nz+qUvhmxMjBiQob4QIOzb
         q0Byuxoy16zW17XKIApMfGzMwuiYBFVkt7ILeGhtvfkPrjU0AAeEbj6AwOjmllzi78Ir
         ZgyjzeUPJAj1TbtFnZ5hK0/iM+7Yol8ZIgxx3jGM02vXg8CwkeF2AXuQKqNx1fTtoI1d
         bC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681673215; x=1684265215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Zvi7xXB7d3Skv4cg+fSfi8Z0mY25ZNLv9NUpsbKDPk=;
        b=fy92Bb2n9mxL+jsfihw8fpu9RX50Ehxbg+GBlPMjLjzxdgHHhFf76OfPtq4AddhwT9
         LLjodahSvV1Zo3QtqzCuF8KVMWWDU54nPDDBvVhmwCjGIT1YWhYQF8zKsiZ/7dD/AyE9
         Sxcuwm+m8pCgP2j+Gw3J3xkMiGwMiQAXbWdoGzFzOnizhGf66NxZtjpQa+Cc7vn+KuIE
         cXjwJGd41EFHvitlh1s835O4/6dfaYypzDyavL1gZA64i2IlSwxinx33ziJXxCrjwNMT
         lqzM6s0qkvUKcKtxXmd9pDWJmBDKWNNu+C3sg8YG7YZw4TX4FrnP9DI4l1ce3VVZ82fs
         Q+RQ==
X-Gm-Message-State: AAQBX9cq1IaRt8Mq2o5PlcMA+1sYXoq0Wib3lps7Upw7/DerpSAyxA1V
        4f7fyz+n7BManS1Cb3n+c+TnpChyAoSYWcfznKs=
X-Google-Smtp-Source: AKy350YTAwoK+nVnrhCWR45EmnO1LDfk4dEsdNk9NI7vGk6knkk+cKl4kftmVR3zY6sOkEvpURXA6q08FjZY+cbN3DA=
X-Received: by 2002:a17:906:7f99:b0:94b:d57e:9d4b with SMTP id
 f25-20020a1709067f9900b0094bd57e9d4bmr5480278ejr.2.1681673215415; Sun, 16 Apr
 2023 12:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com>
 <cb79d313-c7a2-42e9-639a-63cb5366521a@gmail.com> <CAFBinCCzMdQZ4mDF7SEZKHc01MPSepxdzYa+j7G-qDXe5-kBVA@mail.gmail.com>
 <4b328dab-5f96-e5d0-3181-ce059d11b04b@gmail.com>
In-Reply-To: <4b328dab-5f96-e5d0-3181-ce059d11b04b@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 16 Apr 2023 21:26:44 +0200
Message-ID: <CAFBinCCxQvB_fY0r4jkwy7zW1F9s2vrxmcRaTs6hG5ay_Gf8mw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Heiner,

On Sat, Apr 15, 2023 at 8:39=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> On 14.04.2023 21:39, Martin Blumenstingl wrote:
> > Hello Heiner,
> >
> > On Thu, Apr 13, 2023 at 7:55=E2=80=AFAM Heiner Kallweit <hkallweit1@gma=
il.com> wrote:
> > [...]
> >> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Unfortunately I have some bad news and I need to take back my Tested-by=
 :-(
> > Previously my test was: cycle through all available CPU frequencies
> > while stressing the CPU.
> > My assumption was: if the system doesn't lock up everything's fine
> > because we have a high enough voltage.
> >
> > This evening however I got a memory corruption error while trying to
> > log in via UART - which I thought was strange.
> > So I connected my logic analyzer to my Odroid-C1 and did some experimen=
ts:
> >
> > period =3D 30518, duty cycle =3D 15259 (typically used for the 32kHz
> > output to the SDIO wifi chip)
> > before your patches / after applying your patches:
> > PWM: duty cycle: 50.000000% / 50.000000%
> > PWM: period: 30.6 =C2=B5s / 30.5 =C2=B5s
> > Timing: Time: 15.292 =C2=B5s (65.395 kHz) / 15.250 =C2=B5s (65.574 kHz)
> > Timing: Average: 15.296 =C2=B5s (65.377 kHz) / 15.264 =C2=B5s (65.513 k=
Hz)
> > driver debug messages with your patches applied:
> > fin_freq: 850000000 Hz
> > period=3D30518 cnt=3D25940
> > duty=3D15259 duty_cnt=3D12970
> >
> > Then I tried period =3D 12218, duty cycle =3D 0 (typically used for the
> > highest CPU voltage):
> > before your patches / after applying your patches:
> > PWM: duty cycle: 0.338983% / n/a (constant low output)
> > PWM: period: 12.3 =C2=B5s / n/a
> > Timing: Time: 12.250 =C2=B5s (81.633 kHz) / n/a
> > Timing: Average: 6.148 =C2=B5s (162.668 kHz) / n/a
> > driver debug messages with your patches applied:
> > fin_freq: 850000000 Hz
> > period=3D12218 cnt=3D10385
> >
> With a 850MHz input clock we should see a 0.01% duty cycle with 1.2ns
> clock pulses. Can we rule out an issue with the measuring equipment?
> Is your logic analyzer able to display such short clock pulses?
Oh, you're right: my logic analyzer maxes out at 24MHz (~42ns).
So we can ignore this case.

> > Finally I tried period =3D 12218, duty cycle =3D 12218 (typically used =
for
> > the lowest CPU voltage):
> > before your patches / after applying your patches:
> > PWM: duty cycle: 99.661017% / n/a (constant low output)
I have to correct myself: for this case my logic analyzer sees a:
constant high signal

> > PWM: period: 12.3 =C2=B5s / n/a
> > Timing: Time: 12.250 =C2=B5s (81.633 kHz) / n/a
> > Timing: Average: 6.148 =C2=B5s (162.668 kHz) / n/a
> > driver debug messages with your patches applied:
> > fin_freq: 850000000 Hz
> > period=3D12218 cnt=3D10385
> >
> Here I have no idea yet.
[...]
> At first I'd like to verify that the registers have the expected values.
> Can you provide the values of PWM_A/B (depending on which channel is used=
 in your
> case) and PWM_MISC_AB at the end of meson_pwm_enable()? Thanks!
I'm testing with PWM_B and I get:
  REG_MISC_AB =3D 0x008000c2, channel reg =3D 0x28910000

This register value looks correct to me.

This is now my last line in meson_pwm_enable() in case you want to
sanity-check what I did:
dev_err(meson->chip.dev, "REG_MISC_AB =3D 0x%08x, channel reg =3D 0x%08x",
value, readl(meson->base + channel_data->reg_offset));


Best regards,
Martin
