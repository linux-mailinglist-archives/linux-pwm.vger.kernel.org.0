Return-Path: <linux-pwm+bounces-8184-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJkwIJ1NqWk14AAAu9opvQ
	(envelope-from <linux-pwm+bounces-8184-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 10:32:13 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 035CD20E776
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 10:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A47EA308960B
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 09:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A765F1F8691;
	Thu,  5 Mar 2026 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F43PK5AH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA563793DB;
	Thu,  5 Mar 2026 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702965; cv=none; b=T5G7EFuX+ElkOeKVIhnUSWoqRnOnT/unCaD6BVTaQFdDeti7NPoDE3CbsDEsXlaRQsr+Ys9pNO8Df0NW5qQ4KhZMyenfc9ZJNS+QVqCG3U34WF37dBnTy3FIwNZvK4OVYyTkUySqfpKPsyAnFuFtRokytr6Rej/01FqTq4ZPiXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702965; c=relaxed/simple;
	bh=JT5toTgjzbgzKeoODHGgwKMDOSRkF8JApEv+ETaVYco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp3ilGDp5xVWx7yEeS7C/U2Vvf7oaUpM6coB1Q8fELKNyUBjuFu8SRE1/b9OJaD5jfVInRV/CaDpQbDCJXuoXZgBjzI7O/sQ66gWkTuY084/LcShSBorRyPjLX7f3Dd4gsFccvUJete5LODM5jrfHS+xuzOKRLvEWlw12dWljWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F43PK5AH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7BCC116C6;
	Thu,  5 Mar 2026 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772702964;
	bh=JT5toTgjzbgzKeoODHGgwKMDOSRkF8JApEv+ETaVYco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F43PK5AHHkCYeROZH0GYnlXo7VV109Y6s7h7ZSBUj4dft4uoo4Xuy4WIObA6q1SIv
	 HTZrdshzMY3/e4QnbVLBHo6+04Mv1XRSde6qTaharM5PN7eXmlh1Np5Py/S1T+kI6H
	 7l5nBud6kiIIKCk0hs+fPkkxa/h03azEm0JBabs1D2Br0WH6vDIT9cRQ1FROdo5oqE
	 HrT414pDICpuLWUvtzhj6u1pS01UAmnlqrfmCwxMVUVVfsHpkcnqWWg8tZ+m9XoiWM
	 kMTA5/ReE8TZ2avtrTkleUMJ83hV52H2aGXbCbDFpKK/qzvZZE1dbPybwJki+sWxJE
	 b08eSfzdMswXA==
Date: Thu, 5 Mar 2026 10:29:21 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pwm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: imx-tpm: keep channel state instead of counting
Message-ID: <aalMdTmQd075dcF1@monoceros>
References: <20260202104738.837016-1-viorel.suman@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l3hiqyu24f3uothm"
Content-Disposition: inline
In-Reply-To: <20260202104738.837016-1-viorel.suman@oss.nxp.com>
X-Rspamd-Queue-Id: 035CD20E776
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-8184-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Action: no action


--l3hiqyu24f3uothm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: imx-tpm: keep channel state instead of counting
MIME-Version: 1.0

Hello,

On Mon, Feb 02, 2026 at 12:47:38PM +0200, Viorel Suman (OSS) wrote:
> On a soft reset TPM PWM IP may preserve its internal state from
> previous runtime, therefore on a subsequent OS boot and driver
> probe "enable_count" value and TPM PWM IP internal channels
> "enabled" states may get unaligned. In consequence on a suspend/resume
> cycle the call "if (--tpm->enable_count =3D=3D 0)" may lead to
> "enable_count" overflow the system being blocked from entering
> suspend due to:
>=20
>    if (tpm->enable_count > 0)
>        return -EBUSY;
>=20
> Fix the problem by replacing counting logic with per-channel state
> handling and by aligning IP and driver state at probe.
>=20
> Signed-off-by: Viorel Suman (OSS) <viorel.suman@oss.nxp.com>

I wonder if the following change would be enough:

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 5b399de16d60..36f873133f94 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -352,7 +352,7 @@ static int pwm_imx_tpm_probe(struct platform_device *pd=
ev)
 	struct clk *clk;
 	void __iomem *base;
 	int ret;
-	unsigned int npwm;
+	unsigned int i, npwm;
 	u32 val;
=20
 	base =3D devm_platform_ioremap_resource(pdev, 0);
@@ -382,6 +382,12 @@ static int pwm_imx_tpm_probe(struct platform_device *p=
dev)
=20
 	mutex_init(&tpm->lock);
=20
+	for (i =3D 0; i < npwm; ++i) {
+		val =3D readl(base + PWM_IMX_TPM_CnSC(i));
+		if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val))
+			++tpm->enable_count;
+	}
+
 	ret =3D devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");

Best regards
Uwe

--l3hiqyu24f3uothm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmpTO8ACgkQj4D7WH0S
/k7Hrgf/Q+CV5g1n5H2m0Eoa2ED9scvifb8NzAU6vXnl5oRGdYwGSwBPx0kH5aoy
S9Jovt20o7JRkpzJ+8sSZ/QYsshiEDqrELV/kPkpvYHvGhUsbQ/38Vf7xs0ggh70
0kXlGmvOZw6iwmUILjMQD4/MoNgibQkL2HyittLb6IbuH2/meVm7lqipQ1YvRjTe
oeAMdnytVyjW8J0yl7rkHFtUsNSS57NxsiFo1cDWJfcBE1LXyGMlxkHL1s0YwCE4
kF4I0KKeK44djYQ6JG1rvFkVJPMZ39i3pYX42FSS7zGr9G/dRkj452+C3JaZWt7m
c+nOUaZ7FDkwn3kBIuLvwfmxRr1UaQ==
=d5zG
-----END PGP SIGNATURE-----

--l3hiqyu24f3uothm--

