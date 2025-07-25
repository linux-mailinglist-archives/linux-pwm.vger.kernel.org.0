Return-Path: <linux-pwm+bounces-6889-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14381B1212F
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 17:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA73A1CC5AA0
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FBD2EE968;
	Fri, 25 Jul 2025 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XL0tew0C"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B06124418D
	for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458350; cv=none; b=RbsLgOhxj+ZJ8MowZtLMTh3EIun/ourVzt7UR5doNBpt9ZjCJ4Buhokugp65XIja6JItMWFNGS+HgENRXJdytLcor8jh0w6AzezpDcStw1cZQ1BuZnRpzgVaeMbx/0bwd7uS5EFIH3IyTm9FjeEdF+f2BCjJteqDCiEz2hi8nNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458350; c=relaxed/simple;
	bh=CgxDKiGIOk5/DJiW6ZyvTBtPHuWR1BwYQvTWRkSTQw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLGhwXMLCIWIfrhJF/8JRljoeVM1XsYpdbnil6jHkz9Sj05CFx4xkWYBNDzkNRoOPBo9RkTXwPiyONCv7SczLhYgB3IqIdnmH3+fje9rD7OX9eG85YeVDqbsXDZ5T3UQj4Cd9HJA6MdFLW4ILNqwpPdWNCCPAkfWnZEKSID3tqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XL0tew0C; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a5257748e1so1644835f8f.2
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753458347; x=1754063147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYlIflW5mvs0UFEIFJba2iAQLX3R1DBfhqm0wXgNnuQ=;
        b=XL0tew0CrUHmE1MGomQd3pKwQmKbsEn1Tfgl2ilBTHx8dZLAoJty6vnQAf+4x4U1OH
         VKp7+ktccDocErwRkew7Ox3aXD7Orv4eqP4FT0KtvOwnaKzoB6weX9JHPgrSXE2NAiN+
         cJpmgnqzsikw0vuibtCBOrbB1n7d0u13o5l9sMl1/Hw+3stcabsaj+xc8EYJBrXKr0Gk
         x5q2XoosShrxZzFMfdkpiqkAlGIOQr75ZWbGRDO/F1pEJU0A8mMc5dGAclZVMgQjRbMa
         cWgNA8IIG0fR1Ycwn8cvCRDVKsvQnoeBoAAKnuYUzkMmHNv6lgZssXZTAeZvSmuxhA4k
         pzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753458347; x=1754063147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYlIflW5mvs0UFEIFJba2iAQLX3R1DBfhqm0wXgNnuQ=;
        b=GWkHvH/V4cuY2sgyha/mvG5dFjDGLd0JwoWpRKK+Z+c0mHn9xwwhHyvTaBqgeWaiqZ
         OEwcFSsMCcXCDG4TewAWFj6FfkG1WbkJRpwzOrmi5Ih9b13Y9OviT8FBtluudfj6XEtg
         3gwJbWk/xIM+aPZbJuCsNk1CVR+i4RHpzPhZvse9FwlLulEgxx2np/esX1qUSj31Xipo
         G0p8s5LIDZzoAaiYZFrIy9zy0tYGBA1Qc2KVwfd5FSC3usdy6jspZz8K0HAkmEdg34BI
         lZLzPB/nWPzdR0LB+FurOJjNBP4rtysb+NnuEU4xB6oBQUirj92RH7nv7CKlCEk5wVcL
         N5XA==
X-Gm-Message-State: AOJu0Ywic8FMp3MT1AEN0cOpW+Kjpk5X2YlWA9F74gfVQgQIADnvoTTQ
	TdVjgDV3DvcgTYBnUO5xsogoAGErt08XUnbp4M2QzKRCBswM0AojgmUv3W5gtUdvG78=
X-Gm-Gg: ASbGncuQ2uf60JPYYugtrp0HJuAQixv8AQnmgWsOqE2mvgUREWrc2aF4WpujGCOEDHx
	f4STCL/8GAz98bNcNDo8zGtwqji0dAc4Bx41+YlzBpDpelW+5L12eMURnt82Rpu9uUYMS6w+k7y
	UdUdQ9uM9cpzPOXxQ7nbB9014ZYl6luUoArMvQE1xfd1pI8nr2eFzTVL5HxO0GwnYd/6B3/KMjJ
	ssU3Zf6Zmw1QRa9vmTuvU9EoFxUD1LXnNUJgHniAOtmmmpzgIwEDGv+M2KXKSf+ZsMIAJenlb50
	GS1zv3JRN3pNfkQurvQK9yQsR7iKZIQLmEbnRRkw+DUUy01+zWiGXKWlYvfdXBYBRK1ibvw0K6O
	ax/46XgMWK/cEQMmZWo2VbtrmW6TrO0nyw/DtM/P9kNHOdGgOuJ8XjizMvDN2JLlR
X-Google-Smtp-Source: AGHT+IGowIlSkKw5ZzZZdWP+ydqqTiOhlwErsI/LyHjZ9eAmji8YiDyEbd4SmQnr4FCIgMmyEZUdfw==
X-Received: by 2002:a05:6000:2013:b0:3a4:eef9:818a with SMTP id ffacd0b85a97d-3b776645908mr2258005f8f.27.1753458346798;
        Fri, 25 Jul 2025 08:45:46 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778eb2779sm249038f8f.15.2025.07.25.08.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 08:45:46 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 5/8] pwm: mediatek: Implement .get_state() callback
Date: Fri, 25 Jul 2025 17:45:09 +0200
Message-ID: <20250725154506.2610172-15-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3468; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=CgxDKiGIOk5/DJiW6ZyvTBtPHuWR1BwYQvTWRkSTQw8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBog6aQ33zONElPxjZ4ALhMQd0DOuzGO2NKTOZXb mtJniR1ocaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIOmkAAKCRCPgPtYfRL+ TrpQB/9Ik6Qzx21eI6DYqkiOeUDeQuwH9crnOd10V0aDbGnzsezDdRP92c7DUMl4F7G8nNl+J8U 3Eq2uzAHL5uiyC6VZlJweJH2vqXiKuA32h05/qggi3tm48E7zchtLZkp6+xkRIo++5Duz6z8fuy Q9cIpGHRe3i1l7C0Nl3zgZOYwifAQhyIa0PzO2HjZ0yriOZduMuq3cmRYgx+44t3YTeW52Zmzs7 WXIZvGKALMpqd4gyXfJ8ctGCws6y0PHnOaPbFkeX8rU7dI1Cqo1p8ZpeUSXwnHghCp9ZB2GxAf2 93cjWMTr3NEPIYnJojwcjhSN824TxfNto0AZB95wRbrvX7mW
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
index 7d0a6f41d671..05263a17d55d 100644
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
 static void pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
@@ -231,8 +239,70 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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
2.50.0


