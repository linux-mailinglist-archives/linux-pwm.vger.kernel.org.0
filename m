Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C542D88E0
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 09:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732681AbfJPHD3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 03:03:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42972 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732659AbfJPHD3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 03:03:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so26586012wrw.9;
        Wed, 16 Oct 2019 00:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IGofv4/Ku/88kChkBC96+cWtPXeTqXT9jPete3VOo9U=;
        b=UJ2U78bnOcl8EaGyLODuQSbvDUBNAuvXv1Fmn9uD1LkQiVl/A7ek9KcBDLcZkFrdie
         oq184dD8fZLrrI18nRhQ9Nd5V8GfwWRR06B3gOk0izZ3ZzmMGC9Qcbq2HtJFEDa24ECn
         VtsTeWUF+RY8QHzNx5ecOGMcT3orKuTWjo0sDM6eX8+LcFp/hgYfUbUgyWqc/Fb3zVBk
         IHZ7YTcOqXtBXbUQQ6ybSst9J82WegzReDYIc30PH5TmkPkV9nge4un6wigJEcahw6iN
         WRzrDVexqDA65HlCTCe4QPouzqbFQ+eRAuvwSFaoou4db0l+m4IdJ1n9jSnue+c61r1H
         PBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IGofv4/Ku/88kChkBC96+cWtPXeTqXT9jPete3VOo9U=;
        b=KcyP1FXqWIXXZZKr6GKdxYkeHrlfFKB3C5HnpMZ0MoFeKrsdNXft717Wj/HW4ssu0t
         uoN4hh8fVljoEdicfaiEwyQd3SioVOUROSb9IHj66cdf7jdUxES//o6uSh2/5UeHUIY9
         uSI1zucQ7WNCIj+LPojoK/NGh4Sw3oHTOYZ8W8XXYC+I8G5vASAFWqODkEIBbM4VZO4P
         vo8F9p5bDb3fJ6f00ZCilXn5YdsU9I+GUbvEqi//AlgY4ws2kWkXCW4kAQ8Bk8T4RyKf
         fdP4HHc1tzKtg3BwxW5auLog3CIkK9998XlnY8dyBe+CbReRe3dbR9rEQvT82/sDUTt4
         80nA==
X-Gm-Message-State: APjAAAXJ2YLpQCwm6XosxM1W+jzwq1SRnQVqlJxoTWBFiqUJVDxuYvCS
        4XYFOrKy00DQsEpGsulAnTA=
X-Google-Smtp-Source: APXvYqw7t9eK30PIU6CMnErqccHPXcX7RhVu2WwgEF8LtBGQ4aGys5/7upH8IoAYtGMNILl1csS96Q==
X-Received: by 2002:adf:f04f:: with SMTP id t15mr1256271wro.123.1571209406350;
        Wed, 16 Oct 2019 00:03:26 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id e15sm27177088wrs.49.2019.10.16.00.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:03:24 -0700 (PDT)
Date:   Wed, 16 Oct 2019 09:03:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     robh+dt@kernel.org, u.kleine-koenig@pengutronix.de,
        alexandre.torgue@st.com, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, benjamin.gaignard@st.com,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 2/3] pwm: stm32: split breakinput apply routine to
 ease PM support
Message-ID: <20191016070322.GB1296874@ulmo>
References: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
 <1570193633-6600-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <1570193633-6600-3-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2019 at 02:53:52PM +0200, Fabrice Gasnier wrote:
> Split breakinput routine that configures STM32 timers 'break' safety
> feature upon probe, into two routines:
> - stm32_pwm_apply_breakinputs() sets all the break inputs into registers.
> - stm32_pwm_probe_breakinputs() probes the device tree break input settin=
gs
>   before calling stm32_pwm_apply_breakinputs()
>=20
> This is a precursor patch to ease PM support. Registers content may get
> lost during low power. So, break input settings applied upon probe need
> to be restored upon resume (e.g. by calling stm32_pwm_apply_breakinputs()=
).
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32.c | 48 ++++++++++++++++++++++++++++---------------=
-----
>  1 file changed, 28 insertions(+), 20 deletions(-)

Applied, thanks. I've made some minor changes, mostly for consistency
with other drivers and the PWM core. See below.

> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 359b085..cf8658c 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -19,6 +19,12 @@
>  #define CCMR_CHANNEL_MASK  0xFF
>  #define MAX_BREAKINPUT 2
> =20
> +struct stm32_breakinput {
> +	u32 index;
> +	u32 level;
> +	u32 filter;
> +};
> +
>  struct stm32_pwm {
>  	struct pwm_chip chip;
>  	struct mutex lock; /* protect pwm config/enable */
> @@ -26,15 +32,11 @@ struct stm32_pwm {
>  	struct regmap *regmap;
>  	u32 max_arr;
>  	bool have_complementary_output;
> +	struct stm32_breakinput breakinput[MAX_BREAKINPUT];
> +	unsigned int nbreakinput;

I changed these to breakinputs and num_breakinputs since they are
slightly more consistent with the naming elsewhere in PWM.

>  	u32 capture[4] ____cacheline_aligned; /* DMA'able buffer */
>  };
> =20
> -struct stm32_breakinput {
> -	u32 index;
> -	u32 level;
> -	u32 filter;
> -};
> -
>  static inline struct stm32_pwm *to_stm32_pwm_dev(struct pwm_chip *chip)
>  {
>  	return container_of(chip, struct stm32_pwm, chip);
> @@ -512,15 +514,27 @@ static int stm32_pwm_set_breakinput(struct stm32_pw=
m *priv,
>  	return (bdtr & bke) ? 0 : -EINVAL;
>  }
> =20
> -static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
> +static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv)
> +{
> +	int i, ret =3D 0;

Made i unsigned int.

> +
> +	for (i =3D 0; i < priv->nbreakinput && !ret; i++) {
> +		ret =3D stm32_pwm_set_breakinput(priv,
> +					       priv->breakinput[i].index,
> +					       priv->breakinput[i].level,
> +					       priv->breakinput[i].filter);
> +	}

I thought this was a little odd, so I changed it to explicitly check the
value of ret and return on error.

> +
> +	return ret;

And then this became "return 0;"

> +}
> +
> +static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
>  				       struct device_node *np)
>  {
> -	struct stm32_breakinput breakinput[MAX_BREAKINPUT];
> -	int nb, ret, i, array_size;
> +	int nb, ret, array_size;
> =20
>  	nb =3D of_property_count_elems_of_size(np, "st,breakinput",
>  					     sizeof(struct stm32_breakinput));
> -

Dropped this since it made the code look cluttered.

Thierry

>  	/*
>  	 * Because "st,breakinput" parameter is optional do not make probe
>  	 * failed if it doesn't exist.
> @@ -531,20 +545,14 @@ static int stm32_pwm_apply_breakinputs(struct stm32=
_pwm *priv,
>  	if (nb > MAX_BREAKINPUT)
>  		return -EINVAL;
> =20
> +	priv->nbreakinput =3D nb;
>  	array_size =3D nb * sizeof(struct stm32_breakinput) / sizeof(u32);
>  	ret =3D of_property_read_u32_array(np, "st,breakinput",
> -					 (u32 *)breakinput, array_size);
> +					 (u32 *)priv->breakinput, array_size);
>  	if (ret)
>  		return ret;
> =20
> -	for (i =3D 0; i < nb && !ret; i++) {
> -		ret =3D stm32_pwm_set_breakinput(priv,
> -					       breakinput[i].index,
> -					       breakinput[i].level,
> -					       breakinput[i].filter);
> -	}
> -
> -	return ret;
> +	return stm32_pwm_apply_breakinputs(priv);
>  }
> =20
>  static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
> @@ -614,7 +622,7 @@ static int stm32_pwm_probe(struct platform_device *pd=
ev)
>  	if (!priv->regmap || !priv->clk)
>  		return -EINVAL;
> =20
> -	ret =3D stm32_pwm_apply_breakinputs(priv, np);
> +	ret =3D stm32_pwm_probe_breakinputs(priv, np);
>  	if (ret)
>  		return ret;
> =20
> --=20
> 2.7.4
>=20

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2mwLoACgkQ3SOs138+
s6GHWBAAwHNWDi4qqGce8HzLiOPsZ7PV4JSn64OsoS8PfEcGLWagSsNg3JN4vG8S
Hl49Do93zxuquA7pQlxxphQZNfbg4scYnEWZdGN9NPI+HVUiWXxKyKG++k9ZJMR4
KRVmugkh/Qo+sQOAi5qgafxtj42xMnyGj0jp9FNLJ/ZiYAyTabxPalVbLoEOliPX
X3QXW/o9RCcqam/n8vyEj+rsAJj9vdctQJl2q20n3AYH/G6Ku1xbr5htG3aWhWG0
YyvuHEYsTOqo/08TIdbajpkcPzMGh1AjvXwZ6EcNCuM2mGimxv1MH6oWbXyhMO9d
6u2PP3ttwkni+ogoLaYzN7+7/elSNtP10DfThPDvp2SfS4RTOQ/MwJ3DP8+lbNbD
p27zLHY5SE3cSZV8RqXlGQ+IlIPThwG66HJNuLzsfbXCon6OXdzd/sw0s3j8tDwq
V5JEstiS3EDg9mHX7CBH1GWtNm5gYhxMwcWJ5x56yLF/oiHGb+S0MBRjAVjLid9y
JcmXdks8bCk5BieAkfYmhX6Pa3DVHjMrn+DTWfCb/P+J29woIodOkxwVu7IZdWw/
katw5Q+2qtuJsXxmgNUsxVABsaZk7Q9KPo1LNbiz4TsCvttRmRNptxSfC2Je6otM
TSj7eq8zzUcx6GdYGkC6snh+GbHMHn/DyMj+FhmTPdECcsDmiYM=
=ibpm
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
