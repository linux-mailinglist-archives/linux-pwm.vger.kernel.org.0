Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF55735DF00
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Apr 2021 14:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhDMMhd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Apr 2021 08:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhDMMhd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Apr 2021 08:37:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D593C061574;
        Tue, 13 Apr 2021 05:37:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s7so16172764wru.6;
        Tue, 13 Apr 2021 05:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=blFLvImK+bSROOLy8mZl325gwVOmS0Z0lu82RsGW4cs=;
        b=Bbg6tlEPXweaj0I2+dUnmqKpg81zXCZunQOZrbU11OW61jAaM+Mk2GLmaQBMgyZT2n
         9UCkzEHoM0mOZinuNwz7QND35jC17qcw2pqkW647V4xFOWT9tb4q6GSyoBUI9EyhXRo7
         NCy5/uCPCG1cErBcamnKy3N9qRwaUz6Jqongd4T/urvb1A+4jJLxfGCcpCQfmBkFVYI1
         WtTxikhrYT/s/qywpWNc4nbExBgQ7EWavPm8/kETVId4ZJGPYoA7fJS5g/ZTivwCtkPd
         GWnltJ3WNVA/XsTsw3I/haorcnK8Eq3XCOumQL0GBj0o9+Bb23rYzjfn25OTRAQV/pG0
         qiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=blFLvImK+bSROOLy8mZl325gwVOmS0Z0lu82RsGW4cs=;
        b=rnTcZXIEglQoojV5ts6hQfWGSK2EtkqRI+z/oGyek+TekWgk3h5BeZJGQBwQ8FVX9f
         mrN1oGZCMt4jrj/rEkc3aAjJRiHApqXtG8MmLNPw99P93Y+wxIviIp56Xu1N48zPJq/X
         xr5If8/oBn2xMnR5QTWWwBFsRzNMmUK+KFeAl4bOYtsYQGdwK+t0rLll4TTeD5paWeiI
         eDZ/QL4zOGrJpYSPS+rAWkh35LDxc2kzrTiwC/COMaFnhsfBLZzOMiJguW4baFAXnW5f
         i7BfdtMD95fbwXnDrpi9lXdrcWBq0iKnSKr0YA4c9Dyq7LsIx26UcQEw9NZn11KmHXvR
         Xr9w==
X-Gm-Message-State: AOAM533DEe21tLT+Kzw0Zhj3klWtzaqWnZBhnCib7xJhxd/Vo7TdH54b
        1RxxCb2/rkN82Up1C14Mt+c=
X-Google-Smtp-Source: ABdhPJy31GHtr9UHyjKxA3aaq/hv/yIRQ3GHkU2Z+Z7Ac0rwZ41Y1iROygdfYzW/Hj0um1yz9uCb1A==
X-Received: by 2002:a5d:444d:: with SMTP id x13mr12177164wrr.406.1618317431529;
        Tue, 13 Apr 2021 05:37:11 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id x23sm2371064wmj.43.2021.04.13.05.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:37:10 -0700 (PDT)
Date:   Tue, 13 Apr 2021 14:37:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/8] pwm: pca9685: Switch to atomic API
Message-ID: <YHWQnoYY6LLe4rej@orome.fritz.box>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412161808.lp2amdfopw74lvz7@pengutronix.de>
 <YHR3wP4Fk3jidnri@workstation.tuxnet>
 <20210412201019.vouxx4daumusrcvr@pengutronix.de>
 <YHWKehtYFSaHt1hC@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SQSJUN4hek2YcMBJ"
Content-Disposition: inline
In-Reply-To: <YHWKehtYFSaHt1hC@workstation.tuxnet>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--SQSJUN4hek2YcMBJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 13, 2021 at 02:11:38PM +0200, Clemens Gruber wrote:
> Hi Uwe,
>=20
> On Mon, Apr 12, 2021 at 10:10:19PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Clemens,
> >=20
> > On Mon, Apr 12, 2021 at 06:39:28PM +0200, Clemens Gruber wrote:
> > > On Mon, Apr 12, 2021 at 06:18:08PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Mon, Apr 12, 2021 at 03:27:38PM +0200, Clemens Gruber wrote:
> > > > > The switch to the atomic API goes hand in hand with a few fixes to
> > > > > previously experienced issues:
> > > > > - The duty cycle is no longer lost after disable/enable (previous=
ly the
> > > > >   OFF registers were cleared in disable and the user was required=
 to
> > > > >   call config to restore the duty cycle settings)
> > > > > - If one sets a period resulting in the same prescale register va=
lue,
> > > > >   the sleep and write to the register is now skipped
> > > > > - Previously, only the full ON bit was toggled in GPIO mode (and =
full
> > > > >   OFF cleared if set to high), which could result in both full OF=
F and
> > > > >   full ON not being set and on=3D0, off=3D0, which is not allowed=
 according
