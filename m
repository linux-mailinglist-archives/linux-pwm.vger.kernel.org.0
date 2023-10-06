Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899997BB423
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 11:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjJFJXz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 05:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjJFJXy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 05:23:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235BE95
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 02:23:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b64b98656bso332051066b.0
        for <linux-pwm@vger.kernel.org>; Fri, 06 Oct 2023 02:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696584231; x=1697189031; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwAtoVnJzReCMZ8hgdGbQzf0iROFSRSxd1kEuocjSNo=;
        b=iKVA7Ah4yS3YWQSxF0e4ZHHr8N5O+bqAq0/H1OStMoZ/COAK6qcqRQTni2nLf1quA1
         THXh0PD8V5w9L+Qu0WEU+kaZr0u3EVSA/WD8w18mHEYOGzibHRkrhRi9LDv1YVxKK0vP
         PrEC3NLBYqoR7eRgiiLHWe7cs4eGL21yFsy5hns59u1bFCuPNKcegXpc24hXLjdNaiPp
         cbH0Uz/n5VAsfYMcClI4Hb7jOTzIfWIQK5po4UoyqyOrjjHk+drchg4GMVLj4+x0cmJp
         EGkqg4xDPnTYAtWloqEJyxsUaIzfA7E2yTE7xVYCOCUE+Il6zIuzxqpdZWEqZOHb9oHW
         PY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696584231; x=1697189031;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwAtoVnJzReCMZ8hgdGbQzf0iROFSRSxd1kEuocjSNo=;
        b=W9sEkGsta0set28tfeTAoP96Mkq23PVDJg2QMf6ObPCXlcFAIBclA064JzP/NMQgXK
         xcv8ql3Dx81eZp5vk461SOIvQnwGIE6wX6l98CRcj9G4JAMfbLAKxgvucjQE5nX6nB+Y
         B2XH3B4/mnhJmuvrDo04pcTTRLVVwS3Ouk3luriLzXkrm4qHE0A1IeQdZdX0DqsTG9bF
         yrPw7CnX8k90Z2q1JdClJ6y7hFbzNh8PF03SFCO3Ie2vuIfkT1CmzYH050xHMGIDqfmB
         AGqpWKvt1c5JXbXuifjSrkkumgEh5DrjeOrigmrk3ZIe7etdSJzxxAgeaULcJb83Q/n/
         7mtA==
X-Gm-Message-State: AOJu0Yy7/YutK+fKzw3v9dnvkSJwUfedDVh+mIZuZ53zDvM0dbvY8IlE
        peNSWNWLu2KyiBEXceO0U3Y=
X-Google-Smtp-Source: AGHT+IHkRfVNeQkwC5AZqEUctkhiFSQguB/egJTLDcPz/Vk6EY1mEmjZHOYlnjYY03w1MdzYnf8hdw==
X-Received: by 2002:a17:906:538f:b0:9a1:fa4e:ca83 with SMTP id g15-20020a170906538f00b009a1fa4eca83mr7619301ejo.65.1696584231344;
        Fri, 06 Oct 2023 02:23:51 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id dx12-20020a170906a84c00b009b977bea1dcsm2552396ejb.23.2023.10.06.02.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:23:50 -0700 (PDT)
Date:   Fri, 6 Oct 2023 11:23:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 001/101] pwm: Provide devm_pwmchip_alloc() function
Message-ID: <ZR_SJW9vxOYoAC6N@orome.fritz.box>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CzABMSXLTQWyvpXo"
Content-Disposition: inline
In-Reply-To: <20230808171931.944154-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--CzABMSXLTQWyvpXo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 07:17:51PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> This function allocates a struct pwm_chip and driver data. Compared to
> the status quo the split into pwm_chip and driver data is new, otherwise
> it doesn't change anything relevant (yet).
>=20
> The intention is that after all drivers are switched to use this
> allocation function, its possible to add a struct device to struct
> pwm_chip to properly track the latter's lifetime without touching all
> drivers again. Proper lifetime tracking is a necessary precondition to
> introduce character device support for PWMs (that implements atomic
> setting and doesn't suffer from the sysfs overhead of the /sys/class/pwm
> userspace support).
>=20
> The new function pwmchip_priv() (obviously?) only works for chips
> allocated with devm_pwmchip_alloc().
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  .../driver-api/driver-model/devres.rst        |  1 +
>  Documentation/driver-api/pwm.rst              | 10 +++----
>  drivers/pwm/core.c                            | 30 ++++++++++++++++---
>  include/linux/pwm.h                           |  5 ++++
>  4 files changed, 37 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documenta=
tion/driver-api/driver-model/devres.rst
> index 8be086b3f829..73a9ee074737 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -414,6 +414,7 @@ POWER
>    devm_reboot_mode_unregister()
> =20
>  PWM
> +  devm_pwmchip_alloc()
>    devm_pwmchip_add()
>    devm_pwm_get()
>    devm_fwnode_pwm_get()
> diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/=
pwm.rst
> index 3fdc95f7a1d1..a3824bd58e4c 100644
> --- a/Documentation/driver-api/pwm.rst
> +++ b/Documentation/driver-api/pwm.rst
> @@ -134,11 +134,11 @@ to implement the pwm_*() functions itself. This mea=
ns that it's impossible
>  to have multiple PWM drivers in the system. For this reason it's mandato=
ry
>  for new drivers to use the generic PWM framework.
> =20
> -A new PWM controller/chip can be added using pwmchip_add() and removed
> -again with pwmchip_remove(). pwmchip_add() takes a filled in struct
> -pwm_chip as argument which provides a description of the PWM chip, the
> -number of PWM devices provided by the chip and the chip-specific
> -implementation of the supported PWM operations to the framework.
> +A new PWM controller/chip can be allocated using devm_pwmchip_alloc, the=
n added
> +using pwmchip_add() and removed again with pwmchip_remove(). pwmchip_add=
()
> +takes a filled in struct pwm_chip as argument which provides a descripti=
on of
> +the PWM chip, the number of PWM devices provided by the chip and the
> +chip-specific implementation of the supported PWM operations to the fram=
ework.
> =20
>  When implementing polarity support in a PWM driver, make sure to respect=
 the
