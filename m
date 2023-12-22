Return-Path: <linux-pwm+bounces-630-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1BE81C8EE
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Dec 2023 12:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC421F239C1
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Dec 2023 11:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A651799C;
	Fri, 22 Dec 2023 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vJjotAoy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1BA17743
	for <linux-pwm@vger.kernel.org>; Fri, 22 Dec 2023 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33621d443a7so1669488f8f.3
        for <linux-pwm@vger.kernel.org>; Fri, 22 Dec 2023 03:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1703243844; x=1703848644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZCJsoLyOmkKAX7ht3HFrFwteoJzV+g0RP8tYskDzk0=;
        b=vJjotAoyDQ3F/5BJUpAJdwYUiyMC2iXRtAB1GeadokLFCRyX5kXc2z3zOC8eGvP/xZ
         WHtmeCETuL+3sWxbY4afqSuJxc+nFlb23tF4j+r0lxl59ByAHpQi1fL2kTme5FG77x+s
         TkTVxY6DZGmQf89TQepvVJv1FfRMv+Becrg6n55CMD4wsJ3lznlWxTXporSn+r78greH
         l+0kX+VYUEnBVnDSWkUMBMPxpfZccfzotYjcgBeWSBsg0CQRCK3kHpGOzno9ykMiFyuM
         fCtHvMLEBaMfVFygKBxw4Os2Iuy2DhgjY55UQnicf3DV8LSjcaWQfc35r2cfgpnxP+VG
         r9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703243844; x=1703848644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZCJsoLyOmkKAX7ht3HFrFwteoJzV+g0RP8tYskDzk0=;
        b=r5VKpTqAVPzpKWCngG1+Z6sS3VwbEIHwiAys9eQpZm8BCl33goMg2taDHo0PuZqXnO
         aH4nU3JsNI8EgAm1D0JC/RDuMB3gmP0bEVVz7utx0ddVHtH9ONHbcW2BS91/hwUeyOWA
         XGJbVuQExOCvOLpronZmhfmqC4QjCVp4mpiIiOmMHvqe+4M3g68fz5Qmxk236NKXjYs1
         8j50mkZ54HDEhyPFF8VTKvFuQq/mmWbSC8WDDutfQR1Wppabw2IC2UdYF7PRC7bhMh3C
         30HsWPnYdEbuZLLRS6QSnvSANpztMliIxmMc4rdWLeXEOVUyS9p8hFD4+BCQymz69tY7
         lgcA==
X-Gm-Message-State: AOJu0YwxNlxUbZtgx/2WrfoMXMpU5IgH2PKh2mfQ0hk4iSQDYNyl/xS0
	GgnkgAHR/bOGB9dPtHPBbv6sqx1EkIVwvCUUeF8a4Yo3H5s=
X-Google-Smtp-Source: AGHT+IFBwoFjDZf5fns9Sf1GHZi6C2BjjIZEfE1cXFlQtPWX5Mn0XqjoNSMIEs9vr+cUQbzVBD/2/w==
X-Received: by 2002:a05:6000:1b07:b0:336:5d2f:3503 with SMTP id f7-20020a0560001b0700b003365d2f3503mr667803wrz.62.1703243844210;
        Fri, 22 Dec 2023 03:17:24 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:c099:e596:3179:b0fa])
        by smtp.googlemail.com with ESMTPSA id f8-20020adffcc8000000b003366b500047sm4054069wrs.50.2023.12.22.03.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:17:23 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	JunYi Zhao <junyi.zhao@amlogic.com>
Subject: [PATCH v4 3/6] pwm: meson: generalize 4 inputs clock on meson8 pwm type
Date: Fri, 22 Dec 2023 12:16:51 +0100
Message-ID: <20231222111658.832167-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231222111658.832167-1-jbrunet@baylibre.com>
References: <20231222111658.832167-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Meson8 pwm type always has 4 input clocks. Some inputs may be grounded,
like in the AO domain of some SoCs.

