Return-Path: <linux-pwm+bounces-6434-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A32ADF4DE
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 19:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D317166D83
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F056A2FBFE8;
	Wed, 18 Jun 2025 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNU6yYCk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05922F49FD;
	Wed, 18 Jun 2025 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268539; cv=none; b=U8NX6r4dp7+IiBt3qu5LLVDKT1Bm/apyIZMAKz7Cjag2VuioWLV4mK0lrvanOtYYh6j+Wc2t0EWPXeUqWuI4OYQrPzAFFINQqDZQyAABxsuOvu+i0M8n6j16wq1wo0jadDBKoq4+jkMHQUcKI1zkhJLgfBK4KhTA9imin+mrV+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268539; c=relaxed/simple;
	bh=LArCPePMzO+BasZon9StkkfDlv13a3fopLrcbOJJqgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDW2JHEfxCi/BgxCarlTO07/tZLcwUELwEfSVkLM0WaXiey+dHirJCAlHu9O50nZ/Vpzki3fllm3BCaLUaGOt/H+Iu7gbht4O7NXJ8AJTIXfPrq5qGa7nrN62wIDsX8yfybiebHP23GdDrw86e9JISo+HJDiMuTiz7HuZ3h7D/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNU6yYCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4E4C4CEE7;
	Wed, 18 Jun 2025 17:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750268534;
	bh=LArCPePMzO+BasZon9StkkfDlv13a3fopLrcbOJJqgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNU6yYCkSNrivI4pNO22Dm80jQzj9T2iws6xKuRO8+xxwD4bwuuHiB1U/LEbwTWq+
	 f1COU2swCT3suIAJfVKB8k44oUT91GnamNByvI+j4moPI/s1IfKJOwfkzkOxDeXt1I
	 +f2t7HXZaOCDQ/QQPG3Rw3u7sDPAEQKDc6LDyfTISlqbDTIFin1bpNUkhoNVvitb37
	 QjXc+WBvvHitEHNeTbg5LHeIg8+2TgZnL10EJVT05341s76uVcUhp6YzUHgEiAzXn8
	 GvLWlDOpvtDjZSd3QcKqOxVAw+wrqUAhFe5kScJGWgLXEbyPcsjE8f99qXnxkeyk2B
	 1o7qseL+w9Erw==
Date: Wed, 18 Jun 2025 19:42:11 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v5 10/20] pwm: adp5585: add support for adp5589
Message-ID: <52fpewavv56z5fmqxabcua4rv5nugsglctgoiijrbipagryvau@wl3vdhza6ro5>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
 <20250614-dev-adp5589-fw-v5-10-7e9d84906268@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="agqyefwbu5h5hblt"
Content-Disposition: inline
In-Reply-To: <20250614-dev-adp5589-fw-v5-10-7e9d84906268@analog.com>


--agqyefwbu5h5hblt
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 10/20] pwm: adp5585: add support for adp5589
MIME-Version: 1.0

Hello Nuno,

On Sat, Jun 14, 2025 at 03:36:01PM +0100, Nuno S=E1 via B4 Relay wrote:
> From: Nuno S=E1 <nuno.sa@analog.com>
>=20
> Add support for the adp5589 I/O expander. From a PWM point of view it is
> pretty similar to adp5585. Main difference is the address
> of registers meaningful for configuring the PWM.

Patch looks ok, as for patch #3 assuming this is supposed to go in via
Lee's mfd tree:

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--agqyefwbu5h5hblt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhS+nAACgkQj4D7WH0S
/k6anAf+N652Dm3OwSyGiFPAyOmidigaq1rx9YC46HPNtL3bnaDxy3NBgLOElPtS
45j5vZBwy6sOU0zpzzmV6yB7hyHS7gprl6NjwyqR6PleekCnwdSUKUp9JJ8sLJHj
y01sM9nmSpNkYjmF64/FP7QPnwmAIJGo/gwwutTXO8wfgiDPBcYvM55IxA9hLYhn
LUh6+zxarb//ZDzl6ODom9RwnWG9r3aEk+xG5VgOImPQj+FhXtTyztWO4aX5oa64
qyJLzUwL9mLntMfxmXt3VH3yIu2hbRVD7IpVF4MtQRgvpl7mINLQlHZF+I/FXIMA
94+VfIIqZtnNo8wKOcRybJUgkpaRYQ==
=WE2+
-----END PGP SIGNATURE-----

--agqyefwbu5h5hblt--

