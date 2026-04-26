Return-Path: <linux-pwm+bounces-8699-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHMbDtcN7mmUqQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8699-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Apr 2026 15:06:31 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C6D469E3A
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Apr 2026 15:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B2383008769
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Apr 2026 13:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E298D3603EA;
	Sun, 26 Apr 2026 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVPJMv6F"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B735836B;
	Sun, 26 Apr 2026 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777208788; cv=none; b=OjSTJr9eo7tvFwhwzRZtmbJiel4rguyQmabeaBiIRtBXA/au7cQN4cRc6koAcNV4IJetdYdBoVt8tsaMvEZunY+lwgOmcpY/obzyVfD5fEtwIj/MXwSAivcif0gb2CRW3a/m5JbjUlWIftEbAJ9Ij9Ev8CufP3+nUAL1E4zhfGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777208788; c=relaxed/simple;
	bh=F7Ik3qSyzNonPaKu0ttctdmlliVl+oK+J9sKk+2aqjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9uvxdVo6AlCQJv8cD9tNJAVgHYb0YwIcNARfwNgVr0ml7UhT5tkkkgFbSoqf3sqgPG45Md51hOmVcCRXnF55hJPuNaTV9i1w+LK5PiHdkvbvHFZ5Kz+KL85fxPRt757F4NJ9Q6cAKqyHOzgXjJ5pesa0hGCd/ViA2nAzIR3RH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVPJMv6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85EBC2BCAF;
	Sun, 26 Apr 2026 13:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777208788;
	bh=F7Ik3qSyzNonPaKu0ttctdmlliVl+oK+J9sKk+2aqjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVPJMv6FIVTpry6AKVRzDTg0KfalajIzBsXsUzu24Cws86nrohzBFJzf+Wv72+kji
	 1HYFrHN3DxmC7Xs+Wwm1ltwpzBkNEpXk7UfJSoXFHpC6J8rJwUh/4FsaDvFaWsrOlv
	 4q+epwJNpg3iN5J+fkC/ODUEgXT2Em79cwYNVxmiEgQf1xWAAxpLBPxQ7ybVGCwrZM
	 ZHT5f56Gnp+plPyy/4XhBg9/+wx8sY/55rPGY9QSRfTNMxlJj1kBffQgB4vs4/oVGE
	 W/oL88hac6IL4KOifWVXTvRoHjEOHpoc8ed692KnHXmbQUIBW+U33CZCQTAZiou/WY
	 7jellAU74+3jQ==
Date: Sun, 26 Apr 2026 15:06:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee@kernel.org>, 
	William Breathitt Gray <wbg@kernel.org>, kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>, 
	Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 3/6] pwm: Add rockchip PWMv4 driver
Message-ID: <ae4MCRE_hGJ-VcBQ@monoceros>
References: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
 <20260420-rk3576-pwm-v5-3-ae7cfbbe5427@collabora.com>
 <4592b323-bebd-4242-ae31-892a51b5b3be@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eqdlulvhi33joyyv"
Content-Disposition: inline
In-Reply-To: <4592b323-bebd-4242-ae31-892a51b5b3be@rock-chips.com>
X-Rspamd-Queue-Id: 82C6D469E3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8699-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[collabora.com,kernel.org,sntech.de,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email]


--eqdlulvhi33joyyv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 3/6] pwm: Add rockchip PWMv4 driver
MIME-Version: 1.0

Hello,

first of all thanks for your extensive testing, very appreciated.

On Sun, Apr 26, 2026 at 05:44:46PM +0800, Damon Ding wrote:
> On 4/20/2026 9:52 PM, Nicolas Frattaroli wrote:
> > The Rockchip RK3576 brings with it a new PWM IP, in downstream code
> > referred to as "v4". This new IP is different enough from the previous
> > Rockchip IP that I felt it necessary to add a new driver for it, instead
> > of shoehorning it in the old one.
> >=20
> > Add this new driver, based on the PWM core's waveform APIs. Its platform
> > device is registered by the parent mfpwm driver, from which it also
> > receives a little platform data struct, so that mfpwm can guarantee that
> > all the platform device drivers spread across different subsystems for
> > this specific hardware IP do not interfere with each other.
> >=20
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Tested-by: Damon Ding <damon.ding@rock-chips.com>
>=20
> The continuous mode of all PWM channels has been preliminarily tested
> and verified working on the RK3576 IoT board.
>=20
> I have tested with several typical period and duty cycle configurations.
>=20
> Following Uwe's suggestion [0], I also tested with libpwm using commands
> similar to the following:
>=20
> ./pwmset -c 0 -p 0 -P 1000000 -D 500000 -s 5000

This one is good if you have an oscilloscope (or something similar) to
verify the output. Without that (or additionally) pwmtestperf creates a
series of requests that in combination with PWM_DEBUG should uncover
rounding errors in the .tohw and .fromhw callbacks.

A good set of calls then is:

	pwmtestperf -p ... -c ... -P 50000 -S1
	pwmtestperf -p ... -c ... -P 50000 -S1 -I

	pwmtestperf -p ... -c ... -P 50000 -S-1
	pwmtestperf -p ... -c ... -P 50000 -S-1 -I

(Assuming that 50000 is a sensible period for the device under test.)

And yes, I know, I need to document that using something more permanent
than a mailing list post.

Best regards
Uwe

--eqdlulvhi33joyyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnuDccACgkQj4D7WH0S
/k514AgAoS8CgfuXs5XqIUpaG6DUWC9TEK90N9rTPcFI3q1Wfki2g130cEx3h+HQ
URD/O3wMAg5buTbtEJCYFaecSEVEYsQdyOCd1rOmNCOJRhGSNkWTfcz+LTeSwbb/
HZkA4FKcd5bn/KSJ0lymXx60zgeOZDCLkz2hOBIOK/wNm9oIJ3nBbHFU+4K3nhBf
bU0jUkFPgxIq6i8rCb/sewIqpTo0/dAME5F1/ELNCsFhZpACwDZXmCn7xdd4/J4i
wAZwp5rZWex9L8lIoSM6O0ue72lrrPBdxeMA1DlWeD1u9FV9o5NYFIGUuL8Vrum7
3KLGPiD/nTpf9LY7Ns5EfDcuKPeJ7w==
=zN39
-----END PGP SIGNATURE-----

--eqdlulvhi33joyyv--

