Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A993650BCB3
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Apr 2022 18:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378332AbiDVQQf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Apr 2022 12:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378127AbiDVQQ3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Apr 2022 12:16:29 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5865E177
        for <linux-pwm@vger.kernel.org>; Fri, 22 Apr 2022 09:13:35 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h11so10244375ljb.2
        for <linux-pwm@vger.kernel.org>; Fri, 22 Apr 2022 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PzcbmcNBDSLvt2U83LGs67m5lIGBD3xN1LEXJmz0EiE=;
        b=CTMMNoUMclwVRDfNqnz4EFyYHvvpVdmmk2vUfqbROT0cwOSEqH4O04K3ImbfTNSvlE
         99ica51VNnNjLsUCY6uOKcP8NMKFVdItO1jAz4qpx0mKVWqcEb1AFNNOAPwLgucgOICD
         Hl5D3naVlJMtT+Xf/2KjjLsUZXUYT37VIW3IOp2THOw8orRd2AEVFkB8+j17YderdCRh
         i37Ag3SPMagRj4I/dvcxZAGZ+0c/jfTn60+6D6KC6el1NYIMgIDht9dMj+urzzmIuv1v
         dBicF/NJ3YWqBx/9AL8hS06x63E57SdN9XngMxE2iYDY5U9Uy6GmuMrE89xwlm+ee+5M
         ZCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PzcbmcNBDSLvt2U83LGs67m5lIGBD3xN1LEXJmz0EiE=;
        b=S9fmB6BwVqaiGR63M7ekoZazrcTppBI3VcUj/7gSZ0Fzko8VsQTkCBHurijJaQNt67
         MfxZC09CjVxT9lg77WbnDXEMUch4Splugd8IxB1ZRGx6OuP/sJsttMGxbZs2TWx+QNvt
         FKw38d0mnWFWKKIwkU2qR3u298AaMcinXdIgaygJs6EI8NyjNPx0E+oHMueZhMtmiytc
         G1sXl7I6OnRgJCEvvMaiKJ1l+N/XITBwzXwKszbR2uG/1JsmlO+Sb/ddG1uMhwHE+JPo
         4k+4BZj8BDvobHGUBD8Ds0Fz5y4K+NtMseBadCig8+6b2jc3FMsE9yeLXXB6/tGXoQ94
         L5TA==
X-Gm-Message-State: AOAM531ux+O9ot4XtGGGN8KE+gdGEs8oZ5/J2AfaoFHAwli6H/uz6tSI
        i9UbHg+fK4WwcZLOpVOFpWU=
X-Google-Smtp-Source: ABdhPJz82M/fBjDnl4m6PBwNmanaDsedG/GOuujME5bL28tQauD0ssOzMYhArhtFDLRL6c48DwuEMA==
X-Received: by 2002:a05:651c:1542:b0:249:a87f:8a34 with SMTP id y2-20020a05651c154200b00249a87f8a34mr3353267ljp.442.1650644014129;
        Fri, 22 Apr 2022 09:13:34 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id q29-20020a19431d000000b0046bb8d1e4f5sm269590lfa.262.2022.04.22.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:13:32 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:13:29 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: atmel-tcb: Drop duplicated tracking of per-channel
 data
Message-ID: <YmLUKdYOJ4d8hCuL@orome>
References: <20220302180000.333087-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R3f4do0xUoqwJK+v"
Content-Disposition: inline
In-Reply-To: <20220302180000.333087-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--R3f4do0xUoqwJK+v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2022 at 07:00:00PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Per-channel data is tracked using struct pwm_device::chip_data and
> struct atmel_tcb_pwm_chip::pwms[]. Simplify by using the latter
> consistently.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> I just found this patch in my pwm tree authored back in November. It
> seems I failed to send it out earlier as I find no trace of it in my
> mailbox.
>=20
> Best regards
> Uwe
>=20
>  drivers/pwm/pwm-atmel-tcb.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

Thierry

--R3f4do0xUoqwJK+v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJi1CkACgkQ3SOs138+
s6FlqhAAjG8majGG8H2o4yutZN3cWXJYrbKahMHmFKtXH4JkQMVid/SpvmKaMdYz
r5wkh2IB33F/rlzAhOvO56d7vKrmSlYn7D8B2a0PgA7FtglcK1DMehZXmUhzl89c
DPqrbPQ099Dt8meks7ikg/haTGdRtozLsZEA/g4DKSqK3qy+XHwxZ/pGI5gaD5JS
CamV4fFiq0UftkxcxcJ9Di8asw7GrAnzQkCIk4yw2+2+ZeoVKJ1vWkHUgzB+JkFv
kiq0pU/qqZyNsv4qTEYIDmHQ0hirSRc5KR8MTmkGp6DxEy04BbbtbNUS5zGkG2Fa
vaXDCkVGgCCmp4m2cq6pDqdf+jSSC4BLatQGvdmJIdBHxNED/rJARv8dknPW51Yp
O0yE3YmF0z1BmXPCFuGFy0fqFETojOBMXK9yfvLM0b174SQHf6aS6bTeY/vvS13w
I6St1+weg7XkUhxvAg4uCI0KdoSW5xf2uPmvkufTa60QRaLymJ7nALAyYrvzhzzm
msAghJbk72CMgiqlf1Qa2gnmbPJyyRM50OBRHgfIex71KlVGtrrhXsfMJ1NXYrGQ
CJG3rs+WwNxJUc2X9q2HoRVVtXRgEVh0539DDgBCJakoaykVu282iYGFH82Mhyd5
+YmCkv1KIA2fQn7zsehVejUOIkfmtLvULr2tpEbtYMgp2vkR5d8=
=bL8L
-----END PGP SIGNATURE-----

--R3f4do0xUoqwJK+v--
