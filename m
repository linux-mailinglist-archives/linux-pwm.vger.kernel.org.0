Return-Path: <linux-pwm+bounces-6131-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E106DAC430C
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 18:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A138A3A47B7
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5EA212B0C;
	Mon, 26 May 2025 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYxZKwK/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492A6155CBD;
	Mon, 26 May 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748277106; cv=none; b=MztIF0/vo488zx5wp288TCc1nwuX2uATU3hGMb2LCaAfivlF8wI/8tG0Vszqb/MqZ8clzDr8sIZp22sTLipdHTif7W9voupCxFJLSTAFkxLyNP6eNCgt4BsnwbjU2mVo3daigN8easeuP/HyZNKUPIfN0rPtiRYKaFyHC2MokLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748277106; c=relaxed/simple;
	bh=YT9wI6X6eKRIxw4T8R1zmwTV55vpnD8iWP2TLnOFcV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Arpka4Ryk1tcLyV+zWrSVVVeDZjk76JKp3sk+AQMcar1HHAqVZttiMMgoqyzJ1pAxxIer03lI2sRdHWq3HSc7n6fxh0JIbp+wYsFg+n2WfmFjn2Qk2fVDMAaC7qSZzleE6xdTFs5tGiiI5gj3+/0T2NG9DFXphC4BTFtca82YBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYxZKwK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAFEC4CEE7;
	Mon, 26 May 2025 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748277104;
	bh=YT9wI6X6eKRIxw4T8R1zmwTV55vpnD8iWP2TLnOFcV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYxZKwK/KFsB7CW8pwonS2jtgDfYQ8siAgGfuJepDBXyXuz2HlWSgalCkcdN7MxlA
	 mWpCcsH9UCjj09CjcBw/J9HeiytKA67BgV0J7kPdPnGKVJAV+aFuiqfWGV4I4OOjto
	 1H7yj42UeMLnb+FeBejoDIpumvYW1l7FMsujBz4Wk/RJn6g5QoTMW5Izj7UncPl8/E
	 KxgRx6NKp5Ynv9qS4dZ6ZTiKu00t22fZYu7FTKw0BY8czhiCNndVe4DFjm22Nw3L7h
	 J8ORewy4XxgMHkzxOSKDz0AzNEdlfP8PKnSnwq6nBo1RE1J7+s8noTT4gv9a5vsslC
	 D1xI3eIPyE0vA==
Date: Mon, 26 May 2025 18:31:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jingbao Qiu <qiujingbao.dlmu@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 0/2] riscv: pwm: sophgo: add pwm support for CV1800
Message-ID: <uy4idpkmmyswci3o5dul3xwees7azrs2dhorjgb5lxipi4bllb@7lbldfrwdsj7>
References: <20250509-pwm_sophgo-v8-0-cfaebeb8ee17@bootlin.com>
 <sfqdke7xkxg3sr2acber6kjzbcnoay6bnu3enda2xe5wzdi6id@eqiqmkdeovlb>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="54dcx3cnffq3mo6y"
Content-Disposition: inline
In-Reply-To: <sfqdke7xkxg3sr2acber6kjzbcnoay6bnu3enda2xe5wzdi6id@eqiqmkdeovlb>


--54dcx3cnffq3mo6y
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 0/2] riscv: pwm: sophgo: add pwm support for CV1800
MIME-Version: 1.0

On Fri, May 09, 2025 at 08:14:57PM +0800, Inochi Amaoto wrote:
> On Fri, May 09, 2025 at 11:45:42AM +0200, Thomas Bonnefille wrote:
> > The Sophgo CV1800 chip provides a set of four independent
> > PWM channel outputs.
> > This series adds PWM controller support for Sophgo cv1800.
> >=20
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > [Thomas since v8]
> > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > ---
>=20
> As now we have pwm support for SG2042, I suggest sharing driver code and
> binding file with SG2042.

How does the two relate? Is CV1800 the same as SG2042? I'd like to know
before I spend time reviewing a driver that is better spent elsewhere.

Best regards
Uwe

--54dcx3cnffq3mo6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg0l2sACgkQj4D7WH0S
/k5a1gf/f54OOoYAzuPvLt5o6CCQ3DSCXAq7CDs7YbZ8zzIa+csVxMp5km+CSpMA
bK/j1YkZh60A/YMfiRTe+R9K44MHTUwjgrZUWMBj1Ac8r+vgWHxU2Ds3JhBDB2Vp
a1yU5si47X2wOCVIgUzoZV9VnLIxQoOThWQEPgBHaCfBFnqPmrcQIgZbs6D8tVzF
MNrUm7Z3wRfgelZtEwSlO0KpmLvwNLY9bcE4PQbIl9jNkrNlSjgUg9aAb0/U2ntQ
ie0U6EiYDRGYs611qE5yIm/A/KIUaIPVUmK54wICuW2EkieCboDHEnK/4Ld/k+qE
YmMtOp9hMvFBtm/7rj1ezySS9xUxWg==
=pOHE
-----END PGP SIGNATURE-----

--54dcx3cnffq3mo6y--

