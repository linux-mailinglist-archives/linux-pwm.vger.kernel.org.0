Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCD075A6F5
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jul 2023 08:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjGTGx4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Jul 2023 02:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjGTGxz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Jul 2023 02:53:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8E81711
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 23:53:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso2744145e9.0
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 23:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689836033; x=1692428033;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXTzHCbl7v48lM1t2UMqTq27WF4jUpTX5Etm7EOSy6k=;
        b=eYNWywZ4UsmraDXUhM1J0dVgcaVNzgSrgyPoIJ7L82T473HBnjERUkeQ7KXtvrrSQO
         6ItzXajJzXASe49tyAjuYfBX1bYL/H6QeVyT3fGZOnClRMgV/PJA7JSaVXtXEENJKtLy
         P9ewPtiMjRyXO/cvQOGFLGBR8SxXC4U+nnUByFioqdmB+XGkFfrEE/7XyZ/f8ebIUnDs
         XTT9R//venIW6aMvQrGb6li58Qoy+zTrcVvZc/XOjQddQucx5NtIvZFOiwPg4QGIDFmN
         6lkoYSnsaSjChZIslrL5/bS8pMbgsatyKpKZ9QYizPCTgJxVvQ0tLSA39jaDqDYF+k4I
         rWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689836033; x=1692428033;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXTzHCbl7v48lM1t2UMqTq27WF4jUpTX5Etm7EOSy6k=;
        b=ACKF6OqHVp6BHTGXBAs1FuA7vwiyZ2wtc5Oefe97pQ47hR8I8Ncho42aNfJIzuv8sS
         uNxUWkSvWvbz1BsNr9pWDB9ttQXuSvDlTNV1Xgh/ORed8AKses9IGI2CKuvlZTuM47OW
         fdPFhNrRHMLy9WcpmJ/Xv6KCXv3VuZhB3CocOpKrcKpStnbSgNjK8enSA7dLLyOQ7F/S
         remcrGjOYXwuDwuYoEMAcKIUEBS9dRkNwrQ9k7KbYrxTXJR6CxcqXysEtDO6utBJ9XeU
         36xm1LKEsdj6CKLakAnfgdwh092N021hi46A07K9ntvPZ7kw4WdzsQv8za1EXngs31j9
         hZSQ==
X-Gm-Message-State: ABy/qLYzOjLqTNQlcpPzpMPYMW3LURnPU/NDYb02x8ibETJFpbWGLhz5
        e8nzeuznDDjYaXe2khc4dr8=
X-Google-Smtp-Source: APBJJlEJEp6dIoDcCDIqy3PnzVOJH7HxVlY9Kpfo+f+p8xbWrjIuYFdXFkMQ9f0wwa89zBIApEhkXA==
X-Received: by 2002:a1c:f716:0:b0:3f7:e7a2:25f6 with SMTP id v22-20020a1cf716000000b003f7e7a225f6mr3722895wmh.17.1689836032837;
        Wed, 19 Jul 2023 23:53:52 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a17-20020adffad1000000b003143cdc5949sm374651wrs.9.2023.07.19.23.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 23:53:52 -0700 (PDT)
Date:   Thu, 20 Jul 2023 08:53:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 02/10] pwm: atmel-hlcdc: Use consistent variable naming
Message-ID: <ZLjZ_lllJ1PT3O5H@orome>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
 <20230714205623.2496590-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RaX0O7HmxDG07jHf"
Content-Disposition: inline
In-Reply-To: <20230714205623.2496590-3-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--RaX0O7HmxDG07jHf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 10:56:15PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> In pwm drivers the variable name "chip" is usually only used for struct
> pwm_chip pointers. This driver however used "chip" for its driver data
> and pwm_chip pointers are named "chip", too, when there is no driver
> data around and "c" otherwise. Instead use "ddata" for driver data and
> always "chip" for pwm_chips.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 64 +++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> index 96a709a9d49a..9b0165d61c49 100644
> --- a/drivers/pwm/pwm-atmel-hlcdc.c
> +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> @@ -38,11 +38,11 @@ static inline struct atmel_hlcdc_pwm *to_atmel_hlcdc_=
pwm(struct pwm_chip *chip)
>  	return container_of(chip, struct atmel_hlcdc_pwm, chip);
>  }
> =20
> -static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *=
pwm,
> +static int atmel_hlcdc_pwm_apply(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
>  				 const struct pwm_state *state)
>  {
> -	struct atmel_hlcdc_pwm *chip =3D to_atmel_hlcdc_pwm(c);
> -	struct atmel_hlcdc *hlcdc =3D chip->hlcdc;
> +	struct atmel_hlcdc_pwm *ddata =3D to_atmel_hlcdc_pwm(chip);

Can we not just use something like "data", "priv" or "atmel"? "ddata" is
horrific and looks like a typo.

Thierry

--RaX0O7HmxDG07jHf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS42f4ACgkQ3SOs138+
s6EwgxAAtCuHN4Ynf7Rb5Stv3S01Z45OoVePYbRyt0s+WhuKaMJd6GEyzTVRYjws
y304YEyElQdQptWILy9YLtg3CtvH0IuAGgmqQkMULjiS/RPAsXabEnepQ8Ml6ptP
5YTbRQ77bRI8Y1f70k1vBXs1hhlJ9GofFeXRUiMtASh4bluMxZlcNt/742dlM2Lt
WqCxBMsV3hixv5ZyKdI3p71KCh229D25filN5JsbUWyfYQBZ382VxY32k0wWfJGL
NbN2rpQkvmHAlzLdrH1XZGDWNCz9KSncC4t1OPbnFZbwMHj/F8Qkvs9XVej+EVn6
tn3EHAiyXYvZKiyOh14Otd5bDa6myL3Ej19Biw3V4ngykhaEG5NP21bRfw+q9R8c
sjN7CAsdc6rPp4F52g4w1xNpoxlyeTJRX9Rd2/miQcjl4zzisPL0qmJn2qxTRTiy
6IQKxyaNbZw59XG/hEbi4KQAr3rWdfIwvpbv2Yd1mXdfabjkdpNjIRsk114UlAaq
CytZ/EzjvmV6/NYdGGHtRDj234Ac9+726OJdAjdbamw2XXPbwAT9TfqW/JTOxq/W
KRqxXYMOTYgLhSoB4Kg7FtxKh7hrlSwAf87eCrw0XB6/62LYn7jVh1GWg0h7h+XF
iQkaBr2Jyw4Rxwnw+Bp7p7H8edF6M5WywGnKRGXi/5xgayO/k/8=
=nkyn
-----END PGP SIGNATURE-----

--RaX0O7HmxDG07jHf--
