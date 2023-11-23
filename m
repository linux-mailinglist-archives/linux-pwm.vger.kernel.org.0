Return-Path: <linux-pwm+bounces-176-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 017047F6511
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 18:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339391C20A7D
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 17:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861A23FE2C;
	Thu, 23 Nov 2023 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBuJmB01"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A9646B2;
	Thu, 23 Nov 2023 17:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B0FC433CC;
	Thu, 23 Nov 2023 17:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700759859;
	bh=ts+zqQc2FfD6+up8RHX6pODysbXRP+HNaBy6BBRqtZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hBuJmB01jH44PO6tf54BIK+xjnjyj3ttz7jh18Fw5eSzvA+g3tsgaP9iBWoIwKoc2
	 iLBaPkyFpsGYABM9U4JyhfTWNIfzFd+l5Bij1mw/o8fIgpfEdas8TCWDBvsXx6YvER
	 dL6R/W6u6Uc7ezFvnlfXhw8QGw9wsn54YvJMhzJKUIuTd9vlx0zzpV2Hp94mAL5GRL
	 okq/jNr6mV/osPxj1VBv88LY2V8yOXXdzR8PZZ6GyvHgjdEiG/tB6TD7PJVFb/0BoS
	 k4YELSUx9SewzfmMwizuz0fa8zdJzfCeuwwB7V0eL5ETqRQw3BbUETTBM+CptC/ShN
	 Ap1rDH3Z3tjgQ==
Date: Thu, 23 Nov 2023 17:17:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jitao Shi <jitao.shi@mediatek.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: pwm: remove Xinlei's mail
Message-ID: <20231123-swell-outlast-d09bee7f85fe@spud>
References: <20231123134716.2033769-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9vUpuWVFk7p9BYFj"
Content-Disposition: inline
In-Reply-To: <20231123134716.2033769-1-mwalle@kernel.org>


--9vUpuWVFk7p9BYFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 02:47:16PM +0100, Michael Walle wrote:
> Xinlei Lee's mail is bouncing:
>=20
> <xinlei.lee@mediatek.com>: host mailgw02.mediatek.com[216.200.240.185] sa=
id:
>     550 Relaying mail to xinlei.lee@mediatek.com is not allowed (in reply=
 to
>     RCPT TO command)
>=20
> Remove it.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--9vUpuWVFk7p9BYFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV+JLgAKCRB4tDGHoIJi
0t5zAPoCpbE32A6RWoUyYWg7kdcQQ4hIkcinmEa+cuTb40dvFwD/RlVSJ1Dt2mC/
1TVGlA4sr492Jn6Wm/7BbXm4QYIHhAM=
=s9a9
-----END PGP SIGNATURE-----

--9vUpuWVFk7p9BYFj--

