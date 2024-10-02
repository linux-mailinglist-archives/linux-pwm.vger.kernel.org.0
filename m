Return-Path: <linux-pwm+bounces-3426-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EF598CB99
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 05:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77D61C22010
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 03:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AD417BC9;
	Wed,  2 Oct 2024 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHsGFdr8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC439FC5;
	Wed,  2 Oct 2024 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727840339; cv=none; b=f8tC4u3zwGT0FbN1LLaRB2QveMGy1ijm4C5CilEYVZFfMO+7FYKAeQNXNQYH+FmuOY+MPjYmJJgwZbD6Q2wxnL10QATT9rGpCJngY7GJ02BRjmCQvt081pyAs+OsIK25jC8gH2+MwJCZ/g5vq8W267xiSinSPQUZrFm9dDaXsl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727840339; c=relaxed/simple;
	bh=2j6zUIcbLQInb1pwbt4ghbSCOuZ00IuoMsXs762awfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gK0m4HVu9F30z2fTS4h9NEPXzHHzQxbofTRsGj5GBZEIbFAhMvwXdbJaLecI8iUX1sB+19yMUMZnOe1L2/j9Vg6Pg6SZhzyPqm4aZhdPRjd7vQLg5NzxSUcYLLe9fAwMcGB6AqC3/uUatmCgWGL65RTioFMHr4v1BOkQPJkYcdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHsGFdr8; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4583083d019so41519331cf.3;
        Tue, 01 Oct 2024 20:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727840335; x=1728445135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIbzvYlddNVYuSmvTxYuGtOSsbUz9nZDdmvFpVrnk70=;
        b=BHsGFdr8swtvNQuHqSyje1xBdtCuLjNpyQ5vJL4YE6PLIfPbtMzWZusjaC7RlzqWSn
         JKYUVs8pI5uIpWKBclKw4NV7emXYIjwSqo8BxXJLNrNIa7k+X9++cu2MsaFnYFa185d/
         wZQUKp8Pb1kZ3719yvCepznyW6YqdQKPvQrZNAw/MmmCd3fDpHB8c5OmlB9LI37qEvqV
         ugVeyv8Ud2eUX5ZR47+o3x17j5v0E+iE8BPuOhdYEABFkJYDYVaiTnXgjB/i3yqaZnOF
         uFDDsh460mmx6mc57VJikF8SqnXXlAP6EWIiHp3bdJv2IF1NbO16AvPiEK/Nrgy/l5Ro
         LaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727840335; x=1728445135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIbzvYlddNVYuSmvTxYuGtOSsbUz9nZDdmvFpVrnk70=;
        b=g4e8++K9Oiw9h5CtgZorVyNqdbODgPPoSwsDHUQZgUn+on885WAICDtUHovZYnm0wK
         JpJ5fmfOWNNoqNteKX8YxjXz45UZt9Hxfeh+jNWMsSzYzlM0ExQheVZuk0q1utn2SweQ
         y2cTrjzJSjVPpFKnk8WKejRqrnHkUWn5BWOjt7aO1A28Ly5H3tXAgmeEcZsjuux2UUJ+
         3DFnc+YF0Iqq0olBAHVnkG1OAJZGI+hEa17x8tA09s0OnBtk60lVByIZcG1d4RaTm22N
         vh/NepZXX6pwRhBTFFxO1YzQ45Zu0hXDaGIpSpofr9DDkk3mqsdJMTLHX7NYjeohROAi
         ICAw==
X-Forwarded-Encrypted: i=1; AJvYcCVU9yyo5yGcdlUpAIzVmi8gzGtdFnTfQxgF+1RfeK4qNSE3SVL77+TGYcHUGcLtlet1Zacsn68K6m3x9XeI@vger.kernel.org, AJvYcCWg4/PyPO8XPNmsudFytAIdElO6g7M0OY/P2YPW10N+xwHkVmdyvyQ1RHD5g4RafY4ExEhibx+VWmMi@vger.kernel.org, AJvYcCWmbDB7ag19yi6fJLNT9OiIAiSvBa2TbVzzZCcKYojMxoq3hMn9BzaMfyOw18tPFdNhBdX0pDDM0DFT@vger.kernel.org
X-Gm-Message-State: AOJu0YwuXPOB6IpuZF6jZMh8M0apBopEWhyhurtvg4E63+KbpZ1JJ1Nj
	PwvYiSrpPEJZF7LVzynElTHoQJYTHBkkbrHYqmwtrRk6AnCJkMSp
