Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E02922F9DD
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 22:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgG0UKo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 16:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgG0UKo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 16:10:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD550C0619D2
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jul 2020 13:10:43 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k09SF-00059z-C9; Mon, 27 Jul 2020 22:10:35 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k09SF-00024P-15; Mon, 27 Jul 2020 22:10:35 +0200
Date:   Mon, 27 Jul 2020 22:10:34 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Martin Botka <martin.botka1@gmail.com>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH RCC 1/6] pwm: Add different PWM output types support
Message-ID: <20200727201034.dkc6qkkbte6qeiba@pengutronix.de>
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724213659.273599-2-martin.botka1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xyrkgru7urgfvznn"
Content-Disposition: inline
In-Reply-To: <20200724213659.273599-2-martin.botka1@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xyrkgru7urgfvznn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jul 24, 2020 at 11:36:51PM +0200, Martin Botka wrote:
> From: Fenglin Wu <fenglinw@codeaurora.org>
>=20
> Normally, PWM channel has fixed output until software request to change

"fixed" in the sense of "periodic", not "constant", right?

> its settings. There are some PWM devices which their outputs could be
> changed autonomously according to a predefined pattern programmed in
> hardware. Add pwm_output_type enum type to identify these two different
> PWM types and add relevant helper functions to set and get PWM output
> types and pattern.

You write "some devices". Which do you have in mind?

> [...]
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index 2389b8669846..4ee1e81db0bc 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c

adapting the sysfs stuff should be done in a separate step.

