Return-Path: <linux-pwm+bounces-3517-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 112FD993781
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2024 21:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0532829E5
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2024 19:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0551DE3AC;
	Mon,  7 Oct 2024 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="gdmlOQcn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA32A1DE2A6;
	Mon,  7 Oct 2024 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329865; cv=none; b=fwhjv8q/mJDDyzcWKK/xrERgWxPUaiEWfu/+Gooc3jEEhyS60L8IfVZWTnSiptVBmkKb7/BLlrcEok4Lj2l3/vAgzonDGGogvSAp3D8pDqyQNoLnrxzdE4k2bXpTLOmJpohSgZgWcYmT0pnnqSmPaGNlVVBDsaY+rbq0Ova5RMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329865; c=relaxed/simple;
	bh=moA8QgFj7cqt526ZShQi2VFh3BHtKO7P/uYlusbxw+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGK+RVfl6/GIDFLtyLno8KpE5og4aqlB6GDdAQSBwd5+dWB31U8e98t1QoRgv0WP3huTXI4E7jokm21Ysz60XpWx8XXcFidHdc0/olz/fCG9qBw+xX3atGIfZUyKFYLbqDVZheVhReEdAkLz2PwFKlP2UGuIM30XYdrryh/D+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=gdmlOQcn; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id EA44810000C;
	Mon,  7 Oct 2024 22:32:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru EA44810000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728329531;
	bh=JJ23VCJzDOZTr2V6x1enTRhokP19rysAyyD6vIuZ+ys=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=gdmlOQcn/wWaHGlTSWkXrGCI2dhv99T3tV30ubn9XEDCXSo3c4fGmOtut4td3n5P9
	 /U8tp92h5fxr3nmgpNMVGGd61MCP3cD5LWWXyhspyQZDKJg8FtT78xXxWLS9zpjjBa
	 dk+ARcrsmFswgHuJL5GWCbZp701xPkFq7iQWsq/GiIuE8lK0lz5O+24l7bAjNTnQA1
	 /iqcJ7bW2eVf8WQcGuU5Kt4JG3nAV9xlSM882lWZU7UitBw2ogLBwSsf5LtQ1Elqkw
	 xfDLwBy6h7/oNM0uVUbRG44FxW8BiUO3ALNs76UQy0I1IE//79QkwfSufvhn/hCY0V
	 jGyoQql3XW+sA==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
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
Subject: [PATCH 3/3] pwm: meson: Enable constant and polarity features for g12, axg, s4
Date: Mon, 7 Oct 2024 22:32:03 +0300
Message-ID: <20241007193203.1753326-4-gnstark@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 188277 [Oct 07 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/07 17:50:00 #26714324
X-KSMG-AntiVirus-Status: Clean, skipped

g12, axg and s4 SoC families support constant and polarity bits so enable
those features in corresponding chip data structs.

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/pwm/pwm-meson.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 6701738c55e3..c6f032bdfe78 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -571,26 +571,36 @@ static const struct meson_pwm_data pwm_gxbb_ao_data = {
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
@@ -599,6 +609,8 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
 
 static const struct meson_pwm_data pwm_s4_data = {
 	.channels_init = meson_pwm_init_channels_s4,
+	.has_constant = true,
+	.has_polarity = true,
 };
 
 static const struct of_device_id meson_pwm_matches[] = {
-- 
2.25.1


