Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD340B3C04
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2019 16:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbfIPOAz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Sep 2019 10:00:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41186 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbfIPOAy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Sep 2019 10:00:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so38006935wrw.8;
        Mon, 16 Sep 2019 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qd2PZquZEt7TGu4jipazWdI04SsgSJSCx5Z0Sk9nhnA=;
        b=M9SGoML+RjJma+CxOKH34G6igseJZlCRWdiLNQuoWY/CqV6m8RxRR2YCI81rtmosnV
         FZFvPw8hPCPGgoacBKngQgbWnqQijQsY9zegcWRV/Pz4LDRLgwMctCDCb+v57bJCkVP2
         C2kO/eHCMSgzDem66tCFZTPhZz4q2dC/FLYHYEYUuYS97C2L525Hxr6EYt0m84JYrgzR
         9PtUhvozEiOKkyJ2C8tFK5vItr+LoJkgQoWCX2G/bFLY76FbGN7mpXM5Y1hLoqfFl/Dc
         OwKSDJQqpSt7/Uo2HcVVjz7Y0BzTdmbMOFOvpr7qHuenNyE22q0pTTCnjCuIDeN1GL32
         NcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qd2PZquZEt7TGu4jipazWdI04SsgSJSCx5Z0Sk9nhnA=;
        b=SvhgxDu39TKiuPHHaB2H9ZXpEjlfwOWwNu0q8vGgnEBJQzfMuijS77mcfZ1+oYw54E
         gCDMS03munBpCThzIQbZkue5g3jXIe7xxrmhyx5lPMrpnJZctzr1RHd78/+dOWko8z76
         59eO+DVeJMsMEiToIg9NEESvm09NNIm0IFkCBYdK7qoEHd8YNMC9LLH3th3ipHDYc8az
         cs1k/uFEvcKTgHi6NIedzzyexhyNmyTaYyuH5CCunP5xLxNSbsoALpG0N3yMVVgg3lA2
         PUt5S6XfW5Ug5AITRoS7o/0TeVelu9WGw7eEhdVaXEXZpz1cMi4+4ANcs+0Za0eQfSo/
         CenQ==
X-Gm-Message-State: APjAAAVtRdYsaP8K2jO54TwlC8ZGUQk9cs7IELg9Dddh5plogyje6l+3
        jozRMD2Y7as3ua6bbPKnfbtS4KSV
X-Google-Smtp-Source: APXvYqxGdRKXIJywqHIeb6KasqZt7UcKkIFWP0u4ZT0IIy6fMs/8eCXjhQ/gLPAWGRgvEgTc4ys/GA==
X-Received: by 2002:adf:fc05:: with SMTP id i5mr899883wrr.134.1568642450856;
        Mon, 16 Sep 2019 07:00:50 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id v6sm25414392wma.24.2019.09.16.07.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 07:00:49 -0700 (PDT)
Date:   Mon, 16 Sep 2019 16:00:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org, kernel-team@android.com,
        Mark Salyzyn <salyzyn@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, Fenglin Wu <fenglinw@codeaurora.org>
Subject: Re: [PATCH 2/2] pwm: core: Add option to config PWM duty/period with
 u64 data length
Message-ID: <20190916140048.GB7488@ulmo>
References: <1568415464-20267-1-git-send-email-gurus@codeaurora.org>
 <1568415464-20267-2-git-send-email-gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <1568415464-20267-2-git-send-email-gurus@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2019 at 03:57:44PM -0700, Guru Das Srinagesh wrote:
> From: Fenglin Wu <fenglinw@codeaurora.org>
>=20
> Currently, PWM core driver provides interfaces for configuring PWM
> period and duty length in nanoseconds with an integer data type, so
> the max period can be only set to ~2.147 seconds. Add interfaces which
> can set PWM period and duty with u64 data type to remove this
> limitation.
>=20
> Change-Id: Ic8722088510d447fc939ab6a5014711aef1b832f
> Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/core.c  |  20 ++++++---
>  drivers/pwm/sysfs.c |   6 +--
>  include/linux/pwm.h | 115 ++++++++++++++++++++++++++++++++++++++++++++++=
++----
>  3 files changed, 126 insertions(+), 15 deletions(-)

