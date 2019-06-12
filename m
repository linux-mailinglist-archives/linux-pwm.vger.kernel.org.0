Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFBF43065
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 21:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfFLTrU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 15:47:20 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37263 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfFLTrT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 15:47:19 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so12610499oih.4;
        Wed, 12 Jun 2019 12:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EwdJu4okQ0L+2u52FXeBDXEGzF/ps8ei03aC+UR7txM=;
        b=jCItuHIqjcFP/izwsSFnf5iZ4EN8OEZMF4/+XoTAcFGTIvjn8FEFSDtrZZEXarIJht
         XFvZdFpsTYx2UKP8PreoZMEQCIurJCAtxHYRQnD1cDiUz4rMk9IZ5jwLjsMkH6YwbfV8
         JK7juYY/NCn4SQ+bolXDhhhULZdOmNaiTFX6lctDPTgbJ6gXu4x0ppbCc25UIyEGVQtp
         oUF9u4OeEsxLsGYmWkYR/KK1cMA1rXxJ0a5UKjCDFAyN28VcUBpUKp09Cc2KrkGEUmwm
         uhHb8XCubFuUi3Xf0TqPGnVSzGzpC6kjENt0cAfNwGqVy32ibiYbhHmkyb1DMkDKOBAr
         C6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EwdJu4okQ0L+2u52FXeBDXEGzF/ps8ei03aC+UR7txM=;
        b=gXvgu8JXznQEOFUpkx3VQfZjre+qsxVSkSBWDeUeBCAx+ys68pIDj4Ks4FFIp4e/EJ
         h+29HGMkoN60nArVODe7tR82MRa/3xynbqA2OEyay4xYMVsr/WVf8i+opHErm/x2Ve5s
         5aJVYFFiNZYiFbOCaKfTPDrj1QfA+tr4+S2r/S3B3SD+xOtBL8WLlZ1hnkEnazyYlHB6
         rHPU9ch8Ec9RjpgBdQ3lN9pJ0cdLMfEEOrlq1s76JLnqGtTyN2c+Jh/BsdZM2mKCI6Xr
         KI6KmB8WhZB7+6Uu90vdrx+NMy4sC+EbyxqTjDq0S4y75Cn6lKc9NP0b9wNrP5/VFLRv
         bVkQ==
X-Gm-Message-State: APjAAAV6COKj6NLHhODnvxQeOxKTcs5CoINdV83wKQno45B4DnQlaWnr
        auVjru0VupKoyars4LLFR8Dlgmrj8npApSvu+VU=
X-Google-Smtp-Source: APXvYqxI6uMKFy/wojvtvvvIYK/SGmxdGD9fTWk5+T6YyUI+oS3PdPTdR1rtH6s0f//6So6WdhsACfIUlxQ2vDXFdDk=
X-Received: by 2002:aca:f144:: with SMTP id p65mr598979oih.47.1560368838921;
 Wed, 12 Jun 2019 12:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
 <20190608180626.30589-5-martin.blumenstingl@googlemail.com> <20190611163318.tfb5c4jbekjybj76@pengutronix.de>
In-Reply-To: <20190611163318.tfb5c4jbekjybj76@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 12 Jun 2019 21:47:07 +0200
Message-ID: <CAFBinCA1SVXVPJdLQr4S99qEoowqXsNqP5tr64xn46xjaKLqeA@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] pwm: meson: change MISC_CLK_SEL_WIDTH to MISC_CLK_SEL_MASK
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Tue, Jun 11, 2019 at 6:33 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
[...]
> > @@ -463,7 +463,7 @@ static int meson_pwm_init_channels(struct meson_pwm=
 *meson,
> >
> >               channel->mux.reg =3D meson->base + REG_MISC_AB;
> >               channel->mux.shift =3D mux_reg_shifts[i];
> > -             channel->mux.mask =3D BIT(MISC_CLK_SEL_WIDTH) - 1;
> > +             channel->mux.mask =3D MISC_CLK_SEL_MASK;
> >               channel->mux.flags =3D 0;
> >               channel->mux.lock =3D &meson->lock;
> >               channel->mux.table =3D NULL;
>
> IMHO clk_mux is ugly here. It could easily just take
>
>         .mask =3D 3 << mux_reg_shifts[i],
in most cases that would be even nicer to read because it could be expresse=
d as:
  .mask =3D GENMASK(5, 4)

so I like your idea in general
though I think it should not block this patch

[...]
> Apart from that, I wonder if the pwm-meson driver should better use
> clk_register_mux instead of open coding it. (Though there doesn't seem
> to exists a devm_ variant of it.)
I tried to use clk_register_mux in the past. it works but it's not as
nice to read as the open-coded variant because it takes 10 parameters.
I find it easier to read 13 separate lines compared to reading a
function call with 10 parameters


Martin
