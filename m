Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44962343C1B
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 09:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhCVIw5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 04:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCVIwx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 04:52:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EAEC061574;
        Mon, 22 Mar 2021 01:52:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so8778660wmj.1;
        Mon, 22 Mar 2021 01:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=coUfxHZjnvAds7knKbvoQaJLzKIJ/fAxoytksxex/e0=;
        b=gQnKPH4WD8KAVE6hi98zj0GjTMYc4mhAo9+IXKHtj5grOWuTQ/RJAuXAQzAcPoAT3g
         dwAJQwpxQTRoCltxqVOeLEX2Ku3MqK10L4+fxN/YV/Trjv6d76ntdZeScmJp2TFqxkGH
         +hGmbWyYjAdMsCHkk3/7V6yFzkkfuBOxFwmejJ3fnw0ow3WAneDVViNVYyPKZ/XXM0e9
         W7IBzzjyAtjklz28a1VFvHUMgvQucb0kb6enWpoNUkpjZ/a0SpV/yvgnBwiQbAjAmKfj
         PE2/T7hXB7ibH2qTYpNDKCr0qjhA7jCNxBM+gpDq6bM401EAPqCqBSo7tkMauGHMQoAs
         llXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=coUfxHZjnvAds7knKbvoQaJLzKIJ/fAxoytksxex/e0=;
        b=RFaw0cMsbQzQXNEpqsIZPAIt95Riur199RdLL4IsnHYxK6Fnz0GnmG1OgNHfry0FH+
         lara628Gnu8Ce8gXSniMaUXpu/VoFIyEmrlpH6z0AD5Hcjz5KOF8PZ11NuGHzmxGwAf+
         QJFHKbY4+5IIwZHEMnoK8tzFWnkNWIfmF6kzXQB8eYvN0boRVwAVwWyUmuccAq18moWT
         hFZCaNdgIaclTnKHeEqeuD+31w5TN/eEdkP9YsYKGUmuq5iP8eqk0YN3ZqGwOwA8zCIR
         hk6HUf/w2iMINJNxfa8K9xmMRf7Ry54zLy0+89MxYVBY6kiKMS+0qCRmGNXSN63gLZAv
         vImQ==
X-Gm-Message-State: AOAM532CCbVw6KaT6euEaFZA3fC7Z5tlz0QACRj3/s/bR0pb8lHTCeTZ
        Qf0FiJffezPyCpLL6hsDki0=
X-Google-Smtp-Source: ABdhPJxq8otrOxF4RiH0a6wdyEpM9O8GytsgnS3vYx11VW8rbYtImWmm2U0F7zHq6b8wLMqI4ADNUQ==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr14758930wmi.132.1616403172048;
        Mon, 22 Mar 2021 01:52:52 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id p6sm18148841wru.2.2021.03.22.01.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 01:52:51 -0700 (PDT)
Date:   Mon, 22 Mar 2021 09:53:08 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YFha9H+6ATFbb/VA@orome.fritz.box>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <YAB8ZmtOxRV1QN4l@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="clyIA7PyjV+ubgbt"
Content-Disposition: inline
In-Reply-To: <YAB8ZmtOxRV1QN4l@workstation.tuxnet>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--clyIA7PyjV+ubgbt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2021 at 06:16:22PM +0100, Clemens Gruber wrote:
> Hi,
>=20
> On Mon, Jan 11, 2021 at 09:35:32PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >=20
> > On Thu, Dec 17, 2020 at 06:43:04PM +0100, Clemens Gruber wrote:
> > > On Wed, Dec 16, 2020 at 11:00:59PM -0500, Sven Van Asbroeck wrote:
> > > > On Wed, Dec 16, 2020 at 7:53 AM Clemens Gruber
> > > > <clemens.gruber@pqgruber.com> wrote:
> > > > >
> > > > > Implements .get_state to read-out the current hardware state.
> > > > >
> > > >=20
> > > > I am not convinced that we actually need this.
> > > >=20
> > > > Looking at the pwm core, .get_state() is only called right after .r=
equest(),
> > > > to initialize the cached value of the state. The core then uses the=
 cached
