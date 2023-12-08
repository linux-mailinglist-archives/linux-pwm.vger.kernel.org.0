Return-Path: <linux-pwm+bounces-461-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E1480A722
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 16:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE182813F6
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 15:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA625225D5;
	Fri,  8 Dec 2023 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeHGrADi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92181999
	for <linux-pwm@vger.kernel.org>; Fri,  8 Dec 2023 07:15:37 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54917ef6c05so3130660a12.1
        for <linux-pwm@vger.kernel.org>; Fri, 08 Dec 2023 07:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702048536; x=1702653336; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwBpA2u9w3j7nQkyip2cRWLAfWxPLIK5ZudJEH/mfRo=;
        b=UeHGrADiiyqTMa9FhIkCtSTIawP02Zt4Af0RTBZi5V2WVqCVNZn2SWn88aRj0eAo6d
         aOtC4fU/akE/jQZweRVoNLYFHSIjo5t2hZMa5UEX6M09lvAas2mGueXCHqud8M2OW6Wc
         vm9IhIW67iDyfG/AJGCgEkNU/gLIDcevUjOxqmE/FocLUXPiCcD3a+5ZVHj/71X06rdm
         nRcYnOmlOHzYKMg2swnqEaT8Sth+E9ivntVhnQsZwykqU/Cxup/Dtgv/GQas1SarRD9/
         Pcya8RVHP3V3ufge+Nmt1Z5vR6aPAZatV6/hemWhU/jhdCKrHo7FqjKmfwtHPRZgvmUF
         6Tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048536; x=1702653336;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwBpA2u9w3j7nQkyip2cRWLAfWxPLIK5ZudJEH/mfRo=;
        b=YPuLjoKiSkQJX7lOfJyZAiHXjHpQz/pjT5522iUAbSGUAXh62fKmKquhbPcGv/LZIg
         zPErRcmk29saAfzmYqhfAuDkpvT9AaIQmXtx4FwZv84HwFr2HdBVxzfK1I0T9lxawmEq
         pIatpk3dHR5dKA3p3rPQhspo0Dp02wPbD0KRZoaIhqBrTu3R64UJV9/4abafPv4Xyo+D
         th9Fm9468/0OZqF+T1Rkw7HNo5eZd89AQ71aAXAQGWhIE5wv/e/CD47h7ZCs3YpzFFgQ
         4Yk7jyXQwWTkehENy5lBjOqLAIWsUAOYUcw8xBIFl6p2P2pIwChdNY05VMH7Zwvqr4ir
         UctQ==
X-Gm-Message-State: AOJu0Yyeoc8Lv6gSTpEwLulafoCGX0q12HiF/k0N95mTsgfCHGBFngMX
	CalAj+HnTbxw4ePqzMtecAp0jBsFnyw=
X-Google-Smtp-Source: AGHT+IGsygsU/NA1bL55ExYvsU+hQ5+K4iXTFGgiSg1SKijSn6TpOnTG1Q7ZY1sbcECQ+dEvL1c5Yw==
X-Received: by 2002:a50:9997:0:b0:54d:9223:6fb1 with SMTP id m23-20020a509997000000b0054d92236fb1mr108030edb.120.1702048535892;
        Fri, 08 Dec 2023 07:15:35 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v21-20020a50d095000000b0054cd6346685sm900567edd.35.2023.12.08.07.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:15:35 -0800 (PST)
Date: Fri, 8 Dec 2023 16:15:33 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pwm@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de
Subject: Re: [GIT PULL] pwm fixes for 6.7-rc5
Message-ID: <ZXMzFVphyrcG8r9H@orome.fritz.box>
References: <20231208140253.m6lpundvnvtfsloh@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ruoL7juzj/8dALBF"
Content-Disposition: inline
In-Reply-To: <20231208140253.m6lpundvnvtfsloh@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)


--ruoL7juzj/8dALBF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 03:02:53PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Linus,
>=20
> the following change since commit b85ea95d086471afb4ad062012a4d73cd328fa8=
6:
>=20
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
>=20
> is available in the Git repository at:
>=20
>   https://git.pengutronix.de/git/ukl/linux tags/pwm/for-6.7-rc5-fixes
>=20
> for you to fetch as commit 4e7a8dbd2bc0aec4605a5069df7a779bd9e64db1:
>=20
>   pwm: bcm2835: Fix NPD in suspend/resume (2023-11-21 11:09:32 +0100)
>=20
> Please pull this as a fix for the next -rc release.
>=20
> Best regards
> Uwe
>=20
> ----------------------------------------------------------------
>=20
> pwm fixes for v6.7-rc5
>=20
> This fixes a null pointer exception in the bcm2835 pwm driver. The
> problem was introduced by a combination of two commits merged for
> v6.7-rc1 where each change alone would have been fine.
>=20
> Thanks to Florian Fainelli for noticing and fixing the issue.
>=20
> ----------------------------------------------------------------
> Florian Fainelli (1):
>       pwm: bcm2835: Fix NPD in suspend/resume
>=20
>  drivers/pwm/pwm-bcm2835.c | 2 ++
>  1 file changed, 2 insertions(+)

Uwe,

I don't know why you didn't let me know about your plans to send this
out. We should've at least discussed this.

Thierry

--ruoL7juzj/8dALBF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVzMxMACgkQ3SOs138+
s6Fq9Q//X/I2tqRX/Fl1VfuudIOqbQ6QG2vPO5/tGiIt2vK1Fm6jYSqumTXhQIOa
BAbuhBkkgD5eSoYsPs5Wu7EFEcT6oNoXyG7M5ruwdT41BQyQIZk+cu854tb8gNlv
XJg/rLZKBN3UeINWu5ca2XgzmIxTmPNt5818eRGorp1O/rg07LqRqppT4ETcZDe1
uhhFT4eGtf7rHXJiCeEbMcgYcfFbhgSJtNb804TuXN3RMR3OeFYNG8GZtgCDWQ05
WGeLYZO7fqZtNO4L/uah75MbrQblMvWAxSmdhzKp2sVmqoI2pDq4DZrkE7+luxiO
Jm1csgsF5MIx/viLbIcVvtqxWWJM6W9pFXODwsZymsojL/RgndamL9R8l+5c6OIz
1mQRjcsxqOnH41OkfhSPfqilXkAWZF4UFwkueIarT05InbzhrbsyA+YSNMZusXDD
c8a8XXmQkW7QMa8GtR6q8L5zmIGRw1r5GKfYwgJ0nVx3EHsiCIjJ6kpku/EL0Mzf
uNabPVGcSYVrQmKBFa3lRh0rpKgnqBiHGDfa3dgBlIGwa05deNFNKqRr57QVwKlo
77P8prKAeCLQUAUQRvgQFmAQP0z8t6f6NY71rxMgsZK7A98+lvbiMXOG+vb+XYAz
MNWl6gD/rDZCa3X3kRaAwcVlwbjknlWFE+V+MVUGhFEX1FVdyzk=
=Hy04
-----END PGP SIGNATURE-----

--ruoL7juzj/8dALBF--

