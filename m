Return-Path: <linux-pwm+bounces-8459-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ECaKUSNzmnOoQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8459-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 02 Apr 2026 17:37:40 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF43738B534
	for <lists+linux-pwm@lfdr.de>; Thu, 02 Apr 2026 17:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAA863064E37
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Apr 2026 15:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E19F3DCDAF;
	Thu,  2 Apr 2026 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D28Q9m9y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1336534EEF3;
	Thu,  2 Apr 2026 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144134; cv=none; b=MM7FsHVLtB1MD5fKgvk/u3o7wJxoEyR1Y5/nRHVWm8MhJhcA6JbbDAXGNUx45ZLdlS5SFm+zfoj5fjhgB2I/7N4ONYd5kY6jzy0GcuRmAggtuGIVVM9laoMx3B6ZzVPLcSY7mbBVNHOGeEJsQtEoqOVPykDOUn/rME5i0aXm7BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144134; c=relaxed/simple;
	bh=r7iiCd/fvKb2J1LKeOzWFvVJRWgqqYur0jEJoW8UgHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgWcTmvWYsSOCuKSfbffq8iEIR8l3HofqwG5w4KK+B3IY9ecGpxvF0pOgnz5R7IFhp+oeh7l84n34Wst2eMC+3IXfMqkmP2m1GJx653d9gBj9VPaO0I72P/MYVigwyk8IF6jj/GP9rZxJ39pGq3BCKUPQ7/6OUWS0U6v3+yNkzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D28Q9m9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F84C116C6;
	Thu,  2 Apr 2026 15:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775144133;
	bh=r7iiCd/fvKb2J1LKeOzWFvVJRWgqqYur0jEJoW8UgHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D28Q9m9yZT4BWr23qLpUw1YuJaajJCr31KFKFfvGwwEMua/EeNXCyRVb8hA3P4/9C
	 o01Lpl690mjPYInAWG9JQCiCZhsgunpehb/62WC3YYo4/dtzgrzGNyROHK1LAESBc+
	 Al/PHdGRo5Ain6YzP5/QwsQftr+tGnnCOHO/bIWLnuUy9sIVNfefE2JwnReDYi177V
	 aV92lDAfhyyQW0MykCaLnGQ55n5Am4tt/RQG+tskkxDOGscEzgZVtjsQM/hKmVlHKq
	 O18hvkYmprCovTQ0rbfD+pCf8BiK1IULxLQtob8o11EofD4IKelOpA1ME+EcqtsxEV
	 MoUvb+toBNEcw==
Date: Thu, 2 Apr 2026 17:35:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: george.moussalem@outlook.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Baruch Siach <baruch@tkos.co.il>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Devi Priya <quic_devipriy@quicinc.com>, Baruch Siach <baruch.siach@siklu.com>
Subject: Re: [PATCH v20 2/6] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <ac6MP-O2MNDkleZB@monoceros>
References: <20260204-ipq-pwm-v20-0-91733011a3d1@outlook.com>
 <20260204-ipq-pwm-v20-2-91733011a3d1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cuqojunejqg7fvth"
Content-Disposition: inline
In-Reply-To: <20260204-ipq-pwm-v20-2-91733011a3d1@outlook.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8459-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF43738B534
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--cuqojunejqg7fvth
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v20 2/6] pwm: driver for qualcomm ipq6018 pwm block
MIME-Version: 1.0

Hello,

I applied the patch and reviewed it in my editor. Here is the resulting
diff:

diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
index b944ecb456d5..4818d0170d53 100644
--- a/drivers/pwm/pwm-ipq.c
+++ b/drivers/pwm/pwm-ipq.c
@@ -97,9 +97,10 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct p=
wm_device *pwm,
 	if (state->polarity !=3D PWM_POLARITY_NORMAL)
 		return -EINVAL;
