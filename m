Return-Path: <linux-pwm+bounces-4469-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C29FB376
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 18:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D1D18834C7
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 17:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A271B4130;
	Mon, 23 Dec 2024 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtp/dUbd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A57482ED;
	Mon, 23 Dec 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734973784; cv=none; b=E1ZpE60W2/3Mzr+rzTHQ2JMV7GTaQ82d0K8CpSoHrCSiiSHCqeWoeQ68LYiTCb5EBTgG56IJF+WsIDzxs3QljkmTUwe8QcUJNjEmcvGqpoaUJShwc0/J86a/Bktw35+6T4WcKFNtcimnrLS7dsuyLhDpdggS999rbzcQy8/wdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734973784; c=relaxed/simple;
	bh=kW0Bckl9Bzoc1JxJPSbGp3HD7uUooNQTvdc5trcWhbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPpmLA/g0jKDvnu8sshmlP597LRWSBqmZJogdd1+EqgZIGDzQB6sLMgHHZMEqPiOL9/4aSAZyy6Zoa09XE/5lg1S0+sekPzxDcr5nWdOSD8+GpcD2unWtpoFkYT1k1oBc9jZawc0zpE3TfruRvGTlVgGolCv4WukB4NzPZVrbmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtp/dUbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6361C4CED3;
	Mon, 23 Dec 2024 17:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734973784;
	bh=kW0Bckl9Bzoc1JxJPSbGp3HD7uUooNQTvdc5trcWhbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vtp/dUbd4dltVX5Pre7Hk9dXIIKdDhmdEu5KiLVJWhIvwrSS1nliRJ4oXTPp95qbJ
	 Es6806fJtqK8NpK9sEJnH5bZq+s8D4nYuDxFO56Ya9+WaZGVa1Ti6VqxuK8HSAmseY
	 +kew77d47NiLXFQTgaCs/hBUwp6Le7P6jFW36ABcPU0b05bNrinjnu7785Blo3aHWN
	 pDT7C+z4wAshn3zpc3JVmeBuYiE6rhNhIgrIZyoFc1mz8QI+b8GNi86a4CqzI59HNh
	 3ZcQ7YOUZ9qXpWx+/Po9kcmp79Q10YNDVEIO4v3D9asSJZblzHODtoT0vHxYSi3//1
	 5qFcArn2eYrsA==
Date: Mon, 23 Dec 2024 18:09:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 0/7] Add support for MAX7360
Message-ID: <guxwaw4gapkak3ooy5njkcehk7r7zcfy5ibbkzvnqzwth443hj@wcqvllfixfg5>
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
 <f5memlwoahjjvvian4hutan724msi3ojbkhdaoqvtqstnhvfqt@xkdyrpfvy2gp>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zrv7rw2shycav5pt"
Content-Disposition: inline
In-Reply-To: <f5memlwoahjjvvian4hutan724msi3ojbkhdaoqvtqstnhvfqt@xkdyrpfvy2gp>


--zrv7rw2shycav5pt
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/7] Add support for MAX7360
MIME-Version: 1.0

Hello Mathieu,

On Mon, Dec 23, 2024 at 06:05:39PM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Dec 23, 2024 at 05:42:32PM +0100, Mathieu Dubois-Briand wrote:
> > - Removing device tree subnodes for keypad, rotary encoder and pwm
> >   functionalities.
>=20
> How did you test the pwm? Just using sysfs? Without a node there is
> hardly any other usage left, because you cannot pass the pwm to e.g. a
> pwm-fan node. So it might be sensible to drop the nodes for keypad and
> rotary encoder, but I think you better keep the pwm one.

I think I was to quick here. It might just work ...

Best regards
Uwe

--zrv7rw2shycav5pt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdpmVIACgkQj4D7WH0S
/k63egf/XJZyfp0WzA3my7u3QmiJj8JqxqmhZ+023y4Wic7iA1iWq+oo0Pc0QTXb
BYP9FtdlqaBhdqHSnhR/aGIP8qneP57zj/pSFtTM/Zu5cbOhFZdzqYq0fsLkeiH/
ghW3g08L4Dm0zxeLFHW5XcW3KxjY2pr3Hd5WP3DX7V6ifmdqnrHs8cYWNdgeXtMG
JeEjeFJJz/kxwDwLouwUKeO2COFDKUP1pK5F6VGXDv0m1WchXPvWvY8qisE36BFP
Kih9lrLgJS9dhTW0ImidXZvWhCO2ERzSCrh7jKBMVEBcRfNvBDgmdm0JbeDDkWEL
kZhFm4Plx+WQjHUEz6CNy8j+QR2vDg==
=DHTw
-----END PGP SIGNATURE-----

--zrv7rw2shycav5pt--