> > > > >   to the datasheet
> > > > > - The OFF registers were reset to 0 in probe, which could lead to=
 the
> > > > >   forbidden on=3D0, off=3D0. Fixed by resetting to POR default (f=
ull OFF)
> > > > >=20
> > > > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > > > ---
> > > > > Changes since v7:
> > > > > - Moved check for !state->enabled before prescaler configuration
> > > > > - Removed unnecessary cast
> > > > > - Use DIV_ROUND_DOWN in .apply
> > > > >=20
> > > > > Changes since v6:
> > > > > - Order of a comparison switched for improved readability
> > > > >=20
> > > > > Changes since v5:
> > > > > - Function documentation for set_duty
> > > > > - Variable initializations
> > > > > - Print warning if all LEDs channel
> > > > > - Changed EOPNOTSUPP to EINVAL
> > > > > - Improved error messages
> > > > > - Register reset corrections moved to this patch
> > > > >=20
> > > > > Changes since v4:
> > > > > - Patches split up
> > > > > - Use a single set_duty function
> > > > > - Improve readability / new macros
> > > > > - Added a patch to restrict prescale changes to the first user
> > > > >=20
> > > > > Changes since v3:
> > > > > - Refactoring: Extracted common functions
> > > > > - Read prescale register value instead of caching it
> > > > > - Return all zeros and disabled for "all LEDs" channel state
> > > > > - Improved duty calculation / mapping to 0..4096
> > > > >=20
> > > > > Changes since v2:
> > > > > - Always set default prescale value in probe
> > > > > - Simplified probe code
> > > > > - Inlined functions with one callsite
> > > > >=20
> > > > > Changes since v1:
> > > > > - Fixed a logic error
> > > > > - Impoved PM runtime handling and fixed !CONFIG_PM
> > > > > - Write default prescale reg value if invalid in probe
> > > > > - Reuse full_off/_on functions throughout driver
> > > > > - Use cached prescale value whenever possible
> > > > >=20
> > > > >  drivers/pwm/pwm-pca9685.c | 259 +++++++++++++-------------------=
------
> > > > >  1 file changed, 89 insertions(+), 170 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > > > > index 4a55dc18656c..827b57ced3c2 100644
> > > > > --- a/drivers/pwm/pwm-pca9685.c
> > > > > +++ b/drivers/pwm/pwm-pca9685.c
> > > > > @@ -51,7 +51,6 @@
> > > > >  #define PCA9685_PRESCALE_MAX	0xFF	/* =3D> min. frequency of 24 H=
z */
> > > > > =20
> > > > >  #define PCA9685_COUNTER_RANGE	4096
> > > > > -#define PCA9685_DEFAULT_PERIOD	5000000	/* Default period_ns =3D =
1/200 Hz */
> > > > >  #define PCA9685_OSC_CLOCK_MHZ	25	/* Internal oscillator with 25 =
MHz */
> > > > > =20
> > > > >  #define PCA9685_NUMREGS		0xFF
> > > > > @@ -71,10 +70,14 @@
> > > > >  #define LED_N_OFF_H(N)	(PCA9685_LEDX_OFF_H + (4 * (N)))
> > > > >  #define LED_N_OFF_L(N)	(PCA9685_LEDX_OFF_L + (4 * (N)))
> > > > > =20
> > > > > +#define REG_ON_H(C)	((C) >=3D PCA9685_MAXCHAN ? PCA9685_ALL_LED_=
ON_H : LED_N_ON_H((C)))
> > > > > +#define REG_ON_L(C)	((C) >=3D PCA9685_MAXCHAN ? PCA9685_ALL_LED_=
ON_L : LED_N_ON_L((C)))
> > > > > +#define REG_OFF_H(C)	((C) >=3D PCA9685_MAXCHAN ? PCA9685_ALL_LED=
_OFF_H : LED_N_OFF_H((C)))
> > > > > +#define REG_OFF_L(C)	((C) >=3D PCA9685_MAXCHAN ? PCA9685_ALL_LED=
_OFF_L : LED_N_OFF_L((C)))
> > > >=20
> > > > I'd like to see these named PCA9685_REG_ON_H etc.
> > >=20
> > > I did not use the prefix because the existing LED_N_ON/OFF_H/L also do
> > > not have a prefix. If the prefix is mandatory, I think LED_N_.. should
> > > also be prefixed, right?
> >=20
> > I'd like to seem the prefixed (and assume that Thierry doesn't agree).
> > IMHO it's good style and even though it yields longer name usually it
> > yields easier understandable code. (But this seems to be subjective.)
>=20
> I am not sure I want to also rename the existing LED_N_OFF stuff in this
> patch. Maybe we can discuss unifying the macros (either with or without
> prefix) in a later patch and I keep the REG_ON_ stuff for now without to
> match the LED_N_ stuff?

