Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEBC1143D58
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2020 13:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgAUM4O (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 21 Jan 2020 07:56:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35281 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgAUM4O (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Jan 2020 07:56:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so2900902wmb.0;
        Tue, 21 Jan 2020 04:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IiN883AU5YV27YKHLNqbmjRW3uBFRPsqg2MySW+oPwA=;
        b=nxIoL1Bu1W+yeapASfdE1FuTg6OUt4aCtwTEpQzVTs2K2aJrx1I2wN4dTPPuGrpJFZ
         TF3PeQYD/OoB9hUROz9SP63hOayvn9jsAdKB4h8wVrWHeaSj5Pw5MvcE++2xzV4aS7A4
         rK7gmDn+pcJ+tZsAZtlGTSEw3MVTd9ll9JT1yU6JQCMQCulWQZP3oOjMV+0HDgk5DbUG
         boVVSHJydP8J9/GMQYEvP5zVF8JoVBYr4kx0BhGRaAffTibSheJ6mJ3AeQluCJ9Nb3Jn
         yHv+YJrJDK4NC31LU/NcWbdobxw6iYwPuFMectrTjVKwU1fF/YoHYRZLAHbl5uK4d2zj
         Yz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IiN883AU5YV27YKHLNqbmjRW3uBFRPsqg2MySW+oPwA=;
        b=VIvt1TMPI+aSdhcfKsYWHcto3MyV5R0vX2acii5ixLtQ/PFRCm1mjre0voMvDW/Xhq
         Te2joiKhQVrWeAAee14F3MnT8UHWhbrH/W8XorwcRzD6GwvZymPF1z23Roq5Ud1s4NfC
         w77yx9NavPhJ4bzttLwm1Nphb8Z9kN965eRM/UCoTuwzvtgaKQJgT1Gr/4cdnZQFBN+4
         9zfa+GUmX8ZHxFrfX6EhkiYsIaRC5+JKHecRHyCI4SbN3+i+b6umU4QgX7OeaNAN73mh
         zNX/E6Zqc0uYRgkq64CvM/QpGX8jPkr+So9W0Oc1lFJW+K0KVL92v5mdz92pArllfLFY
         8ORw==
X-Gm-Message-State: APjAAAXp4urYzLIw+wEsdWqt1Le2U/yjfx4Bmwi4spDASHw2zZsnZCVA
        FnKoea35VIfnf0oxFkDo47E=
X-Google-Smtp-Source: APXvYqwUwVLqWxMZoXwTUKcJcgXit9yAZes0BUJdNB2GHNve7obgL7QtffcAY3+ORojFyFJJyVRqgA==
X-Received: by 2002:a1c:4857:: with SMTP id v84mr4211618wma.8.1579611370417;
        Tue, 21 Jan 2020 04:56:10 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id q11sm52755072wrp.24.2020.01.21.04.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 04:56:08 -0800 (PST)
Date:   Tue, 21 Jan 2020 13:56:07 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200121125607.GA899558@ulmo>
References: <20200107133130.1338-1-miquel.raynal@bootlin.com>
 <20200120121329.GC206171@ulmo>
 <20200120134137.54dc307e@xps13>
 <20200120141944.GD206171@ulmo>
 <20200120144457.eznywc423ehw6kuc@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20200120144457.eznywc423ehw6kuc@pengutronix.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2020 at 03:44:57PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Mon, Jan 20, 2020 at 03:19:44PM +0100, Thierry Reding wrote:
> > On Mon, Jan 20, 2020 at 01:41:37PM +0100, Miquel Raynal wrote:
> > > Hi Thierry,
> > >=20
> > > Thanks for reviewing,
> > >=20
> > > > > +static bool max7313_pwm_reg_is_accessible(struct device *dev, un=
signed int reg)
> > > > > +{
> > > > > +	struct pca953x_chip *chip =3D dev_get_drvdata(dev);
> > > > > +	unsigned int bank_sz =3D chip->driver_data & PCA_GPIO_MASK;
> > > > > +
> > > > > +	if (reg >=3D MAX7313_MASTER && reg < (MAX7313_INTENSITY + bank_=
sz))
> > > > > +		return true;
> > > > > +
> > > > > +	return false;
> > > > > +}
> > > > > +
> > > > >  static bool pca953x_readable_register(struct device *dev, unsign=
ed int reg)
> > > > >  {
> > > > >  	struct pca953x_chip *chip =3D dev_get_drvdata(dev);
> > > > >  	u32 bank;
> > > > > =20
> > > > > +	if ((chip->driver_data & MAX_PWM) &&
> > > > > +	    max7313_pwm_reg_is_accessible(dev, reg))
> > > > > +		return true; =20
> > > >=20
> > > > This doesn't look correct. The MAX_PWM flag doesn't signify that all
> > > > GPIOs are used in PWM mode, right? So the above check would return =
true
> > > > even if you're trying to access GPIO registers on a chip that has P=
WM
> > > > support.
> > >=20
> > > Not exactly: this part returns true only if we are using a chip with
> > > PWM and we are accessing PWM registers.
> > >=20
> > > Otherwise, for instance if we are accessing GPIO registers, this will
> > > not return anything.
> > >=20
> > > >=20
> > > > I think you still want to proceed with the checks below if reg does=
n't
> > > > match any of the PWM related registers.
> > >=20
> > > This is precisely what we do here. See the
> > > max7313_pwm_reg_is_accessible helper above: only the PWM registers are
> > > checked, I suppose this is the part you missed.
> >=20
> > No idea what I missed, but on a second look, yes, you're absolutely
> > right.
> >=20
> > > > So it'd be something more along
> > > > these lines:
> > > >=20
> > > > 	if ((chip->driver_data & MAX_PWM) &&
> > > > 	    !max7313_pwm_reg_is_accessible(dev, reg))
> > > > 		return false;
> > > >=20
> > > > > +
> > > > >  	if (PCA_CHIP_TYPE(chip->driver_data) =3D=3D PCA953X_TYPE) {
> > > > >  		bank =3D PCA953x_BANK_INPUT | PCA953x_BANK_OUTPUT |
> > > > >  		       PCA953x_BANK_POLARITY | PCA953x_BANK_CONFIG;
> > > > > @@ -267,6 +318,10 @@ static bool pca953x_writeable_register(struc=
t device *dev, unsigned int reg)
> > > > >  	struct pca953x_chip *chip =3D dev_get_drvdata(dev);
> > > > >  	u32 bank;
> > > > > =20
> > > > > +	if ((chip->driver_data & MAX_PWM) &&
> > > > > +	    max7313_pwm_reg_is_accessible(dev, reg))
> > > > > +		return true; =20
> > > >=20
> > > > Same here.
> > > >=20
> > > > > +
> > > > >  	if (PCA_CHIP_TYPE(chip->driver_data) =3D=3D PCA953X_TYPE) {
> > > > >  		bank =3D PCA953x_BANK_OUTPUT | PCA953x_BANK_POLARITY |
> > > > >  			PCA953x_BANK_CONFIG;
> > > > > @@ -855,6 +910,335 @@ static int device_pca957x_init(struct pca95=
3x_chip *chip, u32 invert)
> > > > >  	return ret;
> > > > >  }
> > > > > =20
> > >=20
> > > [...]
> > >=20
> > > > > +static void max7313_pwm_free(struct pwm_chip *chip,
> > > > > +			     struct pwm_device *pwm)
> > > > > +{
> > > > > +	struct max7313_pwm_data *data =3D pwm_get_chip_data(pwm);
> > > > > +
> > > > > +	gpiochip_free_own_desc(data->desc);
> > > > > +	kfree(data);
> > > > > +}
> > > > > +
> > > > > +static int max7313_pwm_apply(struct pwm_chip *chip,
> > > > > +			     struct pwm_device *pwm,
> > > > > +			     const struct pwm_state *state)
> > > > > +{
> > > > > +	struct max7313_pwm *max_pwm =3D to_max7313_pwm(chip);
> > > > > +	struct pca953x_chip *pca_chip =3D to_pca953x(max_pwm);
> > > > > +	unsigned int intensity, active;
> > > > > +	int ret =3D 0;
> > > > > +
> > > > > +	if (!state->enabled ||
> > > > > +	    state->period < PWM_PERIOD_NS || =20
> > > >=20
> > > > I think you should actually make this a !=3D so that you refuse any
> > > > attempt to change the period, since you can't do it anyway.
> > >=20
> > > Actually we discussed this with Uwe, see the below snippet:
> > >=20
> > > ---8<---
> > > > > > +	if (state->period !=3D PWM_PERIOD_NS ||
> > > > > > +	    state->polarity !=3D PWM_POLARITY_NORMAL)
> > > > > > +		return -EINVAL;   =20
> > > > >=20
> > > > > The check for period is too strong. Anything bigger than PWM_PERI=
OD_NS
> > > > > is acceptable, too. (The policy I'd like to see is: Provide the b=
iggest
> > > > > period possible not bigger than the requested policy.) =20
> > > >=20
> > > > I don't understand, what is this parameter supposed to mean? the pe=
riod
> > > > cannot be changed, it is ruled by an internal oscillator. In this c=
ase
> > > > any period bigger than the actual period cannot be physically achie=
ved.
> > > > If we derive ratios with a bigger period than possible, why not
> > > > allowing it for lower periods too? =20
> > >=20
> > > Yes, I understood that the period is fixed for your PWM. However
> > > consider a consumer who would prefer a different period. If you decli=
ne
> > > all requests unless state->period =3D=3D PWM_PERIOD_NS the consumer h=
as no
> > > guide to determine that unless all periods are tested. If however ask=
ing
> > > for period =3D 2s results in getting 31.25 ms this allows the consume=
r to
> > > assume that no period setting between 2s and 31.25 ms is possible. And
> > > so the usual policy to implement is as stated in my previous mail.
> > > --->8---
> >=20
> > I think I understand what Uwe is getting at, but I don't think we should
> > lie to consumers. It's true that in some cases the drivers will silently
> > use a slightly different period if they can't match the one requested,
> > but I don't think that's a good thing. Most of the time in those drivers
> > the computed period that the controller can support is "close enough".
> >=20
> > But in this case the controller doesn't support anything other than the
> > one period, so I don't think accepting anything other than that is good
> > for any consumer.
> >=20
> > Also, typically this doesn't really matter because this will have been
> > defined in device tree and if the device tree has the wrong period, then
> > this should already be caught before the buggy DTS is upstreamed.
> >=20
> > So, I agree that the current situation is not ideal and perhaps we
> > should enforce stronger requirements for accuracy. I suspect that a good
> > solution would be for the drivers to report back the state that would've
> > been applied without actually applying it (kind of like the semantics of
> > clk_round_rate() from the common clock framework). That would give users
> > a good way of checking whether the supported parameters are within the
> > desired range before applying them. For consumers that don't care all
> > that much about precision, they can feel free to ignore any differences
> > between what they asked and what they got, and most of the time that
> > will be fine.
>=20
> Yeah, it's something like clk_round_rate that I want in the end. And to
> make it actually workable the IMHO only sane approach is to allow
> rounding in one direction without limit. And as pwm_apply_state() should
> be consistent with pwm_round_state() the former must round without
> limit, too.

Agreed on the point that both pwm_round_state() and pwm_apply_state()
should do the same rounding. In fact, in most cases I'd expect drivers
to implement the bulk of ->apply() and ->round() in the same function
that basically constructs the new state that will be applied to the
hardware in ->apply() but will be returned from ->round().

I'm not so sure about rounding without limit, though. I think it makes
sense to allow rounding to happen if you can match things closely enough
for it not to matter in most cases. Strictly speaking we're already
breaking use-cases that require a fixed period because there's currently
no way for consumers to determine what the exact state is that is going
to get applied. Consumers could read back the state, but we already know
that that doesn't yield the correct result for some drivers.

Also, in practice, for the large majority of use-cases the exact period
doesn't matter as long as the actual numbers are close enough to the
requested values and the duty cycle/period ratio is about the same as
what was requested.

Similarily, the period will typically come from DT or board files, and
will usually be a value that was hand-picked and would typically match
some value that the hardware supports. And if it isn't a supported
value, it's usually close enough because it was tested to work by who
ever submitted the DT or board file patch.

That said, I think allowing a driver to clamp any given period to the
one and only period that it supports isn't right. There's no way that
the controller can get close to the requested value unless it matches
the fixed period. If we silently ignore that restriction, we're just
going to make it very simple to write DT content that's completely
bogus, yet will still work because we effectively ignore it.

> And if you want to require that a consumer of a PWM that only supports a
> single period setting passes that period, how do you want to handle the
> situation if this period happens to be 2000/3 ns. Is it ok to pass
> .period =3D 666? Is it ok to pass 667?

That seems like a bit of an artificial example. I suspect that a
consumer that supports 666 ns as period will run just fine when run with
a period of 667 ns. So it's ultimately up to the consumer driver to make
use of the pwm_round_state() (or whatever the name will end up to be)
and apply whatever error margins it can deal with before rejecting any
given state.

Also, these kinds of disconnects are very unlikely to happen in practice
because board designs usually get tested for this kind of compatibility
before they are produced. If some PWM consumer requires one specific
period, then the corresponding PWM producer would have been picked to be
compatible with that.

> > In many cases it doesn't matter because the period is defined in DT and
> > is hand-picked to be among the ones supported by the controller, or the
> > small differences between the period in DT and the closest one supported
> > by the controller is not significant and things will just work.
>=20
> In my eyes to get a uniform behaviour of the PWM framework independant
> of the backend used, it must not be the driver who decides if a request
> is "close enough". We need a defined policy. And then it is obvious to
> me that this policy must be implemented in a way that it is in fact the
> consumer who has to decide which settings are ok and which are not. And
> then rounding without limit is the easiest to work with.

That still means that we'll be ignoring mismatches between fixed-period
producers and variable-period consumers. Allowing producers to overwrite
whatever is passed in (without potentially being able to get anywhere
near the requested values) is making it too easy to get things wrong,
don't you think?

> > However, ignoring period settings because the controller supports only a
> > fixed period seems a bit of an extreme.
>=20
> So the setting I want is:
>=20
> 	if (request.period < HW_PERIOD)
> 		fail();
> 	=09
> and with the reasoning above, that's the only sensible thing (apart from
> the revered policy of rounding up and so failing for requested periods
> that are bigger than the implementable period).

But that's just as arbitrary as anything else. request.period =3D=3D
HW_PERIOD - 1 might be an entirely fine setting in many cases.

Thierry

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4m9OMACgkQ3SOs138+
s6EgxQ/8DgcDkaVjw+mAYDnu71Hg5kAFirW0JxQ4Mlloheba34/VEFfybNG5Pm6f
BJJ2PdZYckZS4irb58qHpeNm1bqKx20OtprpIUEBb3m5KlaAhw2xV1c9Wy+C5cET
YZVrC16vL6kDNEdlA5bYgmpQnwiN3Pzkf/ggvYn74ZM0rl5SBZkQAP+g9aDYoxMt
NUKIIgu8AnabjfL/QpLdMOM5H439PqZyDrFhQR83CjJ/kTJPrvDS4yjZvQJG/AsX
Q6+A+zVDYQx5bM/acptM96arC7HCW5iNiR1SMR2PmNQF5K2T/XH2z5Qz+u0fXlix
Pwfqt2zG3oPk3CK3XlfJtlibbWsjHyYwJgANPRUprPL871lJTUmBlUqgNuGeyY9W
EHfC71e/gw89uyYgU0jL6M6P3uKmZych2nqFlv2ZOWnxYoef2wocoRD61KyLMbYi
42cuWvkr7btUnC9DP6BJlD9HjWL0RS9R0rvfaicasZMPEFOs8G5qCZmZH5yL7t72
YeG0IgEwn8xz3uFBOQEFwYyubr7P60TXkOgEb4pzUiPmh1hc+fSGD9Uk6z7pKVtH
oMqOcFfBCnobRbZ31uI/D7bG0qFmXE6zK+ZFFu3KU7Tx0jr8gX6RpRHDt9kcGUfi
T9+ldOHfTBnwB1GT5lXpUyPLEDAxEWmrwNo6Ayq6/mG8OXnX8oM=
=r7Gg
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
