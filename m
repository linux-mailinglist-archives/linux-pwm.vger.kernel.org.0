Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09DA142D18
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2020 15:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgATOTu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jan 2020 09:19:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42987 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgATOTt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 09:19:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so29658420wro.9;
        Mon, 20 Jan 2020 06:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y4xT6YrDXuSZF/CM5vPv2X+jbbtQBV1FlQvF5ZzyiZc=;
        b=hVCI7MOKchX7s11hQ2bZU4vPTZgqWyUhfZItcTu5VBPuKICZYgkJ5SXAHJ/E/am4br
         6s7qBm3ZKkJfUaTO9IxJZwKvmpzBXYD/4VLkAVEk+OQrNh37sa+heKO1HX2+qmqilFCe
         1vMM+AUlRVAwkz+8LP4pRK9LWGrFYQZrmDB59I7Bb7+ukM34I8I9zb+8aceBipjPulDz
         X54KF66RevCyuDuxoH7hAk8VasS6F+LatV8KBaP9SF8D9zxp7chRaohXRAdmGW9XzikK
         Vzjmoul2njDifylG2u6OtYQLIPEYdbq5MyHhyJEnaveAynhg3uosIFvQuVuhvltTf5yb
         LYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y4xT6YrDXuSZF/CM5vPv2X+jbbtQBV1FlQvF5ZzyiZc=;
        b=Q03fRj27ATngo/Xja1czvHQU2TqoOeZ9DgQZRjxAKaRa2HQ+YrWrSWpg85QqTV/xf1
         xFv4ajLqayxESHkrMheLdmKuwKjLk3JX9LvGqJHUHDWF9XbcnFfTlPcX13TLROwcS0wT
         IXHp4UVRTnieqAuIy1cI/3k7rEyoyr4wjvLjWuuvn9HnMP6J2jEc7kP/i6pJS7uCb1d5
         TGW2VS1deyu2KQc7wvCSUWaWjYFvzkzbryAqpoBk1Gr3Pn2k0q7MjUERgky3gZRPn+5u
         9XPm68Skmz/rHcw56frfu+etCbAGKSeDk7YVJxDvzYMhoZccMFNsOxwKAyLFaYUekRIM
         qM0g==
X-Gm-Message-State: APjAAAUfbyoXNMt/fsJp0sRGkdoD47JM+JwAmsZhY/odN68snfKMpWQK
        VYMoc8kwt0KgyEEOlWzt59g=
X-Google-Smtp-Source: APXvYqyaOOAyCxJJzAe8IlwM/9rKsf4o0RMEuX+vgBp/Pfsn8FgtdGPF3C2yhHYrz0n7m0a7MtEo9Q==
X-Received: by 2002:adf:e692:: with SMTP id r18mr18734302wrm.413.1579529987224;
        Mon, 20 Jan 2020 06:19:47 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id z11sm49857552wrt.82.2020.01.20.06.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 06:19:45 -0800 (PST)
Date:   Mon, 20 Jan 2020 15:19:44 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200120141944.GD206171@ulmo>
References: <20200107133130.1338-1-miquel.raynal@bootlin.com>
 <20200120121329.GC206171@ulmo>
 <20200120134137.54dc307e@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline
