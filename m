Return-Path: <linux-pwm+bounces-6493-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E218AE4DC4
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 21:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FAE17C5E1
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 19:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6234A2D12F4;
	Mon, 23 Jun 2025 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Br+Bsi+O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F213FD4;
	Mon, 23 Jun 2025 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750708435; cv=none; b=tT/n2buHW7fTlW5Zs2+hnGvdZsGhhgBEY5U4Efs2SjaJ9tdUtfwYINoAkkYn7dEqPbSfkaF67G16KN3oXmwi0H7RROJ2n8clsMloafRoCFvzHEGwMqOTw3zbuCsr5+dJpRwSjThjlLTdclR37K2c0+pdRVvFOUzPv+RHlB8l2CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750708435; c=relaxed/simple;
	bh=pyqYnOlkjidKRgeVyxX1rCr60cUUf4YqGlw39FHd3yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVeeD/ynfbx8NtEav5qDQnbZN/sV1TCfTXBzjk92QO574Vm4OuD/WoV9nAK0NN9c8g/bxTMGJggDmBrnc+g5lrIaJagJYttsTl5tCkpjeY96ckVXbiKvXc2KTdARPSkMeqDpvMX+pxmBVxeyeagCsf97a7yCnTfeQw2q7maTKKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Br+Bsi+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AB8C4CEEA;
	Mon, 23 Jun 2025 19:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750708434;
	bh=pyqYnOlkjidKRgeVyxX1rCr60cUUf4YqGlw39FHd3yQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Br+Bsi+OVOOTawbj4sGu0MQYf7hqOUg4sm2E2mj6dLITYCSbnDou8doSNxXB1czyi
	 a0kaxiHp42zTxgBVA3OudGDDEuXYMwkgQFFWsIsevVAfjLfEpEYJILsV7Q9AwOr7U6
	 DlObCANx3FRTMZ0YA45A+sfOwqZ7BQh6ucmFzD0v261FbHiN4WgCW6RpcJh2syXjMJ
	 jYDhmlDV3wnIVZ7W9qcOEq/l7wrnzMxCM5WTzcPgc6jwFk7lpYWwu45dQ3dSrtTEsi
	 T97e96NHAjBdLTp5Y2bn6V8042YoSJ/iKryF6B5VPU1qGbDPTrz4TTB2QBzBIKtop7
	 zXh/YNsUXbC7Q==
Date: Mon, 23 Jun 2025 21:53:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
Message-ID: <apbocxuzcptlpghphh7nchnwyxpfhmiwosgxrt4y5awsb67ar3@fbskfbulwsma>
References: <20250621172056.160855-1-marek.vasut+renesas@mailbox.org>
 <20250621172056.160855-3-marek.vasut+renesas@mailbox.org>
 <purpjdp72jw2rok5ihyua635izyih54ufom2knsbaiwdd3jzgk@6wjf364fao2g>
 <dbec18f0-5df4-4eb8-93ab-da6ccfedf8ab@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7nsxiujugcoezieo"
Content-Disposition: inline
In-Reply-To: <dbec18f0-5df4-4eb8-93ab-da6ccfedf8ab@mailbox.org>


--7nsxiujugcoezieo
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
MIME-Version: 1.0

Hello Marek,

On Mon, Jun 23, 2025 at 07:30:33PM +0200, Marek Vasut wrote:
> On 6/23/25 11:11 AM, Uwe Kleine-K=F6nig wrote:
> > when I replied to v3 this v4 was already on the list which I missed. My
> > concern applies here, too, though.
> >=20
> > On Sat, Jun 21, 2025 at 07:19:56PM +0200, Marek Vasut wrote:
> > > +static void argon_fan_hat_i2c_shutdown(struct i2c_client *i2c)
> > > +{
> > > +	argon_fan_hat_write(i2c, 100);
> > > +}
> >=20
> > If you drop this, I'm willing to apply.
>=20
> Dropping this would make the hardware which uses this device more
> susceptible to thermal damage, e.g. in case it gets stuck during reboot a=
nd
> does not boot Linux afterward. I don't want to risk such thermal damage.

We agree here. But the right place to address this is the pwm-fan
driver. A PWM is supposed to do exactly and only what its consumer wants
it to do (in the limits set by hardware). Officially a PWM driver
doesn't know the polarity of a fan, so `argon_fan_hat_write(i2c, 100)`
might fully enable or complete disable the fan. The fan-driver knows the
polarity. The PWM driver doesn't even know that it controls a fan. And
the next guy takes the argon device and controls a motor with it --- and
wonders that the vehicle gives full-speed at shutdown.

So I hope we also agree that the pwm-fan driver (or an even more generic
place if possible that applies to all fan drivers) is the right layer to
fix this. And note that the pwm-fan driver already has such a decision
implemented, it's just the wrong one from your POV as it disables the
fan at shutdown. For me this is another confirmation that having a
shutdown callback in the PWM driver is wrong. The two affected drivers
shouldn't fight about what is the right policy.

Best regards
Uwe

--7nsxiujugcoezieo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhZsMEACgkQj4D7WH0S
/k5JEAf/ScuSFqcJij5p6YFnA9Fb6WDX7yVojrrApcLGB29gnmYa9Cuppt6t6ZW6
r8NkGZ5lsRI1ivyvW149fKyHx+NIEtO3/eSbtVOeIyObx868DH6e7nXU3VMubSbb
9ItUiOsUgmvdz1+QIBPMGc635NaVlUIABwCw51ZYZCp3ahCf6pOY7D6tcJl1rcpf
Yv+beIsZgh7OzjXPhaaCh8NhUwCe8STUjxTMJIlzJHoGa5c5/j+h1tAEHQhwNpot
vN34jVxJnJHhH3NOigvG4GU7jrDJ/XTXWkL7i9b56dyvPSGRcv48OanqFcujaWa9
GR+PvAH2cr0OYrMS0poGoGPQzf0YhQ==
=kmj9
-----END PGP SIGNATURE-----

--7nsxiujugcoezieo--

