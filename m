Return-Path: <linux-pwm+bounces-8571-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHwTHLtR3WkFcQkAu9opvQ
	(envelope-from <linux-pwm+bounces-8571-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 22:27:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C483F3176
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 22:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4C94303076F
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 20:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17D339478E;
	Mon, 13 Apr 2026 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWzZNZY7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC054393DE0;
	Mon, 13 Apr 2026 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776112056; cv=none; b=oiB6FzbfsfxXoVR6gJu1eU6dKMKyb8q/msrx2XoS+C2nbd7Qu3E4ZgqklanxFK4nK8gTh/xjE2SxsgWEx8f2HH8AvN8C2l4pekrLqI7I/82qqgujHwTxIX90lo0AY82Rbr7bMINBhVnEg0D+CmQrvM98Tj62/vZj3wL+djO3Flo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776112056; c=relaxed/simple;
	bh=6yofSQLj+gW5ePwKJizrWlHOQntWXc7yHgiMuUR/QC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzEP73cQpUJpcBpXL8i2UR/GOGrP3EdjfIwM8hIjnG/uNBA5UkMHUjEpOhjlAUJZU8Xc6jNai3iB4bgG1hOUHzTDWJW1ApwS6f8K8vj8hEN7byzTHgGwzVXVSZUmI8nOlfLoI3O6rKuUnHskKeqk6JMJe7Bt8F410AEO2XQVagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWzZNZY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086CAC2BCAF;
	Mon, 13 Apr 2026 20:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776112056;
	bh=6yofSQLj+gW5ePwKJizrWlHOQntWXc7yHgiMuUR/QC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mWzZNZY7tBqVHisz5/TAuMVz5TwYyVIrJsX2ylAlDYRVokTuIo5Bszo7eLA4Qynxp
	 lxS1eKsHMcVwYP52rBrfR27Pa4yrhzLJHiESqYKIoA0fVWL+ro0SPvkTiRY9VM2+0p
	 x/Aq7TOWJVGFwZINF46Bfu2mEIGDBpejfOpskTy8eAJHAir8Dj9VrX7VjW61Y7v6+W
	 w8Y6P6VbTuBha74LE3s4zK+JdtTWCNzvamxsZz0OECIkT+Xbx/AQLHGyhM5FGv9yHS
	 9ASdk+UPEaN2ecqhnGIUwF2kgGaMvId6IRX7l3QxDM7ov93KyvFfoXhrv2csydSsmF
	 p6huCDnuQQocA==
Date: Mon, 13 Apr 2026 22:27:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Devi Priya <quic_devipriy@quicinc.com>
Subject: Re: [PATCH v21 2/6] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <ad1RFmg0AEb7hudQ@monoceros>
References: <20260406-ipq-pwm-v21-0-6ed1e868e4c2@outlook.com>
 <20260406-ipq-pwm-v21-2-6ed1e868e4c2@outlook.com>
 <ady2pLwiNT9FffF7@monoceros>
 <DS7PR19MB888389B41E784995F064EE0B9D242@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bhhp4rpnsyfcrsua"
Content-Disposition: inline
In-Reply-To: <DS7PR19MB888389B41E784995F064EE0B9D242@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8571-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: E2C483F3176
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--bhhp4rpnsyfcrsua
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v21 2/6] pwm: driver for qualcomm ipq6018 pwm block
MIME-Version: 1.0

Hello George,

On Mon, Apr 13, 2026 at 11:17:18PM +0400, George Moussalem wrote:
> On 4/13/2026 1:35 PM, Uwe Kleine-K=F6nig wrote:
> > On Mon, Apr 06, 2026 at 10:24:39PM +0200, George Moussalem via B4 Relay=
 wrote:
> >> From: Devi Priya <quic_devipriy@quicinc.com>
> >>
> >> Driver for the PWM block in Qualcomm IPQ6018 line of SoCs. Based on
> >> driver from downstream Codeaurora kernel tree. Removed support for old=
er
> >> (V1) variants because I have no access to that hardware.
> >>
> >> Tested on IPQ5018 and IPQ6010 based hardware.
> >>
> >> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
> >> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> >> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> >> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> >> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> >=20
> > I have a few remaining nitpicks. If you're ok I'll squash the following
> > diff into this patch and apply it:
>=20
> Just applied it to my own branch, all okay from my side. Thanks for your
> guidance and support!

I did that and added a ; to make the compiler happy. It is now contained
at
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt
as 7.2-rc1 material. I'll push it into next after the merge window
closes in ~ two weeks.

Best regards and thanks for work
Uwe

--bhhp4rpnsyfcrsua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmndUbIACgkQj4D7WH0S
/k5qHwf9EyYDJxkItQQ8h2TnnUjFw/Gtpwym37kt7l4VGsrVlHX6YBTycxXCXH7s
VNWNACZRjum7xCCpPmz4VAl4zTgWgEx7+ex8VuNbv65fcrSl6i3PBFUuGA/y0KRl
+az3cRlBjn8ByJOrdNCbN6CU8W19mPJJQRR5xWPQyglvp8fng+zzJh6IP+GFC0AD
WS0v07e4h8EsKceHh+IcVpd6WgCyB6dLEbhOB0zNk5T28NrN0Rv+fM1/BzheTekN
l/gOJVtH/EE+3VviRU9B55fpHEIJokOoHghOpgvmTYYhvzG/eriVsVOqrBW681MQ
y4Xyyq/MgtbXa0i0xl+kyoGSt07qrA==
=QXzN
-----END PGP SIGNATURE-----

--bhhp4rpnsyfcrsua--

