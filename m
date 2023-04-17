Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B8F6E43D5
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Apr 2023 11:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDQJ2R (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 Apr 2023 05:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDQJ1l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Apr 2023 05:27:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303721BE1
        for <linux-pwm@vger.kernel.org>; Mon, 17 Apr 2023 02:27:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f16ecaadd1so11188925e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 17 Apr 2023 02:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681723643; x=1684315643;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skr4F3sTXuTG1y8kpEW9y6PuSOyN9BupGiKr5TWOkDY=;
        b=qWFSkMjcj40qUAAl6SEps/M542l+4X+C2iqNfhp2Hm9NHgczgel13Pd5y0bFPMtYo9
         kC/TjlOwIvQgfR/xwjT90OqnflRItpYzWQg3AFUEm6496zd+Lp2T2jdObIaw9sb3T10a
         EX7/wM8AjJXPLKfS9S8ly+/V49pzuvmQIhcDn82iwRRiV9lqhg5bXxAAEnvOY+KxNiGa
         wUQPbGP0YjHEODy283iBtHa7kEOM0UePhZ7vBCt7SIMYnDRodQQWIRCmf3qqI9T/Y97F
         6yegnnPZpUBtNBiCxyhynZ0kvS+ZY5v3ASbHGSn1slrBWaa+neXsHUvtxlk1koIacN7H
         EDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681723643; x=1684315643;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skr4F3sTXuTG1y8kpEW9y6PuSOyN9BupGiKr5TWOkDY=;
        b=JznLfQbRSE6SALfdJk4+F8KI0s1EL3zp0zShCeFss+4XmkOQptvhCMtx29rEohWjoj
         ZYd3f68JpzqDiwposjs1XkIvIucNRgQVSulV1ozUc9uHbDqz+nW3D/jIiwaxuNw4BE4M
         1vO2olLO5SG5M9RK8eJb/7KifpnssAlYPHBMaLZzPZDgc9FUJ7kIOTB290lo9tNXEhb9
         dOYBMDEpgV8I+5PwVmgHvaVVJBQfGBUwn/pjWhGA7cv93FmJeN2f3EWkM4jJwOJkpPC8
         yIM07hpaLzcuc84EMv87VnqTZ6N9hayucruvWXeBU728Mc3KbAKSfbQIFBxy0IFqRMIo
         Odcg==
X-Gm-Message-State: AAQBX9fcjKQRM5c0jfPxpsWenAKeLQuzNwFyXfrjJF1YJ1WpOojE6RG0
        2+gfg7bBYKs3XiCIpYaeewk=
X-Google-Smtp-Source: AKy350b+1l8cy3AQywzBIVAvVcyfLEguCcUrXMWznl2I3n3mvrFNMDiniK+zuJ7a+ruW4FOsjxekaw==
X-Received: by 2002:a5d:6a0c:0:b0:2d2:f3e3:115d with SMTP id m12-20020a5d6a0c000000b002d2f3e3115dmr5352998wru.59.1681723643413;
        Mon, 17 Apr 2023 02:27:23 -0700 (PDT)
Received: from orome (p200300e41f053a00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f05:3a00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g23-20020a7bc4d7000000b003f17300c7dcsm3313242wmk.48.2023.04.17.02.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 02:27:23 -0700 (PDT)
Date:   Mon, 17 Apr 2023 11:27:21 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 4/4] pwm: meson: make full use of common clock
 framework
Message-ID: <ZD0Q-fUjMKRrPjXn@orome>
References: <0f087629-810d-f0e0-bf0b-05ca5defc16d@gmail.com>
 <05e3b9de-ee38-97b6-7f39-5b6f7de1674f@gmail.com>
 <CAFBinCAdXE+3VrPJAoik_0TFW6TsB0033s+fTYUTNehPrn=PZg@mail.gmail.com>
 <ZDfHtvZawSWWGTRP@orome>
 <CAFBinCBNA_AWy63P9RwSU98xNJ1-F8KHJWm9Dq1kmrZ7aFbpJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NhQe1dIIe6b/8+OF"
Content-Disposition: inline
In-Reply-To: <CAFBinCBNA_AWy63P9RwSU98xNJ1-F8KHJWm9Dq1kmrZ7aFbpJw@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--NhQe1dIIe6b/8+OF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2023 at 08:33:28PM +0200, Martin Blumenstingl wrote:
> Hello Thierry and Heiner,
>=20
> On Thu, Apr 13, 2023 at 11:13=E2=80=AFAM Thierry Reding
> <thierry.reding@gmail.com> wrote:
> >
> > On Tue, Apr 11, 2023 at 09:48:46PM +0200, Martin Blumenstingl wrote:
> > > On Tue, Apr 11, 2023 at 9:26=E2=80=AFPM Heiner Kallweit <hkallweit1@g=
mail.com> wrote:
> > > [...]
> > > > +               init.name =3D name;
> > > > +               init.ops =3D &clk_gate_ops;
> > > > +               init.flags =3D CLK_SET_RATE_PARENT;
> > > As much as I don't want it: I think we need CLK_IGNORE_UNUSED here as=
 well :-(
> > > On GXBB, GXL and GXM SoCs the board design typically uses PWM
> > > regulators (like the boards using 32-bit SoCs as well as newer boards
> > > using G12A or later SoCs).
> > > This means: if we enable that PWM controller and one of the channels
> > > is firmware managed and the other isn't then we can end up disabling
> > > the clock - taking away VCCK (which supplies the CPU) or VDDEE (which
> > > supplies GPU and various other components).
> > > I'd be happy if there are other suggestions around this though.
> >
> > What exactly does "firmware managed" mean? Typically we describe all
> > supplies in DT to avoid these kinds of workarounds. If VCCK and/or VDDEE
> > are PWM-controlled regulators that should never be turned off, can they
> > not simply be added to device tree and marked as "always-on"? That would
> > propagate to the PWM and make sure the corresponding clock remains
> > enabled.
> Most Amlogic boards use PWM-controlled regulators. There's three SoC
> generations I know of that are "special" when it comes to managing
> these regulators (and CPU clocks) though.
> Let's start with the simple ones: Meson8/8b/8m2, G12A, G12B, SM1 (and
> I assume newer generations as well): here the PWM regulators are
> managed by Linux.
> Then there's the special cases: GXBB, GXL and GXM which run a SCPI
> firmware for managing the CPU clocks, regulators and suspend.
>=20
> SCPI firmware is running in the "secure world", while Linux is running
> in the "normal world".
> I don't know if there's boards with secure boot that lock Linux out
> from the PWM and CPU clock registers.
> This means: so far we've left any PWM controller settings that relate
> to the regulators up to the SCPI firmware, not messing with any of the
> registers from Linux.
>=20
> My concern is for example with the Khadas VIM2, see it's schematics [0] p=
age 4:
> - PWM_C is used to manage the VDDEE regulator (I suspect that there's
> a typo though and it should be called VDDEE_PWM_C, but the schematics
> state that the signal is called "VDDEE_PWM_D")
> - PWM_D can routed to the GPIO headers
> Now if a user enables &pwm_cd (the PWM controller responsible for
> channel PWM_C and PWM_D) to use PWM_D on the pin header we don't want
> to turn off PWM_C by accident.
> Turning PWM_C off by accident can happen if we register the clock gate
> and don't have a consumer for it. CCF (common clock framework) can
> then just turn off that clock because it's unused. This would lock up
> the board because VDDEE is used for critical functionality on the SoC.
>=20
> Two extra questions from Heiner:
> > I check regarding Thierry's comment and found the vddcpu
> > pwm-regulators described in the DT's. Is your concern that
> > not for all boards the vddcpu pwm-regulator is described in
> > the DT?
> Correct, boards that have the pwm-regulators described in their .dts
> (typically the boards using a Meson8/8b/8m2, G12A, G12B or SM1 SoC)
> are not a problem.
> Only the ones that don't describe the pwm-regulators in their .dts are
> an issue as these are managed by the SCPI firmware.
>=20
> > AFAICS pwm channels are independent. How can switching
> > off the clock for one channel affect the other channel?
> It's not about one channel affecting the other. My thought is that
> CCF's "disabled unused clocks" feature will turn off the clock if it's
> not used. Since SCPI firmware uses it, Linux doesn't know that CCF may
> disable the clock unless CLK_IGNORE_UNUSED is set.
>=20
> I hope this makes sense. If you have any additional questions then
> feel free to ask.

It seems to me like really your only option is to completely hide that
clock from Linux. Even if you use CLK_IGNORE_UNUSED, you could still run
into a situation where the clock gets turned off.

Actually the same is true of the PWM channel. Once the PWM channel is
registered somebody could try and use the sysfs interface to control it.
So even if nothing in the DT makes use of the "reserved" PWM channel,
people could still try to use it, which means that even if the clock
were to remain always on, somebody could modify the period and
destabilize the CPU.

I think reserving specific PWM channels is the only way to safely make
this work. People could still abuse this by patching the DT, but once
you can do that, you can probably do a whole bunch of other things as
well, so if there's no hardware mechanism to prevent access to the PWM
channel, that's about as good as it'll get.

Thierry

--NhQe1dIIe6b/8+OF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQ9EPkACgkQ3SOs138+
s6FavxAAhMNAWa1ktohw9z9+7BdmWdfgzpPoUFg3RWkwJbXvEiBEp6QM+V4PEDpL
60i59O7Bzh6ak775NfQExAeSzTLu66HsP+l+YsfmfxKZZ9zNb2vk9/Abme7whIvi
8mxkq49h9mb+uH3FH8HN2TMdEYW59dHUA0GmiCIMv0GPqPdpocjqlyq2PSP+6B1Z
gY0Wi8GCBRsGTb2ZKEHDpsAAq9NW++0xuY/qdy3lvxvkx5O3aMHptS2J6PLyN34O
SxAl6grzWqWEJNytYcGG62K0YUWWx2tVHPxEkb3JCG89TO9ycTYrniECt+wpj4Eu
N0yB0JgWg8c8iUguz+dCZmOPepy6borye5JIOaTk2GO1g0f+43IvJYI3OPUv/x8t
q2PtihLjQ0r35YMal+DLbYNBFFTohiGwL2ox3HIIYnAEdh2qQVcGlbq/ZTYVe5eC
Ev9ye4BA/1XdwLRpDOxT6wuZGjPZNYeDja4kiZ/tm8P2gxA03UPn0M5pzJ256ITM
bh7gJtxboDcH/xMGcLcBGK/0McO1m8bwOqmq5UlumidaKbj0m4xaeACxW7iu03T9
o04n6y56r6Q9b2CB4AwuNuQvN8tdAegIUptXfwdSnYsxS3Sr3NEWmEq32KreCMy/
uJUmLoSWXqdmedKcx6NgZUled0DH+2rKTlrJkpQpd6s9X7ZJ+hk=
=Wyg5
-----END PGP SIGNATURE-----

--NhQe1dIIe6b/8+OF--
