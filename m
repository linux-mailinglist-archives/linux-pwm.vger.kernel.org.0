Return-Path: <linux-pwm+bounces-6418-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 151A1ADD0C6
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 17:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC99A18832BB
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387AC2C08C2;
	Tue, 17 Jun 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ina9tG1C"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0750323B633;
	Tue, 17 Jun 2025 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172088; cv=none; b=ZfLS25yevKg4Gugg1HAXPr470B59ZQjy1gp1IBmIGhm6cyt81+wiQqEH4sbe+A6eZod0QO3RzSLzc6ezUqUeCgDLmFl6d3iqqwKf++FZMgPxMec1jViDPKVJJgxKuSHvpA2KU5otmyasaSkF6XpF64C0cgKvZPos8jyIfcyR4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172088; c=relaxed/simple;
	bh=7PikMIT5Vzc6Yx/xd13Womoa3CIhIrrk9N+wohiFj0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU3QrUqiNldz9IQ4NvtJEJoh8PqIBeM4HaelUxjr6OSGnjUCfp925Gr7VfRxuycx6Ao002M1JMoslKPVlB3D4cJFMv/jl8Yh/SisxRmS6iU4kyyHI/io6newX1TZinQaKVEWPCUrnLzw3mi2Quz7/NhYZUEuNIZZhD4PJIXud6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ina9tG1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D79C4CEE3;
	Tue, 17 Jun 2025 14:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750172087;
	bh=7PikMIT5Vzc6Yx/xd13Womoa3CIhIrrk9N+wohiFj0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ina9tG1CZM9PW/zABqYXltArDsvLX7JhINBsNzZbc5bLEBOidErnFnHLkPQVqcYZf
	 Rg5N2jmIDF+ym2AJ7lxGGHnQKh5n6uTS7BgMBIoIz+YEBjFMCeRzpeA6h2hmEJVyzg
	 tz4Tomq+WtfXe3oUH99P8R0YCWEEM4KGrgbnpii9bDsnur2YaU22sQ6LjxhbX6bHjn
	 QqV5zzBcVJeKVyLAvwWZZweD3YWTGnKd8O/UdzfMktiO47RYu2E2nc6oVGVmqj7Z9O
	 6gyfXtr1mcY8tP0f0nwOpDLhkZ/i3zgrTaO424C9Xn0Hn17dTHSdGPUMEA8uetSIm2
	 nvK+gBMX7tk3g==
Date: Tue, 17 Jun 2025 16:54:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: pwm: convert lpc1850-sct-pwm.txt to
 yaml format
Message-ID: <pv7ipqnw2qdt7eypui2n3up7ofvyzq222ajo2a3cly2fp2r6cr@dyqxjzitoux2>
References: <20250616190435.1998078-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="szqklvgyxtiln7xh"
Content-Disposition: inline
In-Reply-To: <20250616190435.1998078-1-Frank.Li@nxp.com>


--szqklvgyxtiln7xh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/1] dt-bindings: pwm: convert lpc1850-sct-pwm.txt to
 yaml format
MIME-Version: 1.0

Hello Frank,

On Mon, Jun 16, 2025 at 03:04:34PM -0400, Frank Li wrote:
> Convert lpc1850-sct-pwm.txt to yaml format.
>=20
> Additional changes:
> - add ref pwm.yaml.
> - add resets property to match existed dts.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Thanks, I applied your patch to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

as material for the next v6.17-rc1.

Best regards
Uwe

--szqklvgyxtiln7xh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhRgbIACgkQj4D7WH0S
/k4T8gf/UNCtpUWOveBKgzsL5PpGBbfN0Z40HQGi8UhP6l+uZbH5UkEY7bOfyNZ5
t0jMMQpleMR9EyZ2gXcsTsLjldgdCSroqqhSS9/JjhQrRZPsAF8nIZWZ8TBi6nl8
GKX2RGDBcKevdwAgZYfSSdrnzHspMNJRMvjzkD3OYsb0Fw2B66m2RD9WxiriAKBv
YHl05BH6V+LAiJrzA92bKV64kS6CsnnXkG+rvDSIaEeyWmo5WExG2AzbQ4pubyGd
AUw5TRsjL0rSIIbznvw7/R/WeSRkNx1J6vKv4YOYILnG4tZ04eHLE+4v3YC42eYr
9OiYB75TDbemRJGTL6saJBxIOroUdw==
=RzBl
-----END PGP SIGNATURE-----

--szqklvgyxtiln7xh--