X-Google-Smtp-Source: AGHT+IGQo06rFGAaLYe/PP+mn+Sci69dkzVloK3oNesLPqihI2F9VO0OeaH152w1F++iIvk68aXt1g==
X-Received: by 2002:a05:622a:1a81:b0:458:28c9:5de2 with SMTP id d75a77b69052e-45d80493348mr22834511cf.5.1727840335387;
        Tue, 01 Oct 2024 20:38:55 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b62d9e6sm55640446d6.69.2024.10.01.20.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 20:38:54 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: u.kleine-koenig@baylibre.com,
	Alex Lanzano <lanzano.alex@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v8 2/2] drm/tiny: Add driver for Sharp Memory LCD
Date: Tue,  1 Oct 2024 23:37:37 -0400
Message-ID: <20241002033807.682177-3-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002033807.682177-1-lanzano.alex@gmail.com>
References: <20241002033807.682177-1-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the monochrome Sharp Memory LCDs.

Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 MAINTAINERS                         |   6 +
 drivers/gpu/drm/tiny/Kconfig        |  20 +
 drivers/gpu/drm/tiny/Makefile       |   1 +
 drivers/gpu/drm/tiny/sharp-memory.c | 681 ++++++++++++++++++++++++++++
 4 files changed, 708 insertions(+)
 create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5432239f3c5d..f3b1a6115711 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7289,6 +7289,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
 F:	drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
 
+DRM DRIVER FOR SHARP MEMORY LCD
+M:	Alex Lanzano <lanzano.alex@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
+F:	drivers/gpu/drm/tiny/sharp-memory.c
+
 DRM DRIVER FOR SITRONIX ST7586 PANELS
 M:	David Lechner <david@lechnology.com>
 S:	Maintained
diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index f6889f649bc1..bc386954faa2 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -186,6 +186,26 @@ config TINYDRM_REPAPER
 
 	  If M is selected the module will be called repaper.
 
+config TINYDRM_SHARP_MEMORY
+	tristate "DRM support for Sharp Memory LCD panels"
+	depends on DRM && SPI
+	select DRM_GEM_DMA_HELPER
+	select DRM_KMS_HELPER
+	help
+	  DRM Driver for the following Sharp Memory Panels:
+	  * 1.00" Sharp Memory LCD (LS010B7DH04)
+	  * 1.10" Sharp Memory LCD (LS011B7DH03)
+	  * 1.20" Sharp Memory LCD (LS012B7DD01)
+	  * 1.28" Sharp Memory LCD (LS013B7DH03)
+	  * 1.26" Sharp Memory LCD (LS013B7DH05)
+	  * 1.80" Sharp Memory LCD (LS018B7DH02)
+	  * 2.70" Sharp Memory LCD (LS027B7DH01)
+	  * 2.70" Sharp Memory LCD (LS027B7DH01A)
+	  * 3.20" Sharp Memory LCD (LS032B7DD02)
+	  * 4.40" Sharp Memory LCD (LS044Q7DH01)
+
+	  If M is selected the module will be called sharp_memory.
+
 config TINYDRM_ST7586
 	tristate "DRM support for Sitronix ST7586 display panels"
 	depends on DRM && SPI
diff --git a/drivers/gpu/drm/tiny/Makefile b/drivers/gpu/drm/tiny/Makefile
index 76dde89a044b..4aaf56f8707d 100644
--- a/drivers/gpu/drm/tiny/Makefile
+++ b/drivers/gpu/drm/tiny/Makefile
@@ -14,5 +14,6 @@ obj-$(CONFIG_TINYDRM_ILI9341)		+= ili9341.o
 obj-$(CONFIG_TINYDRM_ILI9486)		+= ili9486.o
 obj-$(CONFIG_TINYDRM_MI0283QT)		+= mi0283qt.o
 obj-$(CONFIG_TINYDRM_REPAPER)		+= repaper.o
