Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF4251341F4
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jan 2020 13:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgAHMle (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Jan 2020 07:41:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36566 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAHMle (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jan 2020 07:41:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so2351474wma.1;
        Wed, 08 Jan 2020 04:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2FpWqk5kX5ZHzdiu6B4EPT5qMnNg77c2Hjts/PYf+0A=;
        b=H8P3CEg+uTqzcZSyOl/Loa8wZGqZkRitl/SOWRJP0/aVFNuuGI7zodu6Kei6b4yEUF
         LT3qyhbKoPvXKgHoYXFKWOnlpYof81GFy71es14AQmvZx628+YG3oy8oGYjfnI0kC+D+
         ssZ/Yfq8FOTgKbNnazbaEgX0lo+Wd8nfy39FTOd2Bo39v38VVDzpCCyhAzFDZOkxghDb
         2b1v/ivhwuDjCIHVPxQarzNPZeNVVKVLuqye0R1vL1B56v33dc0hrtEANYuo8cszjAFW
         coOWk77rDWTmtLCiDst7ef7KSffAv9pFxwnEt1MRVRJ1q3H1Z3pwT/zkvX3y4SjGw1UI
         o7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2FpWqk5kX5ZHzdiu6B4EPT5qMnNg77c2Hjts/PYf+0A=;
        b=SpL6uBflHdsQSCEgEiBhL0ED1uulrejsDxTsTOae8xAfYPln6Dlhmihz1mZgoy4TJx
         t88w611uA2jArZvdiyNCsG+9SfCPN3SL6ICw24PgMK6vCRjvNh43gIDaeYpCDek6joK1
         HXPlJOCYozIJ6qH4OCrPBhwZ1vetBQAtDfPz8mOtMuM3N8e9wQz0X1QKkQSLkdmRNXcV
         4tkpiEnDfXWHUwpqQoD5TDHWRTdAEfDQqYwt4iCQAhQm1zt7xp+pE7pVOt6+soQ2TOZ5
         KfzmjmW/wP2pyvx9KQR1Rtti2zSjq5SWzLTLKxtuE76ya0pG1l3tVP88Ekrx4As49p8q
         aEWA==
X-Gm-Message-State: APjAAAWstGfaxmKFoKH3lKgc4uyOdSirsbpLREAoe3M4mfXalbKMvGq8
        09snXUYzXcsN3cmMu0uczb8=
X-Google-Smtp-Source: APXvYqwaF+btXG6zk5cvB15rPmx9cOJ3OhlFMPfM9b/9hmfBceRINUIsHbFESeLBwAtylB9xPyCaHA==
X-Received: by 2002:a1c:e289:: with SMTP id z131mr3483897wmg.18.1578487292009;
        Wed, 08 Jan 2020 04:41:32 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id w20sm3569232wmk.34.2020.01.08.04.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 04:41:30 -0800 (PST)
Date:   Wed, 8 Jan 2020 13:41:29 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] pwm: mxs: add support for setting polarity via DT
Message-ID: <20200108124129.GC1993114@ulmo>
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2019 at 03:32:01PM +0200, Rasmus Villemoes wrote:
> This series adds support for setting the polarity via DT to the
> pwm-mxs driver.
>=20
> The DT binding is updated, but I'm not touching the existing .dts or
> .dtsi files - it seems that the same was done for bcm2835 in commits
> 46421d9d8e802e570dfa4d793a4938d2642ec7a7 and
> 8a88b2a2017d1e7e80db53080baff591fd454722, while
> arch/arm/boot/dts/bcm283x.dtsi still has #pwm-cells =3D <2>.
>=20
> v2:
> - Rebase to v5.4-rc1
> - Address comments from Uwe.
> - Add Rob's ack to patch 4.
> - New patches 5 and 6. The last one is independent of the others, but
>   I stumbled on this when rebasing and found the signature had
>   changed.
>=20
> Rasmus Villemoes (6):
>   pwm: mxs: implement ->apply
>   pwm: mxs: remove legacy methods
>   pwm: mxs: add support for inverse polarity
>   dt-bindings: pwm: mxs-pwm: Increase #pwm-cells
>   pwm: mxs: avoid a division in mxs_pwm_apply()
>   pwm: update comment on struct pwm_ops::apply
>=20
>  .../devicetree/bindings/pwm/mxs-pwm.txt       |   4 +-
>  drivers/pwm/pwm-mxs.c                         | 101 +++++++++---------
>  include/linux/pwm.h                           |   5 +-
>  3 files changed, 53 insertions(+), 57 deletions(-)

Applied, thanks.

Thierry

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4VzfcACgkQ3SOs138+
s6Faow//TMKnlzQDSD5P+wcJ27rYXmJrVrrfo/2vFp2FVtLXqOjDk6c0uR9m8Qiq
oiSIc70R+qNva7QrmlgDZpbIVnSD+ziImsh04Zr9fH8N+pdWda26aqYkGjPUutXU
7Rh02JTyvOqBK7W9qEu2c7xrlUdKzadeeeQSxijqqAyHFSsG5wfNmZK6qeTlB0y/
q0tWwa4YyVfDhjkAWUvKUhw5nPfv/AKO2zStCMv8jIuSJ62w5ahypLBs2A3adZJY
npSKMvPIFzyVOaHdWs3+rmJJzbujKtqMKsQ7RyE6rBRaectlLeHSonDFSjMFtO0t
BKcikgTpmwUEVDzMh0l+uNGm3cAcIjIfRQ7cpigyQEc+dntXNQfRKh8y+x3pWeDc
gssO+6ftEcLgnBSy13djxqNf2xzzqzgv0a/nTzBG2OUfGL85VQTfocP2SN+2yYmV
X4NQckVF2qs8nSQtJCdLhYGUQQMJzJ+KLd0RDRms35E2QiawYii/KvUz+oqN06WP
Wt4h4SWFZ0PVsaq9EeW74DJ1iPvHgDoFWg2y+WGlKO1F3nNQcH15lQdqWuL8i0NP
quf8OKsUUEGTfImySK2ql7pzk2ouy1Sup7wZs8bz7almHoP0KOgFVST9jb1VZRIl
2CQY1FTNqQVTWKcERuxOn6HVMVAnGBLuGWah7wr04iziCVoiY/w=
=4ETa
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
