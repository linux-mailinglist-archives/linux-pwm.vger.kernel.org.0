Return-Path: <linux-pwm+bounces-8567-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Fb5Bmi53GkvVwkAu9opvQ
	(envelope-from <linux-pwm+bounces-8567-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 11:37:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF183E9EB5
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 11:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F6033028353
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA4A3AE1BD;
	Mon, 13 Apr 2026 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bx+8O1xs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6E21B185;
	Mon, 13 Apr 2026 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776072949; cv=none; b=quyU+q+nCh7qwH9jhd7+ElU7n4FB7Oi9/FBnZ/wJYp+jnZDfOBKsaJupr677CZulqb9rfQharxEd92wPySM1H4YZkFJ7av277cApI/4olr6zv559c0C9LRp9NdLi+ng1msfjhjgdoGzK1l3TC3fAUZtGo6q/LzRFZghOLzub1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776072949; c=relaxed/simple;
	bh=qiSFmjvv5lf+NtOOLOQm0uLeRuLoVxlpeEyskUaC3G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQKhsQj7/0pfjc90bL4A5lrQbJ6gs1/sy8B90CZmbZU/DoG2R3MD3tHP3yMFaD6wwei37b8tOkPCwxudhfMmP8aqpYGdeWY3Iewtj6CbZDMbwNgi7/BNlng/bffHK/wvxXPf75xn7ccAiza9Kcm06CRGLwL01vmRnwKs0l0ZcJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bx+8O1xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6266CC116C6;
	Mon, 13 Apr 2026 09:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776072949;
	bh=qiSFmjvv5lf+NtOOLOQm0uLeRuLoVxlpeEyskUaC3G4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bx+8O1xsLMg1XvBrUY7YbsV+O9u6e1FnpGe3gUhAwPIlmYzi5Hmc2Y1+Jj0NMfA8M
	 fygbPc3FZs8fQtu/IOb9+z6G8NYERzukKabqj2bp49YuZaxJ1PlM6LzLvwK+ep/CHL
	 1Z/FjbieYQp2GzajCnSW/GLW1NXyZhTiiZzMnZicPhXKvqmc1ctpcSGyggNuVPhRcL
	 eK7OL9M0tpVt/+QDLeK7HdmyDFaT7t0WQoQufgqVLCD6YiQULqN08AEWQ3EH6iZfOA
	 K6Udbe/py48uw7F+jc4JdXKbGkgvdnC/UCN/7G/DxUsrctbI9mVDz2yO2o73wNnoCk
	 pEMqkqVqKfECw==
Date: Mon, 13 Apr 2026 11:35:47 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: george.moussalem@outlook.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Devi Priya <quic_devipriy@quicinc.com>
Subject: Re: [PATCH v21 2/6] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <ady2pLwiNT9FffF7@monoceros>
References: <20260406-ipq-pwm-v21-0-6ed1e868e4c2@outlook.com>
 <20260406-ipq-pwm-v21-2-6ed1e868e4c2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5u5li7rew6iszz66"
Content-Disposition: inline
In-Reply-To: <20260406-ipq-pwm-v21-2-6ed1e868e4c2@outlook.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8567-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,quicinc.com:email]
X-Rspamd-Queue-Id: 6CF183E9EB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--5u5li7rew6iszz66
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v21 2/6] pwm: driver for qualcomm ipq6018 pwm block
MIME-Version: 1.0

Hello,

On Mon, Apr 06, 2026 at 10:24:39PM +0200, George Moussalem via B4 Relay wro=
te:
> From: Devi Priya <quic_devipriy@quicinc.com>
>=20
> Driver for the PWM block in Qualcomm IPQ6018 line of SoCs. Based on
> driver from downstream Codeaurora kernel tree. Removed support for older
> (V1) variants because I have no access to that hardware.
>=20
> Tested on IPQ5018 and IPQ6010 based hardware.
>=20
> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>

I have a few remaining nitpicks. If you're ok I'll squash the following
diff into this patch and apply it:

diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
index b79e5e457d1a..65af19ded72c 100644
--- a/drivers/pwm/pwm-ipq.c
+++ b/drivers/pwm/pwm-ipq.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (c) 2016-2017, 2020 The Linux Foundation. All rights reserved.
  *
- * Hardware notes / Limitations:
+ * Limitations:
  * - The PWM controller has no publicly available datasheet.
  * - Each of the four channels is programmed via two 32-bit registers
  *   (REG0 and REG1 at 8-byte stride).

