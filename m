Return-Path: <linux-pwm+bounces-7537-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA15C1FE3B
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 12:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56ED44E3717
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16EF33F384;
	Thu, 30 Oct 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emh-metering.com header.i=@emh-metering.com header.b="Q/ey9GsZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from pmg.emh-metering.com (pmg.emh-metering.com [62.153.85.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8D32F83B7;
	Thu, 30 Oct 2025 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.153.85.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825213; cv=none; b=bBuvMXbgpc+i0LGebMTQkeBEH/ZCGct7CwhFypVMpxf3DlkHTVAEio2mWom5hvj9qrhx/EV+I9o/q5Grfn8G0FbAoi1f0zDYrWLstDyXz/Yy5XknzoGBxX9wvIaPEa5waKc57Pu55RL45PG+zanq5C9Vppsc0FxSW2mgtZTtmYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825213; c=relaxed/simple;
	bh=ua3Y7itRMtu5elj9GSD2J65goiDqZR5omxQYD19skBE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PCqT8sAPJQ+dn8hBMVlf3qHno3UUsRSKOVg++FYKDE7yv4ol0QFBSHFNPfESvYth98d1AKnhrq4YeTBC8UJjNh0b+1GbTIviUALuYwzEClKydyy8t6OGe1Wm0QTwHAMNHIKopHp4SnFEWfXm61wga7MbxfHt02A53HUJRSYYvlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emh-metering.com; spf=pass smtp.mailfrom=emh-metering.com; dkim=pass (2048-bit key) header.d=emh-metering.com header.i=@emh-metering.com header.b=Q/ey9GsZ; arc=none smtp.client-ip=62.153.85.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emh-metering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emh-metering.com
Received: from pmg.emh-metering.com (localhost.localdomain [127.0.0.1])
	by pmg.emh-metering.com (Proxmox) with ESMTP id 6A70E201AF0;
	Thu, 30 Oct 2025 12:53:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	emh-metering.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:from:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=EMH; bh=1pCbYYq0xw
	hFd+v4MnGs/Q/HBgsOzi97lwLcKsdRuoA=; b=Q/ey9GsZH/kzevjsax/k06JGZ8
	vS7c6br4j7NWMNbnSLyHo/TuY2PNuaaozbI/frtiH5C85vIUmBLiB8yy6ADqaOQo
	2+yCh73/IWsZVFiVTbwbWPjgAKuoKGW0P+kR7GOhnapNvAUw27cQUYXSiLCBofLz
	1StkUwuz/6VcBzTA85ogd88pUIfemtbi+A6J8iVkfbxhv8b4117yFVwvO7Dp2sYN
	eDiZQthPeOZanKpOyyOIXq32/S1Q3I1abjmAtIbo17RNb95TlHYJXlrT1l7SFqcl
	PqvW1PHNZ8cAJ80MJbiermeN5qw81UhtaRNpXQt7P2Zl2NBeszmpMBrT/gMg==
From: "Krebs, Olaf" <Olaf.Krebs@emh-metering.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "open
 list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix IMX PWM period setting
Thread-Topic: [PATCH] Fix IMX PWM period setting
Thread-Index: AQHcSZLdiHZhs8PhqUSPCiSwKgl9I7TalByg
Date: Thu, 30 Oct 2025 11:53:27 +0000
Message-ID: <548dfa909f984868a62e04efc0c51bdf@emh-metering.com>
References: <20251030114641.4109598-1-user@jenkins>
In-Reply-To: <20251030114641.4109598-1-user@jenkins>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Olaf Krebs <okr@smgw.emh-meter.de>

We use 3 PWM channels to control an RGB LED. Without this patch, an BUSY-er=
ror message is generated during initialization.

[    7.395326] leds_pwm_multicolor led-controller: error -EBUSY: failed to =
set led PWM value for (null)
[    7.405167] leds_pwm_multicolor led-controller: probe with driver leds_p=
wm_multicolor failed with error -16

Our DTS-Config for an imx93-Board:
	...
	led-controller {
		compatible =3D "pwm-leds-multicolor";
		multi-led {
			label =3D "RGBled";
			color =3D <LED_COLOR_ID_RGB>;
			function =3D LED_FUNCTION_INDICATOR;
			max-brightness =3D <255>;
			led-red {
				pwms =3D <&tpm5 0 1000000 PWM_POLARITY_INVERTED>;
				color =3D <LED_COLOR_ID_RED>;
			};
			led-green {
				pwms =3D <&tpm6 2 1000000 PWM_POLARITY_INVERTED>;
				color =3D <LED_COLOR_ID_GREEN>;
			};
			led-blue {
				pwms =3D <&tpm5 1 1000000 PWM_POLARITY_INVERTED>;
				color =3D <LED_COLOR_ID_BLUE>;
			};
		};
	};
	...

Signed-off-by: Olaf krebs <olaf.krebs@emh-metering.com>
---
 drivers/pwm/pwm-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c index 5b=
399de16d60..411daa7711f1 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -190,7 +190,7 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
 		 * there are multiple channels in use with different
 		 * period settings.
 		 */
-		if (tpm->user_count > 1)
+		if ((tpm->user_count > 1) && (tpm->real_period !=3D 0))
 			return -EBUSY;
=20
 		val =3D readl(tpm->base + PWM_IMX_TPM_SC);
--
2.47.3



