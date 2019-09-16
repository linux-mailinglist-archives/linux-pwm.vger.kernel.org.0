Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48DD4B3C0E
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2019 16:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbfIPOBx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Sep 2019 10:01:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39347 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbfIPOBx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Sep 2019 10:01:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so10025018wml.4;
        Mon, 16 Sep 2019 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MJLLYmU54a4xaRGmKBckleHVBVuJ7R5VnrshdzzxD4A=;
        b=MjVYgM0Ui+70erQUFwva8j3TX7YSxY6bZ/0O7fQ5BjrMgbmQ11pq5U6x1lB7tKUsK9
         LSxy/wBBgXwQ5eMRCOxrokq8U8kolgwUzVvYdMMG3f0P4y+Bvu3NXRfbq5/S88XqZGk5
         fw8PYMFVLpRVQsR8+MZV0GVegMtnvvv1OSS/nfSollvcZzoLf5YkzUxZEZtOX/zpb8Rq
         JADhTSqqsgh4JIKz6QqKQdhvi1EgbFMQO6u0yf5zrVHiBbzR73UughkZreXbftTKjo57
         8hlpmHmKKCePXATKmB9OsiAw8a6YnJYKOk0hZsFhEHYmKuLUqDyhATMQMZT99bIpx8eU
         fwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MJLLYmU54a4xaRGmKBckleHVBVuJ7R5VnrshdzzxD4A=;
        b=PtbmGG85By6XQnGDMJXVmEUIXMY7+BuV7VEJBspn8EiqAR/qaMIlvk+9uuqQPL8rBl
         tnh+/k3En+zZVY3ieICzEhb48UMwaAB8tw0vE4XQqIwo7OnUK/sCranBe9J4OwjpMrME
         gtXblwPNog7LY0eAzAPoShtIYNem4lvy39ucgUPkGk0OG4wllXjipPszlyIRu0lO2uQY
         6+R0MqjgAHBQWYl/nLvwzHfaTi4Dvm6ULyM6dQxULvt/L2kSJ5eZkMvLyLU1raV3njf1
         vjafyo5TTmH5dFaaaovgdCFLlmQfEIXd8V5JBdv8nGxzqZgW0qgHaeovs0GelszI1eu9
         uqBA==
X-Gm-Message-State: APjAAAXX+Vw4qJReprEjMMHBu9r7xv0rHgI/OKAXZ8Q3m9wRyZuaBZzF
        VYE/hwWI/B14VyGdHILveLo=
X-Google-Smtp-Source: APXvYqzbfOuk7bFgrhYVh39kc7nSu+vgqGsLzsdEu077Qtm3C0to2fR7+FwuVxpXiTdFpZYWXYkk8w==
X-Received: by 2002:a1c:a90b:: with SMTP id s11mr15324071wme.92.1568642509221;
        Mon, 16 Sep 2019 07:01:49 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id m16sm11063893wml.11.2019.09.16.07.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 07:01:47 -0700 (PDT)
Date:   Mon, 16 Sep 2019 16:01:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org, kernel-team@android.com,
        Mark Salyzyn <salyzyn@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, Fenglin Wu <fenglinw@codeaurora.org>
Subject: Re: [PATCH 1/2] pwm: Add different PWM output types support
Message-ID: <20190916140146.GC7488@ulmo>
References: <1568415464-20267-1-git-send-email-gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
In-Reply-To: <1568415464-20267-1-git-send-email-gurus@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2019 at 03:57:43PM -0700, Guru Das Srinagesh wrote:
> From: Fenglin Wu <fenglinw@codeaurora.org>
>=20
> Normally, PWM channel has fixed output until software request to change
> its settings. There are some PWM devices which their outputs could be
> changed autonomously according to a predefined pattern programmed in
> hardware. Add pwm_output_type enum type to identify these two different
> PWM types and add relevant helper functions to set and get PWM output
> types and pattern.
>=20
> Change-Id: Ia1f914a45ab4f4dd7be037a395eeb89d0e65a80e
> Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/core.c  | 26 ++++++++++++++++++++
>  drivers/pwm/sysfs.c | 50 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pwm.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 146 insertions(+)

This doesn't seem right to me. Are you describing a PWM pin that's
actually driven in GPIO mode? We usually configure that using pinctrl.

Thierry