> @@ -215,11 +215,60 @@ static ssize_t capture_show(struct device *child,
>  	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
>  }
> =20
> +static ssize_t output_type_show(struct device *child,
> +							struct device_attribute *attr,
> +							char *buf)
> +{
> +	const struct pwm_device *pwm =3D child_to_pwm_device(child);
> +	const char *output_type =3D "unknown";
> +	struct pwm_state state;
> +
> +	pwm_get_state(pwm, &state);
> +	switch (state.output_type) {
> +	case PWM_OUTPUT_FIXED:
> +		output_type =3D "fixed";
> +		break;
> +	case PWM_OUTPUT_MODULATED:
> +		output_type =3D "modulated";
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", output_type);
> +}
> +
> +static ssize_t output_type_store(struct device *child,
> +								struct device_attribute *attr,
> +								const char *buf, size_t size)

Indention is broken here. Please align to the opening (.

> +{
> +	struct pwm_export *export =3D child_to_pwm_export(child);
> +	struct pwm_device *pwm =3D export->pwm;
> +	struct pwm_state state;
> +	int ret =3D -EINVAL;
> +
> +	mutex_lock(&export->lock);
> +	pwm_get_state(pwm, &state);
> +	if (sysfs_streq(buf, "fixed"))
> +		state.output_type =3D PWM_OUTPUT_FIXED;
> +	else if (sysfs_streq(buf, "modulated"))
> +		state.output_type =3D PWM_OUTPUT_MODULATED;
> +	else
> +		goto unlock;
> +
> +	ret =3D pwm_apply_state(pwm, &state);
> +unlock:
> +	mutex_unlock(&export->lock);
> +
> +	return ret ? : size;
> +}
> +
>  static DEVICE_ATTR_RW(period);
>  static DEVICE_ATTR_RW(duty_cycle);
>  static DEVICE_ATTR_RW(enable);
>  static DEVICE_ATTR_RW(polarity);
>  static DEVICE_ATTR_RO(capture);
> +static DEVICE_ATTR_RW(output_type);
> =20
>  static struct attribute *pwm_attrs[] =3D {
>  	&dev_attr_period.attr,
> @@ -227,6 +276,7 @@ static struct attribute *pwm_attrs[] =3D {
>  	&dev_attr_enable.attr,
>  	&dev_attr_polarity.attr,
>  	&dev_attr_capture.attr,
> +	&dev_attr_output_type.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(pwm);
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 2635b2a55090..10a102efadc4 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -48,6 +48,29 @@ enum {
>  	PWMF_EXPORTED =3D 1 << 1,
>  };
> =20
> +/*
> + * enum pwm_output_type - output type of the PWM signal
> + * @PWM_OUTPUT_FIXED: PWM output is fixed until a change request
> + * @PWM_OUTPUT_MODULATED: PWM output is modulated in hardware
> + * autonomously with a predefined pattern
> + */
> +enum pwm_output_type {
> +	PWM_OUTPUT_FIXED =3D 1 << 0,
> +	PWM_OUTPUT_MODULATED =3D 1 << 1,
> +};
> +
> +/*
> + * struct pwm_output_pattern - PWM duty pattern for MODULATED duty type
> + * @duty_pattern: PWM duty cycles in the pattern for duty modulation
> + * @num_entries: number of entries in the pattern
> + * @cycles_per_duty: number of PWM period cycles an entry stays at
> + */
> +struct pwm_output_pattern {
> +	unsigned int *duty_pattern;
> +	unsigned int num_entries;
> +	unsigned int cycles_per_duty;
> +};

I don't understand the semantics here. (i.e. how does a given
pwm_output_pattern map to the intended wave form?)

> +
>  /*
>   * struct pwm_state - state of a PWM channel
>   * @period: PWM period (in nanoseconds)
> @@ -59,6 +82,8 @@ struct pwm_state {
>  	unsigned int period;
>  	unsigned int duty_cycle;
>  	enum pwm_polarity polarity;
> +	enum pwm_output_type output_type;
> +	struct pwm_output_pattern *output_pattern;
>  	bool enabled;
>  };
> =20
> @@ -146,6 +171,26 @@ static inline enum pwm_polarity pwm_get_polarity(con=
st struct pwm_device *pwm)
>  	return state.polarity;
>  }
> =20
> +static inline enum pwm_output_type pwm_get_output_type(
> +				const struct pwm_device *pwm)
> +{
> +	struct pwm_state state;
> +
> +	pwm_get_state(pwm, &state);
> +
> +	return state.output_type;
> +}
> +
> +static inline struct pwm_output_pattern *pwm_get_output_pattern(
> +				struct pwm_device *pwm)
> +{
> +	struct pwm_state state;
> +
> +	pwm_get_state(pwm, &state);
> +
> +	return pwm->state.output_pattern ?: NULL;

Who is the owner of the data behind this pointer? Is it expected to be
valid only until the next call to change the output? What happens if the
caller modifies the data returned?

> +}
> +
>  static inline void pwm_get_args(const struct pwm_device *pwm,
>  				struct pwm_args *args)
>  {
> @@ -254,6 +299,9 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, =
unsigned int duty_cycle,
>   * @set_polarity: configure the polarity of this PWM
>   * @enable: enable PWM output toggling
>   * @disable: disable PWM output toggling
> + * @get_output_type_supported: get the supported output type
> + * @set_output_type: set PWM output type
> + * @set_output_pattern: set the pattern for the modulated output
>   */
>  struct pwm_ops {
>  	int (*request)(struct pwm_chip *chip, struct pwm_device *pwm);
> @@ -273,6 +321,13 @@ struct pwm_ops {
>  			    enum pwm_polarity polarity);
>  	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
>  	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
> +	int (*get_output_type_supported)(struct pwm_chip *chip,
> +			    struct pwm_device *pwm);
> +	int (*set_output_type)(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    enum pwm_output_type output_type);
> +	int (*set_output_pattern)(struct pwm_chip *chip,
> +			    struct pwm_device *pwm,
> +			    struct pwm_output_pattern *output_pattern);

This doesn't match the atomic approach that we're following since the
introduction of .apply. Please don't add new non-atomic callbacks.

>  };
> =20
>  /**
> @@ -318,6 +373,20 @@ void pwm_free(struct pwm_device *pwm);
>  int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *stat=
e);
>  int pwm_adjust_config(struct pwm_device *pwm);
> =20
> +/*
> + * pwm_output_type_support()
> + * @pwm: PWM device
> + *
> + * Returns:  output types supported by the PWM device
> + */
> +static inline int pwm_get_output_type_supported(struct pwm_device *pwm)
> +{
> +	if (pwm->chip->ops->get_output_type_supported !=3D NULL)
> +		return pwm->chip->ops->get_output_type_supported(pwm->chip, pwm);
> +	else
> +		return PWM_OUTPUT_FIXED;
> +}

I don't like this "advertising" for specific functions. I'd prefer to
handle this in .apply(), fix all drivers to return -ESOMETHING when the
request cannot be fulfilled.

Having said that I wonder if this output pattern is a common enough
property to add support for it in the PWM framework.

If the only usage is to drive a LED this might maybe better be a
dedicated LED driver? (Though I'm not sure this is a good idea either.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xyrkgru7urgfvznn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8fNLYACgkQwfwUeK3K
7AlzrAf/f4Vj575p9tHeiKqkrcSCJ5u5wzVJHtRw9YgiNHNew4Jieygwg0TiAUjP
cK0XLw6fYUlp5qrJaBWTiNV8kJjW4lRLL6nGRzF2gqETRu88r/VH3V2qCoxcbdf7
LJEiB4itt0vYsKVD6FUHRPnpZAbrjdAXNAij4yxTSPRCw87a+DZrp5p8yUXziXqk
HwB7nTJVuS7eP02xyclaqKoERNMCu47TAADB1HvC4of5H2zRKojXzHjKWfbHqJ+P
15Ds/SJLYcjrJETXhUflt1brIJPKU1LMhleaiHS8oG6h5+xtwLywV8V4f5ka8nJY
2BD03W+kK8RBycNJWV+ZIaRYalsK0Q==
=byXh
-----END PGP SIGNATURE-----

--xyrkgru7urgfvznn--
