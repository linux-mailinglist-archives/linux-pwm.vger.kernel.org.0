Return-Path: <linux-pwm+bounces-6393-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DDFADC3AD
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 09:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E753B6A92
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 07:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABA328B7DB;
	Tue, 17 Jun 2025 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHqXA1T2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7C728983D;
	Tue, 17 Jun 2025 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750146573; cv=none; b=FFDatjN/ECiu7HRWhm27QWkGCUDQ0o8B38sWCgNnliwh4vRNPnpjj9Wozme0Onp6/SsAnv3tTqMMSLhu2x/8o+yPDiaYIi/4RasygDLZQmPKoykLONWKbJEXbVxfqowZDDFBwOXbADhqmq2ZX/NzqYD1Z9xZtFvcPpZFvael4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750146573; c=relaxed/simple;
	bh=iurKei7K1hi10BDh/02oazEWTIo1HpjhFNDYYwF790M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLvHe58iKdvXKD6HTyMWh0jfy4Don8wObFzn9tXX1/1dKBTJhu70MQjtJRnOPRNf8MxjA7H2zHVidTAdqrsURX83rRp/WUfZ1u12HVY+/7/SOHEhBK1hJikMt6cz+9O7xdGgY3UXOx5qPDOtddL1+mYGNiiJLD8ZnN9r+KkZOvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHqXA1T2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BD6C4CEE3;
	Tue, 17 Jun 2025 07:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750146573;
	bh=iurKei7K1hi10BDh/02oazEWTIo1HpjhFNDYYwF790M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHqXA1T2anukYXdEWFJjNXd9bFzszwCNq1w7kc9mKAXSW3c3B0fC5dEeL4Rz37Hd+
	 UAO7nG7dH7J1zpz6kQA7WzhlorhZ28bR6m8WZzT9xAnrTSdewHRQHOgSdyVH15DLYI
	 ulbzqPejjXtnaLNbdDHJ818A8Pwc2H4WMo67kq4hGAAcDSe48DLmwAer1xajH7TM8T
	 Kf+LIeUUa2KiV+0gt0vB/p1OpJeEfeYe0OMcL59RV6vqTGONZsFyXZoUxCeX+depy3
	 ow+R4KQ64dsjzVvFqxj9LA4z0sIoexVf8n+AWzLqgLfTYw6rDVi38cz0n2rb5j7RsC
	 Nrd/pHbUt6GdA==
Date: Tue, 17 Jun 2025 09:49:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: pwm: argon40,fan-hat: Document
 Argon40 Fan HAT
Message-ID: <ikzvtvoigie7e4ift57zoi2uaygemwisjycs4zvgbiwf5s3mxi@mf6pjf6zujcv>
References: <20250617002852.606409-1-marek.vasut+renesas@mailbox.org>
 <20250617002852.606409-2-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nn3fbavpvpwivutq"
Content-Disposition: inline
In-Reply-To: <20250617002852.606409-2-marek.vasut+renesas@mailbox.org>


--nn3fbavpvpwivutq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] dt-bindings: pwm: argon40,fan-hat: Document
 Argon40 Fan HAT
MIME-Version: 1.0

Hello Marek,

On Tue, Jun 17, 2025 at 02:28:01AM +0200, Marek Vasut wrote:
> Document trivial PWM on Argon40 Fan HAT, which is a RaspberryPi
> blower fan hat which can be controlled over I2C.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Uwe Kleine-K=F6nig" <ukleinek@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: Implement dedicated binding document
> ---
>  .../bindings/pwm/argon40,fan-hat.yaml         | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/argon40,fan-hat=
=2Eyaml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml b=
/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
> new file mode 100644
> index 000000000000..2725eee5328c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/argon40,fan-hat.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Argon40 Fan HAT PWM controller
> +
> +maintainers:
> +  - Marek Vasut <marek.vasut+renesas@mailbox.org>
> +
> +description: |
> +  The trivial PWM on Argon40 Fan HAT, which is a RaspberryPi blower fan
> +  hat which can be controlled over I2C, generates a fixed duty cycle PWM
> +  signal with configurable period to control the fan speed.

Did you get that right? I would have expected a fixed period and the
parameter modifying the duty cycle?

> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: argon40,fan-hat
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2

const: 3

Best regards
Uwe

--nn3fbavpvpwivutq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhRHgcACgkQj4D7WH0S
/k6gEQf+KFH6Ikr5mNDMFrWymYUE8hWe9ZbD+5neMjgC+uV47jeIi1RkJbP++tob
GOD/+XyUGgamp8bP39vbO/HIy6qHG0+CpIkb/qpRouxdJSILkzPMznnLXShV1iSj
CqVcASbq49oHdphU93XIjej/n4WSpvFQ0EBS5yMgVDTVBpQo8hLuoH3tYh0/eliz
NLh/ffUgu7NGk9xmdQRy4L2/s86OPvD66/BuDm7ACdF3O8U/9gOMa0+JgX+DrBpp
m6IQ/WEHVJnTjiJVZUsFfOEE1SR0aMYM3FypZmHscUPH3ruaRNpheO1H5wIx9Ikb
5qTJ/rOuDHgh1dgI5OUDgelhfjzjyw==
=4MJQ
-----END PGP SIGNATURE-----

--nn3fbavpvpwivutq--

