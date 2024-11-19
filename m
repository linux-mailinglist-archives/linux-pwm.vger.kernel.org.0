Return-Path: <linux-pwm+bounces-4102-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 381739D2629
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 13:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED93D28726D
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 12:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D881CC179;
	Tue, 19 Nov 2024 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="J2QL3Mac"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F4B1CBE98;
	Tue, 19 Nov 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020810; cv=none; b=gJsthVtcHVfgUgFNcW61GF2qbCccnn15PQNK2lv9Us4lqzIUHajflCNvIdm3Otao21Ej90zZMFLaA0ANTJZ/j43nizvrXUJOogsW0rQ6tGkizyOE/XhxZq4Jf4BpKevIs+I+aL+v1QDsUFKv0FeFZZ3MLuUSjHjeTPu6ixe30rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020810; c=relaxed/simple;
	bh=Q1ilrJjWDJ4+Ex+VxLNUTo9k+NBDo1LseJpkC1syAZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqFNyhlMX2izgKZ20a4YxaKWdVHoBoE0UqOpz2GPSENq9bv3MIjzpwrr5aK+vghBKfLJFle8PJPZGaQbx89Ra4Bten0e8nkQrRFmn9uDhwn82wyYydWM5fjbT5N9p655pVlk8zZSUM7vvoMml7nSGTnKmhg+gdAh8y+1VVONwps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=J2QL3Mac; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id CA5DF10000D;
	Tue, 19 Nov 2024 15:53:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CA5DF10000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1732020806;
	bh=059kkIYqpn0ehFSmAg/GBS0dpyJTqN0Io9RSk7P5TWk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=J2QL3MacK0LO38lqp+Mn2nOqlMhnD3C5Jy3wWygH3YzHN+LdkY4ng5B6CcFHdTW8K
	 83SlWByFK9r9t2i/V/mDjXSlvMlApCd25GkRsM56zvM5lNaQACeKUYUExAF8k2E+xV
	 1kUuX6C6/mmNcI7F4lJnShg7tiVhpfhMtoOn6dmTWbDOQOTw8jYJ3CvBomCTwko48G
	 PN5t1KtnArh+fYjgrAxqPUehQmSpy8I1+/bmRF6c4BoZXQ81osIg6zuUvsB5Ak2+Yg
	 quWYJ3owHbkOpxpTC0X+cqh4UQQn7ApruiosqAJ5hMhAvtXO+wEfOXy4JpiZQ28InJ
	 AFetk3gw5NdGg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 19 Nov 2024 15:53:26 +0300 (MSK)
From: George Stark <gnstark@salutedevices.com>
To: <ukleinek@kernel.org>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH v3 3/4] pwm: meson: Use separate device id data for axg and g12
Date: Tue, 19 Nov 2024 15:53:17 +0300
Message-ID: <20241119125318.3492261-4-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241119125318.3492261-1-gnstark@salutedevices.com>
References: <20241119125318.3492261-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189267 [Nov 19 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/19 08:41:00 #26886618
X-KSMG-AntiVirus-Status: Clean, skipped

Add separate devce id data for compatibles: amlogic,meson-g12a-ee-pwm,
amlogic,meson-axg-pwm-v2, amlogic,meson-g12-pwm-v2 due to those PWM
modules have different set of features than meson8.

Signed-off-by: George Stark <gnstark@salutedevices.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pwm/pwm-meson.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index d7335efa3db7..3cc48c3dde5e 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -561,6 +561,11 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
 };
 
+static const struct meson_pwm_data pwm_g12a_ee_data = {
+	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
+	.channels_init = meson_pwm_init_channels_meson8b_legacy,
+};
+
 static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
 	.parent_names = { "xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5" },
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
@@ -575,6 +580,10 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
 	.channels_init = meson_pwm_init_channels_meson8b_v2,
 };
 
+static const struct meson_pwm_data pwm_meson_axg_v2_data = {
+	.channels_init = meson_pwm_init_channels_meson8b_v2,
+};
+
 static const struct meson_pwm_data pwm_s4_data = {
 	.channels_init = meson_pwm_init_channels_s4,
 };
@@ -584,6 +593,14 @@ static const struct of_device_id meson_pwm_matches[] = {
 		.compatible = "amlogic,meson8-pwm-v2",
 		.data = &pwm_meson8_v2_data
 	},
+	{
+		.compatible = "amlogic,meson-axg-pwm-v2",
+		.data = &pwm_meson_axg_v2_data
+	},
+	{
+		.compatible = "amlogic,meson-g12-pwm-v2",
+		.data = &pwm_meson_axg_v2_data
+	},
 	/* The following compatibles are obsolete */
 	{
 		.compatible = "amlogic,meson8b-pwm",
@@ -607,7 +624,7 @@ static const struct of_device_id meson_pwm_matches[] = {
 	},
 	{
 		.compatible = "amlogic,meson-g12a-ee-pwm",
-		.data = &pwm_meson8b_data
+		.data = &pwm_g12a_ee_data
 	},
 	{
 		.compatible = "amlogic,meson-g12a-ao-pwm-ab",
-- 
2.25.1


