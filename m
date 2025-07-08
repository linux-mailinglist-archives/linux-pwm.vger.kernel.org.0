Return-Path: <linux-pwm+bounces-6783-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273A2AFD528
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E48C480EFD
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9571F2E5413;
	Tue,  8 Jul 2025 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MtF0LBYz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA433F9E8
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995152; cv=none; b=amyjHQwzGbGSDj0Vme9702NKEJWAFdgfQSk1uW8VJdrriaCgY1S94agALc5za6QzoGLVAEe8r2pKUPvHK6QHaw2KFaUOO8Bgco7gZGvPKp6xbz/7cJVz3K6nDTg1Ppu/0d3ztvOKwZ4sVXA5yL88QhAB7WHOVc+71Bjwnlf7T1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995152; c=relaxed/simple;
	bh=19ZdI8deIAcCXvNH+gETZCD8gWi46FYY73oPnFFbcmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=joPxTAKG3FMYHnuVVvhPKIVLAnk/qULje5y/LUIjCZghNov5NJQ/xpnwcTGvP2ZnQvx7g5MlaZpfGqBuJ0rz41RqB4GmA+bBSQy7Sb0rZKd6483wY78iVflgUs3g6EN+KG5wJtZRip2QhrhhzVkn5G7HYuhD3TtaU4agjwqEet4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MtF0LBYz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae361e8ec32so925314866b.3
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995149; x=1752599949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/ATAoJA1B/BYrlImzJt+hnLQ0qBzgSKQ71TlK7q7Sc=;
        b=MtF0LBYzWysYRSKg3R49v+ohG8Ke+LXvbc70KcBxet8LHUcPiFcrKGwG8AgiXpJOlK
         7yMteGlFy31pAf1xnxFb9if3beEMTK9sIL+CaN4cY8t1ASWE1pY4T802d8z9pYOU/kUY
         v6v3cagbSthyg4vhF0SILdXwO4Pilv3BcrBoS+qr8qh8plY3SjS+vkp4hjI2+mNcjofp
         7p37U3TgpYha7m0/ps4vyPYdY2yTVjNodVdV2YAg9XEWf1N/q/UOWwTNJwZESC/pdQy7
         C7edGTLSLkEoMi0u3EjG3LJgVL7iMLeQwTSEuTim1q6e2G4ldElU3aIUx7S9Or083721
         7ciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995149; x=1752599949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/ATAoJA1B/BYrlImzJt+hnLQ0qBzgSKQ71TlK7q7Sc=;
        b=t3yRQv+6sSSmsPchDaG+EPB7CyXWDUiGBhYM3+72SYacC/UlTeIkRsBqR5I6tFln07
         TVncxA27RQ+yE+tEsRgUxsGrXLYLxZL2bxuNVMBBhJoNpN3s/mrklJpqjsspvV8GCYsr
         iAbgRA4fWLhQ7UYGv5d8iWwo27N0dlbZsUPGqxq5uUnaHVHswuhFN2ruec8i8Wa74qUF
         7Z2w3S58USGldGn9aNTGvc9IPd6gLK4Qdbc+6QJdTrI788VXWsDIZ0TvvScXqyctwWLu
         kH2tvSvtiWVmNYS/ODQTfmcxkj4atJ8w4xECrhGkyv6/zOSwNoANn9G4yymlDHViVH8E
         sm2Q==
X-Gm-Message-State: AOJu0YyPV47EDQrARVffivwfm4EmYW8mJZh04FNa0wYzyuJUOeod6501
	fC2vAufwUdO81LPjTnlVEZGpge0+COwiNiT+449enGX7J8xfiVkx+/V41C5k0CccTOg=
X-Gm-Gg: ASbGncuFy3CWh3hn4sAP0mJU9L7cBMfYzHJX+6H0N+PojHntYZgU8/QQhnt2oZm2ucj
	GuzDhRGcpp5V3zrfCB9KLHENNamoTEzBMFnFjGuVCz4/rdswvH/etwTAYY1pSsLjwWXCjWf1oqc
	dNq5qEjZAbxYPncvbW4tzRMVUYN3EXC7Blg4mgi7XMsafKosS7SggDnprh9dMSzeoMbRAIj7NDf
	0+sbuYbPhkzgjPr4gmlIiJjLeBq3A4WoSgZg5x1FVM1u4Kv29QeUFlVsb3hVQDSw8xtjguAon9M
	SawDIuysTLi5ekCkfHB+ZU73c9zTdCLakihw56+bqrm2tgxt61zkgGWAlS4vzAaU3h+d+LENjUt
	kpvbrcc1aF1chSfaZ5TaJPs/aTMBG
