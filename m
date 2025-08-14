Return-Path: <linux-pwm+bounces-7039-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622ECB263DC
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 13:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC703A7EEC
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 11:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A732EAB9F;
	Thu, 14 Aug 2025 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwIlOaYM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01808145B3F;
	Thu, 14 Aug 2025 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755169732; cv=none; b=cmBF8WcUHGUlTKmW+S7fmplzNcKnAG3ml0lNwQIn9Olli43tOCpCboX+C7b2hRvOv1TRlvwHZyKGi9hWf4EYb/D60iEzBuH0kFaaTgMxKhKG+gxvsjO1cNz4E4PkdIXVEeWFyJwnsJSP/R9Aey2CA3fSxKcfNVLC8oxHbAlM9KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755169732; c=relaxed/simple;
	bh=NcM/DeAVlXKmPkl7bBlwD0/QB2aiGZ25NX4zY8t3JZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRSvR+921/hb6pk3i8dKDolwZSdgVPXTcWCB65g5q8sOpskRyApaj+8re41Ae1sKSlU5SfXEcSWJPrFoofDjS5gKKUQTs3XupDbmk8rz3QBj3Xs0QPr8NMjOyXkciuaRXOE42XBvXlnTr8TxYYaP5lal5Do07WwTyHQeQkDgtAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwIlOaYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17270C4CEED;
	Thu, 14 Aug 2025 11:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755169731;
	bh=NcM/DeAVlXKmPkl7bBlwD0/QB2aiGZ25NX4zY8t3JZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NwIlOaYMCnbeBsS0fBLSHuuDnB/pqFV4dluw0+qSzHzUhq+lYiZn73OHbU8mnOnFn
	 hB/r5LcpDdMM3f58g9MJYgITW2nFGieiM9esO9Pd41l5NalsUBpoMbsD4WZqugaLiY
	 mMYfxqLQhL4SM3xQs64YIYw3xr/5rjn4Z4x7asoxXuf1I9nqK4i7ZC2NwFMdBb8dLf
	 TI/xIJtSN8Xc3Fpb3C4mmeddLZq+Q/R7S1JdP1R8pg8sP+9jveJzHb5uCAOVce0djK
	 LbYNTxSpqTxSrcjay48DoGWF5HMxlLm8OPtupmsgRl3JjoSbgRI/Tq2pqXe6d33/dS
	 P3yDSmUkVhUpg==
Date: Thu, 14 Aug 2025 13:08:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] pwm: cros-ec: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <2pgdxifg2zmyhvemm7a2qntprsz5nhh3ustrrlg2vvcqffwj6c@22enjpgycjbt>
References: <aJtRPZpc-Lv-C6zD@kspp>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vfjd7sxzjdmqmwth"
Content-Disposition: inline
In-Reply-To: <aJtRPZpc-Lv-C6zD@kspp>


--vfjd7sxzjdmqmwth
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH][next] pwm: cros-ec: Avoid -Wflex-array-member-not-at-end
 warnings
MIME-Version: 1.0

Hello,

On Tue, Aug 12, 2025 at 11:35:41PM +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
>=20
> Use the new TRAILING_OVERLAP() helper to fix the following warnings:
>=20
> drivers/pwm/pwm-cros-ec.c:53:40: warning: structure containing a flexible=
 array member is not at the end of another structure [-Wflex-array-member-n=
ot-at-end]
> drivers/pwm/pwm-cros-ec.c:87:40: warning: structure containing a flexible=
 array member is not at the end of another structure [-Wflex-array-member-n=
ot-at-end]
>=20
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it. This overlays
> the trailing members onto the FAM while preserving the original
> memory layout.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/pwm/pwm-cros-ec.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> index 189301dc395e..67cfa17f58e0 100644
> --- a/drivers/pwm/pwm-cros-ec.c
> +++ b/drivers/pwm/pwm-cros-ec.c
> @@ -49,10 +49,9 @@ static int cros_ec_pwm_set_duty(struct cros_ec_pwm_dev=
ice *ec_pwm, u8 index,
>  				u16 duty)
>  {
>  	struct cros_ec_device *ec =3D ec_pwm->ec;
> -	struct {
> -		struct cros_ec_command msg;
> +	TRAILING_OVERLAP(struct cros_ec_command, msg, data,

It's a bit ugly to have to pass the name of the flexible array member.

I think the following would work:

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index dab49e2ec8c0..8ca9df87a523 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -108,7 +108,7 @@ enum {
 	union {									\
 		TYPE NAME;							\
 		struct {							\
-			unsigned char __offset_to_##FAM[offsetof(TYPE, FAM)];	\
+			unsigned char __offset_to_##FAM[sizeof(TYPE)];		\
 			MEMBERS							\
 		};								\
 	}

which only leaves one usage of FAM in the name of the padding struct
member. I'm sure someone is able to come up with something nice here to
get rid of FAM completely or point out what I'm missing.

Best regards
Uwe

--vfjd7sxzjdmqmwth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmidw70ACgkQj4D7WH0S
/k5ieAf/TUUo4o0zI26SLZTp8nM6qwiZ9GhAA1lOoSO1+aUR/7VkqYJ7yO/fsdMH
eAjsyTZixz4uh7p0c+nGpPS4wjpGry7l579dXbYkt6gVU3np/kXR93OUJDdYNbkU
pkAhBvgWCRLbhuytiwDm1OJjlbTqu1piDh1/r3wgdud+cnva7caeQCVqfeHtRPQz
X+ww6vwxHzAR2pTzGdLrBIZYt5yZhqUdOXidMETxqGdO3Z17zeUt15fzVyN/6h80
UZOl1VXw9+T2v1v8+Wp48YMBIblWoGKf/qNmDFzpQyzS1tIsXpy+GEaK6tjrODuG
xmdLAxw+LR1V8wthsULHBwBasbgfHg==
=hwjq
-----END PGP SIGNATURE-----

--vfjd7sxzjdmqmwth--

