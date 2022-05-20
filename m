Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7864C52EDAF
	for <lists+linux-pwm@lfdr.de>; Fri, 20 May 2022 16:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350065AbiETOAL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 May 2022 10:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiETOAE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 May 2022 10:00:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3FB66C97;
        Fri, 20 May 2022 06:59:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u27so10816306wru.8;
        Fri, 20 May 2022 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nQZNQkjqA6U0liYRRuGZsqemlIj46ksgprcW+qYyHIM=;
        b=klnw3V+I3SRyAOU9/6zrH9P3IqkMRzwQ/HSX3VF5x8mGvEkly9ffJYBtWOetqY9WfN
         yeonJ7imH+cs/q7eWSbNOQEFaTrmErgTpbya2oCCGRuqMN9hFV0bP+tbkyBmD2X7zrT5
         aethOGokYnkOPIS7pOdMxME6fKLZZW2myC0KGhEx8CvUAIEi1Bui4IraRkUVDbLmkmnw
         m/l99xEzKRDSSDOAlKMbJ26UL+To6GfrazQI/+K+uY3f27VnO7utGU/YXUGLLhLQzPZo
         cMVItLBlLJtel0eFy87+e9OjnEtulGTnbEdktO7538OQCZN4TNAnSzgxq/D4BvW5cmn1
         oJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nQZNQkjqA6U0liYRRuGZsqemlIj46ksgprcW+qYyHIM=;
        b=6gH9tOckAf9uUtmvnvcKOea6vEPn9ZaL7xf0s1JSSPfQUMdxycdeRf6JykDjmOdsK8
         NIFgPePe0o+XT/eoyM2drpZPGJhio125CdckSzNc3ThJX9LqR7xBzzINqGxXuymDxY0k
         p9VQ7P1ZvRGxZhIwKZhXz0CJWYIEcS6N8KOAKYvlFZzu/XSp3rkeBlDJn/9CRS2uH87+
         L4nSE18XphiLESdQbLb77qV5j8Z44Njbk0hhLKEVJDkvBF5q+YALlQ0dBFlPgkH1erR8
         K2zmGHXjMlSJvt2g1mhqtmduLbCcAyl/eVH9eY5OMkaC1KYSsw01Dj5dhvsH6070UMlG
         9+8g==
X-Gm-Message-State: AOAM530kg4LhVB4M6QwfQETWLvrI9eRaf68yqQV0TrZQjBPX70pVcv18
        5+w8VzJTXPRdd/h745Dnae0=
X-Google-Smtp-Source: ABdhPJyHZwq2lHyY0rFxdpRaCmpuH4jyYs0CfKmB+rj/wh9eIbRvVFf2jmLxDK7GE7bPZsolS2ZLSA==
X-Received: by 2002:adf:eacd:0:b0:20d:6ea:13e8 with SMTP id o13-20020adfeacd000000b0020d06ea13e8mr8664177wrn.312.1653055197893;
        Fri, 20 May 2022 06:59:57 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c338400b00394708a3d7dsm2086038wmp.15.2022.05.20.06.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 06:59:57 -0700 (PDT)
Date:   Fri, 20 May 2022 15:59:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: samsung: Implement .apply() callback
Message-ID: <Yoee25lpQ6DRcZoG@orome>
References: <20220328073434.44848-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qt/HAp5dN3afZuBr"
Content-Disposition: inline
In-Reply-To: <20220328073434.44848-1-u.kleine-koenig@pengutronix.de>
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


--qt/HAp5dN3afZuBr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 28, 2022 at 09:34:34AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> To eventually get rid of all legacy drivers convert this driver to the
> modern world implementing .apply().
>=20
> The size check for state->period is moved to .apply() to make sure that
> the values of state->duty_cycle and state->period are passed to
> pwm_samsung_config without change while they are discarded to int.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-samsung.c | 54 ++++++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 12 deletions(-)

Applied, thanks.

Thierry

--qt/HAp5dN3afZuBr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKHntsACgkQ3SOs138+
s6F7OQ/9E5HE/beLWPhDwx7KSju1F8QLGbcPpAWFUH+jcD349WTlotdTT7/ZDY0f
TggGFxGlg/RBIr3bDnR4CqwQ1Qa0TcepHVE7U40LRGYM8r5vpOjosrLlbHNgEGkx
05pEzZ3TZbPQrXscvjlDH3zP2g69uOaeHrbTu6MKzg6S/nJSebf0n2MWdSKH/zN2
ewi5nSpx5QDlfvvSE2wobZ4XcNKN0onvV24gjtwT/I1svvNjcmrYhmZR+GYB3mto
zIM2Aes7Rl95uJ7oInVaRrCp2jRRkHKTGLItuXtmHYZDSWN6u8Ra6I7aE27CRmrU
KLhwtuO+Df/hRkkbo9122k+csinO9itIhMydmhgdZJLUUbabrlM4gymTG6ent2uV
SdvxavTi49/rZulQTiWyowxfkKYax0Esjk0BH4dYANE7gNqzsHiCfGdO6I71FHRj
MfW6tCS1W/LmdugJ1FERHfUCmOztmtRbZ0zvqfxrAlcGi2YXlndrdNZDcxomUzVy
EidNQ+UO5CqJx2wmRlux2Aubrjp7IClACz3Yt2J4k/6zrbP50540jqeLIFtxsnki
tXunhSbYfuXGhjeYT92/EHMKjZgaT5SSIbrvSNuqL4aCpmgSsQvF9xIvPjQdnHnb
ix2OSOAgrlCESrvfhh4qpw21HAN4VS4kk9TU42xxV9djA9fBlSc=
=bs+z
-----END PGP SIGNATURE-----

--qt/HAp5dN3afZuBr--
