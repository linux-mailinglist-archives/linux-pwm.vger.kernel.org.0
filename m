Return-Path: <linux-pwm+bounces-4517-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92689FC4DF
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Dec 2024 11:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08E91883852
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Dec 2024 10:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325A519F115;
	Wed, 25 Dec 2024 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Tw+qhIqh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2CE14A099;
	Wed, 25 Dec 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735124226; cv=none; b=O6jFkobAsH5BdRR1QT2w8l/LkOIsLz14wEg73okJE5JdvzZzLO5yngSjSPmDnQZ0sVojo9dlJUE6ZZhxla/9ekJE2MeDHNUtbZFfzq5E6Dl2znwjv4RwOmWcKqGPF9cUnFlnaRXME9PtFTgXLf8y+OifBPoqMqbW4wfd/D1Jw30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735124226; c=relaxed/simple;
	bh=J2I6q/uBOxD27e2SHqYXsFctYPzKPcHFnWRXTcZFbj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXBRo8zyeSR6sHJ+vkp4xMc7MvUAJ2dXJGffvcPOWQeOwbMuFQTDUEG35VKvvTiChZlAYjE5YY/lwONshk0FIT3VIL47FwXgbGpo4JTp7isSi4HMFc11lKnzofKPsoiWf+zT6PqAURnmwNfAa7+oZYC00ErUf70kdj1p7jki64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Tw+qhIqh; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6A0CF12002A;
	Wed, 25 Dec 2024 13:56:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6A0CF12002A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1735124212;
	bh=uNLnVR9vGF1ncRzwJjWhsdEqfpo2sCMhV9fziN1rC3U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Tw+qhIqhtXZKVdYg+E3R4KbFilIeYTsn0Jn83YP9bKnGS7GQM6/BHzX5e64dVGSm2
	 qUvtu43CMTcl6b3FDC/GMPpdKiWQGpAggLtStgtoLCtbLjz01xOToNJ8DZzf/VAAdI
	 ItkXS8orYrEaYPzeq32SWCwMCsgx3+AfWfOf4NU1bTGfa6MOnGvuwtuBMp6k4SBg/P
	 HLlGB5l/uuDqVNMJn+A1JPnMN9ZsHhSPwacGqyv/zr4/H1X9Hpm9TyomehbSNRyLup
	 cuCDH6Q8XTiU1wGfuGzobRJRliuHiA1GY5t89IBVb0PJMmF78Pcf5YyPRtrf7gSGSV
	 E2ICJbVVv2UhA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 25 Dec 2024 13:56:52 +0300 (MSK)
From: George Stark <gnstark@salutedevices.com>
To: <ukleinek@kernel.org>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH 1/2] pwm: meson: Simplify meson_pwm_cnt_to_ns()
Date: Wed, 25 Dec 2024 13:56:38 +0300
Message-ID: <20241225105639.1787237-2-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241225105639.1787237-1-gnstark@salutedevices.com>
References: <20241225105639.1787237-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190053 [Dec 25 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49 28b3b64a43732373258a371bd1554adb2caa23cb, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/12/25 07:56:00 #26914998
X-KSMG-AntiVirus-Status: Clean, skipped

meson_pwm_cnt_to_ns() uses clock rate got from clk_get_rate(). clk object
is getting from driver's private data thru several steps. Since
meson_pwm_cnt_to_ns() is called several times from a single scope it's
easier to get clock rate once and pass it as parameter.

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/pwm/pwm-meson.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 806e06c2b92e..8c6bf3d49753 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -331,21 +331,9 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
-static u64 meson_pwm_cnt_to_ns(struct pwm_chip *chip, struct pwm_device *pwm,
-			       u32 cnt)
+static u64 meson_pwm_cnt_to_ns(unsigned long fin_freq, u32 cnt)
 {
-	struct meson_pwm *meson = to_meson_pwm(chip);
-	struct meson_pwm_channel *channel;
-	unsigned long fin_freq;
-
-	/* to_meson_pwm() can only be used after .get_state() is called */
-	channel = &meson->channels[pwm->hwpwm];
-
-	fin_freq = clk_get_rate(channel->clk);
-	if (fin_freq == 0)
-		return 0;
-
-	return div64_ul(NSEC_PER_SEC * (u64)cnt, fin_freq);
+	return fin_freq ? div64_ul(NSEC_PER_SEC * (u64)cnt, fin_freq) : 0;
 }
 
 static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -353,10 +341,12 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel_data *channel_data;
+	unsigned long fin_freq;
 	unsigned int hi, lo;
 	u32 value;
 
 	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
+	fin_freq = clk_get_rate(meson->channels[pwm->hwpwm].clk);
 
 	value = readl(meson->base + REG_MISC_AB);
 	state->enabled = value & channel_data->pwm_en_mask;
@@ -370,8 +360,8 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	lo = FIELD_GET(PWM_LOW_MASK, value);
 	hi = FIELD_GET(PWM_HIGH_MASK, value);
 
-	state->period = meson_pwm_cnt_to_ns(chip, pwm, lo + hi);
-	state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, hi);
+	state->period = meson_pwm_cnt_to_ns(fin_freq, lo + hi);
+	state->duty_cycle = meson_pwm_cnt_to_ns(fin_freq, hi);
 
 	return 0;
 }
-- 
2.25.1


