Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8F752EDFD
	for <lists+linux-pwm@lfdr.de>; Fri, 20 May 2022 16:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbiETOUl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 May 2022 10:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiETOUk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 May 2022 10:20:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B2515EA77;
        Fri, 20 May 2022 07:20:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p189so4610488wmp.3;
        Fri, 20 May 2022 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V8d3TsLjdGSYEnI2lRlQdf6FY0CX3FSXW/zunDtdRJ0=;
        b=nPrDXyIfEMAmjBSmmEyvmqFJT3VMmS42uZbtmZdR6NFocwHQFBOrrDkCu2bh+qf4MM
         /7mLKdxexJ6gehCnV6HTvaGSOtaV18WCuzFILpT/KFfEAm8xmK91BHIXQK0x1nftKSfE
         8jNDLduUFmilN+1ShywRnlbZi2K+99UpkXzOKNcIXMcd7XDg+CRU2SMl2C9ansSWXU8k
         4/zfdLDk/hrH3BuLic5AoE8ol10Py7cliTdfI5sn/cxi0fnnNNIElTBOy6ZqVsroy+l8
         xSE7uwjd1CBdJWWvwqtrQTKlCTM7Vf2k6D+hrQZhuPDpqrHrmE+F/C4uVRg2c7JRV6EM
         ujaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V8d3TsLjdGSYEnI2lRlQdf6FY0CX3FSXW/zunDtdRJ0=;
        b=xU9XjK9lHmOZTIsTArbfA9Ijq09dyPBiL5RTFY07PPetDEtsMqkMvSy/4DE07HPpyb
         2o55pc6yVLBY7WcLwWLDvyMoXuYM9jTh42ZXzKJOu/vGx6rFCN59PMEIKBd/3fZYkkbu
         fhlm/EWhchanna8IXvD7ZXXTCxaXuhlr6VeoZ589qFGG/wKagCyW8vaOOFmQ24/GR/H7
         /4W+udcITpUS/f1VnqxhRPIKpa32a28/J9A3qCXkHTKdb/fJlCX7bYdKW8SbNXOhUMND
         B336UkQSlNWiaLje6VMhFnvjoqlzP8iOboxM6wDnBz56rarvUytq0rMGKHAT6aoUTnXb
         Hosg==
X-Gm-Message-State: AOAM531vWge4bX9aC9HyTs7A8MfyY4J+LxFJa9rnP8gDoqyUpb60/SSg
        /nuWRw1KfVa9xvqrKMs7najPeAyr7Tc=
X-Google-Smtp-Source: ABdhPJzgTtilkwzS67YPwgEOjQGvTx+OOIpPBRlDxp1rtZq4Z7qghZ1APuDdwWJhy3ERV9vp9BJtqA==
X-Received: by 2002:a1c:6a14:0:b0:397:39c4:8ac2 with SMTP id f20-20020a1c6a14000000b0039739c48ac2mr2626149wmc.112.1653056436004;
        Fri, 20 May 2022 07:20:36 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id l15-20020adfbd8f000000b0020e65d7d36asm2677140wrh.11.2022.05.20.07.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 07:20:35 -0700 (PDT)
Date:   Fri, 20 May 2022 16:20:33 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: tegra: Optimize period calculation
Message-ID: <YoejsQfd97I6W+lT@orome>
References: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xBogxZoS+yMG4Fb2"
Content-Disposition: inline
In-Reply-To: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xBogxZoS+yMG4Fb2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2022 at 03:22:44PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Dividing by the result of a division looses precision because the result =
is
> rounded twice. E.g. with clk_rate =3D 48000000 and period =3D 32760033 the
> following numbers result:
>=20
> 	rate =3D pc->clk_rate >> PWM_DUTY_WIDTH =3D 187500
> 	hz =3D DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns) =3D 3052
> 	rate =3D DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz) =3D 6144
>=20
> The exact result would be 6142.5061875 and (apart from rounding) this is
> found by using a single division. As a side effect is also a tad
> cheaper to calculate.
>=20
> Also using clk_rate >> PWM_DUTY_WIDTH looses precision. Consider for
> example clk_rate =3D 47999999 and period =3D 106667:
>=20
> 	mul_u64_u64_div_u64(pc->clk_rate >> PWM_DUTY_WIDTH, period_ns,
> 			    NSEC_PER_SEC) =3D 19
>=20
> 	mul_u64_u64_div_u64(pc->clk_rate, period_ns,
> 			    NSEC_PER_SEC << PWM_DUTY_WIDTH) =3D 20
>=20
> (The exact result is 20.000062083332033.)
>=20
> With this optimizations also switch from round-closest to round-down for
> the period calculation. Given that the calculations were non-optimal for
> quite some time now with variations in both directions which nobody
> reported as a problem, this is the opportunity to align the driver's
> behavior to the requirements of new drivers. This has several upsides:
>=20
>  - Implementation is easier as there are no round-nearest variants of
>    mul_u64_u64_div_u64().
>  - Requests for too small periods are now consistently refused. This was
>    kind of arbitrary before, where period_ns < min_period_ns was
>    refused, but in some cases min_period_ns isn't actually implementable
>    and then values between min_period_ns and the actual minimum were
>    rounded up to the actual minimum.
>=20
> Note that the duty_cycle calculation isn't using the usual round-down
> approach yet.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> changes since (implicit) v1: Updated changelog to explain why rate =3D 0
> is refused now.
>=20
> Best regards
> Uwe
>=20
>  drivers/pwm/pwm-tegra.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

Thierry

--xBogxZoS+yMG4Fb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKHo7AACgkQ3SOs138+
s6GOcw//Uue1sqRViVDZImfMCHlPpSssaNGfIk7ORGXaRTA8YXDIsrpJTEEuYIEz
avFkK0dDifpigEYGeaSTSR3RrMFiIu1jMaxVau/FUEcFEsaKSMwlVIDprB8arTBc
KvWTNjIClbspF8HrDrSxoadHJDEqEzJyt1zRvcym8TPXU/hC83TfyFa+8ggEZFC+
MOF5/aRQ1O7beTWTJDRpC9/UG29fe5rocU3LiCXZBUoC7YP0c9gODcunjux9rqwW
8fUtvL8b07cVd6uSh9m6SEgJYclcarAsCgIMfr+tohMDJE1TX55jki3Nn+ypd6cy
bV2vAhJBFClwIEt9KfgPBjyZhuhcVYAg0eIHet0GCdl5p0XQrsb5u1ERmfutqrHZ
8eEDCvP79uC/fiXpKe5jFm+3JEJEheO8D6/V2vVM1Msuhiyr844m2XMF+cp9cE2b
qeLtXn+5qNzTolzlrf2eUXrgaxhWayPsFRBEBRMftF6q6JBkshxy6a9dyNUTcF/d
RfGVlAjPju+ZFIZDlEl99A7pMBmVbVD3481Nk1JQeLiMDieEHb7knbORrKMlnKl5
On8MmjOuakh/M5iVvniYUDBgHlD/0TSFvn5Y8T1ip8/3k8sh/L/rxcrt+BEPo7cN
PwCvqDOQVwxPoCqDEiksIVX2Aw1Y2iCXtQagBCT4bBjoskNCXm4=
=w9fn
-----END PGP SIGNATURE-----

--xBogxZoS+yMG4Fb2--
