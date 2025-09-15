Return-Path: <linux-pwm+bounces-7317-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4E5B5753F
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Sep 2025 11:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4243B3E6A
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Sep 2025 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5392F39B5;
	Mon, 15 Sep 2025 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETCw2ARP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DA01E47B3;
	Mon, 15 Sep 2025 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929852; cv=none; b=grjFyvgbUFYutqQsFKYgZgItxf6yKrhtwXxWB5TxSU+GfVlosx/HtM2puiOlMsTAQYM9HfFw+/rz56tA14eCbRHwEDfkXJ1X2htTa9O0lMuPOQACsqSbq7dHx8BfwrBtLCm4rtQUgakNKQU3Ge1+paP/hm8iNkEpzBXNElXpG+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929852; c=relaxed/simple;
	bh=R+4gah+r4MFQSrR6c810iz7S0zKTbnc0EO7PgcX/Xn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caRqqIfJ+yNEpNRxTL0gbzOurk1f5JhEaBGI01oB/qVG8TF5i7dUpDnyibIaJ2AtsIGwoCxtUjmbds7LoOtR3RA45e0LMYacPPf4fDSYkX9EGa9AJXenT2HcjYCmgjo+dCKf1TGitck0w8KADdSmM3qM++KbgT7ZrgrzEmVpaPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETCw2ARP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1E1C4CEF1;
	Mon, 15 Sep 2025 09:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757929852;
	bh=R+4gah+r4MFQSrR6c810iz7S0zKTbnc0EO7PgcX/Xn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETCw2ARPYr7Lm/34wSIp3bX+Ms/FWpO2KA8ybk9Pgg/zcCg1lOwvdso2rTct5DiqX
	 K9Ey2q3ZNPkNuli3K3TDxG9uh8kahwseQrHfnSPc7fJ/yUI26PmhojUSyIZEI0dr0f
	 cgHmciKOkNppxoKv8MeffyfJXw1qgSmIkZpI5QBWJ0AeyidHVcuWFJiaLAZUMlMzlT
	 JEdqEZAnk4f+gQh8keqpX0OlF6819mcbWDJuQALtkMuq09P9WNgJLx3N6BY7mMm2qS
	 fNYb1s8MR9edHy7wbQIfsqZJ13ZkZkhFVRC2OV9GKOBI8Z3JQxRRoaCkXBIj7Yx0aH
	 9YzOcDpoo/w4A==
Date: Mon, 15 Sep 2025 11:50:49 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: use str_plural() to simplify the code
Message-ID: <fol4hemfnbh7km5dfdkbrfxx3txc4wtv7jvdn4h2xlzxlcoyht@ax7ml3rq53zs>
References: <20250818083629.503250-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7m42mtvfe7tfiq4e"
Content-Disposition: inline
In-Reply-To: <20250818083629.503250-1-zhao.xichao@vivo.com>


--7m42mtvfe7tfiq4e
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: use str_plural() to simplify the code
MIME-Version: 1.0

On Mon, Aug 18, 2025 at 04:36:29PM +0800, Xichao Zhao wrote:
> Use the string choice helper function str_plural() to simplify the code.
>=20
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 0d66376a83ec..732d22dee035 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -2620,7 +2620,7 @@ static int pwm_seq_show(struct seq_file *s, void *v)
>  		   (char *)s->private, chip->id,
>  		   pwmchip_parent(chip)->bus ? pwmchip_parent(chip)->bus->name : "no-b=
us",
>  		   dev_name(pwmchip_parent(chip)), chip->npwm,
> -		   (chip->npwm !=3D 1) ? "s" : "");
> +		   str_plural(chip->npwm));
> =20
>  	pwm_dbg_show(chip, s);

I'm not sure this is an improvement. While the code is shorter and might
compile to more efficient code, it's also less readable.

I tend to do just

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ea2ccf42e814..5b75f4a08496 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2696,11 +2696,10 @@ static int pwm_seq_show(struct seq_file *s, void *v)
 {
 	struct pwm_chip *chip =3D v;
=20
-	seq_printf(s, "%s%d: %s/%s, %d PWM device%s\n",
+	seq_printf(s, "%s%d: %s/%s, npwm: %d\n",
 		   (char *)s->private, chip->id,
 		   pwmchip_parent(chip)->bus ? pwmchip_parent(chip)->bus->name : "no-bus=
",
-		   dev_name(pwmchip_parent(chip)), chip->npwm,
-		   (chip->npwm !=3D 1) ? "s" : "");
+		   dev_name(pwmchip_parent(chip)), chip->npwm);
=20
 	pwm_dbg_show(chip, s);
=20
instead, or drop the output of npwm completely given its value
implicitly clear by the number of lines following this output.

Best regards
Uwe

--7m42mtvfe7tfiq4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjH4XcACgkQj4D7WH0S
/k5jKQf9Gk4jgrfC9v4mMaNZpNCkQGNdovUupapNlWDdOLkYz6KMteHiRvAma2BV
5xNQJrU3sI+0hAGBEVfgmftp0VFyIk2qtxL7DP+fxtk5WnDyFmReS8MzM4ZjAtL0
cTSOf6Ex4EPLkfiuF4QqukUKS14ONtT1SuGuBayTJ4XvqM+ZVjc4tIzU4q6uDJPz
8pZpF15hveiB0VSkAXu6BY9ymsb2mD/R/u0z8oYUyLuA38mOyMNmI+BgG3XEcs/q
YGhQO2SyYcht2i7y3TdFmgDOd+LeRI0jpoysKpjUq2k/dSbcKI2KFMCG4B6XNfmW
PKpxnRHRknGkkfCM3FqyT2u3YirozQ==
=w6pb
-----END PGP SIGNATURE-----

--7m42mtvfe7tfiq4e--