+obj-$(CONFIG_TINYDRM_SHARP_MEMORY)	+= sharp-memory.o
 obj-$(CONFIG_TINYDRM_ST7586)		+= st7586.o
 obj-$(CONFIG_TINYDRM_ST7735R)		+= st7735r.o
diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
new file mode 100644
index 000000000000..7c527a0e2360
--- /dev/null
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -0,0 +1,681 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_fb_dma_helper.h>
+#include <drm/drm_fbdev_dma.h>
+#include <drm/drm_format_helper.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_rect.h>
+#include <linux/bitrev.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kthread.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pwm.h>
+#include <linux/spi/spi.h>
+
+#define SHARP_MODE_PERIOD 8
+#define SHARP_ADDR_PERIOD 8
+#define SHARP_DUMMY_PERIOD 8
+
+#define SHARP_MEMORY_DISPLAY_MAINTAIN_MODE 0
+#define SHARP_MEMORY_DISPLAY_UPDATE_MODE 1
+#define SHARP_MEMORY_DISPLAY_CLEAR_MODE 4
+
+enum sharp_memory_model {
+	LS010B7DH04,
+	LS011B7DH03,
+	LS012B7DD01,
+	LS013B7DH03,
+	LS013B7DH05,
+	LS018B7DH02,
+	LS027B7DH01,
+	LS027B7DH01A,
+	LS032B7DD02,
+	LS044Q7DH01,
+};
+
+enum sharp_memory_vcom_mode {
+	SHARP_MEMORY_SOFTWARE_VCOM,
+	SHARP_MEMORY_EXTERNAL_VCOM,
+	SHARP_MEMORY_PWM_VCOM
+};
+
+struct sharp_memory_device {
+	struct drm_device drm;
+	struct spi_device *spi;
+
+	const struct drm_display_mode *mode;
+
+	struct drm_crtc crtc;
+	struct drm_plane plane;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+
+	struct gpio_desc *enable_gpio;
+
+	struct task_struct *sw_vcom_signal;
+	struct pwm_device *pwm_vcom_signal;
+
+	enum sharp_memory_vcom_mode vcom_mode;
+	u8 vcom;
+
+	u32 pitch;
+	u32 tx_buffer_size;
+	u8 *tx_buffer;
+
+	/* When vcom_mode == "software" a kthread is used to periodically send a
+	 * 'maintain display' message over spi. This mutex ensures tx_buffer access
+	 * and spi bus usage is synchronized in this case.
+	 */
+	struct mutex tx_mutex;
+};
+
+static inline int sharp_memory_spi_write(struct spi_device *spi, void *buf, size_t len)
+{
+	/* Reverse the bit order */
+	for (u8 *b = buf; b < ((u8 *)buf) + len; ++b)
+		*b = bitrev8(*b);
+
+	return spi_write(spi, buf, len);
+}
+
+static inline struct sharp_memory_device *drm_to_sharp_memory_device(struct drm_device *drm)
+{
+	return container_of(drm, struct sharp_memory_device, drm);
+}
+
+DEFINE_DRM_GEM_DMA_FOPS(sharp_memory_fops);
+
+static const struct drm_driver sharp_memory_drm_driver = {
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	.fops			= &sharp_memory_fops,
+	DRM_GEM_DMA_DRIVER_OPS_VMAP,
+	.name			= "sharp_memory_display",
+	.desc			= "Sharp Display Memory LCD",
+	.date			= "20231129",
+	.major			= 1,
+	.minor			= 0,
+};
+
+static inline void sharp_memory_set_tx_buffer_mode(u8 *buffer, u8 mode, u8 vcom)
+{
+	*buffer = mode | (vcom << 1);
+}
+
+static inline void sharp_memory_set_tx_buffer_addresses(u8 *buffer,
+							struct drm_rect clip,
+							u32 pitch)
+{
+	for (u32 line = 0; line < clip.y2; ++line)
+		buffer[line * pitch] = line + 1;
+}
+
+static void sharp_memory_set_tx_buffer_data(u8 *buffer,
+					    struct drm_framebuffer *fb,
+					    struct drm_rect clip,
+					    u32 pitch,
+					    struct drm_format_conv_state *fmtcnv_state)
+{
+	int ret;
+	struct iosys_map dst, vmap;
+	struct drm_gem_dma_object *dma_obj = drm_fb_dma_get_gem_obj(fb, 0);
+
+	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
+	if (ret)
+		return;
+
+	iosys_map_set_vaddr(&dst, buffer);
+	iosys_map_set_vaddr(&vmap, dma_obj->vaddr);
+
+	drm_fb_xrgb8888_to_mono(&dst, &pitch, &vmap, fb, &clip, fmtcnv_state);
+
+	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+}
+
+static int sharp_memory_update_display(struct sharp_memory_device *smd,
+				       struct drm_framebuffer *fb,
+				       struct drm_rect clip,
+				       struct drm_format_conv_state *fmtcnv_state)
+{
+	int ret;
+	u32 pitch = smd->pitch;
+	u8 vcom = smd->vcom;
+	u8 *tx_buffer = smd->tx_buffer;
+	u32 tx_buffer_size = smd->tx_buffer_size;
+
+	mutex_lock(&smd->tx_mutex);
+
+	/* Populate the transmit buffer with frame data */
+	sharp_memory_set_tx_buffer_mode(&tx_buffer[0],
+					SHARP_MEMORY_DISPLAY_UPDATE_MODE, vcom);
+	sharp_memory_set_tx_buffer_addresses(&tx_buffer[1], clip, pitch);
+	sharp_memory_set_tx_buffer_data(&tx_buffer[2], fb, clip, pitch, fmtcnv_state);
+
+	ret = sharp_memory_spi_write(smd->spi, tx_buffer, tx_buffer_size);
+
+	mutex_unlock(&smd->tx_mutex);
+
+	return ret;
+}
+
+static int sharp_memory_maintain_display(struct sharp_memory_device *smd)
+{
+	int ret;
+	u8 vcom = smd->vcom;
+	u8 *tx_buffer = smd->tx_buffer;
+
+	mutex_lock(&smd->tx_mutex);
+
+	sharp_memory_set_tx_buffer_mode(&tx_buffer[0], SHARP_MEMORY_DISPLAY_MAINTAIN_MODE, vcom);
+	tx_buffer[1] = 0; // Write dummy data
+	ret = sharp_memory_spi_write(smd->spi, tx_buffer, 2);
+
+	mutex_unlock(&smd->tx_mutex);
+
+	return ret;
+}
+
+static int sharp_memory_clear_display(struct sharp_memory_device *smd)
+{
+	int ret;
+	u8 vcom = smd->vcom;
+	u8 *tx_buffer = smd->tx_buffer;
+
+	mutex_lock(&smd->tx_mutex);
+
+	sharp_memory_set_tx_buffer_mode(&tx_buffer[0], SHARP_MEMORY_DISPLAY_CLEAR_MODE, vcom);
+	tx_buffer[1] = 0; // write dummy data
+	ret = sharp_memory_spi_write(smd->spi, tx_buffer, 2);
+
+	mutex_unlock(&smd->tx_mutex);
+
+	return ret;
+}
+
+static void sharp_memory_fb_dirty(struct drm_framebuffer *fb, struct drm_rect *rect,
+				  struct drm_format_conv_state *fmtconv_state)
+{
+	struct drm_rect clip;
+	struct sharp_memory_device *smd = drm_to_sharp_memory_device(fb->dev);
+
+	/* Always update a full line regardless of what is dirty */
+	clip.x1 = 0;
+	clip.x2 = fb->width;
+	clip.y1 = rect->y1;
+	clip.y2 = rect->y2;
+
+	sharp_memory_update_display(smd, fb, clip, fmtconv_state);
+}
+
+static int sharp_memory_plane_atomic_check(struct drm_plane *plane,
+					   struct drm_atomic_state *state)
+{
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct sharp_memory_device *smd;
+	struct drm_crtc_state *crtc_state;
+
+	smd = container_of(plane, struct sharp_memory_device, plane);
+	crtc_state = drm_atomic_get_new_crtc_state(state, &smd->crtc);
+
+	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
+						   DRM_PLANE_NO_SCALING,
+						   DRM_PLANE_NO_SCALING,
+						   false, false);
+}
+
+static void sharp_memory_plane_atomic_update(struct drm_plane *plane,
+					     struct drm_atomic_state *state)
+{
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
+	struct drm_plane_state *plane_state = plane->state;
+	struct drm_format_conv_state fmtcnv_state = DRM_FORMAT_CONV_STATE_INIT;
+	struct sharp_memory_device *smd;
+	struct drm_rect rect;
+
+	smd = container_of(plane, struct sharp_memory_device, plane);
+	if (!smd->crtc.state->active)
+		return;
+
+	if (drm_atomic_helper_damage_merged(old_state, plane_state, &rect))
+		sharp_memory_fb_dirty(plane_state->fb, &rect, &fmtcnv_state);
+
+	drm_format_conv_state_release(&fmtcnv_state);
+}
+
+static const struct drm_plane_helper_funcs sharp_memory_plane_helper_funcs = {
+	.prepare_fb = drm_gem_plane_helper_prepare_fb,
+	.atomic_check = sharp_memory_plane_atomic_check,
+	.atomic_update = sharp_memory_plane_atomic_update,
+};
+
+static bool sharp_memory_format_mod_supported(struct drm_plane *plane,
+					      u32 format,
+					      u64 modifier)
+{
+	return modifier == DRM_FORMAT_MOD_LINEAR;
+}
+
+static const struct drm_plane_funcs sharp_memory_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = drm_plane_cleanup,
+	.reset = drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+	.format_mod_supported = sharp_memory_format_mod_supported,
+};
+
+static enum drm_mode_status sharp_memory_crtc_mode_valid(struct drm_crtc *crtc,
+							 const struct drm_display_mode *mode)
+{
+	struct sharp_memory_device *smd = drm_to_sharp_memory_device(crtc->dev);
+
+	return drm_crtc_helper_mode_valid_fixed(crtc, mode, smd->mode);
+}
+
+static int sharp_memory_crtc_check(struct drm_crtc *crtc,
+				   struct drm_atomic_state *state)
+{
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	int ret;
+
+	if (!crtc_state->enable)
+		goto out;
+
+	ret = drm_atomic_helper_check_crtc_primary_plane(crtc_state);
+	if (ret)
+		return ret;
+
+out:
+	return drm_atomic_add_affected_planes(state, crtc);
+}
+
+static int sharp_memory_sw_vcom_signal_thread(void *data)
+{
+	struct sharp_memory_device *smd = data;
+
+	while (!kthread_should_stop()) {
+		smd->vcom ^= 1; // Toggle vcom
+		sharp_memory_maintain_display(smd);
+		msleep(1000);
+	}
+
+	return 0;
+}
+
+static void sharp_memory_crtc_enable(struct drm_crtc *crtc,
+				     struct drm_atomic_state *state)
+{
+	struct pwm_state pwm_state;
+	struct sharp_memory_device *smd = drm_to_sharp_memory_device(crtc->dev);
+
+	sharp_memory_clear_display(smd);
+
+	if (smd->enable_gpio)
+		gpiod_set_value(smd->enable_gpio, 1);
+
+	switch (smd->vcom_mode) {
+	case SHARP_MEMORY_SOFTWARE_VCOM:
+		smd->sw_vcom_signal = kthread_run(sharp_memory_sw_vcom_signal_thread,
+						  smd, "sw_vcom_signal");
+		break;
+
+	case SHARP_MEMORY_EXTERNAL_VCOM:
+		break;
+
+	case SHARP_MEMORY_PWM_VCOM:
+		pwm_init_state(smd->pwm_vcom_signal, &pwm_state);
+		pwm_set_relative_duty_cycle(&pwm_state, 1, 10);
+		pwm_state.enabled = true;
+		pwm_apply_might_sleep(smd->pwm_vcom_signal, &pwm_state);
+		break;
+	}
+}
+
+static void sharp_memory_crtc_disable(struct drm_crtc *crtc,
+				      struct drm_atomic_state *state)
+{
+	struct sharp_memory_device *smd = drm_to_sharp_memory_device(crtc->dev);
+
+	sharp_memory_clear_display(smd);
+
+	if (smd->enable_gpio)
+		gpiod_set_value(smd->enable_gpio, 0);
+
+	switch (smd->vcom_mode) {
+	case SHARP_MEMORY_SOFTWARE_VCOM:
+		kthread_stop(smd->sw_vcom_signal);
+		break;
+
+	case SHARP_MEMORY_EXTERNAL_VCOM:
+		break;
+
+	case SHARP_MEMORY_PWM_VCOM:
+		pwm_disable(smd->pwm_vcom_signal);
+		break;
+	}
+}
+
+static const struct drm_crtc_helper_funcs sharp_memory_crtc_helper_funcs = {
+	.mode_valid = sharp_memory_crtc_mode_valid,
+	.atomic_check = sharp_memory_crtc_check,
+	.atomic_enable = sharp_memory_crtc_enable,
+	.atomic_disable = sharp_memory_crtc_disable,
+};
+
+static const struct drm_crtc_funcs sharp_memory_crtc_funcs = {
+	.reset = drm_atomic_helper_crtc_reset,
+	.destroy = drm_crtc_cleanup,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_encoder_funcs sharp_memory_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static int sharp_memory_connector_get_modes(struct drm_connector *connector)
+{
+	struct sharp_memory_device *smd = drm_to_sharp_memory_device(connector->dev);
+
+	return drm_connector_helper_get_modes_fixed(connector, smd->mode);
+}
+
+static const struct drm_connector_helper_funcs sharp_memory_connector_hfuncs = {
+	.get_modes = sharp_memory_connector_get_modes,
+};
+
+static const struct drm_connector_funcs sharp_memory_connector_funcs = {
+	.reset = drm_atomic_helper_connector_reset,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+
+};
+
+static const struct drm_mode_config_funcs sharp_memory_mode_config_funcs = {
+	.fb_create = drm_gem_fb_create_with_dirty,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+static const struct drm_display_mode sharp_memory_ls010b7dh04_mode = {
+	DRM_SIMPLE_MODE(128, 128, 18, 18),
+};
+
+static const struct drm_display_mode sharp_memory_ls011b7dh03_mode = {
+	DRM_SIMPLE_MODE(160, 68, 25, 10),
+};
+
+static const struct drm_display_mode sharp_memory_ls012b7dd01_mode = {
+	DRM_SIMPLE_MODE(184, 38, 29, 6),
+};
+
+static const struct drm_display_mode sharp_memory_ls013b7dh03_mode = {
+	DRM_SIMPLE_MODE(128, 128, 23, 23),
+};
+
+static const struct drm_display_mode sharp_memory_ls013b7dh05_mode = {
+	DRM_SIMPLE_MODE(144, 168, 20, 24),
+};
+
+static const struct drm_display_mode sharp_memory_ls018b7dh02_mode = {
+	DRM_SIMPLE_MODE(230, 303, 27, 36),
+};
+
+static const struct drm_display_mode sharp_memory_ls027b7dh01_mode = {
+	DRM_SIMPLE_MODE(400, 240, 58, 35),
+};
+
+static const struct drm_display_mode sharp_memory_ls032b7dd02_mode = {
+	DRM_SIMPLE_MODE(336, 536, 42, 68),
+};
+
+static const struct drm_display_mode sharp_memory_ls044q7dh01_mode = {
+	DRM_SIMPLE_MODE(320, 240, 89, 67),
+};
+
+static const struct spi_device_id sharp_memory_ids[] = {
+	{"ls010b7dh04", (kernel_ulong_t)&sharp_memory_ls010b7dh04_mode},
+	{"ls011b7dh03", (kernel_ulong_t)&sharp_memory_ls011b7dh03_mode},
+	{"ls012b7dd01", (kernel_ulong_t)&sharp_memory_ls012b7dd01_mode},
+	{"ls013b7dh03", (kernel_ulong_t)&sharp_memory_ls013b7dh03_mode},
+	{"ls013b7dh05", (kernel_ulong_t)&sharp_memory_ls013b7dh05_mode},
+	{"ls018b7dh02", (kernel_ulong_t)&sharp_memory_ls018b7dh02_mode},
+	{"ls027b7dh01", (kernel_ulong_t)&sharp_memory_ls027b7dh01_mode},
+	{"ls027b7dh01a", (kernel_ulong_t)&sharp_memory_ls027b7dh01_mode},
+	{"ls032b7dd02", (kernel_ulong_t)&sharp_memory_ls032b7dd02_mode},
+	{"ls044q7dh01", (kernel_ulong_t)&sharp_memory_ls044q7dh01_mode},
+	{},
+};
+MODULE_DEVICE_TABLE(spi, sharp_memory_ids);
+
+static const struct of_device_id sharp_memory_of_match[] = {
+	{.compatible = "sharp,ls010b7dh04", &sharp_memory_ls010b7dh04_mode},
+	{.compatible = "sharp,ls011b7dh03", &sharp_memory_ls011b7dh03_mode},
+	{.compatible = "sharp,ls012b7dd01", &sharp_memory_ls012b7dd01_mode},
+	{.compatible = "sharp,ls013b7dh03", &sharp_memory_ls013b7dh03_mode},
+	{.compatible = "sharp,ls013b7dh05", &sharp_memory_ls013b7dh05_mode},
+	{.compatible = "sharp,ls018b7dh02", &sharp_memory_ls018b7dh02_mode},
+	{.compatible = "sharp,ls027b7dh01", &sharp_memory_ls027b7dh01_mode},
+	{.compatible = "sharp,ls027b7dh01a", &sharp_memory_ls027b7dh01_mode},
+	{.compatible = "sharp,ls032b7dd02", &sharp_memory_ls032b7dd02_mode},
+	{.compatible = "sharp,ls044q7dh01", &sharp_memory_ls044q7dh01_mode},
+	{},
+};
+MODULE_DEVICE_TABLE(of, sharp_memory_of_match);
+
+static const u32 sharp_memory_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
+
+static int sharp_memory_pipe_init(struct drm_device *dev,
+				  struct sharp_memory_device *smd,
+				  const u32 *formats, unsigned int format_count,
+				  const u64 *format_modifiers)
+{
+	int ret;
+	struct drm_encoder *encoder = &smd->encoder;
+	struct drm_plane *plane = &smd->plane;
+	struct drm_crtc *crtc = &smd->crtc;
+	struct drm_connector *connector = &smd->connector;
+
+	drm_plane_helper_add(plane, &sharp_memory_plane_helper_funcs);
+	ret = drm_universal_plane_init(dev, plane, 0,
+				       &sharp_memory_plane_funcs,
+				       formats, format_count,
+				       format_modifiers,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+
+	drm_crtc_helper_add(crtc, &sharp_memory_crtc_helper_funcs);
+	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
+					&sharp_memory_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+	ret = drm_encoder_init(dev, encoder, &sharp_memory_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+
+	ret = drm_connector_init(&smd->drm, &smd->connector,
+				 &sharp_memory_connector_funcs,
+				 DRM_MODE_CONNECTOR_SPI);
+	if (ret)
+		return ret;
+
+	drm_connector_helper_add(&smd->connector,
+				 &sharp_memory_connector_hfuncs);
+
+	return drm_connector_attach_encoder(connector, encoder);
+}
+
+static int sharp_memory_init_pwm_vcom_signal(struct sharp_memory_device *smd)
+{
+	struct pwm_state state;
+	struct device *dev = &smd->spi->dev;
+
+	smd->pwm_vcom_signal = devm_pwm_get(dev, NULL);
+	if (IS_ERR(smd->pwm_vcom_signal))
+		return dev_err_probe(dev, -EINVAL, "Could not get pwm device\n");
+
+	pwm_init_state(smd->pwm_vcom_signal, &state);
+	state.enabled = false;
+	pwm_apply_might_sleep(smd->pwm_vcom_signal, &state);
+
+	return 0;
+}
+
+static int sharp_memory_probe(struct spi_device *spi)
+{
+	int ret;
+	struct device *dev;
+	struct sharp_memory_device *smd;
+	struct drm_device *drm;
+	const char *vcom_mode_str;
+
+	dev = &spi->dev;
+
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to setup spi device\n");
+
+	if (!dev->coherent_dma_mask) {
+		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to set dma mask\n");
+	}
+
+	smd = devm_drm_dev_alloc(dev, &sharp_memory_drm_driver,
+				 struct sharp_memory_device, drm);
+	if (!smd)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, smd);
+
+	smd->spi = spi;
+	drm = &smd->drm;
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize drm config\n");
+
+	smd->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
+	if (!smd->enable_gpio)
+		dev_warn(dev, "Enable gpio not defined\n");
+
+	/*
+	 * VCOM is a signal that prevents DC bias from being built up in
+	 * the panel resulting in pixels being forever stuck in one state.
+	 *
+	 * This driver supports three different methods to generate this
+	 * signal depending on EXTMODE pin:
+	 *
+	 * software (EXTMODE = L) - This mode uses a kthread to
+	 * periodically send a "maintain display" message to the display,
+	 * toggling the vcom bit on and off with each message
+	 *
+	 * external (EXTMODE = H) - This mode relies on an external
+	 * clock to generate the signal on the EXTCOMM pin
+	 *
+	 * pwm (EXTMODE = H) - This mode uses a pwm device to generate
+	 * the signal on the EXTCOMM pin
+	 *
+	 */
+	if (device_property_read_string(dev, "sharp,vcom-mode", &vcom_mode_str))
+		return dev_err_probe(dev, -EINVAL,
+				     "Unable to find sharp,vcom-mode node in device tree\n");
+
+	if (!strcmp("software", vcom_mode_str)) {
+		smd->vcom_mode = SHARP_MEMORY_SOFTWARE_VCOM;
+
+	} else if (!strcmp("external", vcom_mode_str)) {
+		smd->vcom_mode = SHARP_MEMORY_EXTERNAL_VCOM;
+
+	} else if (!strcmp("pwm", vcom_mode_str)) {
+		smd->vcom_mode = SHARP_MEMORY_PWM_VCOM;
+		ret = sharp_memory_init_pwm_vcom_signal(smd);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to initialize external COM signal\n");
+	} else {
+		return dev_err_probe(dev, -EINVAL, "Invalid value set for vcom-mode\n");
+	}
+
+	drm->mode_config.funcs = &sharp_memory_mode_config_funcs;
+	smd->mode = spi_get_device_match_data(spi);
+
+	smd->pitch = (SHARP_ADDR_PERIOD + smd->mode->hdisplay + SHARP_DUMMY_PERIOD) / 8;
+	smd->tx_buffer_size = (SHARP_MODE_PERIOD +
+			       (SHARP_ADDR_PERIOD + (smd->mode->hdisplay) + SHARP_DUMMY_PERIOD) *
+			       smd->mode->vdisplay) / 8;
+
+	smd->tx_buffer = devm_kzalloc(dev, smd->tx_buffer_size, GFP_KERNEL);
+	if (!smd->tx_buffer)
+		return -ENOMEM;
+
+	mutex_init(&smd->tx_mutex);
+
+	drm->mode_config.min_width = smd->mode->hdisplay;
+	drm->mode_config.max_width = smd->mode->hdisplay;
+	drm->mode_config.min_height = smd->mode->vdisplay;
+	drm->mode_config.max_height = smd->mode->vdisplay;
+
+	ret = sharp_memory_pipe_init(drm, smd, sharp_memory_formats,
+				     ARRAY_SIZE(sharp_memory_formats),
+				     NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize display pipeline.\n");
+
+	drm_plane_enable_fb_damage_clips(&smd->plane);
+	drm_mode_config_reset(drm);
+
+	ret = drm_dev_register(drm, 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register drm device.\n");
+
+	drm_fbdev_dma_setup(drm, 0);
+
+	return 0;
+}
+
+static void sharp_memory_remove(struct spi_device *spi)
+{
+	struct sharp_memory_device *smd = spi_get_drvdata(spi);
+
+	drm_dev_unplug(&smd->drm);
+	drm_atomic_helper_shutdown(&smd->drm);
+}
+
+static struct spi_driver sharp_memory_spi_driver = {
+	.driver = {
+		.name = "sharp_memory",
+		.of_match_table = sharp_memory_of_match,
+	},
+	.probe = sharp_memory_probe,
+	.remove = sharp_memory_remove,
+	.id_table = sharp_memory_ids,
+};
+module_spi_driver(sharp_memory_spi_driver);
+
+MODULE_AUTHOR("Alex Lanzano <lanzano.alex@gmail.com>");
+MODULE_DESCRIPTION("SPI Protocol driver for the sharp_memory display");
+MODULE_LICENSE("GPL");
-- 
2.46.2


