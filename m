Return-Path: <linux-pwm+bounces-4686-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDBFA16E32
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 15:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3903A2ED6
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59C41E2854;
	Mon, 20 Jan 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do1RccMb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E6195FE5;
	Mon, 20 Jan 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382396; cv=none; b=G6jG0avL9OPij+3QJtC5Qi4Wy5fzIQtlmRdUwBuvGTw0TXlJD5elriMWSXFK7foHUwJDtxjw7o7TFu7J0+6FcmmhkEW8oM6VFbySjXrdHoZK577h3cK+LaW/bzVtCJorhAHj1mSvPTle7BZMnrPhGihzjMnXJERE8e/hJnUnPbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382396; c=relaxed/simple;
	bh=LXi52AccAwK747Lt7jyUBQnKiTisCcClYGh8O1ScBts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XD1JJvLJtupYJ7ctJd4REx2BHYjCQe+WX/chT2t89Z7UhEjmeKbmWGfbsVFNtmxBkEIbcgDEu7O1LPKrh3udABy6zoh597SCi5tTSpUlkZAJzrVglVousgsF/X4fl0PZOTJtsmPGrjPsn/QgK+vWIqF4t5Re1S7jDkfUbfoMYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do1RccMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DC8C4CEDD;
	Mon, 20 Jan 2025 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737382395;
	bh=LXi52AccAwK747Lt7jyUBQnKiTisCcClYGh8O1ScBts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=do1RccMbQCLbqW8/sfmGTksmrSE7v+kl3Eicg7Ms3zp4siwYjqKy22qhH8UWgCDEe
	 9NUTQDMMJpRMsX8yfQflr3BLZisjuirc4+m9NtaaPXfKOEnNK5KOM/ERKwk783MueF
	 LtpA5KVr4UixFXdrZhRxfsBueihF7VU+cod+3N7zcZxy10Pdmx3K47eSDp5lx/PEKl
	 ZGM4Kw+s5HrxdlEnZJ+VnijLBN1IDw3063IFzv8qVqRoc+vQu6zZ2KHwMnlkYqHtX/
	 iTZC2rkapc2PInfxnoWU0U1I45x6giL2DggvZ9ZLMZxAOtTN6raqu1rq/qPzmAPnjq
	 WyZtVpokAXZcg==
Date: Mon, 20 Jan 2025 15:13:12 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 3/7] pwm: max7360: Add MAX7360 PWM support
Message-ID: <vljrtytihjud6v4xnyolrnbopep45ga2kagygoruryqwvpubmt@s76ht4taazpx>
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-3-9519b4acb0b1@bootlin.com>
 <f22l3uqgt65utxehv2zmozqixjkktp4trpr42xr5arvp6o5zcf@g5iriaeskqa5>
 <D74EQQNADWDP.FQ5XFK8TB5XH@bootlin.com>
 <v4bf6bharih6zgz52ya5twfyf47wh3fu56ovic5gjxak2jhufy@q3eudujjwrhm>
 <D74GSFVY17UV.GMN119MAVAK0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ksuvyscayydf7grk"
Content-Disposition: inline
In-Reply-To: <D74GSFVY17UV.GMN119MAVAK0@bootlin.com>


--ksuvyscayydf7grk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/7] pwm: max7360: Add MAX7360 PWM support
MIME-Version: 1.0

Hello Mathieu,

On Fri, Jan 17, 2025 at 04:47:45PM +0100, Mathieu Dubois-Briand wrote:
> On Fri Jan 17, 2025 at 3:40 PM CET, Uwe Kleine-K=F6nig wrote:
> > sounds great. Note that the detail in rounding that is different for
> > waveforms is that a value that cannot be round down to a valid value
> > (because it's too small) is round up. This is a bit ugly in the drivers
> > but simplifies usage considerably. So you never return -EINVAL because
> > the values don't fit.
>=20
> Sorry, I'm not sure I got it right. Does this affect the three members
> of pwm_waveform (period_length_ns, duty_offset_ns, duty_length_ns) ? So
> on this device where the period is fixed and I cannot define an offset,
> does that mean I will silently accept any value for period_length_ns and
> duty_offset_ns ?

Yes. The fromhw callback obviously always fills the respective constants
into .period_length_ns and .duty_offset_ns and the tohw callback
essentially only looks at .duty_length_ns.

Best regards
Uwe

--ksuvyscayydf7grk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeOWfYACgkQj4D7WH0S
/k54PQgAgI5G7ezn2dRsgzfZkJ+j/7tFoBh2cbKXA87rkrTLUlbR9p/EbFiTzTVO
ARjs2KnQBTj1H4tWuPCXngapYO3GsQQLoZ5iUpn+TEGUz1u8bAbu4cLuY5E0gblh
1047+fmzshakbxmFWgU/c4TtdCu9yHeyoTsKLxD63lM2VuO3mKCC9VDadj3W4WYj
mMpjaTRR9XxBlKy/d5all5XkuXEXGHiezwoFCGymjusE4K1ERphejzP0gKRe0RSM
wCWFA2Hf2U6QyyrQbV/G3t/LH1BhmLLZYqvXsyzlu2yhPTb98QUWofewLx9Rx5ob
2Tvt1G69cvF8VAJpVWu3RCLA/miFjA==
=QVPj
-----END PGP SIGNATURE-----

--ksuvyscayydf7grk--