This is to make

	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/*.c

do the right thing. I know "Limitations" isn't a good subject for this,
but until I come around to pick a better marker, doing the same in all
drivers is good.

@@ -44,13 +44,6 @@
=20
 #define IPQ_PWM_REG1			4
 #define IPQ_PWM_REG1_PRE_DIV		GENMASK(15, 0)
-
-/*
- * The max value specified for each field is based on the number of bits
- * in the pwm control register for that field (16-bit)
- */
-#define IPQ_PWM_MAX_DIV			FIELD_MAX(IPQ_PWM_REG0_PWM_DIV)
-
 /*
  * Enable bit is set to enable output toggling in pwm device.
  * Update bit is set to trigger the change and is unset automatically
@@ -59,6 +52,12 @@
 #define IPQ_PWM_REG1_UPDATE		BIT(30)
 #define IPQ_PWM_REG1_ENABLE		BIT(31)
=20
+/*
+ * The max value specified for each field is based on the number of bits
+ * in the pwm control register for that field (16-bit)
+ */
+#define IPQ_PWM_MAX_DIV			FIELD_MAX(IPQ_PWM_REG0_PWM_DIV)
+
 struct ipq_pwm_chip {
 	void __iomem *mem;
 	unsigned long clk_rate;

This is just about ordering definitions taken 1:1 from the manual before
driver specific stuff.

@@ -95,6 +94,12 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct p=
wm_device *pwm,
 	unsigned long val =3D 0;
 	unsigned long hi_dur;
=20
+	if (!state->enabled) {
+		/* clear IPQ_PWM_REG1_ENABLE */
+		ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, IPQ_PWM_REG1_UPDATE);
+		return 0;
+	}
+
 	if (state->polarity !=3D PWM_POLARITY_NORMAL)
 		return -EINVAL;
=20
This ensures that the PWM can be disabled even if state->polarity is
bogus or period and duty_cycle are out of range.

@@ -102,7 +107,8 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct =
pwm_device *pwm,
 	 * Check the upper and lower bounds for the period as per
 	 * hardware limits
 	 */
-	period_ns =3D max(state->period, IPQ_PWM_MIN_PERIOD_NS);
+	if (state->period < IPQ_PWM_MIN_PERIOD_NS)
+		return -ERANGE;
 	period_ns =3D min(state->period, IPQ_PWM_MAX_PERIOD_NS);
 	duty_ns =3D min(state->duty_cycle, period_ns);
=20
This is about correctness. A driver is expected to never configure a
higher value than requested. (And otherwise I would have converted that
to clamp().)

@@ -134,7 +140,7 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct =
pwm_device *pwm,
=20
 	/* pwm duty =3D HI_DUR * (PRE_DIV + 1) / clk_rate */
 	hi_dur =3D mul_u64_u64_div_u64(duty_ns, ipq_chip->clk_rate,
-				     (u64)(pre_div + 1) * NSEC_PER_SEC);
+				     (u64)NSEC_PER_SEC * (pre_div + 1));
=20
 	val =3D FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
 		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);

Just consistency with the period calculation

@@ -144,9 +150,7 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct =
pwm_device *pwm,
 	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
=20
 	/* PWM enable toggle needs a separate write to REG1 */
-	val |=3D IPQ_PWM_REG1_UPDATE;
-	if (state->enabled)
-		val |=3D IPQ_PWM_REG1_ENABLE;
+	val |=3D IPQ_PWM_REG1_UPDATE | IPQ_PWM_REG1_ENABLE;
 	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
=20
 	return 0;

Simplification that is possible after checking for state->enabled early.

@@ -174,7 +178,7 @@ static int ipq_pwm_get_state(struct pwm_chip *chip, str=
uct pwm_device *pwm,
 	hi_dur =3D FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
 	pre_div =3D FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
=20
-	effective_div =3D (u64)(pre_div + 1) * (pwm_div + 1);
+	effective_div =3D (u64)(pwm_div + 1) * (pre_div + 1)
=20
 	/*
 	 * effective_div <=3D 0x100000000, so the multiplication doesn't overflow.

Again consistency.

A nice followup for this patch would be the conversion to the waveform
API; just in case you're still motivated to work on this driver :-)

Best regards
Uwe

--5u5li7rew6iszz66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmncuPAACgkQj4D7WH0S
/k6j2ggAi6ViW/EbwGsB3KMUtRdeCBKA1j/00S/Dirdtq6zPgEP4NdESKK/dC8NK
dAEL8QG5001/3TAsWqRPZLTgqTaefy0MFnqTWFZ9IvrveGJ2OgydifghV1rO/d/W
xCPkzF+IVf/0r2TXTaHdyVTVYpdm3M432AlYoNv7QRSuE5Lga1LmNLR21fgCUosS
XQH54r9AYH9ORQEXQm7KgiNfDBnzLvYmMIwTiaxJO72curvNHUjlOchnoeYSWLOS
prkwooNqVME5Lm/QD9UqXN/aFSToaOsZbzKWGAFZn/hngwzl4TdplA0Tdd/juGe4
onbAs6qgAxlQ8J4eS55a877V4RYPmw==
=m3gv
-----END PGP SIGNATURE-----

--5u5li7rew6iszz66--