Uwe guessed right, I don't think these need the prefix. There's very
little potential for name clashes and this driver is already called
PCA9685, so adding the prefix everywhere can be annoying, especially
if that then causes you to need line breaks, etc.

For things like function names I usually prefer having a consistent
prefix because it makes it much easier to decipher stack traces. Not so
with the defines here.

But I also don't feel strongly, so either way is fine. If you decide to
go with the prefix, making it consistent throughout the file in a
separate patch would be preferable, though.

>=20
> >=20
> > > > > +	val =3D 0;
> > > > > +	regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
> > > >=20
> > > > I asked in the last round why you initialize val. You answered "jus=
t to
> > > > have it set to 0 in case regmap_read fails / val was not set." I wo=
nder
> > > > if
> > > >=20
> > > > 	ret =3D regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
> > > > 	if (!ret)
> > > > 		/*=20
> >=20
> > I intended to write something like
> >=20
> > 		/* initialize val in case reading LED_N_OFF failed */
> >=20
> > > > 		val =3D 0
> > > >=20
> > > > would be better then and also make the intention obvious.
>=20
> Maybe a little bit better.. I can change it.
>=20
> > >=20
> > > I am not sure if that's more clear, but if others find it more obvious
> > > like this, I can change it.
> > >=20
> > > >=20
> > > > > +	return ((off_h & 0xf) << 8) | (val & 0xff);
> > > > > +}
> > > > > +
> > > > >  #if IS_ENABLED(CONFIG_GPIOLIB)
> > > > >  static bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca, =
int pwm_idx)
> > > > >  {
> > > > > @@ -138,34 +186,23 @@ static int pca9685_pwm_gpio_request(struct =
gpio_chip *gpio, unsigned int offset)
> > > > >  static int pca9685_pwm_gpio_get(struct gpio_chip *gpio, unsigned=
 int offset)
> > > > >  {
> > > > >  	struct pca9685 *pca =3D gpiochip_get_data(gpio);
> > > > > -	struct pwm_device *pwm =3D &pca->chip.pwms[offset];
> > > > > -	unsigned int value;
> > > > > =20
> > > > > -	regmap_read(pca->regmap, LED_N_ON_H(pwm->hwpwm), &value);
> > > > > -
> > > > > -	return value & LED_FULL;
> > > > > +	return pca9685_pwm_get_duty(pca, offset) !=3D 0;
> > > > >  }
> > > > > =20
> > > > >  static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigne=
d int offset,
> > > > >  				 int value)
> > > > >  {
> > > > >  	struct pca9685 *pca =3D gpiochip_get_data(gpio);
> > > > > -	struct pwm_device *pwm =3D &pca->chip.pwms[offset];
> > > > > -	unsigned int on =3D value ? LED_FULL : 0;
> > > > > -
> > > > > -	/* Clear both OFF registers */
> > > > > -	regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0);
> > > > > -	regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), 0);
> > > > > =20
> > > > > -	/* Set the full ON bit */
> > > > > -	regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), on);
> > > > > +	pca9685_pwm_set_duty(pca, offset, value ? PCA9685_COUNTER_RANGE=
 : 0);
