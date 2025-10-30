Return-Path: <linux-pwm+bounces-7534-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AC6C1F28D
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 09:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D233B3ADA9A
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 08:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80DC335BAF;
	Thu, 30 Oct 2025 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emh-metering.com header.i=@emh-metering.com header.b="Bw59v1gN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from pmg.emh-metering.com (pmg.emh-metering.com [62.153.85.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2C532D0E2;
	Thu, 30 Oct 2025 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.153.85.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814629; cv=none; b=TSmzvZ4gEa3gyxU7YyYX/d+EpbA3rIpCAvkARoXcM7QwjNOyQ/27GcKy33ZZnl1NGcgPTJhEJPOW+ENkzVun23sXHxjxVHtpHDvlNxphOYV5dMCrxCfsEyLQ5GJHrGjmx2JbeV1Q+q4bcYC97DUtbCK8RC6o/7gw0hMKIo1m1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814629; c=relaxed/simple;
	bh=0r3JH/OKc/obMtkwojem6t6BoX7GyuazF9lJiH+WOzc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j0nb0xyUJ1DPBuZ556fWBOe3fMhVcsiOHPEc/KPP2NzZ1B09uHMDnrfm3HB32AtUzlIGzwBWXdS3IjrdiV+U6yItOXZGLvn8XInv+7+9H2BXQH89DmfQ7z5xnfX/GfVhwN1EHhfaHX8jLTnJAjhYWKYg+rTJ1Okh0NdXMeMIayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emh-metering.com; spf=pass smtp.mailfrom=emh-metering.com; dkim=pass (2048-bit key) header.d=emh-metering.com header.i=@emh-metering.com header.b=Bw59v1gN; arc=none smtp.client-ip=62.153.85.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emh-metering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emh-metering.com
Received: from pmg.emh-metering.com (localhost.localdomain [127.0.0.1])
	by pmg.emh-metering.com (Proxmox) with ESMTP id 2E088201A2B;
	Thu, 30 Oct 2025 09:51:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	emh-metering.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:from:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=EMH; bh=MHQiv9s65d
	po7FDHmAP6xWP3YKRgmxyddilHRLa35UM=; b=Bw59v1gNBZSiPl3Mo91zylHTR0
	Z0arcUb+nLgdab2KDuPkoC4Za4CNhc55VGbBNKnQYw49qJrZ8MnBqYMcJ5DThUtk
	EGI2gi5AkG6GbK410FTCFBnMGtWq03/hfIWzJoRFV8kP+cgLG0WRS9u0LB4LYhcO
	sUeO98N+sOyDz86Wb7Ko1TcFbqWUYWiAUXoQQwb/x6W39+FnutNj9mM8HreuKxLY
	93I8YQx7EMtFjlCp0kZC+/1WnQLZzY8ieKYKCp3QgVaJhSI3o6gc9SnFPEnIBuMq
	ORsGKMbK5owlLdPjzGAn9rGh58FRw3kTrQBw3K18MYVzoBSXOr1CbOpBsC9w==
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
Thread-Index: AQHcSXnStwBUqBV5nkubIW1yr2rgX7TaYM8g
Date: Thu, 30 Oct 2025 08:51:20 +0000
Message-ID: <c26fde7dff3a41ff9f7e6c97e2a31801@emh-metering.com>
References: <20251030084727.4098222-1-user@jenkins>
In-Reply-To: <20251030084727.4098222-1-user@jenkins>
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

From: Olaf krebs <olaf.krebs@emh-metering.com>

We use 3 PWM channels to control an RGB LED. Without this patch we get an e=
rror:

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
399de16d60..82db43f56da8 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -190,7 +190,7 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
 		 * there are multiple channels in use with different
 		 * period settings.
 		 */
-		if (tpm->user_count > 1)
+		if ((tpm->user_count > 1) && (tmp->real_period !=3D 0))
 			return -EBUSY;
=20
 		val =3D readl(tpm->base + PWM_IMX_TPM_SC);
--
2.43.0



