Return-Path: <linux-pwm+bounces-3907-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B9F9B1565
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Oct 2024 08:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226831C210BE
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Oct 2024 06:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8208815D5A1;
	Sat, 26 Oct 2024 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tFs7N6QD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6859C217F2E;
	Sat, 26 Oct 2024 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729924383; cv=none; b=im1HcXQQeweKs+xWF3jr97p2nVODG1VCYEB7OWTcBvibWv1PiU4HxEn256y7LUzSTVHiifES/PtwK/2DjYpkGRqMALzgLiSukWmZetgXT0VxkOWg4AI8rkLbIHCF/YKSk0o/c/r0CcOJ4iSn+L9q/gsmHfBcwjafBdFMW9rLI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729924383; c=relaxed/simple;
	bh=agr57+TwKsLYZRR5ZaPF7RExp8eb0fp9/mzsJ9nUsqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5gsYzFz16/NnWY0wqUy+UrUXrP8elInYz526oYB1w3H/6GWp0ZMW7hu2qIXIPnH6ZP+uHlwxQyyVedkzJCTV58QGsKqizx1TVGp9Wm84LUjBHrrRJRJfkGcNvaalI7fYSha0e37bo7PE9LMTg3phNdDgup4I+2fZPlTyyMggsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tFs7N6QD; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 4aM1tR7nLgeRP4aM1tvlXG; Sat, 26 Oct 2024 08:32:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1729924377;
	bh=4QS1A65O3hsr8uWMktbnBm+HEJ1CiTpjN/zqDqUf/lw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=tFs7N6QDolaDk7ESBYl8GFFTn+5HZ/WlloVaEE1Y7G7haduNLJhW4WvAmzayQlTk8
	 sBsujEPYlcSb7F4Rd3UUj71cECce5/uCKSvSzHW5kHcHcB9aFWzTEcFh8rWPX2V1c+
	 wRCLMqnZaTXU/Zh7uRoNPJPGwKWmslXSMdxZoDce5qRpzkpyQLu+N4rjQmaY7QwTpW
	 Xuzb4TAXU1JEA0OScvK0Toeoz40tq3UVsrTjqi2zlImtLPe6n0iOAUs6FIaiGyCiiH
	 AP4vXVXM2RaMwlkQO+T1+HAFWi8acVfhEOaxQy8YGNekW8fCHmpKDVoUgqPFqXzvde
	 2rCMO7Ksvs41w==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Oct 2024 08:32:57 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dri-devel@lists.freedesktop.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH] drm/tiny: Fix some error handling paths in sharp_memory_probe()
Date: Sat, 26 Oct 2024 08:32:36 +0200
Message-ID: <b218165cf9af60907e0912266134f1ef1d3617b9.1729924305.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after allocating resources based on which
"sharp,vcom-mode" is used, then these resources must be released, as
already done in the .remove() function.

Use 2 new devm_add_action_or_reset() for that and simplify code
accordingly.

Fixes: b8f9f21716fe ("drm/tiny: Add driver for Sharp Memory LCD")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/gpu/drm/tiny/sharp-memory.c | 66 ++++++++++++++---------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index 2d2315bd6aef..01d1ce2462e1 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -48,12 +48,6 @@ enum sharp_memory_model {
 	LS044Q7DH01,
 };
 
