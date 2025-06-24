Return-Path: <linux-pwm+bounces-6511-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189C4AE6E72
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 20:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EC83A8EE3
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 18:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA9E2E7637;
	Tue, 24 Jun 2025 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VLF4XE8z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BE32E7172
	for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788983; cv=none; b=Z0dCQ2pcaysTZqP86LvqkzmR/WQ805OFKp9dYLxV9yzBBEaNn6Ts8f8cOvq+tBiN5unkWlmi88bkzDZ0mxwEWWSp3wBezY/S5S9hoMW1LSiwfu+rhZNPUHjvDlt8gojFy3JR7er5YpC+ui3ERbq27jPp/G7ErcRiKthgruEzG+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788983; c=relaxed/simple;
	bh=Grm4/8ikiEolMT+F9vV5J2vuFqu3Jgr5rE/slbokM48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrQBaAEmiYcevXPPsuLEMwIWLbbNNeXQHXdb37013XYBPdmMFqR3f8kcoX7AFI5sppSbhGlA47u/VMNqueMFaTYthOsoAzCdkbVBdO3urrjuKvcHf0cjiLmWPvp+S/C3hZtMyNsVn0qFtkp/YXGTCK6M3G7f4N0O+FJXi2Kjdhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VLF4XE8z; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ade58ef47c0so26476766b.1
        for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750788980; x=1751393780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PG9blNa6kVNTC134BShE8Y6pI0rxNsm9+LpAXIfxx14=;
        b=VLF4XE8z0dRjETY++lZvWytRHDr83S1imsKgFwJpt/0zXH6ONK7KU2pCcjHv80Hbdx
         8w8wzJYvzQXp87UtI8tX60II0aVlR7P3+/cBhMhajUF/TjyFoXTIGreLjwVdq3hrMuuR
         LbG+SIo81N+n+F2pAxVtYlEBLOWJy0YjLoC12PmoB/unYLaIh4J7q7JK/lEGS5K8MbEN
         PcKuHLOrVtGW3ndU2xtUHvVRiX26M2B6E7BOapPWewXdGIHv/VitQCTe9gjGdbg+AxNM
         SiWuZH9fjLy89dUa/U7+9RcVOOyVEZK5pWc0xJt3UXdSHGlldOBMMlaymdxEum09TOBF
         hlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750788980; x=1751393780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PG9blNa6kVNTC134BShE8Y6pI0rxNsm9+LpAXIfxx14=;
        b=QrLZY0tqzAQJ3HOamDxGWgIpL6K4L6CDRQQIelRRJMv48Kic5oQZHtkHfANFVrhqD2
         deUtDk6bWe1f4M0hIvT+V8yzGFFkYNkgxRNVZSJev2O0zBbs9Oi0uW2ez1rQ7prf72lY
         /IrL1E6kGcVujbEvUe3KFFqiNqfk/Gicm3yd+uxt5KVc8Qml3DQ2JwUTZpKrj81nI6s/
         +nJuFV1Ppklfn2rMK+Z4jV88bjJ4q+Z96li0nwWEVb9sNCn8C/5tW8GtXbdYnKEEoNBY
         +jmuVlxZk+3pq0b4nb8hlU+zTp7o/QoxJhE9QQZsP4j0yRr6MA3HzHqBQwx89wiyjQs4
         ugJA==
X-Gm-Message-State: AOJu0YzZf9OpOwhXxadNRbcAQXSFbYMBPZg50eQOZVerzXQHeX1e2TLN
	Z5Y4mZbVNa64vboMaN9Rzi2+7U56HYNDq9M0CIcN/ntPNKs5I0SaC/D6D2zx+Cdhp0nFTpQD6i7
	Cdaui
X-Gm-Gg: ASbGncvNhP1ywMhslfvmhmhVk4BEFXb1M18ixAa0VvP9w20b/nT3bz84F/QNRkKYXIY
	Ig2/AfIF+Yzhw578pcDBzqqYBaAcvPeciBB1PymceGCyE8Kxbfxbk9VdcTAYy0+Shy1AAUCphWO
	8d10rhYBhvAipDuJMbvU5xmA8bCcvOBBf8niKhFr3PpZPXcZARDgIdGM4hT5Tc2hbdTZTCI+4hV
	HEShEfNXFwbjO41H3LJFZxt8A/U0D1velxjXRxMXsfjjJDtD3C8i3EQ6D9MErfbaHb5njRoO4dA
	rGTKq+JjJraiHKVxKlaCi648AuJXPg7RT30zO3ZEsFZvh7/t+AtaATQcEsC6H8iT8To=
