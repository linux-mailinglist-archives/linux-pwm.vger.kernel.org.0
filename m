Return-Path: <linux-pwm+bounces-3516-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA060993763
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2024 21:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6517E1F2236C
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2024 19:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6FA1DE2A6;
	Mon,  7 Oct 2024 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Up/f+KOU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412611DE2B0;
	Mon,  7 Oct 2024 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329549; cv=none; b=hmcphLfiKh5utwKXnK+Q9UpBBQE9/ulGu5MfqjySqFlnI4ctwTgLYKLdT2WCRD8UZQ3nM2sMBrlHUeb8n7hkLZNnVLVkOg5+SciIa0agk8UgiHIqOhJ4AxvqyzIc4ehvUKxA1X7H8G4SxeBtPKrH4KHiYbZB88bP2675P6fSfcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329549; c=relaxed/simple;
	bh=RlyQsLLqETUySqaWFyZbNKKGu2VI1lOlntvUAnlpzRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maKSj9HcW6uALdc1I5gRGbPHbprK8pHq0Ln1Ztr/QK7DjoTzoFmqPgYuECQKnL5Zz7TXeoxqw8VZO0tSO7h0488pmmfHf6NYfmm8kTYzl998WKtav7cP48lpirulYFPIhzoEmOp19rZK2E6+cUGJtU5tR5oOZycj17f3LPq/6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Up/f+KOU; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B0EDE120012;
	Mon,  7 Oct 2024 22:32:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B0EDE120012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728329531;
	bh=h07xMRo79t9BDqK2U7E8zsHG7AI21nJZGqYv+D883f8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Up/f+KOU0JMgy+NoT01VK0xEX8f4CYJJG46N8jslqlXinJ/s52lxJpvS6dGcmgmvw
	 xWcXHjW3PsdDEwq3UpISlz14a/xfu7o3/W2y9AeihE9RKYnXlw7Gb5HBISxtUMWDuI
	 2WZ9xkkzZtGxyHHbLYCDNE/agtRzjxIaEUEOacoiU/ulPC0Bp+iWP2qwp2ZgP+z77u
	 9UZHTz6YYlgWi/wAZdzfb/j3wHzU931Xggfxe205Z5ql/KfzKMZ9SDQGPAHFYiAVau
	 987wPq3MadREpxRi7jvPtwx3N1+EhCVXE0qOvFi9HAmYTtJ3HwlNRXMy3O77I8VtOc
	 n9TP+5UKyQadw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  7 Oct 2024 22:32:11 +0300 (MSK)
From: George Stark <gnstark@salutedevices.com>
To: <u.kleine-koenig@pengutronix.de>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH 2/3] pwm: meson: Use separate chip data struct for g12a-ee-pwm
Date: Mon, 7 Oct 2024 22:32:02 +0300
Message-ID: <20241007193203.1753326-3-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241007193203.1753326-1-gnstark@salutedevices.com>
References: <20241007193203.1753326-1-gnstark@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 188276 [Oct 07 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/07 17:50:00 #26714324
X-KSMG-AntiVirus-Status: Clean, skipped

PWM module of g12a SoC family has different set of features than meson8
so use separate chip data struct for it.

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/pwm/pwm-meson.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 5d51404bdce3..6701738c55e3 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -578,6 +578,11 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
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
@@ -624,7 +629,7 @@ static const struct of_device_id meson_pwm_matches[] = {
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


