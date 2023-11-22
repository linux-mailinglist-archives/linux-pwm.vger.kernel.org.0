Return-Path: <linux-pwm+bounces-150-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B697F4E2E
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 18:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E281C20B77
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA8C57898;
	Wed, 22 Nov 2023 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRZ1LhjI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0C883
	for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 09:19:31 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32f737deedfso4383062f8f.3
        for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 09:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700673570; x=1701278370; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/f21OxEl7cDdyy0tEczoV80ahY1lbR5S6hlsHjkSse4=;
        b=hRZ1LhjIQhVidpj+ApO0qhXUCq1wONmxUZgwwAd7mDrMVOt83u6doS4NtwPux3V2O2
         mLq/uCuXmtPbNdlgeGFBndtXdvO+mc7MDQATzfhh/pn0XrKz/BbFGOjYwg1m389g53FJ
         hfUf2iU66rK4ebLYPbGHlCW05Ro7qWSaC3HH/QRwynsYIB7SaZQWWZefTuHkBIWyZ3cT
         ZNwEYlSCf5RLcBBbO67kGhkgpS5YAQ8M5spNrxED5WBt+0smImRiaY/uu4hm7ruAQwS1
         jumADgimUlHGJA73DJnG7PZSfrL46+wsMaO+giHyWiakoJf1EfTGw+4B/FP9Wsv6nxY/
         mfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673570; x=1701278370;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/f21OxEl7cDdyy0tEczoV80ahY1lbR5S6hlsHjkSse4=;
        b=KylzbyXJdWcGU3z3ADBsVCyzdlzbIgqvC8PwVt40EdwiOe9kfvhebTeb9o0e7f/x01
         xpEPomK/Hp1zQMsXIv5w8BfJZVHu7nacFGTnfHWMGCWJCwWggj2PmOMdPhSJ4V63NM6o
         wx6U3gYmsM8/LHuVjZ4/oEvIVPdyWkdmBIUUgpbWU3FqXjUJlLD1pflyufQypBCeQhvG
         ub9bSylk8ZIHjY20uDGubkIW0ZHKEa+QnxT4lP2W8dKc6l50a45fuLBYrM3n5aGjYJzy
         ZNJv9Iy33v0HUZjnzHGSOLGLTfP6bTUAknnO+EPdO1FZvQE8MMpdQ0E4lXVTTdVy96ee
         dn+w==
X-Gm-Message-State: AOJu0Yzvc49WyosC+eLbp9j9RpnBeEmOInFqcmp1DvSRe0x9LkWyF4Zj
	Vba67TigqdIzStf5WNKHblgMzfiglMc=
X-Google-Smtp-Source: AGHT+IFaPnkqu+EQ0B7jH6YDoV3MNPOxAaR4RGxd9NpMeuiWEeAbb1GFWwp7CvEuO1A5vIKnEwyN8w==
X-Received: by 2002:a5d:64a4:0:b0:32f:79e5:8119 with SMTP id m4-20020a5d64a4000000b0032f79e58119mr1030690wrp.1.1700673569429;
        Wed, 22 Nov 2023 09:19:29 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id x5-20020adfffc5000000b0032fb17c65desm17642377wrs.19.2023.11.22.09.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:19:29 -0800 (PST)
Date: Wed, 22 Nov 2023 18:19:27 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 104/108] pwm: Ensure that pwm_chips are allocated
 using pwmchip_alloc()
Message-ID: <ZV44H9ZQDuEA217B@orome.fritz.box>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-105-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yzn7diKWROL6MmvN"
Content-Disposition: inline
In-Reply-To: <20231121134901.208535-105-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)


--yzn7diKWROL6MmvN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 02:50:46PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Memory holding a struct device must not be freed before the reference
> count drops to zero. So a struct pwm_chip must not live in memory
> freed by a driver on unbind. All in-tree drivers were fixed accordingly,
> but as out-of-tree drivers, that were not adapted, still compile fine,
> catch these in pwmchip_add().
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c  | 10 ++++++++++
>  include/linux/pwm.h |  1 +
>  2 files changed, 11 insertions(+)

We don't usually care about out of tree drivers. But this also indicates
to me that we're doing something wrong here. If we cared about out of
tree drivers we should be implementing this in a way that doesn't break
things immediately. If we don't care, we might as well make sure that
compilation breaks for any drivers that haven't been adapted.

I don't see what this odd interim state would be good for.

Thierry

--yzn7diKWROL6MmvN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVeOB8ACgkQ3SOs138+
s6GqYg//aWdIVq5QEqS4UqA4ZmpAyvTCBrpDzwzehsGhGrqDs9a7NKyONliNQO7Z
+MBZlFSKtu/4NXTXPhKTTAOmy/32UJx1O30Mvz1Eb8XWpoqnkt1q62lF/3uJvVmY
zRMKbw+8uU2EY+dxMAlDVypDdf0jKP//s2arC/VppoaI1MhCabVqKLy9BdXrhDFg
CGkU0NOe2GjEUO4q//wAOOpjM77XiI6IXdNeVZXTdNE9hZImu5uZgHtqv0g3kM1C
VMOzPQOKkftmKHwRhE9/yUm/03BhqXOAS14BtDJha50OyTOfWZnQWu3hDRYuPHWG
L8LWW63n9O09tn1FyV2VXrDWRhuEUp8anKm2o3Bhg39jZTZPoydB7x8a6qm+hwjg
+vI8yrrUzSmrPEnyw8aEPSqvxIzjXjEt2XK1AX9imOCdL4tx5CwYUNkV7dJaHDmK
FIpg5mlctoripQ5Q3fZTBReQ+ev4NtJRsQx01lR9NJHLCF9le110JTmUOY6rMdWP
NMinf7IWnqwjcn97kXS041sLqJzsP+VArRCi6aW6a3IEAlBQnP3UzFysqpuZZS5W
o9buvPIKfo7ixScvTevLPPWug7XwVmhNMk0uuFj/RNnG8P7KyO15DTzmT1vC9tTO
BIK/rTvtRVq43UtaFh5wihYs1JLX5LO7jLtCltlQhzjzZJBUUHE=
=+rB0
-----END PGP SIGNATURE-----

--yzn7diKWROL6MmvN--

