Return-Path: <linux-pwm+bounces-6636-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163D4AEFB05
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 15:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB3B18834C7
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 13:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596F7274B37;
	Tue,  1 Jul 2025 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAQV2l30"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246BF2749ED;
	Tue,  1 Jul 2025 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377434; cv=none; b=b1jZrD2wSEoL/6knieBCelHYm1w/gqj+B5gMKunBXOSc/2ymkD4cm3/wdZ1OMLPHAZSoS/zEcbOcZSv4sxn0mEUzjQxnz7m+PXtb1q6uv01vXqQoMcgOnn67lR22WlE/cXrNUK2OqP6+i4JGQM1XkN53sdQeCLQqRSCOwsALveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377434; c=relaxed/simple;
	bh=QEri1aMgp2r+dzNRsIXv4XJpvaey9cHU7DvjULjHETo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGHMj4FSPxyXoInDc0pQ96dAc3rmYUQ83Pyw+/DJg7Abx+gSQenFfiFgA8EtS3MlVbfZNu/OlqVkZ1PhGNrl5L8/LlngtolHRfFrsprkGp6BiEMk++COnRqr6M6C2Z0wRJS3aXAOkynNnBYMdFBFB55300vws7Rf1bjNW5UPGWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAQV2l30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E76C4CEEB;
	Tue,  1 Jul 2025 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751377433;
	bh=QEri1aMgp2r+dzNRsIXv4XJpvaey9cHU7DvjULjHETo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAQV2l30UOUzrIvUBK5f8zLbZCkIeWmG7DcU8cJ7i042m7NzvkjAVZqlkJaKkx2K/
	 Uv1Ulazbsok/cL2ebjA6vUj8/FlVSUxk/FfIQc18eEGG2QrWf0Xzc/CRhzaGqxLf7r
	 o4MuKf3RZ8QytSoRMS+33z/H9PhA4EtIo6YfTRTjbg1WSAOmlLxEBPNmYoNlGAEl0k
	 89qD29t4Xz4JEqSXQ8gD3rbQ9DqVV7NpuKrCZy3PbQYOWPPO0D48nhKInreyG7/TJS
	 00SkQWX0hOI/6BWzvlo2ZVs5hBE7aJYi+njt6NwossC1PajeJglSQDOmqLVcP+EXqT
	 RBHE/Qtq8k7FA==
Date: Tue, 1 Jul 2025 15:43:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v6 16/20] Input: adp5585: Add Analog Devices ADP5585/89
 support
Message-ID: <sjbb62jqcjvac7fzyqtk5rvxijvakwc6ldpe3p2stgtzrgj3ur@5wbl4vndhjpi>
References: <20250630-dev-adp5589-fw-v6-0-a0f392a0ba91@analog.com>
 <20250630-dev-adp5589-fw-v6-16-a0f392a0ba91@analog.com>
 <txppsdw4w7ocnysvrm54ta4ulplwawd5pk2l5wt3bhrag6qbev@gr4ah7lgjigi>
 <83685a983e2134fd644a8720383408d4b452996a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eiky45vah3utsuop"
Content-Disposition: inline
In-Reply-To: <83685a983e2134fd644a8720383408d4b452996a.camel@gmail.com>


--eiky45vah3utsuop
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 16/20] Input: adp5585: Add Analog Devices ADP5585/89
 support
MIME-Version: 1.0

Hey Nuno,

On Tue, Jul 01, 2025 at 10:19:03AM +0100, Nuno S=E1 wrote:
> I did asked Lee before sending v6 but He likely missed it. I would add it=
 here
> but it is painful to do it with b4 so I ended up adding the log directly =
in the
> commit message. b4 was removing git notes and I also don't like git notes=
 adding
> that "Notes:" line in the beginning. Do you have any suggestion on how you
> handle this with b4 other than b4 send -o $DIR && git-send-mail?

I'm not using b4 for sending, but ISTR that adding the --- to the commit
log after the S-o-b area does the right thing. You get the tripple dash
twice then, but git-apply does the right thing with it.

Best regards
Uwe

--eiky45vah3utsuop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhj5hMACgkQj4D7WH0S
/k4BNwf/a2LJkTBtTdXq1/F9eLwd8rV8z7mOhyUKkPRY37abhB7qh9Q0H8AmapVF
awxH/wsGH2fQS9/V78o6Ye3F6AHc+lLe4F1F/eV4PmHzzDm/l0gy81UNVkRfmfAP
eff8CKXok4yZwRBYzhyg8KRjEszhU3qGSyZG1K+qOTMBPC1n2wZAR3PFImqhW+VN
TpzHsPWc61pPZfqR5i3IiYduUXUEFh42XlJJtlEMBIJ6QBgWMiZ4kG3Ta4hARTYV
XpHCtBsToddbuzn7gPkfbm9u+QgznO7h/aqs24+1rla0qnTdvyq51DD2dV/McCej
SDx8+YxV+WCJ6Hxjvc1akoRkZLKI6Q==
=BzFn
-----END PGP SIGNATURE-----

--eiky45vah3utsuop--

