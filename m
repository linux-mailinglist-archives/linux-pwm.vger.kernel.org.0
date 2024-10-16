Return-Path: <linux-pwm+bounces-3684-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6EB9A0E1D
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 17:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6581F28419B
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 15:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4838020F5A4;
	Wed, 16 Oct 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="RqWx/hQa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF6320E02C;
	Wed, 16 Oct 2024 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092373; cv=none; b=iN+q8N5Hxx0OCHMyDdWCFlbIJ24yalKopNbxpUG6yVgDCZlE5eIuA163TTyoWQoEJg5di5jJtK//BDD2VLDNnHreDBBRe4YUjVSEjHIgbjcXD5dghP4/oDJ0c67Q2BjegCYLyDKkO7eif87ebX+NecNiPVHwfsDn4ql0IEzCpAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092373; c=relaxed/simple;
	bh=SgaNbygPL1qlXvE283AqP8VRPTXMMLohWpoE+My0yQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rrg1RrV2H6Jaqi5iwOU4KWim/n/Lc/UhmLGiZQ58/o4D2AoGKNPoho+l8eW90Wp0S6Uax16V9QwkWv0HTosgu4PIQCxvhRoSs3N7nxBh7ZNWjY/4UOzBj8npEa84fu9QMWUu5wf3n5xzIySZs5h3UlTduSbxkw7hJ1AkbFXs5w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=RqWx/hQa; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 285FF100012;
	Wed, 16 Oct 2024 18:26:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 285FF100012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1729092361;
	bh=NL7Zfmi8yLx1Y81VddpKEj1YM5hXopU8fzyaFR15A60=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=RqWx/hQaagFTOTHQOLRK5PFkIPRcfxEMyRQCQFw98MnzDsjllYji6DgaS6jsPTEQN
	 /ylXw8KPHuX5tt30LXXuOfTsjtHtZLv05LBVFJCgEIFAMixfu2M4IHfW16CeFJ0MMb
	 3e/NsDhRfKrrOYFt852f6bgPr+kuvonmtU+wEV544hSczIsZOtdG6cU3eZnyQ8jMub
	 nA7aBT81aKGvV4X1O9Fm3K2WUaf2Uv2gB9D08vMq9d1KA0P5f/6afoPvFLJIALj/fw
	 D9Z0O8UfPF52qb/BuQ9AACA9x1K8DTQ3HL8ogPMqlGZMDcEoHFJDDVRh7CLRRXYOyT
	 oV7n5YM+ym22g==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 18:26:00 +0300 (MSK)
From: George Stark <gnstark@salutedevices.com>
To: <u.kleine-koenig@pengutronix.de>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH v2 1/4] pwm: meson: Simplify get_state() callback
Date: Wed, 16 Oct 2024 18:25:50 +0300
Message-ID: <20241016152553.2321992-2-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016152553.2321992-1-gnstark@salutedevices.com>
References: <20241016152553.2321992-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188482 [Oct 16 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/16 12:08:00 #26762169
X-KSMG-AntiVirus-Status: Clean, skipped

In .get_state() callback meson_pwm_channel struct are used to store
lo and hi reg values but they are never reused after that so
for clearness use local variable instead.

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/pwm/pwm-meson.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 98e6c1533312..2ef632caebcc 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -310,6 +310,7 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel_data *channel_data;
 	struct meson_pwm_channel *channel;
+	unsigned int hi, lo;
 	u32 value;
 
 	channel = &meson->channels[pwm->hwpwm];
@@ -319,11 +320,11 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
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


