Return-Path: <linux-pwm+bounces-4103-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7D49D262A
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 13:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC871F246D1
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 12:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11B01CC8A0;
	Tue, 19 Nov 2024 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="keb1McVj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E8F14E2E2;
	Tue, 19 Nov 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020810; cv=none; b=DpNkb3TVwCdE9XfRarRP0ZN6Fv0VPW3W97MPx9uCymFbziu7dXWYc1h+O8RaR1G/cJQi5V1A+2Snw/61dsEzDb39ZhOb5at8v/Ew22RVOL5JiBc2mj5MpRWVxDR1TaCEV9KtoaydiPaSN9dJGcfPqBvp1sf9afvk8wJvMIDi0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020810; c=relaxed/simple;
	bh=9pwhsAOdX77X/LilUWMR1xrvHAySdz8MW6g7a0vVS1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGSGU8+NYCdexuJQo10Pt8SJF13xvIa5nIQ+qdlENvumcc9otqdPTlGUjQf0LKDV+YJ/omZb4cQX4LhPiZnwK3laeOG+Sclyc0Ztsi69geuDbU4PjFEhJD4sA/vBOK8g53B0dYvFbatDBJkR7iGGZmVi0Gdx68IzKYL8/QG/vs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=keb1McVj; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2FB1A10000A;
	Tue, 19 Nov 2024 15:53:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2FB1A10000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1732020806;
	bh=e4s53L2k5iK23hNWZ8+0hrRU9tNwL4Gmep/nSlXigqI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=keb1McVjYq5jn6y4fP69ixHEzgWpB64wdCFPO3w/uJR0IDd3zGhOeipCTFbyUfn5n
	 LEJBSuvL3+RwdS2GcFRVeDYlKp9GhoU2PXWAXuh31Pkb3SeoOJL3Bh+nP9trcc5xJ7
	 AVgkCKq21OdWRcu1urBJls2YHLy9OAgn28krh+1mXlX4JWaM90NbUAlQ2fxi/m/uME
	 VuY375fMYTUjiEG8NTE/Gn1GotqRRPCbWAV3n5Afqw5eIkN3EctaQfQkFmplMlqDla
	 TECyk6ylQTeEmO2+7ixX8pXuWunyi9Q1O6Qm6qSnlQ2aWdqYzfIZcYXC0EyNNb28sV
	 SNS/MaIGBqG+w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 19 Nov 2024 15:53:25 +0300 (MSK)
From: George Stark <gnstark@salutedevices.com>
To: <ukleinek@kernel.org>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH v3 1/4] pwm: meson: Simplify get_state() callback
Date: Tue, 19 Nov 2024 15:53:15 +0300
Message-ID: <20241119125318.3492261-2-gnstark@salutedevices.com>
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

In .get_state() callback meson_pwm_channel struct are used to store
lo and hi reg values but they are never reused after that so
for clearness use local variable instead.

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/pwm/pwm-meson.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 98e6c1533312..c4ee019ce577 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -309,21 +309,20 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel_data *channel_data;
-	struct meson_pwm_channel *channel;
+	unsigned int hi, lo;
 	u32 value;
 
-	channel = &meson->channels[pwm->hwpwm];
 	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
 
 	value = readl(meson->base + REG_MISC_AB);
 	state->enabled = value & channel_data->pwm_en_mask;
 
 	value = readl(meson->base + channel_data->reg_offset);
-	channel->lo = FIELD_GET(PWM_LOW_MASK, value);
-	channel->hi = FIELD_GET(PWM_HIGH_MASK, value);
+	lo = FIELD_GET(PWM_LOW_MASK, value);
+	hi = FIELD_GET(PWM_HIGH_MASK, value);
 
-	state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->lo + channel->hi);
-	state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
+	state->period = meson_pwm_cnt_to_ns(chip, pwm, lo + hi);
+	state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, hi);
 
 	state->polarity = PWM_POLARITY_NORMAL;
 
-- 
2.25.1


