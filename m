Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D944A197C6A
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 15:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgC3NHc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 09:07:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43949 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbgC3NHc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 09:07:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id m11so15651638wrx.10;
        Mon, 30 Mar 2020 06:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UPlLyojeCluLgFP08/bKunqvjY3lVGNaJQ1Ua3ag9cw=;
        b=prR33xBATk6NpwOfAC3/IZqOL2a+HH3eEu9jQBtH4zcO4EhwGkMhtpx/p6/PoeQDxo
         PGK2xDWuAbfq04P6ST7lTC4yBdRkL9Mel0FMxHRNPCHEuuUv9uepB3e7ozDAQfsa0jCu
         9meZ2dPUeT+dXD/NkkslhBbL6C1FofAy/W/i7By/wfHDRyucjxtoiKaQQVhIvfgGAyu2
         jYkuxAdEtOW91bdh2V3yiGqIr+crkjIFxNw8oZg5nJSrpsLbmOSuhdX6X/yIf6iNQIXT
         lSEJ6+S6iy5SAaBnJfJg2bYNqkEo3Jn5uhw871GuuWy+cJjpYa/t0VI+1p30vWDGN8Q1
         kJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UPlLyojeCluLgFP08/bKunqvjY3lVGNaJQ1Ua3ag9cw=;
        b=uHmtvR0p6OPcM/zEgaw3TJv7BvELx3VvRdEWbIYE41JvZ+a5QU0+LKu+nYBM6D+sn0
         iphYHrrMHRwQOlL9puhUK9OHH5ftDOkpM16Z71WhzznOJW28Ccvl0Lbmn/avzlAcig5h
         mbmceoBOVAevsE8hDv2JUU9Tvh7OLDcYo89BR1wG9yQRQlxhVoix/wPm0yazEHaWjkTZ
         3lxMG4A12lV0Jc6J2nCr/Pen4i35Xq8QsXnTlQCiEn4BC87kMIL7SBvVpTSWTF/a6wAZ
         zfOwqlCyinzHIX1EFsexIeMGVdwxAL/I+QJk0DZ4Yerp0rFI0HEaGe6NtNYbjlZCZA3T
         /qtQ==
X-Gm-Message-State: ANhLgQ068zdmcbmr7sH73+46EsnA6y1P2jdb0hYoPfTcDstAZnvmktBu
        v2Zu+CV7KKQY9Z7cp3y7ZpE=
X-Google-Smtp-Source: ADFU+vspE9hsPyghXrSmNLrZni+cY35MdgqODY0Z/wp0xZ0VgHeKlvoWlvJJcPL0ozb8STcwDCu9Ag==
X-Received: by 2002:a5d:46ca:: with SMTP id g10mr14417792wrs.290.1585573647614;
        Mon, 30 Mar 2020 06:07:27 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id a192sm22485545wme.5.2020.03.30.06.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 06:07:26 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:07:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (EXT) Re: [PATCH 3/4] pwm: pca9685: initialize all LED registers
 during probe
Message-ID: <20200330130724.GA2431644@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-3-matthias.schiffer@ew.tq-group.com>
 <20200226150051.sbopz7uzbdhtccba@pengutronix.de>
 <74522773dd3e820ab6f38cd83e52c83f1288c04a.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <74522773dd3e820ab6f38cd83e52c83f1288c04a.camel@ew.tq-group.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 05:13:51PM +0100, Matthias Schiffer wrote:
