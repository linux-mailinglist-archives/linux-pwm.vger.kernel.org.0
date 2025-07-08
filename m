Return-Path: <linux-pwm+bounces-6784-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C206CAFD52C
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB6018935F9
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD902DAFAE;
	Tue,  8 Jul 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p5+VYfBx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA09A2E5403
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995153; cv=none; b=gWkfvuE7XgLl1Cgbz2LuCBt5CjzFbWFPIAkICcMIl/a24wuU433oKOwFMKnRsW/UPP69d7YbWjnKSD63beXv9NvdotpQdRdcUGXYTXxUzoKYEhUMdRz1yx23wpwl8RQ1T8KUZNk7UH9IBUKf23pAuZuJyCmP8ZOWgM/j38PsfWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995153; c=relaxed/simple;
	bh=I1fNVW0MQmUn1ozq1+QPQ2MYW4IIPUu8ikCSK9SKAbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6IoAlPJhPSMgEDjIfStvlg8Y09PWmg6SiK2uwI2C6AEPnP5xUerLA/wy+uV/BBI6SLeWX+9px4nXYOoOVBmg/PLiyqzTaqn7DRtUHaKgli12cMhwZK/8l+kv1sSLUqpngG+hUPGeav6Hc/fpWIMnwcva/M3bS24S/V6zobx3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p5+VYfBx; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so9162583a12.3
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995150; x=1752599950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFqlxkQ/SD97qpkHJtoGI6W/z2FZNN0aT+KCWb460Og=;
        b=p5+VYfBxRUepPielgByJKQdPVoDSGZkocBo1WE0nMVK7C2peiepAww8i/NeS/hcozf
         I15KUwbsFrO/CAKS4L0K/3QgBCsAf8feUa6p5n49tPeVcCZgo6leuo4mGvF0q0AXvg8I
         87+aADNHo3hC3U3VIM22pUtZaaLMdGugmwphkWayCodZHTngb/HIrDBES0Gttpx71Ate
         9v/3K/emsWdfX2uLwqO2BpbJb3xSlMK4ADKWG+gq8U2NeJqQMh1cEAQyVMUnLIkLdZI2
         CwoNoUjU+ZvO/zjPOK1bxPsi/5Rv6MZh+QFHUJAzhVr1QJCvTIlgjJ3DyYDA4PgMKlal
         kE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995150; x=1752599950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFqlxkQ/SD97qpkHJtoGI6W/z2FZNN0aT+KCWb460Og=;
        b=nTx7hTlCsKRZer0Lu6M/4zxW1lFtmAjobQB8yV3930/brmkTBg4EyDYMWEpAuHDuqi
         x1qKlRKZZ7HnINb/gVEUMmPE73PLKy/Tnz6jEdT6hXdnCjVRJichBm0O+PGxXFRKOZ7B
         VGY8jRYSlqJLxpcESsHxFxb021vHyDPTIIJKyJMAAoWdAVmR3nr7P1fHkMCCsxMP+O9l
         5qmYFyn54Xrswopc9EuyNAICr+UmQD7i7EsEN1DMy6WVCLmKjVoGSic+2+TWyY4+6h3M
         1J74Urn8k9eerPR3aVQ0Fws9kpW4ZSRGZWt2Hx9+yyH+93ckmX8ZFoRKrf7B6ha9Dzb4
         bk2w==
X-Gm-Message-State: AOJu0YxJXCZK59V4vShO44SU55kMVpnpdZrLLx+lb/5DAz5qWv3Vveqo
	paG/6vDFP7zaY+qEV8MuE8dAaRa3QpOvz/ZIrWVsrgz3KL/IjNZra7CmQNjjjE+FcPo=
X-Gm-Gg: ASbGncs37ZejlSEUgTs7Vl1bBB9vflojFLyZII8iQhJYKJ0/S+CM2wZuBqtBlU1OE5b
	VHc55bUvV9CSYoxw+2FOpvV7XhamzPPB12Cb0cvAhUJ149iErPr7IALhsD/V5Pn4lBA83Ced7mb
	7cJ87ubsH4wjeBqG0Xi6tCD1Dg88PEaqRqEhtNMljwrG3A59JVD1oqLMmqNJ13hB2IAQJRAZSOD
	6DwoThDEIaZkhNS6wiwbGg4eGGSeckeaA5wh4hYta0hcEJ2jCLwyvC7CTtlyO7dB6lBNv7Zn5V8
	b9vnEAdN2x5i9wHypYDChmMLQ+rCuFFZBYBH2tleDFi1+/00WghbI9+XCJQxm5V4BfaTyzs6AVB
	Qq6/E3wWJYjSVDPD/9Kc/kEV8cyU6
X-Google-Smtp-Source: AGHT+IFZmtC3hiekQDGureBWTwbubovtQOb0Tr/eF8NbDaK8y0PJsPcnu0JRq4l9Y8UVzbZpMV9iig==
X-Received: by 2002:a05:6402:2106:b0:606:df70:7aa2 with SMTP id 4fb4d7f45d1cf-60fd6e50540mr14395037a12.31.1751995150125;
        Tue, 08 Jul 2025 10:19:10 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60fcb1fb06bsm7448054a12.64.2025.07.08.10.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:19:09 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 5/8] pwm: mediatek: Implement .get_state() callback
