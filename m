Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F394118E19
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Dec 2019 17:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfLJQs1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Dec 2019 11:48:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbfLJQs1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 10 Dec 2019 11:48:27 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24F4C214D8;
        Tue, 10 Dec 2019 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575996506;
        bh=R33HTSexU1kbb824ncW7/1smobUzWfbTBjTiOaZwbr4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xMD67H81d0rp4JlhSYv1MoGQjhVBvSBRrcQrfvMaUV/rshK9dgLMGQgqo5z4NjcdK
         jxWfkYEMimmj7J965YbYsbYVsynwmdBWIm+UgMowjc1wUvpOwajun7sSYs3nvp7Zwx
         eDKMLOXpXw1a8WZl44k8KAsREU20jmY7ev/JU1Ek=
Received: by mail-qk1-f172.google.com with SMTP id m188so16993121qkc.4;
        Tue, 10 Dec 2019 08:48:26 -0800 (PST)
X-Gm-Message-State: APjAAAXcAIGYFvIz5lYG3Pc72HeoTNaOnwvRXFbUPoCA+CASBy09DC6z
        0KWXhsgBf0kb6wESpgfnIhYJGM+CSHiEqINA/Q==
X-Google-Smtp-Source: APXvYqx9dzG7yP7Wuz5at60Qc6xU1g9ebTuNbbK6+p8S0ZoNXrD/Xdz8GC+/TsRt7j+zA0yyIQg0bEtIgkzleZIfQv8=
X-Received: by 2002:a37:a70b:: with SMTP id q11mr13613735qke.393.1575996505147;
 Tue, 10 Dec 2019 08:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20191119175319.16561-1-peron.clem@gmail.com> <20191121072408.GE4345@gilmour.lan>
In-Reply-To: <20191121072408.GE4345@gilmour.lan>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 10 Dec 2019 10:48:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJevcG2qv+BYKTnP=out0jPxuEcdYuLq7idxK04Q05fag@mail.gmail.com>
Message-ID: <CAL_JsqJevcG2qv+BYKTnP=out0jPxuEcdYuLq7idxK04Q05fag@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add support for H6 PWM
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 21, 2019 at 1:24 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Tue, Nov 19, 2019 at 06:53:11PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi,
> >
> > This is a rework of Jernej's previous work[1] taking account all the
> > previous remarks.
> >
> > Bindings is still strict but probe in the driver are now optionnals.
> >
> > If someone could confirm that the PWM is not broken, as my board
> > doesn't output it.
> >
> > I didn't add the acked-tags as there are big changes.
>
> Applied 1 and 7 for 5.6, thanks!

I believe patch 7 breaks linux-next:

Error: Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.exampl=
e.dts:35.37-38
syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm=
.example.dt.yaml]
Error 1

Usually that's due to a missing include.

Rob