Drop the parent number parameter and make this is constant.
This is also done to make addition of generic meson8 compatible easier.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 2971bbf3b5e7..ef50c337f444 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -60,7 +60,7 @@
 #define MISC_A_EN		BIT(0)
 
 #define MESON_NUM_PWMS		2
-#define MESON_MAX_MUX_PARENTS	4
+#define MESON_NUM_MUX_PARENTS	4
 
 static struct meson_pwm_channel_data {
 	u8		reg_offset;
@@ -98,7 +98,6 @@ struct meson_pwm_channel {
 
 struct meson_pwm_data {
 	const char * const *parent_names;
-	unsigned int num_parents;
 };
 
 struct meson_pwm {
@@ -343,7 +342,6 @@ static const char * const pwm_meson8b_parent_names[] = {
 
 static const struct meson_pwm_data pwm_meson8b_data = {
 	.parent_names = pwm_meson8b_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_meson8b_parent_names),
 };
 
 /*
@@ -351,12 +349,11 @@ static const struct meson_pwm_data pwm_meson8b_data = {
  * The last 2 are grounded
  */
 static const char * const pwm_gxbb_ao_parent_names[] = {
-	"xtal", "clk81"
+	"xtal", "clk81", NULL, NULL,
 };
 
 static const struct meson_pwm_data pwm_gxbb_ao_data = {
 	.parent_names = pwm_gxbb_ao_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_gxbb_ao_parent_names),
 };
 
 static const char * const pwm_axg_ee_parent_names[] = {
@@ -365,7 +362,6 @@ static const char * const pwm_axg_ee_parent_names[] = {
 
 static const struct meson_pwm_data pwm_axg_ee_data = {
 	.parent_names = pwm_axg_ee_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_axg_ee_parent_names),
 };
 
 static const char * const pwm_axg_ao_parent_names[] = {
@@ -374,7 +370,6 @@ static const char * const pwm_axg_ao_parent_names[] = {
 
 static const struct meson_pwm_data pwm_axg_ao_data = {
 	.parent_names = pwm_axg_ao_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_axg_ao_parent_names),
 };
 
 static const char * const pwm_g12a_ao_ab_parent_names[] = {
@@ -383,16 +378,14 @@ static const char * const pwm_g12a_ao_ab_parent_names[] = {
 
 static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
 	.parent_names = pwm_g12a_ao_ab_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_g12a_ao_ab_parent_names),
 };
 
 static const char * const pwm_g12a_ao_cd_parent_names[] = {
-	"xtal", "g12a_ao_clk81",
+	"xtal", "g12a_ao_clk81", NULL, NULL,
 };
 
 static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
 	.parent_names = pwm_g12a_ao_cd_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_g12a_ao_cd_parent_names),
 };
 
 static const struct of_device_id meson_pwm_matches[] = {
@@ -434,13 +427,13 @@ MODULE_DEVICE_TABLE(of, meson_pwm_matches);
 
 static int meson_pwm_init_channels(struct meson_pwm *meson)
 {
-	struct clk_parent_data mux_parent_data[MESON_MAX_MUX_PARENTS] = {};
+	struct clk_parent_data mux_parent_data[MESON_NUM_MUX_PARENTS] = {};
 	struct device *dev = meson->chip.dev;
 	unsigned int i;
 	char name[255];
 	int err;
 
-	for (i = 0; i < meson->data->num_parents; i++) {
+	for (i = 0; i < MESON_NUM_MUX_PARENTS; i++) {
 		mux_parent_data[i].index = -1;
 		mux_parent_data[i].name = meson->data->parent_names[i];
 	}
@@ -456,7 +449,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 		init.ops = &clk_mux_ops;
 		init.flags = 0;
 		init.parent_data = mux_parent_data;
-		init.num_parents = meson->data->num_parents;
+		init.num_parents = MESON_NUM_MUX_PARENTS;
 
 		channel->mux.reg = meson->base + REG_MISC_AB;
 		channel->mux.shift =
-- 
2.42.0


