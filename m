Return-Path: <linux-pwm+bounces-4106-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8089D262C
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 13:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4429B1F24673
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 12:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381E61CC8AD;
	Tue, 19 Nov 2024 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="XfaAxOt8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E81CBEBC;
	Tue, 19 Nov 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020811; cv=none; b=TbIfXgEw1cGfV5TfURtFbgAZbMRSWI9g4+YtB3k/DZs2rPgN3CQd3Z+Xe/1OY1bBEncJgDbpsWDK9khLWX62yd/aJqhjp285l1m9FvHNDXs8LxILN/BrT88qmc1NaAGdZIbfFI2WFos/TyIAAwhaZ0VlxQ8v2DGVSwTLanDrKew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020811; c=relaxed/simple;
	bh=z1qJmt+nNCOzp3ahO6UqRHWpOI8pCHCZDjYoNobDk74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXcB25j9wWL6kk6mQOm1ZMTAGfYcsYpCuSPsbGcBLF/V+NSfoPbZp8Hw37Duc8ehoF7zpB+phHniakGkdkOsIxp7umzQF+pD/QmKxhH+YMKCLJW5tKwcF0uoS8AlNzrqCGNar5ZhKv8fVsJWOBO+MPSSDs9h21ecJu/+f80iyvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=XfaAxOt8; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 08FD610000E;
	Tue, 19 Nov 2024 15:53:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 08FD610000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1732020807;
	bh=SlfMZQ4DgQrFKcas76Ke7AUU5dNNyOcvl5kzGZtWTCQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=XfaAxOt8xJL0o2bn3DElg0ZCWAij29HHkhbit0ttw7XFteLn4SLBOOabt9Utnrg9I
	 mvmE3/7E5yo5OC+7Fjqf4udXGCU4t4iAzLaLeokoP9hMl68/eByu7jIa4Si4E/dUdY
	 i2gkFFEWBUXx+o1Vu+bBxWr+5gaIOsM5huoaCx40/DohYEV6OrXAl1tQRgOMwij+Xx
	 9cSlxWWUKO1EgytpoeIzmSibeuvaJenxNFtz6XU35t02ZUZbbVDNC4OOiNKnazpJwa
	 Hrot9p1bJZufuaXF7KW3w5Sfa2Bq7wm1P7g6gLaUeJBeJbPYzSP5g/DrV57BEeXa/2
	 QHNemeT/uGfDQ==
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
Subject: [PATCH v3 4/4] pwm: meson: Enable constant and polarity features for g12, axg, s4
Date: Tue, 19 Nov 2024 15:53:18 +0300
Message-ID: <20241119125318.3492261-5-gnstark@salutedevices.com>
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

g12, axg and s4 SoC families support constant and polarity bits
so enable those features in corresponding chip data structs.

Signed-off-by: George Stark <gnstark@salutedevices.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pwm/pwm-meson.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 3cc48c3dde5e..806e06c2b92e 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -554,26 +554,36 @@ static const struct meson_pwm_data pwm_gxbb_ao_data = {
 static const struct meson_pwm_data pwm_axg_ee_data = {
 	.parent_names = { "xtal", "fclk_div5", "fclk_div4", "fclk_div3" },
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
+	.has_constant = true,
+	.has_polarity = true,
 };
 
 static const struct meson_pwm_data pwm_axg_ao_data = {
 	.parent_names = { "xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5" },
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
+	.has_constant = true,
+	.has_polarity = true,
 };
 
 static const struct meson_pwm_data pwm_g12a_ee_data = {
 	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
+	.has_constant = true,
+	.has_polarity = true,
 };
 
 static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
 	.parent_names = { "xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5" },
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
+	.has_constant = true,
+	.has_polarity = true,
 };
 
 static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
 	.parent_names = { "xtal", "g12a_ao_clk81", NULL, NULL },
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
+	.has_constant = true,
+	.has_polarity = true,
 };
 
 static const struct meson_pwm_data pwm_meson8_v2_data = {
@@ -582,10 +592,14 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
 
 static const struct meson_pwm_data pwm_meson_axg_v2_data = {
 	.channels_init = meson_pwm_init_channels_meson8b_v2,
+	.has_constant = true,
+	.has_polarity = true,
 };
 
 static const struct meson_pwm_data pwm_s4_data = {
 	.channels_init = meson_pwm_init_channels_s4,
+	.has_constant = true,
+	.has_polarity = true,
 };
 
 static const struct of_device_id meson_pwm_matches[] = {
-- 
2.25.1


