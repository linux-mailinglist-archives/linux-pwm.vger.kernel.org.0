Return-Path: <linux-pwm+bounces-7020-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10651B224C7
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 12:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFD51B62473
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 10:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408EB2EA162;
	Tue, 12 Aug 2025 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1fAi/GY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF619D8AC;
	Tue, 12 Aug 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995454; cv=none; b=jskpRrOA4I2yNEWLD0MsfFXgw/5S2zPaHqR3njKjtSNEOBRH05BrW/q8hFwUcgNkmvtufUKx49F/5PZ/8GoGYMbVtId8mywvjuJB3L0ln7eUIpn1HTRqsBV89oTyDX06pZY7XMA25XNxspNzUu7hdB4lqZcLkpv+1DgCNYuRgQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995454; c=relaxed/simple;
	bh=J8rVonJeLT9Z5TovIwI3US6OvTejPp0e0BDvn2/Z0BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf8KWqwpE8NLPAribus73rqJtCppVrPdlC7qQnIzFxfclHuCZJZvv7daTLCmx9ZkjQfKpRYutJuBeFKIrOoBTJMhM8yMZU4BkTFfqiwZLfTWAcabK6NAb+A9cpBbbuN/hSTJA/T9xjprGwAsUPgLmjz8OH3clniBOAuPf8kT+EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1fAi/GY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CCDC4CEF0;
	Tue, 12 Aug 2025 10:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754995453;
	bh=J8rVonJeLT9Z5TovIwI3US6OvTejPp0e0BDvn2/Z0BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1fAi/GYOYfaq4gVx2LznWOiqtFzauqUfFP/8rYCiQlxtmuQQ3+NSR5kYCi+CHLdy
	 WKjfsFvvL+BM0vZTRX1MsWOukh0RDYHzoC5mIu1ExSyC8ElY9K9HNDtw7zNl9zCugz
	 n1j1u0/g0wR+IxzaOYruW0l6NVino0PqLRaJnw3/8AY1fkHXhoMVjmyFtG6bd68s/5
	 gBDPSjjauCtj9tU4RUbjCgo+GxeqgOHChyi0wfn7wBoycu04x0FELQwLwZBuEObgcW
	 LeNtsDlePGt2cobTUxgN6CKALA2cqWmJht0v7e9YAzQ3IXvSB1XRjXyTuzYOobPzex
	 GTQUQazAzmpww==
Date: Tue, 12 Aug 2025 12:44:10 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: Rename GPIO set_rv callback back to its original
 name
Message-ID: <z7wqrfqvx5rtm6ztvwnb4po5dvabgb2lyse6nws6ojzjdr6k3e@qzpopioosaai>
References: <5366fcd01c9f8b374914e6137f01d156033c8a9e.1754986373.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qkl5xl6kf72ekdgo"
Content-Disposition: inline
In-Reply-To: <5366fcd01c9f8b374914e6137f01d156033c8a9e.1754986373.git.geert+renesas@glider.be>


--qkl5xl6kf72ekdgo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Rename GPIO set_rv callback back to its original
 name
MIME-Version: 1.0

On Tue, Aug 12, 2025 at 10:14:59AM +0200, Geert Uytterhoeven wrote:
> As of commit d9d87d90cc0b10cd ("treewide: rename GPIO set callbacks back
> to their original names"), the .set_rv() callback no longer exists:
>=20
>     drivers/pwm/core.c: In function =E2=80=98__pwmchip_add=E2=80=99:
>     drivers/pwm/core.c:2514:26: error: =E2=80=98struct gpio_chip=E2=80=99=
 has no member named =E2=80=98set_rv=E2=80=99
>      2514 |                         .set_rv =3D pwm_gpio_set,
> 	  |                          ^~~~~~
>     drivers/pwm/core.c:2514:35: error: initialization of =E2=80=98int (*)=
(struct gpio_chip *, unsigned int)=E2=80=99 from incompatible pointer type =
=E2=80=98int (*)(struct gpio_chip *, unsigned int,  int)=E2=80=99 [-Werror=
=3Dincompatible-pointer-types]
>      2514 |                         .set_rv =3D pwm_gpio_set,
> 	  |                                   ^~~~~~~~~~~~
>     drivers/pwm/core.c:2514:35: note: (near initialization for =E2=80=98(=
anonymous).direction_input=E2=80=99)
>=20
> Fixes: 1c84bb7fc0ad5841 ("pwm: Provide a gpio device for waveform drivers=
")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Probably to be folded into the original commit, when pwm/for-next is
> rebased to v6.17-rc1.

That's what I did, before seeing your patch. Note that the Fixes line
isn't accurate, because it only gets wrong when it's merged in a tree
that contains d9d87d90cc0b ("treewide: rename GPIO set callbacks back to
their original names"). I don't know in which tree you found the two
commits together (I think Stephen fixed it for next?), but then
technically the merge commit would be at fault.

Best regards
Uwe

--qkl5xl6kf72ekdgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmibGvgACgkQj4D7WH0S
/k5C/gf/WX66APsZZs/lryauGaiDHdlVAx6RfmXwGLnHh5a8+RhoXXjQuJ1pjc9R
1jg/IYkyDta95dl9lD15KIBfty1sLttQzCGhW+ik1ywOGy29GL9eyqrx3WT2gOSI
hV+xiquvmZPR+a8GTC/6zBZOi3sgHotkCtMUdBC/R5SegdwHerD+kiXWUDwqMXqj
MZRmDUVAv2fLJY+0MPPtI/A5ST7WvxyLqRj2sxKVrzOJz/3k2h7/oaHelNnt8gIJ
gm97SeN+i/9jiUOU3ONXms+HmvAhQ2luEQZ5PfVHAKMgm3H5Z+9GG4C7/ErX0aAu
0ZpTlWbR5C8K8Ma+c/aS7p73OX2yfQ==
=cfou
-----END PGP SIGNATURE-----

--qkl5xl6kf72ekdgo--

