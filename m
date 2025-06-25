Return-Path: <linux-pwm+bounces-6533-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E970DAE869E
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 16:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0481B1C245F0
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BFA269808;
	Wed, 25 Jun 2025 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFIqdS12"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B09267714;
	Wed, 25 Jun 2025 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862098; cv=none; b=JCJpJ3gyJBURODUwHrdI7+zCQh5IRbsAFY4YavMmiT4c12KnLpuHptI6yYP7WfKM/oWqXAxTwyNgoFK9FaHebM9I3eoNv6sRh7a4Xsk8R/DsW+HVl+mx+v1U+aWXXqlXpu3RmQhEgvcLRHRwdP3OuO1PArE2OwwKZHsq3p2ZICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862098; c=relaxed/simple;
	bh=z3DlrwGS2dulcUFskpXwOZRGYXJoYMk2ic/qJ7NGQ98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qj52WNskqeU6lf3we6tzjnfavHt0y5di4w38LQacr2YxWXTatlWVnJavJ+RLw59+0XP4RB7uu4jv4VZ70m0FG1tS5FIuASuE2uihQHL9MOI7d0qtCrDIoP5HT4IH2HUP0WnA0/E7tnzGN7vf7dupWVqW87xc8EzO8qZTqMEBZsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFIqdS12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918EBC4CEEA;
	Wed, 25 Jun 2025 14:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750862098;
	bh=z3DlrwGS2dulcUFskpXwOZRGYXJoYMk2ic/qJ7NGQ98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFIqdS12pTHVGBcdnEP8Mhwbq8Vn1QSVptDV8QSj9OzKInmqJJlubSE0Rcic8OqV4
	 FeQEaSu4ab1LNWXUe9qIiFlo04j9zzeCeUbRb/cK32ZPel6jnJ+gRL6lwXoBcVqJsI
	 bxxyLcZ91QyiWLVmMUrT4a+7Y0fZW1oP7bgStgZ6pIJqYujkCU+n3LiLV9bIKPKl7G
	 JhOO1Z//ElDB/3t9iR8B3cgnf6F69y2hIl9fVMflxTpeEx3bNLm4dGpDZlLxUYsaDg
	 AhQT94SqA19zhZZTVryynJbE+77vBQyjheGKvGaIFhivXut/xhCvtIQYk7MxxcznAV
	 0qZ4uj9UwOGOQ==
Date: Wed, 25 Jun 2025 16:34:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, john@phrozen.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 0/3] pwm-mediatek: Add support for MT6991/MT8196 SoCs
Message-ID: <z3jombms3o6466wsxx66xkuppyjdzeiwphke343llinhsl3vmj@t35gj3dc2fxm>
References: <20250623120118.109170-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p5zmvddaeyo4hoae"
Content-Disposition: inline
In-Reply-To: <20250623120118.109170-1-angelogioacchino.delregno@collabora.com>


--p5zmvddaeyo4hoae
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v1 0/3] pwm-mediatek: Add support for MT6991/MT8196 SoCs
MIME-Version: 1.0

Hello,

On Mon, Jun 23, 2025 at 02:01:15PM +0200, AngeloGioacchino Del Regno wrote:
> This series adds support for the PWM IP, version 3.002, found in the
> MT6991 Dimensity 9400 Smartphone SoC and in the MT8196 Chromebook SoC.

applied all three patches to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next

as material for the next merge window.

Best regards
Uwe

--p5zmvddaeyo4hoae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhcCQ0ACgkQj4D7WH0S
/k797ggAh4/X9IUMj216zP9Qt66t/ivkC1Z+SDL2dpjzRMEwFuAhDo1EsHRRymfS
L98tEHQ00vOfPPg2qxs8I2zFRKgNieSef2xgEGSt/eGH1KxPxg05pgTUjEV5l88V
spN1/cKXf7ndw+iHibA4tYXOeciigNN8WrcAont+mk9mvEw0o1Rg7ma4OW26qrCm
g0CVqVsNvAxoqQ7AJrsXk67N/y5LLdcpwOvfKK/2aEehL2A5Jaz2Txa/RBX2Fv58
akRrqrLZ3mKDXL3GD/ZOY+Rpr3J4/qwMCn14ZbL4t5/Lu1f2shk+aeOS9KJK/QJc
rkTCrfOsoNcuAvkNliKqtl/H+g7UJg==
=Agi6
-----END PGP SIGNATURE-----

--p5zmvddaeyo4hoae--