X-Google-Smtp-Source: AGHT+IFrcG96JrZDUtRLLfUHSmdYd0QuGzkM6KDLSamcPOlWpMggWkcGLqmh1NvtxhozeDWm8e0BSQ==
X-Received: by 2002:a17:907:94cd:b0:ae0:6621:2f69 with SMTP id a640c23a62f3a-ae0a721d166mr499379066b.13.1750788979788;
        Tue, 24 Jun 2025 11:16:19 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae0b672e340sm69784166b.180.2025.06.24.11.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 11:16:19 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/8] pwm: atmel: Drop driver local locking
Date: Tue, 24 Jun 2025 20:15:37 +0200
Message-ID:  <5ad3417aecd4dc6eca9699e21691e3725ea0bb87.1750788649.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
References: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Grm4/8ikiEolMT+F9vV5J2vuFqu3Jgr5rE/slbokM48=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoWutOAGkz0Jb/AzI9tildXjKFjjA79bDy5p4vC CzZTbK5l7uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaFrrTgAKCRCPgPtYfRL+ TsguB/9QgWDoULz9mbfbA/1g2HCUD116S2oSsL1dwLE9q6BDfeUFP6eIMPdLh5Q43Uvny0fGfcB 8aw4XkvugbwOEItlIf2COaayQ68HdsbBwgju4mLoLYKGDXkmVuyIwF2vCT1vVdl9fYhnbWdg4xO hjRsFFmGtDp/R8eHdcMsbFP4K9NdlvYDeuZUl9pScq3fWJn+mpBjb44hjsoAJYJ8QWI7Tzb8+7d xTXVpnmi0xUU8jgBwAARTw3tIPeE6DfFoWPWs9VkyZZr/8MUxx5+kSpkDYf4i6aoUXWL5MFREqH V9R/5PuC914L0oHn+lAPYnzwtczT38gmBV7Mu91T/Ry4JOrF
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The two functions making use of the lock are only called transitively from
.apply(). Calls to .apply() are already serialized by the pwm core so the
lock in the driver has no effect and can safely be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-atmel.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index b2f0abbbad63..06d22d0f7b26 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -91,9 +91,6 @@ struct atmel_pwm_chip {
 	 * hardware.
 	 */
 	u32 update_pending;
-
-	/* Protects .update_pending */
-	spinlock_t lock;
 };
 
 static inline struct atmel_pwm_chip *to_atmel_pwm_chip(struct pwm_chip *chip)
@@ -145,8 +142,6 @@ static void atmel_pwm_update_pending(struct atmel_pwm_chip *chip)
 
 static void atmel_pwm_set_pending(struct atmel_pwm_chip *chip, unsigned int ch)
 {
-	spin_lock(&chip->lock);
-
 	/*
 	 * Clear pending flags in hardware because otherwise there might still
 	 * be a stale flag in ISR.
@@ -154,16 +149,12 @@ static void atmel_pwm_set_pending(struct atmel_pwm_chip *chip, unsigned int ch)
 	atmel_pwm_update_pending(chip);
 
 	chip->update_pending |= (1 << ch);
-
-	spin_unlock(&chip->lock);
 }
 
 static int atmel_pwm_test_pending(struct atmel_pwm_chip *chip, unsigned int ch)
 {
 	int ret = 0;
 
-	spin_lock(&chip->lock);
-
 	if (chip->update_pending & (1 << ch)) {
 		atmel_pwm_update_pending(chip);
 
@@ -171,8 +162,6 @@ static int atmel_pwm_test_pending(struct atmel_pwm_chip *chip, unsigned int ch)
 			ret = 1;
 	}
 
-	spin_unlock(&chip->lock);
-
 	return ret;
 }
 
@@ -509,7 +498,6 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	atmel_pwm->data = of_device_get_match_data(&pdev->dev);
 
 	atmel_pwm->update_pending = 0;
-	spin_lock_init(&atmel_pwm->lock);
 
 	atmel_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(atmel_pwm->base))
-- 
2.49.0


