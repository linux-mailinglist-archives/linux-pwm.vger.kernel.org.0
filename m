Return-Path: <linux-pwm+bounces-7579-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E2BC2A3AC
	for <lists+linux-pwm@lfdr.de>; Mon, 03 Nov 2025 07:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D669A347EF8
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Nov 2025 06:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF7B20E702;
	Mon,  3 Nov 2025 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emh-metering.com header.i=@emh-metering.com header.b="ei12Vmxg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from pmg.emh-metering.com (pmg.emh-metering.com [62.153.85.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D081D416E;
	Mon,  3 Nov 2025 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.153.85.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762152632; cv=none; b=cbVyN2kXKeIOMcX3UerNwYDQV5en3QfF0StJ2HkVPCLKy83c/wzzMxfkL2sPJzwZrcyvHe6uujONpKsT5f2YLBLZm9+yQNtF80njOZ/cMDKC1ecoKVLmyjbRnHq5MgLf7dNe2QhdiNw301Np3WcFvvqK4ko70vYkApxxY2kZLf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762152632; c=relaxed/simple;
	bh=YlYPpkNMv1k/7qhVYm/6KIJE4qBuiONsX4rIdUOhzng=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i5R3t6a5Ife8Mvo6M2Is/8gNz26Hp0GJ8Y1b2mSdSgFqNAsRynNf9CFElEZD227EXbhGRAJba7OxJ5TjDAv93yO60eKqnqxF1u8ldIAPPZKT/XmOkJRwVR6+5acjVROJfsa77Kx2Vv4N6ICz9NwV6J2nCQ2PgI3VsJmmGW3FFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emh-metering.com; spf=pass smtp.mailfrom=emh-metering.com; dkim=pass (2048-bit key) header.d=emh-metering.com header.i=@emh-metering.com header.b=ei12Vmxg; arc=none smtp.client-ip=62.153.85.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emh-metering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emh-metering.com
Received: from pmg.emh-metering.com (localhost.localdomain [127.0.0.1])
	by pmg.emh-metering.com (Proxmox) with ESMTP id 79533201269;
	Mon, 03 Nov 2025 07:50:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	emh-metering.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:from:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=EMH; bh=EB2O6kTVDp
	xjxa6R1ervwAhb64BXCh6IFZiwSALTWaw=; b=ei12VmxgEys3hOhNzAqfWfZpUW
	e8SIzsI7bzqQyiatL4os7UmgkilXHKCXIh0JLH3bQzfuxkMTU1zMfBPTcJwDOCRd
	ReqAWzJuwjoWpCIwpYxc7M8wmtawa71/EORM6NFxDYV2lvN/bNuuFZYHcpHP3KG6
	6lrUHsAPhzYD6YsWhRBEVgSBEdtTelGtaEqbq8nBJ8X8pfdmOswTIzwqH41ab1De
	zKV95vvd+svWUeJhbVNsJKCQVC+LPinj5x6LfvN6F3KLHhPElDpRk0I5kjyakx12
	pnqvuFEGXZGflaKwXb9esY/JU3FqffrOvbmyrW87UJOk3aPxhDmdq0wDrBlg==
From: "Krebs, Olaf" <Olaf.Krebs@emh-metering.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3] Fix IMX PWM period setting
Thread-Topic: [PATCH v3] Fix IMX PWM period setting
Thread-Index: AQHcTI3pZaT6LbFQuk2XOLVoRSV617TggtSg
Date: Mon, 3 Nov 2025 06:50:20 +0000
Message-ID: <1b071599b84c4519a81990fbfe09782b@emh-metering.com>
References: <20251103064813.522840-1-user@jenkins>
In-Reply-To: <20251103064813.522840-1-user@jenkins>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Olaf Krebs <okr@smgw.emh-meter.de>

If a second PWM is requested by a driver before the first is configured, tr=
ying to configure any of these results in .user_count > 1 and thus the conf=
iguration fails.
Fix that by only erroring out by additionally checking if the period is act=
ually configured.

Exapmle: Using of 3 PWM channels to control a RGB LED.

DTS-Config for an imx93-Board:
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

Without this patch, an BUSY-error message is generated during initializatio=
n.

[    7.395326] leds_pwm_multicolor led-controller: error -EBUSY: failed to =
set led PWM value for (null)
[    7.405167] leds_pwm_multicolor led-controller: probe with driver leds_p=
wm_multicolor failed with error -16

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