>  signal conventions in the PWM framework. By definition, normal polarity
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 8aa3feec12a9..cfcddf62ab01 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -196,6 +196,31 @@ static bool pwm_ops_check(const struct pwm_chip *chi=
p)
>  	return true;
>  }
> =20
> +void *pwmchip_priv(struct pwm_chip *chip)
> +{
> +	return &chip[1];
> +}
> +EXPORT_SYMBOL_GPL(pwmchip_priv);
> +
> +struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int =
npwm, size_t sizeof_priv)
> +{
> +	struct pwm_chip *chip;
> +	size_t alloc_size;
> +	unsigned int i;
> +
> +	alloc_size =3D sizeof(*chip) + sizeof_priv;
> +
> +	chip =3D devm_kzalloc(parent, alloc_size, GFP_KERNEL);

Are you sure this works the way you want it to? If you allocate using
device-managed functions, this memory will be released when the driver
is unbound from the device, so we're basically back to square one,
aren't we?

> +	if (!chip)
> +		return ERR_PTR(-ENOMEM);
> +
> +	chip->dev =3D parent;
> +	chip->npwm =3D npwm;
> +
> +	return chip;
> +}
> +EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
> +
>  /**
>   * __pwmchip_add() - register a new PWM chip
>   * @chip: the PWM chip to add
> @@ -208,8 +233,6 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
>   */
>  int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
>  {
> -	struct pwm_device *pwm;
> -	unsigned int i;

Am I missing something? You seem to be using this variable in the for
loop below, so how can you remove it?

Thierry

>  	int ret;
> =20
>  	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
> @@ -234,9 +257,8 @@ int __pwmchip_add(struct pwm_chip *chip, struct modul=
e *owner)
>  	}
> =20
>  	chip->id =3D ret;
> -
>  	for (i =3D 0; i < chip->npwm; i++) {
> -		pwm =3D &chip->pwms[i];
> +		struct pwm_device *pwm =3D &chip->pwms[i];
> =20
>  		pwm->chip =3D chip;
>  		pwm->hwpwm =3D i;
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 6f139784d6f5..3c0da17e193c 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -5,6 +5,7 @@
>  #include <linux/err.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> +#include <linux/compiler_attributes.h>
> =20
>  struct pwm_chip;
> =20
> @@ -380,6 +381,10 @@ static inline void pwm_disable(struct pwm_device *pw=
m)
>  int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
>  		unsigned long timeout);
> =20
> +void *pwmchip_priv(struct pwm_chip *chip) __attribute_const__;
> +
> +struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int =
npwm, size_t sizeof_priv);
> +
>  int __pwmchip_add(struct pwm_chip *chip, struct module *owner);
>  #define pwmchip_add(chip) __pwmchip_add(chip, THIS_MODULE)
>  void pwmchip_remove(struct pwm_chip *chip);
> --=20
> 2.40.1
>=20

--CzABMSXLTQWyvpXo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUf0iUACgkQ3SOs138+
s6H90w//Y0aRiqjgDuKXxsxIYmDPojjSpIoH/h0e/OOeXmIZSI1a9nP/iSc1MRUv
qd2wu62ZwOHdg5ZXOCP4dd5sFFOnlMFkNM/NpkCPE6GoU1NyLJPo9PFMPQR+bsos
kQGwy0HaGRtJUMGl6kXabt/rCJb/QUljfAU9uoW37cSTCo5DOcBv9Jl0/6+xrOix
Bf0uPz2VrshwMGAPyEUZTyxESz9SDzwx6ASFUI36sYgtQTphftlqFNaCRznNJNCp
xuO4ai4xQDouXGt04oYDHzkNsyX0Rr7xAewWuIhS/ZUC+hKwsTuoAcJRvKIWcSj8
XhGgMBLQh+f356oz2ltbGRr72fLThd7HoZjAywBhPFF5xrCGhpxSpXji6+Cw0VIo
4RfOEmDZop5iukcjf9MGy1FQNdmDN1GAg42uhOtAOcS+D/iuYQC3l3mKw/IFb9AA
6KEn9gI0fe1JfQd7C+/mgGIuDHcmF9OJLRKBhFew4J3H+ZdZbTrkKhSRLitwT6I3
Wkxg3r2+Zia277QlGYjzKyoktaqcaHjXjTo23cVQ/8vAoQFh+83y5i70cZjmkI2T
eRVi3POnQXiXNpjBfkiOe6H6kMcXp7BRyXKWG9AGwSpHpSU2KLxE1KoikDFkLSuT
BcAhSbjVWRr6kKMqf6YeILukB9e4QEeWHLbHx5K2ocmSIyPKXHs=
=aCDe
-----END PGP SIGNATURE-----

--CzABMSXLTQWyvpXo--
