Return-Path: <linux-pwm+bounces-7692-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8EFC83D93
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 09:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F6A84E2022
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 08:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF52D2D879E;
	Tue, 25 Nov 2025 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cae1ewiV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F52D8391;
	Tue, 25 Nov 2025 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057170; cv=none; b=dMl7x3i7c/3/NfJx2RlBm4EQ6GGvqXnAxTxDlNgYpfKoIdIif08ceRo585+7rWJXn5M46y0CoKbiNmVF5zU3uDQC/BhFUwiQkR37Ytd4rTSFS8S7FbOzeplWoq5bv97yuhinEX/0jHGvLFlBD8p8DgM2SnKhIa6sz4lKpE6Y78o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057170; c=relaxed/simple;
	bh=zH5FB/8OAjc944aFFO6O0LpNuQBkrSNDXALpMndA99U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhFi1A11KlmTB87T3e00ybmhevygi8l0Z0BVpf9WF2YVA3iBxdXKdBaD39XjdIsZbh5lWk5n3+TXABdzXEsAwSO3HUTDh7iAOQMP/aewV0Ikt7iKM7nvmlqiaejZcE57AlC4wy1kOxBzCr/kPA5zgGkW5DYiGkh8nOLKqjPfC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cae1ewiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87511C116D0;
	Tue, 25 Nov 2025 07:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764057170;
	bh=zH5FB/8OAjc944aFFO6O0LpNuQBkrSNDXALpMndA99U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cae1ewiV+1dye9pnY4px5u+nVGt/0eB405dckyzOBdhObGdJAgjWhVZM9HC/GKSlb
	 EsrXra9CfaEiuCCxXX79GgCKbiHh3I0PHU081xwuN1G7bYDPt8gGarcs6W7zInWEwN
	 a6qfXc5luwfRQMcZXrr9iKvlxIruBvOqJJlzt3d5hHdJXP7rEv17GyorT0v8IozPyM
	 tJV5HZ2+D37I+w62gH0Ac1R5q7fhQ+W/Uzzxfhkrwk6Jj7FemtP2SZaBT6qTZgDIf6
	 qUn4mvkhZDiPAaOOba4OxdIbuQ1HX2MkbMwy4y/FhrxUtoYBsLUOyrH32ab38DEFC6
	 mjP2uT5sz9YCA==
Date: Tue, 25 Nov 2025 08:52:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 4/6] pwm: tiehrpwm: implement .get_state callback
Message-ID: <b2uf4jtvavhnktunabpufq7vyqiqrrwkcf7u6t7ffj3ll2ktmh@4w4myyquf26q>
References: <4zdh44geiodumnqsfmwbxcfhishs7xeg5qsb6o3zb3nog7yfu6@wvqwqwltlip5>
 <20251125034830.1512-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="slm3jei4ynoepn6t"
Content-Disposition: inline
In-Reply-To: <20251125034830.1512-1-rafael.v.volkmer@gmail.com>


--slm3jei4ynoepn6t
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 4/6] pwm: tiehrpwm: implement .get_state callback
MIME-Version: 1.0

Hello Rafael,

On Tue, Nov 25, 2025 at 12:48:30AM -0300, Rafael V. Volkmer wrote:
> From my reading of the PWM core, it seems acceptable for a driver to
> provide both the legacy apply/get_state callbacks and the waveform
> callbacks, with the logic factored so that they share
> the same hardware decoding.

No, that makes no sense. The waveform callbacks can do (nearly)
everything that the legacy calls can, so the idea to keep both types
strikes me.

> If you=E2=80=99d strongly prefer that tiehrpwm is
> converted directly to waveform without an intermediate get_state()
> series, I can rework the patches in that direction instead.

I don't prefer it strongly, I just wonder how sensible this is regarding
your (and a bit my) work force.

Best regards
Uwe

--slm3jei4ynoepn6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmklYEIACgkQj4D7WH0S
/k4Yewf/eyjgO5GeN+sB0dpZ7NB4r+kSFgUS9CgJ1xeGKnwdEGQ3a8WltO5FviXC
w4xGVL+k8mj4nEM8Cxedqz0kzdAYieZIce8RkMzDlJcSJ2meAZr7mievhxVKFBWr
7esQo7GMYgdJdyeDQ1Rfk02cgO113dAUEOOsJAColkITDGoFKn0Ar//3MJlVq8+R
hB60SOKhiZh/DvndKV6cB+AdZM6f3Ww8wi/7mmg0BeaIMhbClqF+7Esl6Ny5pv6O
ZsadDS48mpuLbD8ioxF4G6Ok1g8z7CYB+uKIeiuZfTJtEDoea76WE4UplNeRJuj8
mucVuLmPZsYRSkheOzqdkg4ROIJeUw==
=krUQ
-----END PGP SIGNATURE-----

--slm3jei4ynoepn6t--

