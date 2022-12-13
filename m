Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33C064B721
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Dec 2022 15:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiLMOTH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Dec 2022 09:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiLMOTF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Dec 2022 09:19:05 -0500
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1595715A2D;
        Tue, 13 Dec 2022 06:19:04 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3b48b139b46so192980297b3.12;
        Tue, 13 Dec 2022 06:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stUPhAmsFLnwiVT4OmpK0u4KbKXDU9HwwZGKx71HwVY=;
        b=Zk69aHCO+M0XK7JOemUXNebGDq7hybxp0hrx8oAAJvMMkD3LQb2xSLVQut2aeARn3U
         40D5wgh9cSct0iKr9I5CoKmMkfl5nLZRbZ4ujATCYuC/VwIYD/jWJV50+Xw9uOJMzpwu
         cYD3qmJJbsFBeADNLunc5W91SQmwI73pD6t43V3BnirkYw+TwJ4QzsLavTsOcVDkNgl9
         zj91elKjmz37x4Dy2K2HMjkD46n7JrPoIoaZAvEQYlpjCEfVtWxvAMlD3hXhFuf7k53x
         wsWkqGG0BPcSDAz4bNDb/M9Wa3NoPvFrglennNBtNTidWml+o/H/P9pCOe68z6j9yi+3
         OmaA==
X-Gm-Message-State: ANoB5pn9eDDlmlocB7BCGBbqp1lHI1Agupeyb0bL9ApCrUMNFhCd4jJt
        0y7gC6sLSb5QJ4ejqYGVj7w8yB9sSwGUPA==
X-Google-Smtp-Source: AA0mqf52E2xEsbn5HS1O5B7A9Sdz/479+T2uMpDvvxZxGbmAZ4PoFZRNCoBrJKUIYL0XOo8HpQQgPg==
X-Received: by 2002:a05:7500:1814:b0:ea:6b4b:4100 with SMTP id ci20-20020a057500181400b000ea6b4b4100mr2082604gab.8.1670941142646;
        Tue, 13 Dec 2022 06:19:02 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id j4-20020a05620a000400b006fba44843a5sm7653766qki.52.2022.12.13.06.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 06:19:01 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id s11so17764316ybe.2;
        Tue, 13 Dec 2022 06:19:01 -0800 (PST)
X-Received: by 2002:a25:7104:0:b0:702:90b4:2e24 with SMTP id
 m4-20020a257104000000b0070290b42e24mr13213086ybc.365.1670941141531; Tue, 13
 Dec 2022 06:19:01 -0800 (PST)
MIME-Version: 1.0
References: <20221124191643.3193423-1-biju.das.jz@bp.renesas.com> <20221124191643.3193423-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221124191643.3193423-4-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Dec 2022 15:18:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVTq5zgJL40Dbisw0as7ei0c+asHABMU=8tBEpTR+2YfA@mail.gmail.com>
Message-ID: <CAMuHMdVTq5zgJL40Dbisw0as7ei0c+asHABMU=8tBEpTR+2YfA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] pwm: Add support for RZ/V2M PWM driver
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Biju,

On Thu, Nov 24, 2022 at 8:17 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The RZ/V2{M, MA} PWM Timer supports the following functions:
>
>  * The PWM has 24-bit counters which operate at PWM_CLK (48 MHz).
>  * The frequency division ratio for internal counter operation is
>    selectable as PWM_CLK divided by 1, 16, 256, or 2048.
>  * The period as well as the duty cycle is adjustable.
>  * The low-level and high-level order of the PWM signals can be
>    inverted.
>  * The duty cycle of the PWM signal is selectable in the range from
>    0 to 100%.
>  * The minimum resolution is 20.83 ns.
>  * Three interrupt sources: Rising and falling edges of the PWM signal
>    and clearing of the counter
>  * Counter operation and the bus interface are asynchronous and both
>    can operate independently of the magnitude relationship of the
>    respective clock periods.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Replaced devm_reset_control_get_optional_shared->devm_reset_control_get_shared

Thanks for the update!

> --- /dev/null
> +++ b/drivers/pwm/pwm-rzv2m.c

> +static void rzv2m_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +                               struct pwm_state *state)
> +{

As of commit 6c452cff79f8bf1c ("pwm: Make .get_state() callback return
an error code") in pwm/for-next, this needs to return an error code
(but you probably already know).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