=20
-	if (!ipq_chip->clk_rate)
-		return -EINVAL;
-
+	/*
+	 * XXX Why? A comment please. (Is this already covered by the checks
+	 * below?)
+	 */
 	if (state->period < DIV64_U64_ROUND_UP(NSEC_PER_SEC,
 					       ipq_chip->clk_rate))
 		return -ERANGE;
@@ -107,18 +108,29 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struc=
t pwm_device *pwm,
 	period_ns =3D min(state->period, IPQ_PWM_MAX_PERIOD_NS);
 	duty_ns =3D min(state->duty_cycle, period_ns);
=20
+	/*
+	 * Pick the maximal value for PWM_DIV that still allows a
+	 * 100% relative duty cycle. This allows a fine grained
+	 * selection of duty cycles.
+	 */
 	pwm_div =3D IPQ_PWM_MAX_DIV - 1;
+
+	/*
+	 * XXX mul_u64_u64_div_u64 returns an u64, this might overflow the
+	 * unsigned int pre_div.
+	 */
 	pre_div =3D mul_u64_u64_div_u64(period_ns, ipq_chip->clk_rate,
 				      (u64)NSEC_PER_SEC * (pwm_div + 1));
-	pre_div =3D (pre_div > 0) ? pre_div - 1 : 0;
+
+	if (!pre_div)
+		return -ERANGE;
+
+	pre_div -=3D 1;
=20
 	if (pre_div > IPQ_PWM_MAX_DIV)
 		pre_div =3D IPQ_PWM_MAX_DIV;
=20
-	/*
-	 * high duration =3D pwm duty * (pwm div + 1)
-	 * pwm duty =3D duty_ns / period_ns
-	 */
+	/* pwm duty =3D HI_DUR * (PRE_DIV + 1) / clk_rate */
 	hi_dur =3D mul_u64_u64_div_u64(duty_ns, ipq_chip->clk_rate,
 				     (u64)(pre_div + 1) * NSEC_PER_SEC);
=20
@@ -161,6 +173,10 @@ static int ipq_pwm_get_state(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
 	pre_div =3D FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
=20
 	effective_div =3D (u64)(pre_div + 1) * (pwm_div + 1);
+
+	/*
+	 * effective_div <=3D 0x100000000, so the multiplication doesn't overflow.
+	 */
 	state->period =3D DIV64_U64_ROUND_UP(effective_div * NSEC_PER_SEC,
 					   ipq_chip->clk_rate);
=20
@@ -210,6 +226,8 @@ static int ipq_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Failed to lock clock rate\n");
=20
 	pwm->clk_rate =3D clk_get_rate(clk);
+	if (!pwm->clk_rate)
+		return dev_err_probe(dev, -EINVAL, "Failed due to clock rate being zero\=
n");
=20
 	chip->ops =3D &ipq_pwm_ops;
=20

Comments with XXX need more code adaptions (or a comment why my concern
isn't justified).

Best regards
Uwe

--cuqojunejqg7fvth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnOjMAACgkQj4D7WH0S
/k4pVgf/cETIaYkltCz65bm+33f6CU+amN5LmNhNoMv7fFgWhXEQJJWO4BQD2cyF
NmakHDiUbBrzos0rZgvfEejWIPMH5iMoL6kY2DPMIq3SEb9aowgfXMAtbxWxcW4q
zKnfpjj29dDcZiX6MdF3aTeQLEbPuWt7viGtegmyPBCBm/qa79BDyKLDw0MVPcpv
6GTFyqq7xjMZ0USn23CH/r5AscEgPG2VwItf7UDXJPPrRXTZArIUE+S97bGX+tL3
17S+i+b7LVXUdrcRZtHrFifM9m69OaQDRGJLPnr91B2+7/wFYzOSBcTaErnWu3R2
Pw3r6JurrbfzRaFT3xqLW5aB+LxyeA==
=qKav
-----END PGP SIGNATURE-----

--cuqojunejqg7fvth--