X-Google-Smtp-Source: AGHT+IGucY9wMs7PPxnmYrtor4bXdxwyYwkd/rVLgKZxlKqD6066rMDLI+nsaWmwtsE5QbvvgbtN8w==
X-Received: by 2002:a17:907:724a:b0:ae0:a245:2fef with SMTP id a640c23a62f3a-ae6b0b755fcmr447729366b.20.1751995148752;
        Tue, 08 Jul 2025 10:19:08 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae3f6ac5fd7sm930253266b.103.2025.07.08.10.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:19:08 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 4/8] pwm: mediatek: Initialize clks when the hardware is enabled at probe time
Date: Tue,  8 Jul 2025 19:18:34 +0200
Message-ID:  <b207c0aeb73d0da96736e38363640f8bee226014.1751994509.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2039; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=19ZdI8deIAcCXvNH+gETZCD8gWi46FYY73oPnFFbcmk=; b=owGbwMvMwMXY3/A7olbonx/jabUkhozcoM8P/LqPHVqpflnoI/OLM6kmm8ICr5zcuW/ZF/Y2p bwnX7l2djIaszAwcjHIiimy2DeuybSqkovsXPvvMswgViaQKQxcnAIwkQVe7H8FH2UtOf57mYvV lL0HHQtzemub64XUj+z4e8w9unDzX5V/70MusK5l39w0beoMj65168x03mak2tTHMMqWLNTqr1i WWavOk/TTsbJok5iFytuYU3Ifxavjatut1wd1dUp79Ilsvbm42uyo05rbFd31d388OW/ZKMvuvb L6lp7D0r+GRf80fSbz3A2qlvloq+tg7uXDe+3XdK/nXz4dWOZ5JclO3S1Uq2jnhVQVvlUbfb422 1lbX6n4tXl6Qtzfb9u+s7Kv7m50cfFYzKEb43bc8GNE8wPWNz+rl7e26HNk6ngHna8/VPagMGHy troFe0qZxV242jSW1G0t/pyi6fSholvzGPMNh3f5unbqAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When a PWM is already configured by the bootloader (e.g. to power a
backlight), the clk enable count must be increased to keep clock usage
balanced. So check which PWMs are enabled during probe and enable the
respective clocks.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 47 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 8cc61a835cd5..376d059c47bf 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -228,6 +228,49 @@ static const struct pwm_ops pwm_mediatek_ops = {
 	.apply = pwm_mediatek_apply,
 };
 
+static int pwm_mediatek_init_used_clks(struct pwm_mediatek_chip *pc)
+{
+	const struct pwm_mediatek_of_data *soc = pc->soc;
+	unsigned int hwpwm;
+	u32 enabled, handled = 0;
+	int ret;
+
+	ret = clk_prepare_enable(pc->clk_top);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(pc->clk_main);
+	if (ret)
+		goto err_enable_main;
+
+	enabled = readl(pc->regs) & GENMASK(soc->num_pwms - 1, 0);
+
+	while (enabled & ~handled) {
+		hwpwm = ilog2(enabled & ~handled);
+
+		ret = pwm_mediatek_clk_enable(pc, hwpwm);
+		if (ret) {
+			while (handled) {
+				hwpwm = ilog2(handled);
+
+				pwm_mediatek_clk_disable(pc, hwpwm);
+				handled &= ~BIT(hwpwm);
+			}
+
+			break;
+		}
+
+		handled |= BIT(hwpwm);
+	}
+
+	clk_disable_unprepare(pc->clk_main);
+err_enable_main:
+
+	clk_disable_unprepare(pc->clk_top);
+
+	return ret;
+}
+
 static int pwm_mediatek_probe(struct platform_device *pdev)
 {
 	struct pwm_chip *chip;
@@ -275,6 +318,10 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 					     "Failed to get %s clock\n", name);
 	}
 
+	ret = pwm_mediatek_init_used_clks(pc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to initialize used clocks\n");
+
 	chip->ops = &pwm_mediatek_ops;
 
 	ret = devm_pwmchip_add(&pdev->dev, chip);
-- 
2.49.0


