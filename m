Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170C676664A
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 10:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjG1IEr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 04:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbjG1IEK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 04:04:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CD93C26
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 01:02:25 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe104df822so1677055e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690531344; x=1691136144;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYM+7Hxeiy/zYV2rA6It/fCBYA1mIgJrIwwqnoyI16Q=;
        b=Wy6PcTqm0lASLVO6XrA5cXAZ52JkBtE7hd5w5A3ou1OOQPfgRembi0F9CnF7+ugo4t
         LOqGmFrEoDGMhl9IRBiFmtwcisMIiaFastrV7CS5mtzan8yo+L15Q0A63BtkyFGM4xvg
         9fJ5koXRFLWGuCXunOD3XCPvvUe9mjyZMk55UBf59Bef56hWE5m6pP4kTDSRXTcclP3P
         rcCToVZz6HkyTZMUxRsCNmEKxUR2Tc7wv19FzabfmP9Q/9LDOZqhgPjMSducLxNMd+YX
         QFVd/QtSDPPUIsDpfE0W5E0DLbBN55bbEsZyvCUeMEgpMg74i5vvjm5TEkhfLJhAm5pX
         oSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690531344; x=1691136144;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYM+7Hxeiy/zYV2rA6It/fCBYA1mIgJrIwwqnoyI16Q=;
        b=KskzcKuvH8RV2JDfaVPSYmQYgsj6h5NUT2sAOwu25RZrnzp59IdSyv84S3O4oyR7o+
         oueZCpWTDwzwE6AgpBCrB4Znl6KOJvHh5qHw9JkeGbXTogp/ogQYU/M7IpeGr1jUiccv
         MS5HKBLPPMUyjT4+xXcRJcphmu18d2rWkNvx6kW0zFW7Yzo+W1wxqik4ephl8Es/JxNU
         uwGE2h9cGWFjCXMXCMjpM3fe7atiSgqatDVEsAAi/6mL90W/alyvcPty93Xn4IpphVfY
         e57P9cyWKvkm9+LPwevsZqqk95uNkrAtcFLE7YPbvw1jD6WMYJ6qtVskayZwTJRVH/b8
         3bqw==
X-Gm-Message-State: ABy/qLbo/Xzd8YVPe7WzSjD0VInOe2NZt/A5JKvekQwnuRIRVFcXowJ2
        QOE9jIX1798GatNE0eUak50=
X-Google-Smtp-Source: APBJJlElOTovIl2beeM+x0POT8VUO9qTc95oQ0L0Cyj7z/JG5/PDMHQsUoAqguf1s0EMmkcGlgs07Q==
X-Received: by 2002:a1c:f309:0:b0:3fc:182:7eac with SMTP id q9-20020a1cf309000000b003fc01827eacmr1322726wmq.33.1690531344075;
        Fri, 28 Jul 2023 01:02:24 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c511400b003f7f475c3bcsm19727225wms.1.2023.07.28.01.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 01:02:23 -0700 (PDT)
Date:   Fri, 28 Jul 2023 10:02:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de
Subject: Re: [PATCH 2/2] pwm: stmpe: Don't issue error messages for problems
 in .apply_state()
Message-ID: <ZMN2DtpxEpHcseTi@orome>
References: <20230714214519.2503468-1-u.kleine-koenig@pengutronix.de>
 <20230714214519.2503468-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bpX/+TxFeOrauri4"
Content-Disposition: inline
In-Reply-To: <20230714214519.2503468-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bpX/+TxFeOrauri4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 11:45:19PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> pwm drivers are supposed to be silent for failures in .apply_state()
> because a problem is likely to be persistent and so it can easily flood
> the kernel log. So remove all error messages from .apply_state() and the
> functions that are (only) called by that callback.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-stmpe.c | 35 ++++++-----------------------------
>  1 file changed, 6 insertions(+), 29 deletions(-)

I don't necessarily agree with that claim. Given that some of the
implementations can be quite complex, the error messages may be useful
to diagnose what exactly is going wrong. It's also quite rare for any
consumers to call pwm_apply_state() in quick succession, so I don't
think "flooding" is really a problem.

Is this an actual problem anywhere?

Looking at where these errors would originate, these can be either from
I2C or SPI and the MFD driver will do some probing and failures in that
code would lead to probe failure, so any persistent problems are likely
going to be detected early on. And if there are errors that start to
happen at runtime, it's probably not a bad idea to be as noisy as
possible.

On the other hand, the stmpe_reg_read() and stmpe_reg_write() produce
error messages of their own, so the ones in this driver mainly serve as
adding context. Perhaps rather than removing these, turning them into
dev_dbg() would be a good compromise?