Date: Tue,  8 Jul 2025 19:18:35 +0200
Message-ID:  <84ca6573e8ef5607042ed56fca65ad766a0e6570.1751994509.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751994509.git.u.kleine-koenig@baylibre.com>
References: <cover.1751994509.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3445; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=I1fNVW0MQmUn1ozq1+QPQ2MYW4IIPUu8ikCSK9SKAbE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBobVL2enJCg2AIeQ7i8MM86G6Semnf/UncLKYA0 AbOgu5IAbqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG1S9gAKCRCPgPtYfRL+ TuHVCACm+IDvCvHbhyfKb9oC8HSgRWQpdeUqpMbO8kQjlpAa83J1/SmexLOXYNzzc0E+fZMY+vW 4XUWKG0+FCl6nvLqNv9gm2cnhbKoX1r0/SgJLBq+DbnRcmbMpDEfxiurv9yqfyEilGy0rbVcsCH QCwbiOr0MY09UX+KSqKY11BznjXmvJFwuY11F35vHllEZAH5t6l1oB+L8XGyFj2CuGWQPZG+vz1 xzolSx6G2mnpRaxel8a1S57RWuknEKCayUbHFIvXvgPnuZB+PL3zmgCEuQbTwW3ioOXyimxbLma HAKRx7BKmg+oLHx+9NE14dCXwavGKlhXYDp5QTcltaLx0Rjt
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The registers can be read out just fine on an MT8365. In the assumption
that this works on all supported devices, a .get_state() callback can be
implemented. This enables consumers to make use of pwm_get_state_hw() and
improves the usefulness of /sys/kernel/debug/pwm.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 70 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 376d059c47bf..76b293f2b6c4 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -31,6 +31,7 @@
 #define PWMDWIDTH_PERIOD		GENMASK(12, 0)
 #define PWM45DWIDTH_FIXUP	0x30
 #define PWMTHRES		0x30
+#define PWMTHRES_DUTY			GENMASK(12, 0)
 #define PWM45THRES_FIXUP	0x34
 #define PWM_CK_26M_SEL_V3	0x74
 #define PWM_CK_26M_SEL		0x210
@@ -108,6 +109,13 @@ static inline void pwm_mediatek_writel(struct pwm_mediatek_chip *chip,
 	       num * chip->soc->chanreg_width + offset);
 }
 
+static inline u32 pwm_mediatek_readl(struct pwm_mediatek_chip *chip,
+				     unsigned int num, unsigned int offset)
+{
+	return readl(chip->regs + chip->soc->chanreg_base +
+		     num * chip->soc->chanreg_width + offset);
+}
+
 static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       int duty_ns, int period_ns)
 {
@@ -224,8 +232,70 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return err;
 }
 
+static int pwm_mediatek_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
+	int ret;
+	u32 enable;
+	u32 reg_width = PWMDWIDTH, reg_thres = PWMTHRES;
+
+	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
+		/*
+		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
+		 * from the other PWMs on MT7623.
+		 */
+		reg_width = PWM45DWIDTH_FIXUP;
+		reg_thres = PWM45THRES_FIXUP;
+	}
+
+	ret = pwm_mediatek_clk_enable(pc, pwm->hwpwm);
+	if (ret < 0)
+		return ret;
+
+	enable = readl(pc->regs);
+	if (enable & BIT(pwm->hwpwm)) {
+		u32 clkdiv, cnt_period, cnt_duty;
+		unsigned long clk_rate;
+
+		clk_rate = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
+		if (!clk_rate) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		state->enabled = true;
+		state->polarity = PWM_POLARITY_NORMAL;
+
+		clkdiv = FIELD_GET(PWMCON_CLKDIV,
+				   pwm_mediatek_readl(pc, pwm->hwpwm, PWMCON));
+		cnt_period = FIELD_GET(PWMDWIDTH_PERIOD,
+				       pwm_mediatek_readl(pc, pwm->hwpwm, reg_width));
+		cnt_duty = FIELD_GET(PWMTHRES_DUTY,
+				     pwm_mediatek_readl(pc, pwm->hwpwm, reg_thres));
+
+		/*
+		 * cnt_period is a 13 bit value, NSEC_PER_SEC is 30 bits wide
+		 * and clkdiv is less than 8, so the multiplication doesn't
+		 * overflow an u64.
+		 */
+		state->period =
+			DIV_ROUND_UP_ULL((u64)cnt_period * NSEC_PER_SEC << clkdiv, clk_rate);
+		state->duty_cycle =
+			DIV_ROUND_UP_ULL((u64)cnt_duty * NSEC_PER_SEC << clkdiv, clk_rate);
+	} else {
+		state->enabled = false;
+	}
+
+out:
+	pwm_mediatek_clk_disable(pc, pwm->hwpwm);
+
+	return ret;
+}
+
 static const struct pwm_ops pwm_mediatek_ops = {
 	.apply = pwm_mediatek_apply,
+	.get_state = pwm_mediatek_get_state,
 };
 
 static int pwm_mediatek_init_used_clks(struct pwm_mediatek_chip *pc)
-- 
2.49.0