> > > > >  }
> > > > > =20
> > > > >  static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsign=
ed int offset)
> > > > >  {
> > > > >  	struct pca9685 *pca =3D gpiochip_get_data(gpio);
> > > > > =20
> > > > > -	pca9685_pwm_gpio_set(gpio, offset, 0);
> > > > > +	pca9685_pwm_set_duty(pca, offset, 0);
> > > > >  	pm_runtime_put(pca->chip.dev);
> > > > >  	pca9685_pwm_clear_inuse(pca, offset);
> > > > >  }
> > > > > @@ -246,167 +283,52 @@ static void pca9685_set_sleep_mode(struct =
pca9685 *pca, bool enable)
> > > > >  	}
> > > > >  }
> > > > > =20
> > > > > -static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_=
device *pwm,
> > > > > -			      int duty_ns, int period_ns)
> > > > > +static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> > > > > +			     const struct pwm_state *state)
> > > > >  {
> > > > > [...]
> > > > > +	prescale =3D DIV_ROUND_CLOSEST_ULL(PCA9685_OSC_CLOCK_MHZ * stat=
e->period,
> > > > > +					 PCA9685_COUNTER_RANGE * 1000) - 1;
> > > > > +	if (prescale < PCA9685_PRESCALE_MIN || prescale > PCA9685_PRESC=
ALE_MAX) {
> > > > > +		dev_err(chip->dev, "pwm not changed: period out of bounds!\n");
> > > > > +		return -EINVAL;
> > > > >  	}
> > > > > =20
> > > > > [...]
> > > > > +	if (!state->enabled) {
> > > > > +		pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
> > > > >  		return 0;
> > > > >  	}
> > > > > =20
> > > > > [...]
> > > > > +	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
> > > > > +	if (prescale !=3D val) {
> > > > > +		/*
> > > > > +		 * Putting the chip briefly into SLEEP mode
> > > > > +		 * at this point won't interfere with the
> > > > > +		 * pm_runtime framework, because the pm_runtime
> > > > > +		 * state is guaranteed active here.
> > > > > +		 */
> > > > > +		/* Put chip into sleep mode */
> > > > > +		pca9685_set_sleep_mode(pca, true);
> > > > > =20
> > > > > [...]
> > > > > +		/* Change the chip-wide output frequency */
> > > > > +		regmap_write(pca->regmap, PCA9685_PRESCALE, prescale);
> > > > > =20
> > > > > -	regmap_update_bits(pca->regmap, reg, LED_FULL, 0x0);
> > > > > +		/* Wake the chip up */
> > > > > +		pca9685_set_sleep_mode(pca, false);
> > > > > +	}
> > > > > =20
> > > > > +	duty =3D PCA9685_COUNTER_RANGE * state->duty_cycle;
> > > > > +	duty =3D DIV_ROUND_DOWN_ULL(duty, state->period);
> > > >=20
> > > > If you round down here you should probably also round down in the
> > > > calculation of prescale. Also note that you're losing precision by =
using
> > > > state->period.
> > > >=20
> > > > Consider the following request: state->period =3D 4177921 [ns] +
> > > > state->duty_cycle =3D 100000 [ns], then we get
> > > > PRESCALE =3D round(25 * state->period / 4096000) - 1 =3D 25 and so =
an actual
> > > > period of 4096000 / 25 * (25 + 1) =3D 4259840 [ns]. If you now calc=
ulate
> > > > the duty using 4096 * 100000 / 4177920 =3D 98, this corresponds to =
an
> > > > actual duty cycle of 98 * 4259840 / 4096 =3D 101920 ns while you sh=
ould
> > > > actually configure 96 to get 99840 ns.
> > > >=20
> > > > So in the end I'd like to have the following:
> > > >=20
> > > > 	PRESCALE =3D round-down(25 * state->period / 4096000) - 1
> > > >=20
> > > > (to get the biggest period not bigger than state->period) and
> > > >=20
> > > > 	duty =3D round-down(state->duty_cycle * 25 / ((PRESCALE + 1) * 100=
0))
> > > >=20
> > > > (to get the biggest duty cycle not bigger than state->duty_cycle). =
With
> > > > the example above this yields
> > > >=20
> > > > 	PRESCALE =3D 24
> > > > 	duty =3D 100
> > > >=20
> > > > which results in
> > > >=20
> > > > 	.period =3D 4096000 / 25 * 25 =3D 4096000 [ns]
> > > > 	.duty_cycle =3D 100000 [ns]
> > > > =09
> > > > Now you have a mixture of old and new with no consistent behaviour.=
 So
> > > > please either stick to the old behaviour or do it right immediately.
> > >=20
> > > I avoided rounding down the prescale value because the datasheet has =
an
> > > example where a round-closest is used, see page 25.
> >=20
> > The hardware guy who wrote this data sheet wasn't aware of the rounding
> > rules for Linux PWM drivers :-)
> >=20
> > > With your suggested round-down, the example with frequency of 200 Hz
> > > would no longer result in 30 but 29 and that contradicts the datashee=
t.
> >=20
> > Well, with PRESCALE =3D 30 we get a frequency of 196.88 Hz and with
> > PRESCALE =3D 29 we get a frequency of 203.45 Hz. So no matter if you pi=
ck
> > 29 or 30, you don't get 200 Hz. And which of the two possible values is
> > the better one depends on the consumer, no matter what rounding
> > algorithm the data sheet suggests. Also note that the math here contains
> > surprises you don't expect at first. For example, what PRESCALE value
> > would you pick to get 284 Hz? [If my mail was a video, I'd suggest to
> > press Space now to pause and let you think first :-)] The data sheet's
> > formula suggests:
> >=20
> > 	round(25 MHz / (4096 * 284)) - 1 =3D 20
> >=20
> > The resulting frequency when picking PRESCALE =3D 20 is 290.644 Hz (so =
an
> > error of 6.644 Hz). If instead you pick PRESCALE =3D 21 you get 277.433=
 Hz