pwm_ops->config() is considered legacy API and only remains for drivers
that haven't been converted to the atomic API yet. If you want to extend
the range for period and duty cycle, please add that to the atomic API,
which is pwm_ops->apply() and struct pwm_state.

Thierry

>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 960a451..02ad16b 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -526,9 +526,19 @@ int pwm_apply_state(struct pwm_device *pwm, struct p=
wm_state *state)
> =20
>  		if (state->period !=3D pwm->state.period ||
>  		    state->duty_cycle !=3D pwm->state.duty_cycle) {
> -			err =3D pwm->chip->ops->config(pwm->chip, pwm,
> -						     state->duty_cycle,
> -						     state->period);
> +			if (pwm->chip->ops->config_extend) {
> +				err =3D pwm->chip->ops->config_extend(pwm->chip,
> +						pwm, state->duty_cycle,
> +						state->period);
> +			} else {
> +				if (state->period > UINT_MAX)
> +					pr_warn("period %llu duty_cycle %llu will be truncated\n",
> +							state->period,
> +							state->duty_cycle);
> +				err =3D pwm->chip->ops->config(pwm->chip, pwm,
> +						state->duty_cycle,
> +						state->period);
> +			}
>  			if (err)
>  				return err;
> =20
> @@ -1181,8 +1191,8 @@ static void pwm_dbg_show(struct pwm_chip *chip, str=
uct seq_file *s)
>  		if (state.enabled)
>  			seq_puts(s, " enabled");
> =20
> -		seq_printf(s, " period: %u ns", state.period);
> -		seq_printf(s, " duty: %u ns", state.duty_cycle);
> +		seq_printf(s, " period: %llu ns", state.period);
> +		seq_printf(s, " duty: %llu ns", state.duty_cycle);
>  		seq_printf(s, " polarity: %s",
>  			   state.polarity ? "inverse" : "normal");
> =20
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index ab703f2..ef78c40 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -42,7 +42,7 @@ static ssize_t period_show(struct device *child,
> =20
>  	pwm_get_state(pwm, &state);
> =20
> -	return sprintf(buf, "%u\n", state.period);
> +	return sprintf(buf, "%llu\n", state.period);
>  }
> =20
>  static ssize_t period_store(struct device *child,
> @@ -77,7 +77,7 @@ static ssize_t duty_cycle_show(struct device *child,
> =20
>  	pwm_get_state(pwm, &state);
> =20
> -	return sprintf(buf, "%u\n", state.duty_cycle);
> +	return sprintf(buf, "%llu\n", state.duty_cycle);
>  }
> =20
>  static ssize_t duty_cycle_store(struct device *child,
> @@ -212,7 +212,7 @@ static ssize_t capture_show(struct device *child,
>  	if (ret)
>  		return ret;
> =20
> -	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
> +	return sprintf(buf, "%llu %llu\n", result.period, result.duty_cycle);
>  }
> =20
>  static ssize_t output_type_show(struct device *child,
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 416f08e..d714385 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -39,7 +39,7 @@ enum pwm_polarity {
>   * current PWM hardware state.
>   */
>  struct pwm_args {
> -	unsigned int period;
> +	u64 period;
>  	enum pwm_polarity polarity;
>  };
> =20
> @@ -66,9 +66,9 @@ enum pwm_output_type {
>   * @cycles_per_duty: number of PWM period cycles an entry stays at
>   */
>  struct pwm_output_pattern {
> -	unsigned int *duty_pattern;
> +	u64 *duty_pattern;
>  	unsigned int num_entries;
> -	unsigned int cycles_per_duty;
> +	u64 cycles_per_duty;
>  };
> =20
>  /*
> @@ -79,8 +79,8 @@ struct pwm_output_pattern {
>   * @enabled: PWM enabled status
>   */
>  struct pwm_state {
> -	unsigned int period;
> -	unsigned int duty_cycle;
> +	u64 period;
> +	u64 duty_cycle;
>  	enum pwm_polarity polarity;
>  	enum pwm_output_type output_type;
>  	struct pwm_output_pattern *output_pattern;
> @@ -136,12 +136,30 @@ static inline void pwm_set_period(struct pwm_device=
 *pwm, unsigned int period)
>  		pwm->state.period =3D period;
>  }
> =20
> +static inline void pwm_set_period_extend(struct pwm_device *pwm, u64 per=
iod)
> +{
> +	if (pwm)
> +		pwm->state.period =3D period;
> +}
> +
>  static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
>  {
>  	struct pwm_state state;
> =20
>  	pwm_get_state(pwm, &state);
> =20
> +	if (state.period > UINT_MAX)
> +		pr_warn("PWM period %llu is truncated\n", state.period);
> +
> +	return (unsigned int)state.period;
> +}
> +
> +static inline u64 pwm_get_period_extend(const struct pwm_device *pwm)
> +{
> +	struct pwm_state state;
> +
> +	pwm_get_state(pwm, &state);
> +
>  	return state.period;
>  }
> =20
> @@ -151,12 +169,30 @@ static inline void pwm_set_duty_cycle(struct pwm_de=
vice *pwm, unsigned int duty)
>  		pwm->state.duty_cycle =3D duty;
>  }
> =20
> +static inline void pwm_set_duty_cycle_extend(struct pwm_device *pwm, u64=
 duty)
> +{
> +	if (pwm)
> +		pwm->state.duty_cycle =3D duty;
> +}
> +
>  static inline unsigned int pwm_get_duty_cycle(const struct pwm_device *p=
wm)
>  {
>  	struct pwm_state state;
> =20
>  	pwm_get_state(pwm, &state);
> =20
> +	if (state.duty_cycle > UINT_MAX)
> +		pr_warn("PWM duty cycle %llu is truncated\n", state.duty_cycle);
> +
> +	return (unsigned int)state.duty_cycle;
> +}
> +
> +static inline u64 pwm_get_duty_cycle_extend(const struct pwm_device *pwm)
> +{
> +	struct pwm_state state;
> +
> +	pwm_get_state(pwm, &state);
> +
>  	return state.duty_cycle;
>  }
> =20
> @@ -300,6 +336,8 @@ static inline void pwm_init_state(const struct pwm_de=
vice *pwm,
>   * @set_output_pattern: set the pattern for the modulated output
>   * @owner: helps prevent removal of modules exporting active PWMs
>   * @config: configure duty cycles and period length for this PWM
> + * @config_extend: configure duty cycles and period length for this
> + *	PWM with u64 data type
>   * @set_polarity: configure the polarity of this PWM
>   * @enable: enable PWM output toggling
>   * @disable: disable PWM output toggling
> @@ -325,6 +363,8 @@ struct pwm_ops {
>  	/* Only used by legacy drivers */
>  	int (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
>  		      int duty_ns, int period_ns);
> +	int (*config_extend)(struct pwm_chip *chip, struct pwm_device *pwm,
> +		      u64 duty_ns, u64 period_ns);
>  	int (*set_polarity)(struct pwm_chip *chip, struct pwm_device *pwm,
>  			    enum pwm_polarity polarity);
>  	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
> @@ -363,8 +403,8 @@ struct pwm_chip {
>   * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
>   */
>  struct pwm_capture {
> -	unsigned int period;
> -	unsigned int duty_cycle;
> +	u64 period;
> +	u64 duty_cycle;
>  };
> =20
>  #if IS_ENABLED(CONFIG_PWM)
> @@ -418,6 +458,67 @@ static inline int pwm_config(struct pwm_device *pwm,=
 int duty_ns,
>  }
> =20
>  /**
> + * pwm_config_extend() - change PWM period and duty length with u64 data=
 type
> + * @pwm: PWM device
> + * @duty_ns: "on" time (in nanoseconds)
> + * @period_ns: duration (in nanoseconds) of one cycle
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +static inline int pwm_config_extend(struct pwm_device *pwm, u64 duty_ns,
> +			     u64 period_ns)
> +{
> +	struct pwm_state state;
> +
> +	if (!pwm)
> +		return -EINVAL;
> +
> +	pwm_get_state(pwm, &state);
> +	if (state.duty_cycle =3D=3D duty_ns && state.period =3D=3D period_ns)
> +		return 0;
> +
> +	state.duty_cycle =3D duty_ns;
> +	state.period =3D period_ns;
> +	return pwm_apply_state(pwm, &state);
> +}
> +
> +/**
> + * pwm_set_polarity() - configure the polarity of a PWM signal
> + * @pwm: PWM device
> + * @polarity: new polarity of the PWM signal
> + *
> + * Note that the polarity cannot be configured while the PWM device is
> + * enabled.
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +static inline int pwm_set_polarity(struct pwm_device *pwm,
> +				   enum pwm_polarity polarity)
> +{
> +	struct pwm_state state;
> +
> +	if (!pwm)
> +		return -EINVAL;
> +
> +	pwm_get_state(pwm, &state);
> +	if (state.polarity =3D=3D polarity)
> +		return 0;
> +
> +	/*
> +	 * Changing the polarity of a running PWM without adjusting the
> +	 * dutycycle/period value is a bit risky (can introduce glitches).
> +	 * Return -EBUSY in this case.
> +	 * Note that this is allowed when using pwm_apply_state() because
> +	 * the user specifies all the parameters.
> +	 */
> +	if (state.enabled)
> +		return -EBUSY;
> +
> +	state.polarity =3D polarity;
> +	return pwm_apply_state(pwm, &state);
> +}
> +
> +/**
>   * pwm_enable() - start a PWM output toggling
>   * @pwm: PWM device
>   *
> --=20
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>=20

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1/lZAACgkQ3SOs138+
s6Gr9w//fWzdVFYyV5O4upWdw2GnsmaWBHWyYbrYTqnnOUJ+shyIUee36nwUEr9c
TGxLFUIfJrAOCd5zifME3fT+DQouOWdvvicgcUExJUSpetcB9Tcf2eYqnbQtjaox
VLycmqxFwqzY74nWG6vpSykDNlFdrGtkGRJcxENVW1Rb6DvNbKpf1GVqzhd7VmB6
Hii42L/li0eN08pwgxLgXmIFZo7wdhQf+wOYjE8BKliRs2hYhaTQX1bYFB8mpEjD
7mjvxRZeU664MjagRh0Dcxrv4iNGFzRsQroImWKrPivQRIMeBrWZk1n74QKI4G/e
m+xM72T4qD0I6oJ2tqd/Cm2JiM4UlxcsZMMDDCS8FOCRJiikFMVC8Y+WvjY/gxWI
qA0MOQXS5IRp+oGSOyngbEqBaRvQmVW5pwN3ZjWQxaogUvkUAbfLehkEtuPit7/t
oYw8SvTooWxkpNzGnDsmdhgQF2W5pBE+phQwEag7/TVrKCQ4elBuEyslQQ5D5hbp
u8Z95VP6JOOtSAJxOp7KnZmg+aV8zViq0utF56OYeFE0TZeh/onkCjTdgixcALGc
qf9oYm/gRClvo15pQhVXiQbp8q2C7OOYdy2iGo6GiCnEC4GuPxpmicaXQ+LAeHjL
0i481/q/XGq60Rbzl4f8fqtTqFVine3uUJNT/RDkhM8X8EhpF0c=
=j7hY
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
