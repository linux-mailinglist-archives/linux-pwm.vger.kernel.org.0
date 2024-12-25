Return-Path: <linux-pwm+bounces-4515-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1AE9FC4DC
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Dec 2024 11:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A6D1882FC1
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Dec 2024 10:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7520C18C03E;
	Wed, 25 Dec 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="rVTEioeG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2811487DD;
	Wed, 25 Dec 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735124225; cv=none; b=rCIbIhMwByMv11KFeKqsTIhpoEVWqRCj7tn10BCor7KBBtFyBALYfmOjWF0PCzvA2RdRGQ19GbTcDhS2wfpRB/K7HBZZdakHMVdPVCG2s54RG/4KP4VkEEXmON++exv2zHDSj0Pf+Nz7RDGi88kbnpn+jx8nH+aVhK+t3OLVm0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735124225; c=relaxed/simple;
	bh=V75VB1eXLoWsiHGmf+F4GWH3zBdYnxAxPQiGAFWJlKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWn8MogsooTJg7k28OZGsTzau1w4YwXQfTF35MsvYw65bJeS9XtADqrC3m1vk4IwrgHs59VXCPckMONjQ+4RlFECuj18AayPrv6f1yfSAic/WsJbhz2rBF2cDegka4YDM026vMFQDWLAy5j5o8ygKdZx6af4yjooeZVjxnxKuFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=rVTEioeG; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 939BC12002B;
	Wed, 25 Dec 2024 13:56:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 939BC12002B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1735124212;
	bh=dHd86CgFN+A0zZ482ESQ0Jwc5FHNViFNXh8Giwjs8PQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=rVTEioeGm71YqPhpX6WvJeRaZD0VCWAfZyZQaGLovEYa72qV64beApDHYZHMkhFKK
	 IJDIJML4sHbedxxuVXVRroGwCy9vMV5QHL55WGmAH4ojaQgQOKFoS4tzcicpAGy6ye
	 PaxWVKrP6u3uq/D19yvylTSz7nMwJ+mbaoSPTgXFiBKaOMQYTZylPtdK2z34p5/WSl
	 EzsynvzUnpiQyBOJ1B3pIeae+xIpukOalEZGFfpBsZZl+gB4mmTCo43BVXEAMg/qhd
	 7iYFBAaVFbb95tf0y07OP4AJvApJOSBbENU/uDjhampMSBj0IEr3XZX1Bz4d1CBgct
	 MwRLigBn2rIGg==
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
Subject: [PATCH 2/2] pwm: meson: Fix computing counter register
Date: Wed, 25 Dec 2024 13:56:39 +0300
Message-ID: <20241225105639.1787237-3-gnstark@salutedevices.com>
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

High and low values in the counter register are incremented by 1
internally unless they a zero and constant bit is supported and set.
So decrement by 1 calculated high and low PWM periods before applying.

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/pwm/pwm-meson.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 8c6bf3d49753..51839936ec89 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -214,6 +214,15 @@ static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
 		channel->hi = duty_cnt;
 		channel->lo = cnt - duty_cnt;
 		channel->constant = false;
+
+		/*
+		 * hi and low reg values are incremented by 1 internally
+		 * unless they are zero and constant bit is set
+		 */
+		if (channel->hi)
+			channel->hi--;
+		if (channel->lo)
+			channel->lo--;
 	}

 	channel->rate = fin_freq;
@@ -342,6 +351,7 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel_data *channel_data;
 	unsigned long fin_freq;
+	bool const_enabled;
 	unsigned int hi, lo;
 	u32 value;

@@ -356,10 +366,16 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		state->polarity = PWM_POLARITY_NORMAL;

+	const_enabled = meson->data->has_constant &&
+		(value & channel_data->const_en_mask);
+
 	value = readl(meson->base + channel_data->reg_offset);
 	lo = FIELD_GET(PWM_LOW_MASK, value);
 	hi = FIELD_GET(PWM_HIGH_MASK, value);

+	lo += (const_enabled ? !!lo : 1);
+	hi += (const_enabled ? !!hi : 1);
+
 	state->period = meson_pwm_cnt_to_ns(fin_freq, lo + hi);
 	state->duty_cycle = meson_pwm_cnt_to_ns(fin_freq, hi);

--
2.25.1