> > (error =3D 6.567 Hz), so 21 is the better choice.
> >=20
> > Exercise for the reader:
> >  What is the correct formula to really determine the PRESCALE value that
> >  yields the best approximation (i.e. minimizing
> >  abs(real_freq - target_freq)) for a given target_freq?
> >=20
> > These things don't happen when you round down only.
>=20
> Sure, but it might also be counterintuitive that the Linux driver does
> not use the same formula as the datasheet. And when using 200 Hz, 29 is
> a little closer than 30.
> I once measured the actual frequency and the internal oscillator is not
> very accurate, so even if you think you should get 196.88 Hz, the actual
> frequency measured with a decent scope is about 206 Hz and varies from
> chip to chip (~=C2=A0205-207 Hz).
>=20
> >=20
> > > So would you rather have me keep the old duty rounding behaviour?
> > >=20
> > > Meaning: Keep rounding up the duty calculation in apply and use
> > > round-down in the new .get_state function?
> >=20
> > There are two things I want:
> >=20
> >  a) To improve consistency among the PWM drivers (and to keep the math
> >     simple and unsurprising), the pca9685 driver should use round-down
> >     instead of round-nearest (or whatever mix it is currently using).
> >=20
> >  b) .get_state should be the inverse to .apply in the sense that
> >     applying the result of .get_state is idempotent.
> >=20
> > I don't care much how you get there, so it's up to you if you do that in
> > this patch that converts to .apply, or if you keep the math as is and
> > then adapt the rounding behaviour in a separate change. But changing the
> > algorithm in this patch and not getting to the "good" one is ugly, so
> > please don't do that.
>=20
> OK, then I think the best option is to keep the math as it was before
> and if we want to change the rounding behaviour we do this in a separate
> patch in the future. Then we can continue the discussion wether changing
> the prescaler formula to round-down even though the datasheet does it
> otherwise is the way to go.

I agree, keeping the existing behaviour is preferable. The series
already changes plenty as-is, and rolling the rounding change into it
may make it more difficult to revert/fix later on.

We can always consider a follow-up patch to change it.

Thierry

--SQSJUN4hek2YcMBJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmB1kJwACgkQ3SOs138+
s6ErSg/7BxCJiw2nIRVibzrfjTKQZr9wRrBCWeJkTAdUdegWEC1Fs3kXTPhcn0o9
WE3Kf0uCOF+ej/I82iq0RMwYdxfYKj2kMvRnFVevuQpy4+aPap0+kEKlGtUzkL+u
hG1giljwaRQFY9CflQqpcSYl9JCAUc3oHacITKCWuJqhCTtck6PhZwoXYNPfjubV
ytrtKiq4sB25lG2I7xX+sGAqfOmhUtGzjNMAU0RVQePvQpNpa+GedHaxakBq/ZwL
M8aMSvBx+GDvtBhoT4k1zh6mF6sJfWsbMFbuM9MFRoEY1oxPleaJwS/ghmu5ibg5
NZxe04g0anypj2hoGTPK/U+1rg3uYHqMiDcyOdQSfb/a3dZ2EkVOnMKYKkCTi67U
Ep00SItdKLt/KIBIu0bQPDTtztn9Iqub97Y6XeGwqjaUCoWQtSSAsz/pxhBbno5X
Gth0gd6lU45atAOdV3ZVyltCMie8qHDXOY4QkHBpe3dhPuaYasSfVDCr+AXBXJg7
Mm1hoPVBFnSsyYpAKeyQjtfwd/yBJv6jJR2OojDrMUuIPg8FRDp9CXyCVly/cc70
rb6NwolHbXPyssiVNQfP530hJICHVq9O1tJG2UYHulhJJJbLde2Fx9LwdXod9/Tr
naDQhclatErIOSPYO3PhSoz1ymcu6LSd8I5eVd0J9HQ3JLUOIDk=
=V3S9
-----END PGP SIGNATURE-----

--SQSJUN4hek2YcMBJ--
