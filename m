Return-Path: <linux-pwm+bounces-6228-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D503FACB9BD
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 18:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E1C189B365
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 16:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D2D2248B0;
	Mon,  2 Jun 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlQHfKSk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BFE2C3258;
	Mon,  2 Jun 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748882385; cv=none; b=do8wecLCdxFYPef1+9ewsCDsog2e54M9zK7e4tS3Dt+qnJqK+X8lBUZWfO6f5mG9qoTqcy+6NnXHiMr00R32YxxJZa4bvJxZFl1Mj+d1kPdgAWEgYZrTr6QYQ3/CoZ6H8xDXhMov0S8Qk1Hwdcb4KS6SwT8w5NjEvosBSP0k8fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748882385; c=relaxed/simple;
	bh=e7pm2A0dvrPnFtemdr71Iq/QgQlb8NO8MxQy+Ry8Xxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHalI1eaiFbqf12NN+fMTLjXRH3VK8wPoqwxBRVtUpWLZ60t7kFgTpXYg6X25nvq3b9aw3czfOrwk/ZBNuN0T575mUA5QqLoxMd3sytwvMIagt3z0dB7WPNJUfn9ITJhL8A5yj+g6TyMVJgSIgNyR8b0NwWKYsQBEeNGXgLuUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlQHfKSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACF2C4CEEB;
	Mon,  2 Jun 2025 16:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748882383;
	bh=e7pm2A0dvrPnFtemdr71Iq/QgQlb8NO8MxQy+Ry8Xxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlQHfKSkBUvgS+ppRZ0U+kEkSJ/OkXyu8uskpkl+9ScyP6dEFTF6iVUU5esuKs50R
	 mXecNucqDFw/CF3eCalR0EBznCFkfQsVniGxuaZbdnGeeTmee8kMUY8S5a1UqInNQ8
	 2oZj44baPkqD5AhUFX9pphTfs+nceLEbhVN+PyRVv/cj/qxBRAM9VZNCQq8lwfPmdY
	 MRCTNE7031djyWZO6vYWJnR7xizIGGigrPuSGw2uVgB89CTtZOyMtJbSdeb+G+qD2C
	 S34LIdNxkV6ZE1Q+UI+U+AHW+XqnU82PMTgiwP3rOR3EhOqU4m/ICJiKZwXwXW6uqP
	 p0YOuWbfwLNpg==
Date: Mon, 2 Jun 2025 18:39:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/3] pwm: axi-pwmgen: add external clock
Message-ID: <m6evwezyzewtbiacqxfh4x6klrnc4425j6vayg7gtbytuodqpm@r72ajswzfo4k>
References: <20250529-pwm-axi-pwmgen-add-external-clock-v3-0-5d8809a7da91@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u26q2jrrojj6d6m4"
Content-Disposition: inline
In-Reply-To: <20250529-pwm-axi-pwmgen-add-external-clock-v3-0-5d8809a7da91@baylibre.com>


--u26q2jrrojj6d6m4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/3] pwm: axi-pwmgen: add external clock
MIME-Version: 1.0

Hello David,

On Thu, May 29, 2025 at 11:53:17AM -0500, David Lechner wrote:
> When we created the driver for the AXI PWMGEN IP block, we overlooked
> the fact that it can optionally be configured to use an external clock
> in addition to the AXI bus clock. This is easy to miss in testing
> because the bus clock is always on because it is driving other
> peripherals as well.
>=20
> Up to now, users were specifying the external clock if there was one and
> the AXI bus clock otherwise. But the proper way to do this is to would
> be to always specify the bus clock and only specify the external clock
> if the IP block has been configured to use it.
>=20
> To fix this, we add clock-names to the devicetree bindings and change
> clocks to allow 1 or 2 clocks.

I applied path #1 for 6.17-rc1 and will send patches #2 and #3 to Linus
before 6.16.

Best regards
Uwe

--u26q2jrrojj6d6m4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg908kACgkQj4D7WH0S
/k4bVgf/Ye0/AfnDPkgzq/NTliksF484IKG2xWdbQoo1nhmvomETPD7t9dyJSzMZ
ZGW98pEZyXHJQSrvNt1guNJF/vLUCs/fBpsCunCfkjAhBhMc5/cGfkwlMFSqEBGC
eyJ7dcP7HB1/U12uvB8jh5uO17kxeDDz3XSlYsiwH+ePgSlLTj5ILn1kuPOHssuI
yUXh6Up1f9iahnqME6BbP/6DrfKFpfYTMxUr5mqk80W5rcKPTNaqdj1OlVn8ARrt
RSoxj+hXGYVX6m1Xw0ccJNw9hagzc146Ujlqpo4mC5ClTx+2iUUWPNIH3Yub99vX
ssJInNm0jBMFWRX70etHpdfjhgmQOg==
=exv3
-----END PGP SIGNATURE-----

--u26q2jrrojj6d6m4--