Thierry

>=20
> diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
> index e205405c4828..4a8d0d9b9cfc 100644
> --- a/drivers/pwm/pwm-stmpe.c
> +++ b/drivers/pwm/pwm-stmpe.c
> @@ -43,22 +43,12 @@ static int stmpe_24xx_pwm_enable(struct pwm_chip *chi=
p, struct pwm_device *pwm)
>  	int ret;
> =20
>  	ret =3D stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
> -	if (ret < 0) {
> -		dev_err(chip->dev, "error reading PWM#%u control\n",
> -			pwm->hwpwm);
> +	if (ret < 0)
>  		return ret;
> -	}
> =20
>  	value =3D ret | BIT(pwm->hwpwm);
> =20
> -	ret =3D stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
> -	if (ret) {
> -		dev_err(chip->dev, "error writing PWM#%u control\n",
> -			pwm->hwpwm);
> -		return ret;
> -	}
> -
> -	return 0;
> +	return stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
>  }
> =20
>  static int stmpe_24xx_pwm_disable(struct pwm_chip *chip,
> @@ -69,19 +59,12 @@ static int stmpe_24xx_pwm_disable(struct pwm_chip *ch=
ip,
>  	int ret;
> =20
>  	ret =3D stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
> -	if (ret < 0) {
> -		dev_err(chip->dev, "error reading PWM#%u control\n",
> -			pwm->hwpwm);
> +	if (ret < 0)
>  		return ret;
> -	}
> =20
>  	value =3D ret & ~BIT(pwm->hwpwm);
> =20
> -	ret =3D stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
> -	if (ret)
> -		dev_err(chip->dev, "error writing PWM#%u control\n",
> -			pwm->hwpwm);
> -	return ret;
> +	return stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
>  }
> =20
>  /* STMPE 24xx PWM instructions */
> @@ -124,11 +107,8 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> =20
>  		ret =3D stmpe_set_altfunc(stmpe_pwm->stmpe, BIT(pin),
>  					STMPE_BLOCK_PWM);
> -		if (ret) {
> -			dev_err(chip->dev, "unable to connect PWM#%u to pin\n",
> -				pwm->hwpwm);
> +		if (ret)
>  			return ret;
> -		}
>  	}
> =20
>  	/* STMPE24XX */
> @@ -241,11 +221,8 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
>  		value =3D program[i] & 0xff;
> =20
>  		ret =3D stmpe_reg_write(stmpe_pwm->stmpe, offset, value);
> -		if (ret) {
> -			dev_err(chip->dev, "error writing register %02x: %d\n",
> -				offset, ret);
> +		if (ret)
>  			return ret;
> -		}
>  	}
> =20
>  	/* If we were enabled, re-enable this PWM */
> --=20
> 2.39.2
>=20

--bpX/+TxFeOrauri4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTDdgsACgkQ3SOs138+
s6EpzA//fjFlgQrloiZWpkw958vNc6JYHa3kpUjykvO5CmGEHDdqjI9Tmmbl/5cB
0t/FOBs+YG8CharyF4EKmqQRCQjy1OdTNivMI4AcnDKxoUR4WVYKII1e4fyOPLcp
NUzKeED7qj4rsF02HHq8DEabLcWSOOSqN32Tr/6a1Rp2jxCD/ORsAEAxXDmFa+FY
pJyWlrs7d8V20UVOtsSnNRFTJwtdDT3hhZqETL35wKxrGch4z6MxhFnNoh2Iysov
CxhTLpZdnw+seuKtV6lgy+DexEIhbVr2LqFE09XqzJK3Fq3Rd95aLG4zWkJFlZyp
tQim1sRprsvhBYoHPCo9r4RCpGyNk1HkT3z737VtxxIELQKmymCRXrkEuDR2lcsn
XTqC8C+9GbSmsRyrrArIY1O+KmC3cw5cQPmCHkVpcYuVd3eWX73iTn4NlCfanfgo
vu2Bk5WLZ33Szl3/4kDqZEj1lb1cJiTnykx/uj17jY5JJmPZKYP79+FxcFvHw73E
UfaZxwervfhi3yIaweR4ARzpJc0G6wyvIKgKnkngV2sF9MI/E2/baEDJWy/aJSik
Xg/4FZ84a0ELogv+J0MDZDLGTKsTiK0/6rh9PtxrS8cUTb4zIdMBMBE0uo9wcVmR
VV8IVMIOJi456Vrb8NLkiMRe0aLyiipmUrLQyUTlny+Kcfz6Gz0=
=ZY6e
-----END PGP SIGNATURE-----

--bpX/+TxFeOrauri4--
