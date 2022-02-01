Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA74A581C
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Feb 2022 08:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbiBAHvk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Feb 2022 02:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbiBAHvj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Feb 2022 02:51:39 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10299C06173B
        for <linux-pwm@vger.kernel.org>; Mon, 31 Jan 2022 23:51:39 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id j2so50790074ejk.6
        for <linux-pwm@vger.kernel.org>; Mon, 31 Jan 2022 23:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1eOQXte/ttf4BLlpxNLNvQ3pV+AVKK+X/iBpKN/Oep0=;
        b=MA6Q4QOJbH/JUhj9pyMd2jRrM9t13ittE0yi6IBM+yYxpPCiLBH8lhdYk/Y/wzZQ2x
         mIy5KXlE+zngJuBUH35xUeK3K+Bpifm6Y9lg8kpscZvW5unyTRBGkyl+KkNjhPgYn455
         ClwyV+L2+IYqQVFSoc5Fp0QnEbTtKpKu5glSb6FIHa3V1WjwoBmA7qAFKIE6C64x6Ylw
         uDM5K1R42LSNhUl43Q5FDqCVcd12zOw7KZA7oO7ColzSpTh8j+/lKKL95EZcCxRU28MV
         PNhfUhmuFPX6+avSJVthPkEBDr4OClMeakSz4AkULfzIpLM18h/lEfyw02CW8dbkK35+
         OnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1eOQXte/ttf4BLlpxNLNvQ3pV+AVKK+X/iBpKN/Oep0=;
        b=Mtz5SNsQ3UyIdGATyxuZLNZF4fIQrDFisnoXYlN746u7hGMBC0bm1bx6LQrehXNwZl
         41UxJbxx/bGPqQGKay0X5x46KMlr5K4RF66n9SNe+5NG0VSbie5G8YnE7c6v5bHwXvhI
         hEF0xpMJnzEpVRgE/FyvDzbs7IFoFZFLA5BtXMxwuXnNvIhHN/U8d30QrDYU+Q9I5JPm
         4Wy29KbF4ZbTAnj9Oi3SMPFhdwYDC9/SV7WFwATEAQxwvm+jJQp9iHEgs+TwpfL6zn15
         gfVsYvSI99PGhJrCimULww277TmdMTIQfTGAT8K7l9F9sFBb+hQ4rWvFHhrpUGZxb1We
         x4Bg==
X-Gm-Message-State: AOAM531LyOqmo+sUN5xDCdR6m6mC47dqWsf/u3Vjp3ESj8rcAiST3q5G
        cwOc7E8sQx0gHI/qTGyj4lM=
X-Google-Smtp-Source: ABdhPJznT3p6XLLKnPQrtfkRMc1YTbBlaBH4sQSdw0lXgdgTJQDNYBaumTOHlEG84DMSH+AAPywgnA==
X-Received: by 2002:a17:906:58ca:: with SMTP id e10mr19636595ejs.747.1643701897622;
        Mon, 31 Jan 2022 23:51:37 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id r15sm14135645ejz.72.2022.01.31.23.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 23:51:36 -0800 (PST)
Date:   Tue, 1 Feb 2022 08:51:34 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/3] pwm: lpc18xx-sct: Reduce number of devm memory
 allocations
Message-ID: <YfjmhhbDaEuaYKfb@orome>
References: <20211110084950.1053426-1-u.kleine-koenig@pengutronix.de>
 <20211110084950.1053426-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aWY76Ep0dM5+N2BK"
Content-Disposition: inline
In-Reply-To: <20211110084950.1053426-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--aWY76Ep0dM5+N2BK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2021 at 09:49:49AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Each devm allocations has an overhead of 24 bytes to store the related
> struct devres_node additionally to the fragmentation of the allocator.
> So allocating 16 struct lpc18xx_pwm_data (which only hold a single int)
> adds quite some overhead. Instead put the per-channel data into the
> driver data struct and allocate it in one go.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-lpc18xx-sct.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

This could've been merged with patch 3 to make it a bit more obvious why
this is useful. Patch 2 itself is a bit half-baked without patch 3. But
I'll apply these anyway.

Thanks,
Thierry

--aWY76Ep0dM5+N2BK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmH45oYACgkQ3SOs138+
s6HMKBAAna+c2iANvCK0JIcTtWKgpQkrlsmpd0nK5OymirOd7ZWD4noT5ZTb1zlK
+cHFG/HtOS0ze1Yc7D8EN4BsA9XF9ug7Rpkyp6Z2WzOTKMRYq+xiP1qRBGR5fjzy
1Qz3JY6zDuVCQ/xW5vDqQiAvbsxCRgYun5JIU5GA4qTt77cc2hwxQpo3dYKDuSzC
X1E5dJDWsjCAlEPbsYdCbO29QxPHduCoeXxK0Jk0FXPiPIa0qgHd0kCcP5qHzGgX
Wk7U+iSu+ib82qxQ3RZlAoZ+C3zys3sDSCEE+FbPwLbQPnnK+XdLIUYLynqOmTqb
O9d2EWbj99uVVEFjwKT5rWcZag+D+KtUad6iImzCYm9dcxM1ntrn86zn2KMPtQht
anIehpjEqU0fpXJAqGCTe3ShDo6I/mcjLLNa3WHJvhkcEnFAnTO9G2fVeRAC5/Sl
ZHD4Koeldgnxvy+FDxdN2lw53uoGzBB3+DZm18LHf8GgMpZ6sCxBVPBxVau+7G93
BFDFHEUfiZKa1TaxT8qQOgMe0Deq8tfZ7RaPzCgmppviyHRGR0CffacAL4LAEJ2N
dfsgXpbJA5cnHscNnJCfjRaquWEcRJVcFZgBMoXSBhmBpgJt5NjO2pdOsUoaZMbz
lIC6zsPGVWKXSnwahy9PM0dETkUGRODMMdVeByy2zHMWmqgWDDU=
=te/b
-----END PGP SIGNATURE-----

--aWY76Ep0dM5+N2BK--