In-Reply-To: <20200120134137.54dc307e@xps13>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2020 at 01:41:37PM +0100, Miquel Raynal wrote:
> Hi Thierry,
>=20
> Thanks for reviewing,
>=20
> > > +static bool max7313_pwm_reg_is_accessible(struct device *dev, unsign=
ed int reg)
> > > +{
> > > +	struct pca953x_chip *chip =3D dev_get_drvdata(dev);
> > > +	unsigned int bank_sz =3D chip->driver_data & PCA_GPIO_MASK;
> > > +
> > > +	if (reg >=3D MAX7313_MASTER && reg < (MAX7313_INTENSITY + bank_sz))
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > > +
> > >  static bool pca953x_readable_register(struct device *dev, unsigned i=
nt reg)
> > >  {
> > >  	struct pca953x_chip *chip =3D dev_get_drvdata(dev);
> > >  	u32 bank;
> > > =20
> > > +	if ((chip->driver_data & MAX_PWM) &&
> > > +	    max7313_pwm_reg_is_accessible(dev, reg))
> > > +		return true; =20
> >=20
> > This doesn't look correct. The MAX_PWM flag doesn't signify that all
> > GPIOs are used in PWM mode, right? So the above check would return true
> > even if you're trying to access GPIO registers on a chip that has PWM
> > support.
>=20
> Not exactly: this part returns true only if we are using a chip with
> PWM and we are accessing PWM registers.
>=20
> Otherwise, for instance if we are accessing GPIO registers, this will
> not return anything.
>=20
> >=20
> > I think you still want to proceed with the checks below if reg doesn't
> > match any of the PWM related registers.
>=20
> This is precisely what we do here. See the
> max7313_pwm_reg_is_accessible helper above: only the PWM registers are
> checked, I suppose this is the part you missed.

No idea what I missed, but on a second look, yes, you're absolutely
right.

> > So it'd be something more along
> > these lines:
> >=20
> > 	if ((chip->driver_data & MAX_PWM) &&
> > 	    !max7313_pwm_reg_is_accessible(dev, reg))
> > 		return false;
> >=20
> > > +
> > >  	if (PCA_CHIP_TYPE(chip->driver_data) =3D=3D PCA953X_TYPE) {
> > >  		bank =3D PCA953x_BANK_INPUT | PCA953x_BANK_OUTPUT |
> > >  		       PCA953x_BANK_POLARITY | PCA953x_BANK_CONFIG;
> > > @@ -267,6 +318,10 @@ static bool pca953x_writeable_register(struct de=
vice *dev, unsigned int reg)
> > >  	struct pca953x_chip *chip =3D dev_get_drvdata(dev);
> > >  	u32 bank;
> > > =20
> > > +	if ((chip->driver_data & MAX_PWM) &&
> > > +	    max7313_pwm_reg_is_accessible(dev, reg))
> > > +		return true; =20
> >=20
> > Same here.
> >=20
> > > +
> > >  	if (PCA_CHIP_TYPE(chip->driver_data) =3D=3D PCA953X_TYPE) {
> > >  		bank =3D PCA953x_BANK_OUTPUT | PCA953x_BANK_POLARITY |
> > >  			PCA953x_BANK_CONFIG;
> > > @@ -855,6 +910,335 @@ static int device_pca957x_init(struct pca953x_c=
hip *chip, u32 invert)
> > >  	return ret;
> > >  }
> > > =20
>=20
> [...]
>=20
> > > +static void max7313_pwm_free(struct pwm_chip *chip,
> > > +			     struct pwm_device *pwm)
> > > +{
> > > +	struct max7313_pwm_data *data =3D pwm_get_chip_data(pwm);
> > > +
> > > +	gpiochip_free_own_desc(data->desc);
> > > +	kfree(data);
> > > +}
> > > +
> > > +static int max7313_pwm_apply(struct pwm_chip *chip,
> > > +			     struct pwm_device *pwm,
> > > +			     const struct pwm_state *state)
> > > +{
> > > +	struct max7313_pwm *max_pwm =3D to_max7313_pwm(chip);
> > > +	struct pca953x_chip *pca_chip =3D to_pca953x(max_pwm);
> > > +	unsigned int intensity, active;
> > > +	int ret =3D 0;
> > > +
> > > +	if (!state->enabled ||
> > > +	    state->period < PWM_PERIOD_NS || =20
> >=20
> > I think you should actually make this a !=3D so that you refuse any
> > attempt to change the period, since you can't do it anyway.
>=20
> Actually we discussed this with Uwe, see the below snippet:
>=20
> ---8<---
> > > > +	if (state->period !=3D PWM_PERIOD_NS ||
> > > > +	    state->polarity !=3D PWM_POLARITY_NORMAL)
> > > > +		return -EINVAL;   =20
> > >=20
> > > The check for period is too strong. Anything bigger than PWM_PERIOD_NS
> > > is acceptable, too. (The policy I'd like to see is: Provide the bigge=
st
> > > period possible not bigger than the requested policy.) =20
> >=20
> > I don't understand, what is this parameter supposed to mean? the period
> > cannot be changed, it is ruled by an internal oscillator. In this case
> > any period bigger than the actual period cannot be physically achieved.
> > If we derive ratios with a bigger period than possible, why not
> > allowing it for lower periods too? =20
>=20
> Yes, I understood that the period is fixed for your PWM. However
> consider a consumer who would prefer a different period. If you decline
> all requests unless state->period =3D=3D PWM_PERIOD_NS the consumer has no
> guide to determine that unless all periods are tested. If however asking
> for period =3D 2s results in getting 31.25 ms this allows the consumer to
> assume that no period setting between 2s and 31.25 ms is possible. And
> so the usual policy to implement is as stated in my previous mail.
> --->8---

I think I understand what Uwe is getting at, but I don't think we should
lie to consumers. It's true that in some cases the drivers will silently
use a slightly different period if they can't match the one requested,
but I don't think that's a good thing. Most of the time in those drivers
the computed period that the controller can support is "close enough".

But in this case the controller doesn't support anything other than the
one period, so I don't think accepting anything other than that is good
for any consumer.

Also, typically this doesn't really matter because this will have been
defined in device tree and if the device tree has the wrong period, then
this should already be caught before the buggy DTS is upstreamed.

So, I agree that the current situation is not ideal and perhaps we
should enforce stronger requirements for accuracy. I suspect that a good
solution would be for the drivers to report back the state that would've
been applied without actually applying it (kind of like the semantics of
clk_round_rate() from the common clock framework). That would give users
a good way of checking whether the supported parameters are within the
desired range before applying them. For consumers that don't care all
that much about precision, they can feel free to ignore any differences
between what they asked and what they got, and most of the time that
will be fine.

In many cases it doesn't matter because the period is defined in DT and
is hand-picked to be among the ones supported by the controller, or the
small differences between the period in DT and the closest one supported
by the controller is not significant and things will just work.

However, ignoring period settings because the controller supports only a
fixed period seems a bit of an extreme.

Thierry

> > > +	    state->polarity !=3D PWM_POLARITY_NORMAL)
> > > +		return -EINVAL;
> > > +
> > > +	/* Convert the duty-cycle to be in the [0;16] range */
> > > +	intensity =3D max7313_pwm_duty_to_intensity(state->duty_cycle);
> > > +
>=20
> [...]
>=20
> > > @@ -1130,7 +1522,7 @@ static const struct of_device_id pca953x_dt_ids=
[] =3D {
> > > =20
> > >  	{ .compatible =3D "maxim,max7310", .data =3D OF_953X( 8, 0), },
> > >  	{ .compatible =3D "maxim,max7312", .data =3D OF_953X(16, PCA_INT), =
},
> > > -	{ .compatible =3D "maxim,max7313", .data =3D OF_953X(16, PCA_INT), =
},
> > > +	{ .compatible =3D "maxim,max7313", .data =3D OF_953X(16, PCA_INT | =
MAX_PWM), },
> > >  	{ .compatible =3D "maxim,max7315", .data =3D OF_953X( 8, PCA_INT), =
},
> > >  	{ .compatible =3D "maxim,max7318", .data =3D OF_953X(16, PCA_INT), =
}, =20
> >=20
> > Aren't you missing a call to pwmchip_remove() somewhere? Otherwise once
> > you unload the driver, the PWM chip will become dangling and any attempt
> > to access its PWMs will crash.
>=20
> That's true, I'll correct.
>=20
>=20
> Thanks,
> Miqu=C3=A8l

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4ltv4ACgkQ3SOs138+
s6Gw9Q//SQB7dSTq7vwljQDsbG+ic6gTkPYKDCUd1DNmmbzkDS236ooM5imOLl9p
UY8abmpbo4pnx8HC1iigxLyeO3SdlJNkC0VslgR28Mj2TThfiDiuDBY7wukMw9/e
q2H7Mkxf3b/qJkxwEos8LKK8y1LTX+k9/8NlbaD7VnIAhGVGBgtP4RLLZy3/Xtdl
jb3WNltYaq3KVE26x9EJwhO5DM7hORSc/uP41hMFy2wnzJEMBW5ogI6IJcCL7zYd
0ZTh/whWMyT7yeB1pfznJHdn72e1S4t8vL/fD5Q3rv9hHIfOjcfgQAcI5COASUPZ
1t4/G49K9YRGQruKJf9uNEjS0wRThvM1VMcEo37ISi0518G0eONey5AXdD87Q+l9
mT397ZinfhD+olGHpvEaOv/nJxHSk9RJZByEoxZV268KxevHVYBftu+uv7KBonc+
S85z87cL1j1BIJuiELnPecbqqcN6AV07C5StK469x1UWoqRPvUffx9SVF87i9jGs
ISqppNMd31oQkk2/5hqLmyvOyTxDrLSDFCWsfHsO4SvHSnWWl7ky/kqXiQuLJIIt
EJLXbiJt43gTO3tTOacUcgG+SJyK23w8hicbDMV7MtpJPt8IDRFsM1dwYmDgBWva
5p/BUL3AxVN67YUFej7wYKx9uYPAWElu1QTz/bjw+WiUYtZIrO8=
=hxKi
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--