> > > > value throughout, it'll never read out the h/w again, until the nex=
t .request().
> > > >=20
> > > > In our case, we know that the state right after request is always d=
isabled,
> > > > because:
> > > > - we disable all pwm channels on probe (in PATCH v5 4/7)
> > > > - .free() disables the pwm channel
> > > >=20
> > > > Conclusion: .get_state() will always return "pwm disabled", so why =
do we
> > > > bother reading out the h/w?
> > >=20
> > > If there are no plans for the PWM core to call .get_state more often =
in
> > > the future, we could just read out the period and return 0 duty and
> > > disabled.
> > >=20
> > > Thierry, Uwe, what's your take on this?
> >=20
> > I have some plans here. In the past I tried to implement them (see
> > commit 01ccf903edd65f6421612321648fa5a7f4b7cb10), but this failed
> > (commit 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3).
> >=20
> > > > Of course, if we choose to leave the pwm enabled after .free(), then
> > > > .get_state() can even be left out! Do we want that? Genuine questio=
n, I do
> > > > not know the answer.
> > >=20
> > > I do not think we should leave it enabled after free. It is less
> > > complicated if we know that unrequested channels are not in use.
> >=20
> > My position here is: A consumer should disable a PWM before calling
> > pwm_put. The driver should however not enforce this and so should not
> > modify the hardware state in .free().
> >=20
> > Also .probe should not change the PWM configuration.
>=20
> I see. This would also allow PWMs initialized in the bootloader (e.g.
> backlights) to stay on between the bootloader and Linux and avoid
> flickering.

Yes, that's precisely one of the reasons why we introduced the atomic
API. One of the use-cases that led to the current design was that the
kernel pwm-regulator on some platforms was causing devices to crash
because the driver would reprogram the PWM and cause a glitch on the
power supply for the CPUs.

So it's crucial in some cases that the PWM driver don't touch the
hardware state in ->probe(). If some drivers currently do so, that's
something we should eventually change, but given that there haven't been
any complaints yet, it likely means nothing breaks because of this, so
we do have the luxury of not having to rush things.

> If no one objects, I would then no longer reset period and duty cycles
> in the driver (and for our projects, reset them in the bootloader code
> to avoid leaving PWMs on after a kernel panic and watchdog reset, etc.)

This isn't strictly necessary, but it's obviously something that's up to
board designers/maintainers to decide.

Thierry

--clyIA7PyjV+ubgbt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYWvQACgkQ3SOs138+
s6FcJg//ZR0zAocR/x8CX247pgq0Sjcn5fZGy46F2tlxas6t34qvHPh8FYMALIvw
5W5EXkYsGpItoByvgtz/sKIZFaNSPnzHHdF9EQ4m/Y+4J6+stUBGTVBVNM3SvAl9
WnSEzFs0Xin8zXi6ocFRCAJnX4yto4Su5F87lBK8hpJaEZjmP3e2GHuohvV78uSm
0pcdaZBlmpnCSGI87YiQJeNTLAaR5RnZUEUinnda2Nxe0OXhek2olAEh5+BjfW6w
tLLJjuGbGOAJRsE6WMrAywncLnptVKu69dB3TQXDBQW1f+BESe0B/TGJcPD9el84
Nqd3I+IeEfsEcGGFJgG40UsqHAnOLo2uuKEDeEMzJxJh+8U6hkPok5RIrq+Z5h/e
4rkRRCCcXUa86wBOGzFXWnNnpxPzWOgSFT9klagyGaWnMZ+av+p8bWfecx4mPSQK
NxQH1x2sNd8Y1XdQMKt5nkU3+dix06gr44keheEUL+qHDe2rbgK0sk7Uo0aXsbgr
KflNTTma7J/Ux9+UQqzEGmVivYeXrPBU67Tq/Th2Bxcv168an+MT2S95+CdTD2f9
t36t+bKefy54LqPaFELYCkkAf1phPbWl67637WVls5WADNmf5Bg6N4Lt/rJzj/wd
TOfXw0pwPiBRo3/gOs9Jm5Ak6LfcCTtuZP9tMw7DgxugDAZdTWs=
=BSxS
-----END PGP SIGNATURE-----

--clyIA7PyjV+ubgbt--
