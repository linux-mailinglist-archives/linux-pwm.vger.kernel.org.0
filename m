Return-Path: <linux-pwm+bounces-6329-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A98F5AD784C
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 18:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41F3188406E
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F096417AE1D;
	Thu, 12 Jun 2025 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQnDrAOT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3979D2;
	Thu, 12 Jun 2025 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745931; cv=none; b=ZjduAvmxolyxqY2VVyitmBBZ4DSVFP37HOH7T4HfRzvUDDD7hXT8ybbbs5y0Ily0S0Bl7ZibWczLDbqusOgT5o5kDl9nSexhi2w7ZQqEKasSvJbqEdlOfym6POjMfYBEloWvfniD3T3399h77C8Yz5oNgetGPfxt2L6UWfEUnfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745931; c=relaxed/simple;
	bh=moGTr9/fW+jD86gPeE/kqiO0ZH9DaS65paiKqxR1ui0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPIxKb9x1GLv2jQDAXuOpbKa9S0r195W97ps2Z6cI94wErUfNJdNWQxCqroe3e4WyTE+yGHrlKCld6KgIVzc/bFP6V2OPZBE7kg69JVKT7SUQwnusUJqaY4mHNQxJJMmUk/9Da6AYbQNft1Ei4obPpajzcE15l0t8KIDZlOXIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQnDrAOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA72C4CEEA;
	Thu, 12 Jun 2025 16:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749745931;
	bh=moGTr9/fW+jD86gPeE/kqiO0ZH9DaS65paiKqxR1ui0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQnDrAOTQ7WSuJHQfCLgovgcBkCpJbjEnz/UmBnOrZ47VnlU5ogNNJrwYYAPcLjSO
	 52x4Cbh/LL9AKiQM3MS413hYfgnQs6PzIM9C7n403CBy6V381dKZa7UiIj/CXiXUjC
	 ebep74PV1lUZmqMMx6Zykl2MFNIfsPAmoaq73fpclbMUL7RynrYwpw3dePS50znJ+9
	 6nqfjG5VSxPPvDGNjZ8YP6ShqkZETQfmrdXaiNAGqO83K+pt3TF8pHnpnt12j58ZeP
	 xmK2vh5/yFQIq0CGQ5NnIUvJBStNeWAMTrOYxaP2bP6NxPMky5UQxcu9iA9zi0KNjo
	 chDEQzMg/D/3w==
Date: Thu, 12 Jun 2025 17:32:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: trivial-devices: Document Argon40 Fan
 HAT
Message-ID: <20250612-progress-envelope-c332c4cdd26d@spud>
References: <20250610220814.167318-1-marek.vasut+renesas@mailbox.org>
 <20250610220814.167318-2-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zMnRP1NtZIw9AVTm"
Content-Disposition: inline
In-Reply-To: <20250610220814.167318-2-marek.vasut+renesas@mailbox.org>


--zMnRP1NtZIw9AVTm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 12:07:26AM +0200, Marek Vasut wrote:
> Document trivial PWM on Argon40 Fan HAT, which is a RaspberryPi
> blower fan hat which can be controlled over I2C.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

I don't see how a pwm controller, with a fan connected to it, is a
trivial device, sorry.
PWM fans have their own pwm consumer binding too, so it feels wrong on
two levels.

> ---
> Cc: "Uwe Kleine-K=F6nig" <ukleinek@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 27930708ccd5..b8f1ee6e63dd 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -45,6 +45,8 @@ properties:
>            - adi,lt7182s
>              # AMS iAQ-Core VOC Sensor
>            - ams,iaq-core
> +            # Argon40 Fan HAT PWM controller
> +          - argon40,fan-hat
>              # Temperature monitoring of Astera Labs PT5161L PCIe retimer
>            - asteralabs,pt5161l
>              # i2c h/w elliptic curve crypto module
> --=20
> 2.47.2
>=20

--zMnRP1NtZIw9AVTm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaEsBBwAKCRB4tDGHoIJi
0u43AP4yFJTXBQdvFrfjkCek8wtpsM/IkVEYDJRK5aRPkIk19AEAiDNuuIO1Www/
wMQu1sXzA+JM9JzQm1Qf5CESt6J2nwA=
=Trye
-----END PGP SIGNATURE-----

--zMnRP1NtZIw9AVTm--

