Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F43359F76
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhDINDK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 09:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDINDJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 09:03:09 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56041C061760;
        Fri,  9 Apr 2021 06:02:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id v6so7274918ejo.6;
        Fri, 09 Apr 2021 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R5JdFJtNaIaiUWqelsbhXaCxf/lEZxMt7ZMtGbV2ZtA=;
        b=LG8dzngLAtNIZjBNqq7pfRxAbe6yG87VPGaUX/jxjU+2CRwMNoXvrE9pOoHO7uqFoH
         53J+VYwg8t1nHq9QVZQkHkVnVFl+v2TJAmJHU7hXDepONVU0o07K0kCguVoeaLZP98tw
         Lq6GoRGAkotsBG9xpKcZCEtlRaajYk6Wi9m8+CoDVLhcY+mTF9qqp/7TPdd0Re5OmzhW
         nyeaYfJ2Jj8Ilf+LQdDoVuw7GhixWpgVuFnqQbH5XFVWvZc4/zvSsWz+t9nd8aPwQVLF
         T11yh+sK/O9iLX69oQSKT4pOCkokW8/V7lJALmsuxjm7Qg8GkpN59MTq1ZnW7Gb+MtT5
         +JqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R5JdFJtNaIaiUWqelsbhXaCxf/lEZxMt7ZMtGbV2ZtA=;
        b=hJQgi0O7pnu9qEbNZopgSka3mtY3dzlWN+gnnWGGP8sz1pRLz/yWkgx+MOF1bcp5Sl
         5ffifNcyRWQSQz1tWpHMGLr9ha4Up5yHPAa1w05p7N1r66iqR67h6caWB6oiDYaWp89m
         mjDwEtP2j+KaUjI4iEcurAxBqPTS8zxKq+Rc+aoPjaTmoKTwSrMfleDOlNgGTlwgBpx7
         DNztWpR+dmLFLCGXsBFrLxsZr5JM4SLQUm0ggEmPfN8ZS7ABxoRX5hRpauep7H+Kp4XF
         jgudH8oQW14v0aAA9BJMv/RV2r+iP6PuIY9DMbYXsC2hMImojFvUDlaO6/WxSTZ9P6aG
         /HKA==
X-Gm-Message-State: AOAM532SWG5zrLMFVezneWKTExm/5JeUONDNZpwmegtI1R4ZMP5XU8HJ
        QnJKhAOb0QwNGqL6rgcTJnY=
X-Google-Smtp-Source: ABdhPJyPEFbWgCNftGSj84hdTC3b20sUr5miwSIH5zGC6i3BZ+XqF7EWohQTZ9f4pdyy+7xJygO4Xw==
X-Received: by 2002:a17:906:2e14:: with SMTP id n20mr15759017eji.16.1617973365894;
        Fri, 09 Apr 2021 06:02:45 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id g20sm1422991edb.7.2021.04.09.06.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 06:02:44 -0700 (PDT)
Date:   Fri, 9 Apr 2021 15:03:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/8] pwm: pca9685: Improve runtime PM behavior
Message-ID: <YHBQmGJIsa6sNRIg@orome.fritz.box>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-3-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yucEIjxemkfSPh6I"
Content-Disposition: inline
In-Reply-To: <20210406164140.81423-3-clemens.gruber@pqgruber.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yucEIjxemkfSPh6I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 06:41:35PM +0200, Clemens Gruber wrote:
> The chip does not come out of POR in active state but in sleep state.
> To be sure (in case the bootloader woke it up) we force it to sleep in
> probe.
>=20
> On kernels without CONFIG_PM, we wake the chip in .probe and put it to
> sleep in .remove.
>=20
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
> Changes since v6:
> - Improved !CONFIG_PM handling (wake it up without putting it to sleep
>   first)
>=20
>  drivers/pwm/pwm-pca9685.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index d4474c5ff96f..0bcec04b138a 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -474,13 +474,18 @@ static int pca9685_pwm_probe(struct i2c_client *cli=
ent,
>  		return ret;
>  	}
> =20
> -	/* The chip comes out of power-up in the active state */
> -	pm_runtime_set_active(&client->dev);
> -	/*
> -	 * Enable will put the chip into suspend, which is what we
> -	 * want as all outputs are disabled at this point
> -	 */
> -	pm_runtime_enable(&client->dev);
> +	if (IS_ENABLED(CONFIG_PM)) {

This looks odd to me. I've seen similar constructs, but they usually go
something like this (I think):

	pm_runtime_enable(&client->dev);

	if (!pm_runtime_enabled(&client->dev)) {
		/* resume device */
	}

Which I guess in your would be somewhat the opposite and it wouldn't
actually resume the device but rather put it to sleep.

Perhaps something like this:

	pm_runtime_enable(&client->dev);

	if (pm_runtime_enabled(&client->dev)) {
		pca9685_set_sleep_mode(pca, true);
		pm_runtime_set_suspended(&client->dev);
	} else {
		/* wake the chip up on non-PM environments */
		pca9685_set_sleep_mode(pca, false);
	}

? I think that's slightly more correct than your original because it
takes into account things like sysfs power control and such. It also
doesn't rely on the config option alone but instead uses the runtime
PM API to achieve this more transparently.

Thierry

--yucEIjxemkfSPh6I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwUJYACgkQ3SOs138+
s6Er7RAAjikTXssRSRsCCvtNEO0zM04tAdA7IVWeR1W3tbQsey1b6G9xqZL6hHoC
gDt8wdLMh4/BvkseBGRWzyBkI0oN9Vry/pxZQg+izgmjpb5TTN6iVDmW7+fMumLP
aQwogG14Gu3dinGWHIIndKSI/swpRSzq8jlV8CC0liuqzdEG28mQRz81uNANBDfA
Llo9sRBPmuDIxHdR1dyOmacyMFxmrwZy79GgObDwEmDZGEGzdTMrVnPYpHUhRa16
+DdATITfzlLBDqcjbaCDiK38xsSiAYxQW+WykxjpIetHAxEAt1zZmgCTjcQ53+CT
8oFi1fWIky+dyG+shDYnVXr+58nyOoLNweTxH499cETgaL+69CYoOceF+C5ePGQv
u/CKWCrY1tDppHKcOV1oNk9b91uH8+H6Dy+R5HKZltzduh5dTt5v0WBHIrmmtm9k
fgY8vs8yp0uQ/AqKiSj4Y8cCoGOUYNxoiVQDkpkcEP3JLRGs+r6bzqAdMK4wWbCL
YnqfrjgTNVIJjdadNBFEBw+xEa0eraPrLn/aYvbYUTWbUhYleJg5IMblXwHsQ5F4
MXPunIu195VL7a77zRJqovTYNviMu4nsRKluktv+FAAjLujyeIxl3Pm8odzvhmga
QIryBk5yj0gcwHLkSMKsaAj1VAM7Ob15B3QUQ2M4vyfBi1fm2LY=
=k4Q5
-----END PGP SIGNATURE-----

--yucEIjxemkfSPh6I--
