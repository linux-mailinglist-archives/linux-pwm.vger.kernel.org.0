Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1AAF18C62
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2019 16:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfEIOxE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 May 2019 10:53:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40984 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfEIOxD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 May 2019 10:53:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id d12so3461121wrm.8;
        Thu, 09 May 2019 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q+1TsGRKkwXUYYOoB2LIsila6ZhfcUv70iojfQ5/w9M=;
        b=dvO63F4GKSuh+nx1VkFNjrbeq11WPXdaaDZIDHHzeqEb0NC2LSjjRvIMFTU6xWKCAS
         NSz848cbvpQZmfWPe8Q5F4WzqTlzYFtIjQhq/iBANrIEZD29GrwhSUThKRvtqeTLxVga
         8Jnwbvwxoh0zvK8gumUsopxm8EUOq5ylrRawCp/7M9GfeiySm5Bez81iFE3VNLSEd4V9
         jvy8KDKUx8jOblvYJ49BYWvY6S1dho2EH1yeg2+zuUBZUaf+IwTxARnK76IGMxTYQJAV
         WRDGN4TEsnlJ3OnxtVJzOpnEAq9+T/h8Es3/+9cWV6POPE+EwjxLrew7SYzA1rK8IDvB
         +i9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q+1TsGRKkwXUYYOoB2LIsila6ZhfcUv70iojfQ5/w9M=;
        b=krS2iM4mqA6SAr8Tmo2iIHjpKacd3B5nC8yvNJeY2+WSH5vWMU7RFSSrvGmi+eZwUW
         D5e0R47C9ol743xwaUWNlMNrBPDvrvPQNlQzKZTlMWGcebBaU5gMQ+G9ll+5dAY2ijXk
         tVcbSl9mfzXkYLMebLO0xaXHC7UX7l48UbjowXJ0jsk05IH2RF3EwV8p29d734aE5c9w
         31sAhO7P3Xlhxgwvruh9pLD144PfGZaDWlNNLTbzCtPPcJlZpj+vobAD2/0TrzBJaN4e
         62oNVDxZN1Gyt0m7SIivqQhsmDsHlX7tgWI40QRj4MLeF6AxoLm5BIm1KPELCqWqzfls
         5bqg==
X-Gm-Message-State: APjAAAVV/3p9L1AwpiJ3Rd7Crchvhv/DRhSGUB7gJugE/eiOSfpi4BPP
        5Q3xtz7REQwRTaGmzzt+znI=
X-Google-Smtp-Source: APXvYqzIxbcYRCSo8r50PrcP3rEHkfelhjH97R+hDzmn2hwZU4TaoWItIaQT7DNkBg+WqpZCTE6Naw==
X-Received: by 2002:adf:9dd0:: with SMTP id q16mr3534840wre.28.1557413581230;
        Thu, 09 May 2019 07:53:01 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id v184sm3707659wma.6.2019.05.09.07.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:53:00 -0700 (PDT)
Date:   Thu, 9 May 2019 16:52:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, bichao.zheng@amlogic.com
Subject: Re: [PATCH 0/2] pwm: meson: two small bug-fixes
Message-ID: <20190509145259.GA8907@ulmo>
References: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdOeJE8sLwpQaOMV"
Content-Disposition: inline
In-Reply-To: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sdOeJE8sLwpQaOMV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 08:18:15PM +0200, Martin Blumenstingl wrote:
> This series applies on top of my other fix "pwm: meson: fix scheduling
> while atomic issue" from [0]
>=20
> The first patch fixes an issue where the maximum possible pre-divider
> (128) could not be used because there was an off-by-one error in the
> code. I discovered this while testing with the longest supported period
> (349514407ns) when running from XTAL. This is verified to work on my
> Meson8b Odroid-C1 board using "pwm_b" on GPIOX_11.
>=20
> The second patch was suggested by Uwe Kleine-K=C3=B6nig but was actually
> implemented much earlier (back in mid 2018) by Bichao Zheng from
> Amlogic. This patch fixes changing the duty cycle by relying on the
> hardware to re-start the PWM output (instead of adding an artificial
> "constant LOW" of about 20ms - as measured by Bichao Zheng when
> stopping and re-starting the PWM output from within the driver). I
> tested this fix on my Meson8b Odroid-C1 board which uses a PWM driven
> CPU regulator (DVFS with all supported OPPs is still working fine for
> me, although I couldn't observe any issues before this patch).
>=20
> I also have some code-improvements queued which I'll send in the next
> days, see [1]
>=20
>=20
> [0] https://patchwork.kernel.org/cover/10880419/
> [1] https://github.com/xdarklight/linux/commits/meson-pwm-for-5.2-v1
>=20
>=20
> Bichao Zheng (1):
>   pwm: meson: don't disable pwm when setting duty repeatedly
>=20
> Martin Blumenstingl (1):
>   pwm: meson: consider 128 a valid pre-divider
>=20
>  drivers/pwm/pwm-meson.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Both patches applied, thanks.

Thierry

--sdOeJE8sLwpQaOMV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUPssACgkQ3SOs138+
s6HQ2w/5AYGbx7MbLUpSUjsimmVEVGLHZMNi+Ma8lE2mK2HKzvp1nHPQvai/Pob7
2dnkyZjxB5FhHBJSuh92Wpk7rdLUMEG0mY/BJRkZG5Ne2dt94Jxyz2clVbM950kE
7YtzMBuPmCWvn8noD9aSyiVqVAeBppUfQhBBWvWaC2byjmXW5YB0ND/yyZH6o33x
ZS9gH8v6COySx2zNxzWjk3Fx7q8PjqnY2JvKZqpLSoE4rt49YJnUdafeRPDdBOoa
odBOSmVE8u4NvjLL/lbHgfpX9ITApqBGsfIX9EQZiqsGsD3DFFJff7zuxjMJJLfZ
cVsvWaTRzQhPxB2CkWQJ/yn8OI0JOPdCXKyZM1sK/apBRj3lEhD6AoYdwlslk4MW
Qn4mqSf5yWE7i8XnSo9Bb3IvE0U0F9+WSRE9Cf/IeKryeE2SwbIGNbbHrtQNqD4I
95xa0Ck4ijkwX4N3j1fL+/6VfLG/gRUs7aXUtwfMPyf4ln49hwHvAkFJfWU7fOqm
zffAQhbmqEeuiGFO9BZGHtTF5l9WzOEhs+aqtupn226xLAAUA5AUUZeypRwswNIM
x8X91p+Iy/EJdck2vcsLmFgl2CHuSo45bUepmicGOaOc1611ZZMry5fgqSgEn4iI
pVmuiNeb8uZ//O5v+GG0vdt94+lLwZAwCARg/UHfmPf55T4AMuI=
=7AFQ
-----END PGP SIGNATURE-----

--sdOeJE8sLwpQaOMV--
