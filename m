Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC791EBC0A
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jun 2020 14:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgFBMsj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Jun 2020 08:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMsi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 08:48:38 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7D4C061A0E
        for <linux-pwm@vger.kernel.org>; Tue,  2 Jun 2020 05:48:38 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y13so12633307eju.2
        for <linux-pwm@vger.kernel.org>; Tue, 02 Jun 2020 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D8ASqWdJAv4t2zLF3N0AUOlU0jAxJ7ZIdD5NPQNHjtQ=;
        b=q5BiBMm6LBcsZZl6y+QtTB8QMD09UkwOycxWIv8vTm+sOTvKN7AnH4f5Dbb4ihlc0T
         hjZO8PZKG6NCuSHlJQMKMe7adp3yh0QoO+G8PoGz++SYakN6EU/I47tc6LtpGpLLojON
         349dPRDJttaotizfuNqo2/ktYHgJm6hK18mJtUPkk5ZSnF8BOc2Rv6lQWiuzgXpFm+KD
         X47bmmhC4lr1SiHhb1oCsPpgVI5wETtOUVtKSfSZ3mIQLx+Wm7PqqaXwC6dPN5+bo0Wr
         pIPQY2V1/d7z2tgVw0WjtnlIb17ymUZA3uzua0FOWjqIV5S1bcvKSwhep78wkTC3+PtS
         E7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D8ASqWdJAv4t2zLF3N0AUOlU0jAxJ7ZIdD5NPQNHjtQ=;
        b=VLe9CQv8h+HrI4hHHspJ4YHsyVu0W6BQiVqtHu0bVHObz4d2pv+ON0kwLlIfE86IyC
         yp1UDamALVf1kw1tpJ+6qq50bhOPiwjMKc+qOmerUWcsmkp8M9t0RnGhLlXe+b/nFL4u
         UNxdaETPvFlYeYjZERrKq6aEeVrNvE7S+w0hiN+iPCFcZH1ysyac6gfca5s834L6hMJJ
         xCJkhQJ40RcgZjzRjsMoCrwU8C8+cFP6XqtN1kOtm6ySvaCCioENrlEVRFX/ArxDl1y5
         amh6tv88/mSLmO4JIAwWySg9u7FKseZukfTSUpbGoWDc1k6lGzdOS819+GLd0zL9x618
         tbxQ==
X-Gm-Message-State: AOAM531IkG2bByrlJMxhtxte/st8GsATr2D0HpMZ6XtiR1Gk+t/+LQRn
        eoS2nCUwm8HPrEQl5ycM1s5/2C3G
X-Google-Smtp-Source: ABdhPJz9TSeTycfAnFGOX7r1nw8BJ3WU0LAiYCUi9qQB1y/48Xus0YdiirnXPJDYCzGQ/fZvyc+wmA==
X-Received: by 2002:a17:906:77c4:: with SMTP id m4mr14353047ejn.246.1591102117237;
        Tue, 02 Jun 2020 05:48:37 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id sa19sm1621550ejb.15.2020.06.02.05.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 05:48:35 -0700 (PDT)
Date:   Tue, 2 Jun 2020 14:48:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: imx27: Fix rounding behavior
Message-ID: <20200602124835.GF3360525@ulmo>
References: <20200416080245.3203-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Content-Disposition: inline
In-Reply-To: <20200416080245.3203-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2020 at 10:02:45AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> To not trigger the warnings provided by CONFIG_PWM_DEBUG
>=20
>  - use up-rounding in .get_state()
>  - don't divide by the result of a division
>  - don't use the rounded counter value for the period length to calculate
>    the counter value for the duty cycle
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-imx27.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Applied, thanks.

Thierry

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7WSqMACgkQ3SOs138+
s6H0Ew//dg1D7NOYsebYUxn1ebbp1eH/F2Xg1HwYxqcR0QKh+xVcdEHbVEVqPkKL
Fn1HM0l8qe/Und4p8CvS36PyTTGn4X/c3O3+l0wXYvsbTMCwlQctBbcWMvafAgIj
xcjfweYrjXZUwNM9KYiNIZCASt5pI3lfTbnxp+vLQhnGgkL8ZmZUmBmspVTLsSOy
yYn50/FlqSFCFWfiFK/WE8UZWo5rAFO5KubXsJKKMipyJuKTa5tumLj8ic30E9g6
HRHqPuBS/BoIZ4ZzxfgDZo6qyHHvnlFx3ZAXxEFwVGiHj2gy2LH9XpIW/unZLxwq
kW5ydvr+ynOZhKqWNHP3g2080+tM+nm/G6PUeh4tws85qANHcFYge5HhjF+NDunP
oI1ZOgIaqBcRnBRooDJ4Zn/JQHmpQ0X4pwJdNeKAR2pFq0wp5w+UeQbNpRMxJho1
ia+KawFNTWTFCTLFgvzP2GY0yZ+BL5Kx6820khlcQtdq6zqNz0EWS4dJ5pN84VB9
qkpAOpMiP0Mvx8cnaDdLzEFZ0LAE8wIIlUZvS4xo+PzMglH51F3HzHjYMpJ45rEP
dlAXS7W2tswYlUK89IrpEdZv5dcT4t1FeXtLRfZF0bv6RUGW35uTUw8sWgvqk3KT
dkpcXxfpRNkifF63NKULxHq8wrEAbwqZDdYzlVLweJMRpAW+/TI=
=YRtJ
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--
