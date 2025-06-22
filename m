Return-Path: <linux-pwm+bounces-6469-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D8BAE3126
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Jun 2025 19:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148427A6C0F
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Jun 2025 17:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4144F1F153A;
	Sun, 22 Jun 2025 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKTwMUCO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F9E1E8353;
	Sun, 22 Jun 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750613404; cv=none; b=J4GpmlkkiuCvvrnGcy527AleLtzSD/6Y6o7oq+ESOc6h/3Y7Z2M4xBWRF7TXZWxEKxS0vYP6b4fGJrxsIkTBGfmfBTYsdFl6ilr5QJ9I8cyORH7mD0HQDJkbcIF1B1XxrGpAPmJN4tCDxt4044h1mdLVVbJt1HsXw86CAB9zo48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750613404; c=relaxed/simple;
	bh=OS0E8KOX7/E4yLPOZ70Yoa+cE9UMOByLcBzQmN8JgO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4GkCPkErk04YqCIKPxo3uCiB2P15gccBscm+bBri6nHrGlLGJT8ugKrvAW7AFKZlvXfd/5uibOB7DF7hX0ZcH2vvpGWLKrdS1CNz+pdCdmlBSKsr8QINrfnrtgAuQLxWr/fdu5tnOuaHQWnxIUGfPN/pkG3EaNwGm9JbsItDxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKTwMUCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12CFC4CEE3;
	Sun, 22 Jun 2025 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750613403;
	bh=OS0E8KOX7/E4yLPOZ70Yoa+cE9UMOByLcBzQmN8JgO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKTwMUCO5s6rkVIsGp6RhFJmFH8l2j7ITrt1yqV6WioZ0pN5XOdfp1XD5U4nZ/tcv
	 UJ4d2++KpH/BGupliKjnssUyG3MG1SP7OjJ4xKrgIEHXzDAxOUCaI1exOHCejTEeeM
	 FQF/WNJ6XcLwRfMOK0/K+qj/PHSJB0WIDmkxwA+SlVX4aHdPHSDdqysWzMMMtEc23p
	 SbNxtZMqLTXOvdYxGg0IXbj2FzYFwMf/zv3tq86h1TREaxvAFr7AsPVqIu2kpe+I3M
	 Up0/eaNuuWe+EMfYBqm5zagrmRUEXssGiC1hmgZi1y3yO4lQQP8K89fi2FlIG0q/Vd
	 yB/Uv89mN6DXQ==
Date: Sun, 22 Jun 2025 19:30:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
Message-ID: <tdb43v4er7v3dtbnfj2qadpf7n7rso3b2tzjb24efvhxsuadoe@tsqm4atws6aj>
References: <20250617092037.37229-1-marek.vasut+renesas@mailbox.org>
 <20250617092037.37229-3-marek.vasut+renesas@mailbox.org>
 <fhns5fnckokwsb572kge6tmqaaoholzvgncdctj7vskigytvmu@3uirsrszul36>
 <7ed914a7-8a40-4e13-8783-0fc2c01546e5@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gucpbjrcw5mdqkjb"
Content-Disposition: inline
In-Reply-To: <7ed914a7-8a40-4e13-8783-0fc2c01546e5@mailbox.org>


--gucpbjrcw5mdqkjb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
MIME-Version: 1.0

Hello Marek,

On Sat, Jun 21, 2025 at 07:19:51PM +0200, Marek Vasut wrote:
> On 6/17/25 4:02 PM, Uwe Kleine-K=F6nig wrote:
> > > +static void argon_fan_hat_i2c_shutdown(struct i2c_client *i2c)
> > > +{
> > > +	argon_fan_hat_write(i2c, 100);
> > > +}
> >=20
> > Isn't that something that the fan driver should cope for? PWM drivers
> > usually do nothing on shutdown.
>=20
> It's probably best to force the blower fan to maximum before
> reboot/shutdown. The firmware might not handle the fan and the SoC might =
get
> very hot before Linux boots again.

This is a IMHO a layer violation though. Yes, this PWM only comes in
combination with a fan. But still, the reason to want to emit a 100%
relative duty is because there is a fan, not because this is a PWM. So
this belongs into the fan part. And "funny" enough pwm-fan also has a
=2Eshutdown callback that disables the fan.

So I'd ask you to address this part in the pwm-fan driver and drop the
shutdown callback here.

Best regards
Uwe

--gucpbjrcw5mdqkjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhYPZUACgkQj4D7WH0S
/k5t4ggAngFrSGtYH6zdnsiT83EPSHXDoZDuS12DQVfcpktk7iIgJtibNZ+eDFlI
z9hUcgzPd5KZjgiVLXIDREV8AnP3/+yWh70aqOSEnbQRs7Ilcvl60flLC1K1XPc8
g3/Cw2sBp1jr4mOFH+cLCEKt8f8Q9bSF+17hVjdhPDmh48mJtacA2qiGsReJO059
SezDJDlAkxFek1CPrgapIdTtWILYHkfbpmI67h1edJ/24a7TzOTPOT3fNAsN2blg
b2vWa4mkpzemCYqOLYTcTkWF8sL6CHhNmk39ukzOFu9v6WLlC2Lt5cJ2KCGb1ZNN
xqDgpDZezZKt//VUFzlaS18CR2bf3Q==
=ngrq
-----END PGP SIGNATURE-----

--gucpbjrcw5mdqkjb--

