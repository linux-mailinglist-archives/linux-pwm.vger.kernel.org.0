Return-Path: <linux-pwm+bounces-6028-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B625ABC584
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 19:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBEC4A2A0A
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 17:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D631E286D48;
	Mon, 19 May 2025 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC9nWKQv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ADC265CA2;
	Mon, 19 May 2025 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675383; cv=none; b=BWZ/yRADOYfU/DuWS7ZUtKVVQHc28cjpTefuGhyP8Ou+vhphtiC2/nSvqJIhBr/W86a26xlsU95rWZA8vHgSRCLK4jdyaga6lpPsC2rNSy/v33Z6U4Yp/2PJ1gOX6ShtPbN58cCJycIWwkUm9Ga4rNrblJD4FhO6mRy3PpS7y9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675383; c=relaxed/simple;
	bh=ob+T55wxX5wUfQYIT/wfSG8mNacxWK+R4QP7tPmMQXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhQkbbmTgXwF2b9GBh7C7xwJIksvp5FD60tzVZpkGz+sNUZbxDBAaxJ7AX6RoVK+XCR2VWtL/oqCghbiNa+dDtcKfZVLA7vU8XIiXuHC8rvcVI9DVr/5+4VLIbt2znKPSWpRIDD1352aZKf9fxAConeT+I28YJBjugSWTQda2bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC9nWKQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261ACC4CEE9;
	Mon, 19 May 2025 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747675383;
	bh=ob+T55wxX5wUfQYIT/wfSG8mNacxWK+R4QP7tPmMQXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nC9nWKQvQqAGY0CZigDIKu+VYTrOQqIQ/0tg4pmjrsOEcb3tZCtIxIDwUCzoU0Cdd
	 fqCwemjfkeJSoF17X0Zb4TXkNLGFzoEbyS7dS+atkKh+Z52Mu32XXe27rm3UY1pevz
	 73nu5JplmVmU80qEOZDNR32Z2gtVBctSOJvyhD5clvpjoHccVcIu6Vs0DHtgZPPfgA
	 D7V65qbkqAh4XG27/S+HbQnKjq8jlJkggFvg3a3p0/7OQqnyqCJTDqbflm+Y7p2NDo
	 QRCVzErRhQ2z/U+v6l45xh5RIeZC+PuQNlPKOazO/Mh21JsoXoyWBVKDA+EMIYL3pA
	 9w3v39LxH1utw==
Date: Mon, 19 May 2025 19:23:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: timer: renesas,tpu: remove binding
 documentation
Message-ID: <2pcyqik46iko7gfrmqyz7v4nbnyktpo7u7zwuffydpvoqyrw6k@5sndkwmeutub>
References: <87semglt2g.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e37qavuhtggha2pl"
Content-Disposition: inline
In-Reply-To: <87semglt2g.wl-kuninori.morimoto.gx@renesas.com>


--e37qavuhtggha2pl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] dt-bindings: timer: renesas,tpu: remove binding
 documentation
MIME-Version: 1.0

Hello,

On Thu, Apr 10, 2025 at 01:10:48AM +0000, Kuninori Morimoto wrote:
> commit 1c4b5ecb7ea1 ("remove the h8300 architecture") removes Renesas TPU
> timer driver. Let's remove its binding documentation.
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

=2E

Thanks
Uwe

--e37qavuhtggha2pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgraPAACgkQj4D7WH0S
/k6qGwf/T8WbpOWCxnhenBbVyQ1V5ioc1B59ilAXhj8wIS96MBjpcfT0heU/AE8r
V+6l+6Z6AAZkz+ULyYfh5LwU5O0uZKjZpAG0hBf0d+kqIjMYkXSTYJIF2LaHOR9z
1ELPScxfFfzTBbmCQ6gY813t5riPapaTNOBzP8aIKfDP/sLVw4PHEf5d/T/hdNMU
UjCxAwNneACKPerKG8N0ZR/2shQyum2CWK1Zijqh+4+Nsas82nDORwd+xQ7bMk4C
GtyNh10Npvh7IVI4BiHnyzeKLVqh1Ex9pgvdmdpVaUC5milCPuqJ0tSY7zFN5uRh
ZeIyBvNLNlsgTpIbqAPOOoZE13T3Rw==
=8UWA
-----END PGP SIGNATURE-----

--e37qavuhtggha2pl--

