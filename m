Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EF050BD56
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Apr 2022 18:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449793AbiDVQqq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Apr 2022 12:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449794AbiDVQqp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Apr 2022 12:46:45 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F535F24B
        for <linux-pwm@vger.kernel.org>; Fri, 22 Apr 2022 09:43:40 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t25so15253240lfg.7
        for <linux-pwm@vger.kernel.org>; Fri, 22 Apr 2022 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hSLDhPvZ/qq56qC7ghMdZ74eW1bE+fY1+xiSFROWRIA=;
        b=p3sboTo1t7/kbjmdbuUJL5jhd910l0H0RZEdw5MqFoHg6mLd98irRDg9i2BkhVyVBg
         9q0K/B1CEpEERgEwu4uZ/vnd0BUAzsjw6QtvWdLRxn9DQ3/M9gXSvTe5UE+O6f6rl0v1
         fFDkv5R3hNRlWEAxbf9nIXnmL6Ju8czyqIzwQLpM5vbjWMIs4rkHb5NbFTwZozgE+YuQ
         6X3uQsnu+hXbbBos4wBw2RiX+wmkDZTsVuLBoO9wCQ0U68zce1bmfAG+cYA7LQDimArh
         ToZhD6HD+gaR/JdTrpGVaAR9l6jd7SndyYXWHu40ijIeRt7m4w+gokfnb/Xw20zCltK/
         LiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hSLDhPvZ/qq56qC7ghMdZ74eW1bE+fY1+xiSFROWRIA=;
        b=T+6StbVSD3tDNk+U5zpUt9i6gfyuStRkuIMPyuSuZCGokAaP/Uujv+EMMxxRfe5nXj
         S1L1Rl7nBWP1VKi3y4kAj9EFSx35v+OLPRI9U1HOrmejVLbmEAATDfs1tJ32wCq1ThgZ
         SzaEL7k2hA+9k4tUicxvEsTpUxSeavxJWno4zYHuaAwDD9JLamM46fIGlOR5yHlW7X9I
         Vde40dmVQGOEnactXwQaWaWuKUVjDRo4SgQzsJc1xh/hHJJOrGpeWFDMM8ljZNjGazVm
         S509GeQ7GYJn1iQR7ZEcHvVhzkkXfMsz+oeXETS1t7FbQGqR0jd77rt1iIuoPmtdvDs3
         kWgw==
X-Gm-Message-State: AOAM533eFjufBT/7zL6XLrZJd4jYjc2AQu8717RBQ0huiUlhuxpaLO4f
        LURwNpR60oANz72wBEFrepXEdrDIJbQ=
X-Google-Smtp-Source: ABdhPJx5JVq09zzaY2EB6TzgTXEp6kOlU1t1Ku7CcDGMpZfDgVaboniKAhk5wUaKdrs/bsGr9zy2FA==
X-Received: by 2002:a05:6512:78:b0:46b:c2d0:8134 with SMTP id i24-20020a056512007800b0046bc2d08134mr3813207lfo.686.1650645819174;
        Fri, 22 Apr 2022 09:43:39 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id m20-20020a194354000000b0046f8c68f965sm279809lfj.166.2022.04.22.09.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:43:38 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:43:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Milo Kim <milo.kim@ti.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] pwm: lp3943: fix duty calculation in case period was
 clamped
Message-ID: <YmLbNy7q2ZBnNsbE@orome>
References: <20220408152239.164462-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y5USQPmL25wGDsD+"
Content-Disposition: inline
In-Reply-To: <20220408152239.164462-1-u.kleine-koenig@pengutronix.de>
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


--y5USQPmL25wGDsD+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2022 at 05:22:38PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> The hardware only supports periods <=3D 1.6 ms and if a bigger period is
> requested it is clamped to 1.6 ms. In this case duty_cycle might be bigger
> than 1.6 ms and then the duty cycle register is written with a value
> bigger than LP3943_MAX_DUTY. So clamp duty_cycle accordingly.
>=20
> Fixes: af66b3c0934e ("pwm: Add LP3943 PWM driver")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-lp3943.c | 1 +
>  1 file changed, 1 insertion(+)

Both patches applied, thanks.

Thierry

--y5USQPmL25wGDsD+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJi2zcACgkQ3SOs138+
s6Hoag//T6Cap0KY+6Gx7TrkrrcUOO/dNdOhH9gi4pWPIDGUOGANGf5MVb49+7CI
POepgRbVb5PQ+B0m+Vi6Z5fvmm5MEYlGPLwNNAfrKRJzX8KoHUaS4tuMVSovN0P3
GX96cOXIPYnhkrm40GPgCH3uAoH2m728NR72jrpyHtR4uq+8zz285794gqJFqJBy
93kIPeYfi7/dPiYhWrxFFjmCFRC8+RrwrGsgklXmGjyqaUNNymRAwQalhTw7vhZE
QT0UZ8ntXhAMjlsBmRAebDILRnK5uraxpr2fwYqLMUiWVKApJmyM8xCivp1uuM2C
B3beH0LhgrJ5ud8qUTvdeMbYP6RhzMbJ9NjkD5QQETPu8r44812WAZ6UrDcRZi6d
t9AUg82A8u8B/tglGCka/N54ze2i+cNxh3yEJh2NF5Qf42FelBfUN7hAqAPRlT3E
+c8Uq6GNRIgS2eJiHgR3YIRNFjj8TgA+fJ+VUnaHhy+6UX2p9TXL9XzePYqu4GRs
6z2sGus7ayKDqUWevd6zB+YU+R7U9TCPlZNn6cT8ug5N2ObFIqWEsXUoiBhz9QBA
1bxzPxmQR433G6LVBj368UgXVV3+uQpmntppKRbV3Ceq7CqWwS1SRV/sJ4JWzj67
aPgQr2ou5G8Ezp05zE2cAFlE2goJaUF0+d3rj1pm96qDpzizxiw=
=zEOk
-----END PGP SIGNATURE-----

--y5USQPmL25wGDsD+--