>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 8edfac1..960a451 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -282,6 +282,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>  		pwm->pwm =3D chip->base + i;
>  		pwm->hwpwm =3D i;
>  		pwm->state.polarity =3D polarity;
> +		pwm->state.output_type =3D PWM_OUTPUT_FIXED;
> =20
>  		if (chip->ops->get_state)
>  			chip->ops->get_state(chip, pwm, &pwm->state);
> @@ -498,6 +499,31 @@ int pwm_apply_state(struct pwm_device *pwm, struct p=
wm_state *state)
>  			pwm->state.polarity =3D state->polarity;
>  		}
> =20
> +		if (state->output_type !=3D pwm->state.output_type) {
> +			if (!pwm->chip->ops->set_output_type)
> +				return -ENOTSUPP;
> +
> +			err =3D pwm->chip->ops->set_output_type(pwm->chip, pwm,
> +						state->output_type);
> +			if (err)
> +				return err;
> +
> +			pwm->state.output_type =3D state->output_type;
> +		}
> +
> +		if (state->output_pattern !=3D pwm->state.output_pattern &&
> +				state->output_pattern !=3D NULL) {
> +			if (!pwm->chip->ops->set_output_pattern)
> +				return -ENOTSUPP;
> +
> +			err =3D pwm->chip->ops->set_output_pattern(pwm->chip,
> +					pwm, state->output_pattern);
> +			if (err)
> +				return err;
> +
> +			pwm->state.output_pattern =3D state->output_pattern;
> +		}
> +
>  		if (state->period !=3D pwm->state.period ||
>  		    state->duty_cycle !=3D pwm->state.duty_cycle) {
>  			err =3D pwm->chip->ops->config(pwm->chip, pwm,
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index 2389b86..ab703f2 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -215,11 +215,60 @@ static ssize_t capture_show(struct device *child,
>  	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
>  }
> =20
> +static ssize_t output_type_show(struct device *child,
> +			     struct device_attribute *attr,
> +			     char *buf)
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
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t size)
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
> @@ -227,6 +276,7 @@ static ssize_t capture_show(struct device *child,
>  	&dev_attr_enable.attr,
>  	&dev_attr_polarity.attr,
>  	&dev_attr_capture.attr,
> +	&dev_attr_output_type.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(pwm);
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 24632a7..416f08e 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -48,6 +48,29 @@ enum {
>  	PWMF_EXPORTED =3D 1 << 1,
>  };
> =20
> +/**
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
> +/**
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
> @@ -144,6 +169,26 @@ static inline enum pwm_polarity pwm_get_polarity(con=
st struct pwm_device *pwm)
>  	return state.polarity;
>  }
> =20
> +static inline enum pwm_output_type pwm_get_output_type(
> +		const struct pwm_device *pwm)
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
> +}
> +
>  static inline void pwm_get_args(const struct pwm_device *pwm,
>  				struct pwm_args *args)
>  {
> @@ -250,6 +295,9 @@ static inline void pwm_init_state(const struct pwm_de=
vice *pwm,
>   * @get_state: get the current PWM state. This function is only
>   *	       called once per PWM device when the PWM chip is
>   *	       registered.
> + * @get_output_type_supported: get the supported output type
> + * @set_output_type: set PWM output type
> + * @set_output_pattern: set the pattern for the modulated output
>   * @owner: helps prevent removal of modules exporting active PWMs
>   * @config: configure duty cycles and period length for this PWM
>   * @set_polarity: configure the polarity of this PWM
> @@ -265,6 +313,13 @@ struct pwm_ops {
>  		     struct pwm_state *state);
>  	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
>  			  struct pwm_state *state);
> +	int (*get_output_type_supported)(struct pwm_chip *chip,
> +			struct pwm_device *pwm);
> +	int (*set_output_type)(struct pwm_chip *chip, struct pwm_device *pwm,
> +			enum pwm_output_type output_type);
> +	int (*set_output_pattern)(struct pwm_chip *chip,
> +			struct pwm_device *pwm,
> +			struct pwm_output_pattern *output_pattern);
>  	struct module *owner;
> =20
>  	/* Only used by legacy drivers */
> @@ -320,6 +375,21 @@ struct pwm_capture {
>  int pwm_adjust_config(struct pwm_device *pwm);
> =20
>  /**
> + * pwm_output_type_support()
> + * @pwm: PWM device
> + *
> + * Returns:  output types supported by the PWM device
> + */
> +static inline int pwm_get_output_type_supported(struct pwm_device *pwm)
> +{
> +	if (pwm->chip->ops->get_output_type_supported !=3D NULL)
> +		return pwm->chip->ops->get_output_type_supported(pwm->chip,
> +				pwm);
> +	else
> +		return PWM_OUTPUT_FIXED;
> +}
> +
> +/**
>   * pwm_config() - change a PWM device configuration
>   * @pwm: PWM device
>   * @duty_ns: "on" time (in nanoseconds)
> --=20
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>=20

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1/lcoACgkQ3SOs138+
s6GM0A/+IRUR5WGQo40/BHtmMW53AXJJEf7dZK44p/Fnx4wgEG4bIc5bxKYL9ECj
vXTT5eoVCd17oA1pObpnzXMi4cZDGtVhkr/iYG1Uz+ejAsxESlBwtxdU+qoLIOqd
iDl0e+pNHwJ1bYCAg2oKMtxLk3fucDnTqZQGL1BEQRZ5xKP1hSFmPwB3hyHiMf9Y
lo+PAppmylD0CNmGDCLy0eYXq6KuXbiZrmAtdeQ8POpxAV6MJzYSV3hvGODHmSB5
o5XRfZiP/6ciSncq0go/K8k8kHcNKWM5UwMneUYvSYw9csZtCn4W9y9r14aNOJQz
L4XCrBKmC16sBHohiG2mJdxEdPLXbqJNLErqJa9LgbljH0rcA3C5OlKYIscIdSI7
LedrTYo1kBKrHSgM8CXwx0k25ArEDMzYVAe/385A3YDn4/AaTab/k+eNkIfqjj6S
TgCbIXr+nB1g32S6CUZ65vJXe3M9PBnGTxtCiGeWBKoQWXNRDMqkCPY9kdgT25la
DFQzEuCcFapWF5HHTILIeCJWGGV02nm6cLkZ2gCT9irOK1f4RilgK2yP4joEJk4X
MICxurACtQtu6rRiBKsHDauZewdHm7a+ha/6X/m2chOhY+oC+v8SylSsALO5E/tj
SNmjtSqmMgleEXhjR62+iWRsTXXR4zsr1X2jhHQAgsgG56+ey9U=
=6J/Y
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