-enum sharp_memory_vcom_mode {
-	SHARP_MEMORY_SOFTWARE_VCOM,
-	SHARP_MEMORY_EXTERNAL_VCOM,
-	SHARP_MEMORY_PWM_VCOM
-};
-
 struct sharp_memory_device {
 	struct drm_device drm;
 	struct spi_device *spi;
@@ -67,10 +61,6 @@ struct sharp_memory_device {
 
 	struct gpio_desc *enable_gpio;
 
-	struct task_struct *sw_vcom_signal;
-	struct pwm_device *pwm_vcom_signal;
-
-	enum sharp_memory_vcom_mode vcom_mode;
 	u8 vcom;
 
 	u32 pitch;
@@ -500,25 +490,41 @@ static int sharp_memory_pipe_init(struct drm_device *dev,
 	return drm_connector_attach_encoder(connector, encoder);
 }
 
+static void sharp_memory_stop_kthread(void *data)
+{
+	struct task_struct *task = data;
+
+	kthread_stop(task);
+}
+
+static void sharp_memory_disable_pwm(void *data)
+{
+	struct pwm_device *pwm = data;
+
+	pwm_disable(pwm);
+}
+
 static int sharp_memory_init_pwm_vcom_signal(struct sharp_memory_device *smd)
 {
 	int ret;
 	struct device *dev = &smd->spi->dev;
+	struct pwm_device *pwm_vcom_signal;
 	struct pwm_state pwm_state;
 
-	smd->pwm_vcom_signal = devm_pwm_get(dev, NULL);
-	if (IS_ERR(smd->pwm_vcom_signal))
-		return dev_err_probe(dev, PTR_ERR(smd->pwm_vcom_signal),
+	pwm_vcom_signal = devm_pwm_get(dev, NULL);
+	if (IS_ERR(pwm_vcom_signal))
+		return dev_err_probe(dev, PTR_ERR(pwm_vcom_signal),
 				     "Could not get pwm device\n");
 
-	pwm_init_state(smd->pwm_vcom_signal, &pwm_state);
+	pwm_init_state(pwm_vcom_signal, &pwm_state);
 	pwm_set_relative_duty_cycle(&pwm_state, 1, 10);
 	pwm_state.enabled = true;
-	ret = pwm_apply_might_sleep(smd->pwm_vcom_signal, &pwm_state);
+	ret = pwm_apply_might_sleep(pwm_vcom_signal, &pwm_state);
 	if (ret)
 		return dev_err_probe(dev, -EINVAL, "Could not apply pwm state\n");
 
-	return 0;
+	return devm_add_action_or_reset(dev, sharp_memory_disable_pwm,
+					pwm_vcom_signal);
 }
 
 static int sharp_memory_probe(struct spi_device *spi)
@@ -595,15 +601,20 @@ static int sharp_memory_probe(struct spi_device *spi)
 				     "Unable to find sharp,vcom-mode node in device tree\n");
 
 	if (!strcmp("software", vcom_mode_str)) {
-		smd->vcom_mode = SHARP_MEMORY_SOFTWARE_VCOM;
-		smd->sw_vcom_signal = kthread_run(sharp_memory_sw_vcom_signal_thread,
-						  smd, "sw_vcom_signal");
+		struct task_struct *sw_vcom_signal;
+
+		sw_vcom_signal = kthread_run(sharp_memory_sw_vcom_signal_thread,
+					     smd, "sw_vcom_signal");
+
+		ret = devm_add_action_or_reset(dev, sharp_memory_stop_kthread,
+					       sw_vcom_signal);
+		if (ret)
+			return ret;
 
 	} else if (!strcmp("external", vcom_mode_str)) {
-		smd->vcom_mode = SHARP_MEMORY_EXTERNAL_VCOM;
+		/* empty */
 
 	} else if (!strcmp("pwm", vcom_mode_str)) {
-		smd->vcom_mode = SHARP_MEMORY_PWM_VCOM;
 		ret = sharp_memory_init_pwm_vcom_signal(smd);
 		if (ret)
 			return ret;
@@ -640,19 +651,6 @@ static void sharp_memory_remove(struct spi_device *spi)
 
 	drm_dev_unplug(&smd->drm);
 	drm_atomic_helper_shutdown(&smd->drm);
-
-	switch (smd->vcom_mode) {
-	case SHARP_MEMORY_SOFTWARE_VCOM:
-		kthread_stop(smd->sw_vcom_signal);
-		break;
-
-	case SHARP_MEMORY_EXTERNAL_VCOM:
-		break;
-
-	case SHARP_MEMORY_PWM_VCOM:
-		pwm_disable(smd->pwm_vcom_signal);
-		break;
-	}
 }
 
 static struct spi_driver sharp_memory_spi_driver = {
-- 
2.47.0


