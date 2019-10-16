Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADF6D89FF
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 09:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfJPHlk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 03:41:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46304 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfJPHlk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 03:41:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so26714785wrv.13;
        Wed, 16 Oct 2019 00:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G2RiC5j4ZC+QNkltEYjAf3/AmJoRh3yjXVN3pTFgAVM=;
        b=l7BUnwKwcMvzSnIW1ly4qOp6Dhg5EoealJKK/k5zXJMeeDJ5iRFB3DGyxyRMrcQQri
         zA2pMn3C5Eo6/KM8B9EDA+TFfDDYmRL5Ezh/Wm+Gk+nA8goGbGLt2e8MFB0V1sZp7ipQ
         i82hnaERCLSKfBOQgIx2qWR/7sOkCfLDnjMBw2A99Sc5AUa3nPRA2tOscUbf/0O6rpev
         6yjR3Tg2+Vz2l0WtBH1mzy23K09++asH4E1aRftQuN99imuzFDLwOmtl5aJJfhgoc4yF
         c32P/Xiy0z52vsUajta72bADi1xiMjMO66R/pAW76Ijf6ZYoInYQ1fFDJyHsJY/lwgjy
         JY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G2RiC5j4ZC+QNkltEYjAf3/AmJoRh3yjXVN3pTFgAVM=;
        b=prqzweSHoXzWAbLxwq7Tc8mf9HIx+5ivW824oelnxcSSd3c6qwy0Uyc2Z7miM1IZvc
         16EotzIwEdtC1VFYB8k0c94VLKHeuKeCfmsTzoFxZxQbgEP4BLe7YHQNTMjsUv/zuH8w
         a1sPodt6ET7jl2Rxa2gYZ9e7m2a7S8bB4F9tjyYfqG0HhOVSgHst8AVHngaiF2aShkam
         Ru5Buz3REkHbMj5FaFwtb7RfEvfgqN6TdzS8ezTlTpM7WkmiwfJme7YEA7kRoFMGkI2b
         5o7ztajAheTvdQlC92rfHH37UOyLpAWDxtSi6gwnuXiecr7TJJrfePMXMXzxTHpNwXgF
         pCOQ==
X-Gm-Message-State: APjAAAWSkjJHtBNAxoL43a/mH6cROZwOnVNhiHbPSNqRZQuYriKGxTk/
        RSnfN47rb6YklucRlN+O9ZA=
X-Google-Smtp-Source: APXvYqwEsUuM0WyqMH+c7Nxa7MjVdmr00UhNnF3QHbFLupUGFRUp/AYeMfMtzGbBkjBDEv6Tuq7YKg==
X-Received: by 2002:a5d:540e:: with SMTP id g14mr1428833wrv.177.1571211697122;
        Wed, 16 Oct 2019 00:41:37 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id k24sm6145176wmi.1.2019.10.16.00.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:41:35 -0700 (PDT)
Date:   Wed, 16 Oct 2019 09:41:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org, kernel-team@android.com,
        Mark Salyzyn <salyzyn@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pwm: Convert period and duty cycle to u64
Message-ID: <20191016074134.GE1296874@ulmo>
References: <1571191899-6150-1-git-send-email-gurus@codeaurora.org>
 <1571191899-6150-2-git-send-email-gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline
In-Reply-To: <1571191899-6150-2-git-send-email-gurus@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2019 at 07:11:39PM -0700, Guru Das Srinagesh wrote:
> Because period and duty cycle are defined as ints with units of
> nanoseconds, the maximum time duration that can be set is limited to
> ~2.147 seconds. Change their definitions to u64 so that higher durations
> may be set.
>=20
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/core.c  |  4 ++--
>  drivers/pwm/sysfs.c | 10 +++++-----
>  include/linux/pwm.h | 16 ++++++++--------
>  3 files changed, 15 insertions(+), 15 deletions(-)

Applied, thanks.

Thierry

> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 6ad51aa..dc79c03 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -1163,8 +1163,8 @@ static void pwm_dbg_show(struct pwm_chip *chip, str=
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
> index 2389b86..3fb1610 100644
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
> @@ -52,10 +52,10 @@ static ssize_t period_store(struct device *child,
>  	struct pwm_export *export =3D child_to_pwm_export(child);
>  	struct pwm_device *pwm =3D export->pwm;
>  	struct pwm_state state;
> -	unsigned int val;
> +	u64 val;
>  	int ret;
> =20
> -	ret =3D kstrtouint(buf, 0, &val);
> +	ret =3D kstrtou64(buf, 0, &val);
>  	if (ret)
>  		return ret;
> =20
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
>  static DEVICE_ATTR_RW(period);
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index b2c9c46..1efdd63 100644
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
> @@ -56,8 +56,8 @@ enum {
>   * @enabled: PWM enabled status
>   */
>  struct pwm_state {
> -	unsigned int period;
> -	unsigned int duty_cycle;
> +	u64 period;
> +	u64 duty_cycle;
>  	enum pwm_polarity polarity;
>  	bool enabled;
>  };
> @@ -105,13 +105,13 @@ static inline bool pwm_is_enabled(const struct pwm_=
device *pwm)
>  	return state.enabled;
>  }
> =20
> -static inline void pwm_set_period(struct pwm_device *pwm, unsigned int p=
eriod)
> +static inline void pwm_set_period(struct pwm_device *pwm, u64 period)
>  {
>  	if (pwm)
>  		pwm->state.period =3D period;
>  }
> =20
> -static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
> +static inline u64 pwm_get_period(const struct pwm_device *pwm)
>  {
>  	struct pwm_state state;
> =20
> @@ -126,7 +126,7 @@ static inline void pwm_set_duty_cycle(struct pwm_devi=
ce *pwm, unsigned int duty)
>  		pwm->state.duty_cycle =3D duty;
>  }
> =20
> -static inline unsigned int pwm_get_duty_cycle(const struct pwm_device *p=
wm)
> +static inline u64 pwm_get_duty_cycle(const struct pwm_device *pwm)
>  {
>  	struct pwm_state state;
> =20
> @@ -308,8 +308,8 @@ struct pwm_chip {
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
> --=20
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>=20

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2mya4ACgkQ3SOs138+
s6FBTg/9HxvrPqbqcQrp36je+9mg0wOu6IRZgSJnWjsrWQmUHA5jZcmToEWYwlUA
4oLcy5TYRte50DkE7gDP0A2A94gMeFEUDQaoXLXYUNTF4d6hSK6BF0Yrao2wX3+c
IZv4/LoGfSmGdMwxmT0Jg+UFYub481YbNOANHJXCq1qWQpXVT6zm3RMv1GVMnj1Y
E/m5kwrJuql7wKMQIIwEu0Yoyop4Tc9rdK1jQvw06CkShc6pTOG6Y+QjUYstNtDR
IwHv7Adp2kaUKgoO9nFzVCcOgKgKMfHwGKkjUa0Gqu7+OpOEe1UgeMeYs1Ih9hJL
PH7RhrXErru8ZNjDi8DTDQ5jViuLEAdiTYJ8UMP+dTgqoPb2S4XSFCSdWwVnJKGR
64HA9NQUOTTr6wHdO5VowOwA+rtnlgKSSOtKpcV9ToXJOLv6PIK3lRl6C8gGwR2k
hHhHiiUmW/kQZEAWzwMfTjYt3LibnRgrxbVwC3amXBdBkjXFXs8/+9drTMZVQWFB
aaKX40MoLDbkgfEKdM/S2cWzT2Me1xRIGv0q8oCSyjWOZdUQ8SggPCJaVo+9FbzO
/F1c4xe972AXziz51nZmpMFNLIvRrULI/6AwSxiwK2zrojO3NintC6syAninpetq
zkNEseFdiq+asEwsdEDsedTMEQEz/VMgGBCADFBbDXoGIEs09Q4=
=REYO
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--