> On Wed, 2020-02-26 at 16:00 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > On Wed, Feb 26, 2020 at 02:52:28PM +0100, Matthias Schiffer wrote:
> > > Initialize all ON delays to 0 during probe, rather than doing it in
> > > pca9685_pwm_enable.
> > >=20
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > > >
> > > ---
> > >  drivers/pwm/pwm-pca9685.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > > index 393ab92aa945..370691b21107 100644
> > > --- a/drivers/pwm/pwm-pca9685.c
> > > +++ b/drivers/pwm/pwm-pca9685.c
> > > @@ -289,13 +289,6 @@ static int pca9685_pwm_enable(struct pwm_chip
> > > *chip, struct pwm_device *pwm)
> > >  {
> > >  	struct pca9685 *pca =3D to_pca(chip);
> > > =20
> > > -	/*
> > > -	 * The PWM subsystem does not support a pre-delay.
> > > -	 * So, set the ON-timeout to 0
> > > -	 */
> > > -	regmap_write(pca->regmap, LED_N_ON_L(pwm->hwpwm), 0);
> > > -	regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), 0);
> > > -
> > >  	/*
> > >  	 * Clear the full-off bit.
> > >  	 * It has precedence over the others and must be off.
> > > @@ -388,6 +381,13 @@ static int pca9685_pwm_probe(struct i2c_client
> > > *client,
> > >  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
> > >  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
> > > =20
> > > +	/*
> > > +	 * The PWM subsystem does not support a pre-delay.
> > > +	 * So, set the ON-timeout to 0
> > > +	 */
> > > +	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
> > > +	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
> > > +
> >=20
> > What is a pre-delay: Something like:
> >           _________                   ______
> >     _____/         \_________________/
> >     ^                           ^
> >=20
> > Where ^ marks the period start and then the time between period start
> > and the rising signal is the pre-delay?
> >=20
> > If so, the IMHO more right approach is to keep the pre-delay until a
> > new
> > setting is applied and in .get_state ignore the pre-delay. This way
> > you
> > don't modify the output in .probe() which sounds right.
> >=20
>=20
> My approach was to get the hardware into a known state by resetting
> most registers (which is what the driver attempted to do so far). If
> getting the hardware state via get_state is preferable, I can implement
> that instead.

I think what Uwe was suggesting was to delay setting these registers
until the PWM is actually used. We typically do that in order not to
mess with whatever the bootloader may have set up.

Consider for example the case where the PWM is used to drive a
backlight, which might be showing a splash screen. If you reinitialize
the PWM at probe time, the backlight might go dark some time before the
kernel gets around to initializing the backlight.

For now I think we should just leave this where it is because likely a
change in PWM will be followed by a pwm_enable() call with the legacy
API. Ideally this driver would be converted to the new atomic PWM API,
in which case it'd be best to write the entirety of the hardware
registers during ->apply().

Thierry

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6B7woACgkQ3SOs138+
s6E1pBAAnG+N21eVrYOAi4fg+13x0D6CzUhyDs2ieFfER1TzR1e7GRA7uwtBEd76
kv21RsKUKUcjunPihaAGnHMI1GWF8cm3AXU4ss2ChWZ1re6uCYKdp2RLJHmHDvM3
KKi7Lsmq36XGCpwEzBhHq9qUYVRlimS+Sy9T+XwFxwU+6SMvCpGA2mgQNQTbh/t8
FZwngg0GFFmaULN1lrdSIjcq4uEaSXOpIRiYIBV1bCV97GQLNRGjcbuzzWIiE2l6
qvqYVVW4cJ6e/Kk9qoCHW4toBVGiQXlXzUwUMPJAtSvWvg1t+f9vxl6b7xz6DkdX
8C94dcf8ag612TNoQVaY9MrEpOU53039bgZTugZSqE4i5hM85wEPlhZmFjJbV5V1
Lv04CAnkeGhUSkgolQK2yFfrhS2UJvaYFC9BnOQakSaje/44SI7ywYCNScQ3pMc0
Mp87A1HkM/4h4dbNhp4lmM5ghyTQbIYbz3h+G/nhaBWW2qOOiXne6jgPdniQKdTS
u0R9UEVBhl5me7Fk/9PMWcxxXFjKA+z14INDubRjZmBAjLqWtmBWRb2YfCPq9QAI
9YF68GSoFJp/R83qEv+yOEt1QDvkvzH72MBdHfOaAocu+k+raZl1vEVv+tS3nq+b
ouTb2q8TFZCQdiHqTZ8NGfkgogrCeRyLawRdSkEQbZLZoH8u0Z4=
=fw4R
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
