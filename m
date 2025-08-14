Return-Path: <linux-pwm+bounces-7038-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB41B2639C
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 12:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE261CC549B
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 10:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAACB2FC889;
	Thu, 14 Aug 2025 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K09pQZu+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A02EA472;
	Thu, 14 Aug 2025 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168843; cv=none; b=urOegwunxysrKG6ftjWfXA1WlmgRgel+3MANMbJEb9CEQ+/1Sh8Qv3tRV1z8Poor/Ip+D/xVFEq+qYbr6FRfNUSXMCjgRsbZcq4eW+BCS++O/aS42Vl7w2yAyc4KfU52WEOcQNvQaltn7znNsLh2Ten52TNbQXsJoINjt1qRLmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168843; c=relaxed/simple;
	bh=ziANNSCP7w5PAQy8kOB8wkVCq4nc196swfrWsB7bTGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fop+n3Bgu1fWKojD4r80V/nFcYk3EO9Db+XaJEa93Tft2XtYEOh8WaPLLlV3gyCsWITO0bAsp1kKIxD0oSHbBWPobcrQmZoVbga+24+sO6uYiOdoMIBIDg+3b/Rgg7BAX1gNQ4R2d+hvKt23MoiExok3fa2r0jxOBg8Dz+DhHyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K09pQZu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E220C4CEED;
	Thu, 14 Aug 2025 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755168843;
	bh=ziANNSCP7w5PAQy8kOB8wkVCq4nc196swfrWsB7bTGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K09pQZu+HKLg3pe91+ILUUnSSCf9V5lv5hpw/25AC4fQbw/nUmJ7RgITAg5gIcgYg
	 q16cR5Lf/k5uJ9a5q4MtkNLae+U6HvI0/N+I8hvwbweaXlDDY0WefaE5ivyzRLu3c5
	 A8kkRZh+243uOoQhBbZmO9Tl9oyvSqw1u+H3S5ejCO+pD+AYG0onw1asQluRG0boaU
	 mjIkBXM/PB3xtLOXdjVGtLyZail+FuJZ3hTp+6yLjgQiY3oW51014lMdCpVghteK8t
	 VmaEC+K6Crc9JaMUXy0aloTaXjitdZR8HnOWQNJbkzxE9Mghw6RpdXlN6oat/tJXlo
	 TJj3Zl9xptE0g==
Date: Thu, 14 Aug 2025 12:54:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Frank.Li@nxp.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ghennadi.Procopciuc@nxp.com, s32@nxp.com
Subject: Re: [PATCH v3 0/2] Add the s32g2 and s32g3 FTM PWM support
Message-ID: <jmhzng2ezrrqhy52y7eru2ik6uburn4rnilfwreqmvkeirqbnm@b5ksjlufwuwf>
References: <20250812200036.3432917-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7nq7dujoidxx352a"
Content-Disposition: inline
In-Reply-To: <20250812200036.3432917-1-daniel.lezcano@linaro.org>


--7nq7dujoidxx352a
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/2] Add the s32g2 and s32g3 FTM PWM support
MIME-Version: 1.0

Hello Daniel,

On Tue, Aug 12, 2025 at 10:00:34PM +0200, Daniel Lezcano wrote:
> The NXP Automotive platform s32g2 and s32g3 have on their board a
> FlexTimer (FTM) dedicated for the PWM. The same IP is found on the
> Freescale Vybrid Family and the i.MX8 SoCs. However, there is a small
> difference with some registers not available on the s32g2/3 and 6
> channels instead of 8.
>=20
> These two patches provide the DT bindings for the s32g2/3 compatible
> strings and the code to deal with the FTM difference.
>=20
> Changelog:
>         v3:
> 	 - Fixed dt-bindings subject prefix
>         v2:
> 	 - Merged the two booleans for the regmap holes check
> 	 - Clarified why this is needed in the changelog
> 	v1:
> 	 - Initial post
>=20
> Daniel Lezcano (1):
>   dt-bindings: pwm: fsl,vf610-ftm-pwm: Add compatible for s32g2 and
>     s32g3
>=20
> Ghennadi Procopciuc (1):
>   pwm: Add the S32G support in the Freescale FTM driver

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

with this merge conflict resolution:

diff --cc drivers/pwm/pwm-fsl-ftm.c
index 6683931872fc,e0069dbdb02d..000000000000
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@@ -396,7 -428,9 +416,7 @@@ static int fsl_pwm_probe(struct platfor
  		return PTR_ERR(chip);
  	fpc =3D to_fsl_chip(chip);
 =20
 -	mutex_init(&fpc->lock);
 -
- 	fpc->soc =3D of_device_get_match_data(&pdev->dev);
+ 	fpc->soc =3D soc;
 =20
  	base =3D devm_platform_ioremap_resource(pdev, 0);
  	if (IS_ERR(base))

The pro tip here to make your upstream maintainer lucky is to work on
their tree or next or at least the latest development release and make
use of `git format-patch --base`.

Best regards
Uwe

--7nq7dujoidxx352a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmidwEUACgkQj4D7WH0S
/k6hAQf+JIneL5db7exA59/VygPd9FRzBydkVt90GrolvsX9nDiE+4iWGWE+slLC
OWUMcZ/zG03Evfgo11QGKFvXPjxiOddA6kkjdPMT9VToITh0Yfw9jQ1s4eGqnzJc
oIA942VfrfwY6hcQcmxW/IGnbjk309Vu5XLd0+6srcOIhAm59UZ9UjRq1NTIwP/+
7yDm0nXzMAMJ4T0pPZJQFd6+9fIa0FpkSf3GGkhW7HQ6sAeYkeXQZw9iNcggwsph
skcEdxqb6MqzIlG7Ec4ZKJI4/QNDJzoUgNBbmcH+CL8Lc8mmaVR9oLRCC7B3n8P4
6SV5zT1ZRaH/JMwJ3R6Web+1Y0gLNA==
=XzQx
-----END PGP SIGNATURE-----

--7nq7dujoidxx352a--

