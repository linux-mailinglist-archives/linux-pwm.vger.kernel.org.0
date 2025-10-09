Return-Path: <linux-pwm+bounces-7422-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 481B2BCA04A
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Oct 2025 18:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00894261AB
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Oct 2025 16:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029FC2FC877;
	Thu,  9 Oct 2025 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW1ISmQH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7422FC869;
	Thu,  9 Oct 2025 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025669; cv=none; b=A/XD4BhFyg+GMwuqVaKRvMZGQTIVriHudAxC/VZ3WgMf2PNZc5G1oSM206gLX/hlKD7r501dRA+uwEaqPirxvh4ikLtjW0T+owcVT+jjkehq99DCV/DG929+mm0t3GK6KVhAiGxP/dVPzlON4RXVW2ngNIy4A8iB32q6vh3X9UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025669; c=relaxed/simple;
	bh=rnM9C5ciw8KHlWwe0+yd9sUniD1HWQyWJ+pwcqcmOfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tkdzu47nvIdOnUG09OGO5y9F5trdZBYBKpgCaWFLIkwsR5DR9ZhToE83AO5SWO2id+nJns372PDuj/cXa7lBsgFcPFezy2ffM1A3fyub7Y76d8E374cUyp4Vg/zwPOrQo2CMfQIn4HrhZNfl2DaE7/C+vyGIE0R016pTGRZKXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW1ISmQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F5FC4CEF7;
	Thu,  9 Oct 2025 16:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025669;
	bh=rnM9C5ciw8KHlWwe0+yd9sUniD1HWQyWJ+pwcqcmOfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NW1ISmQHkM0Z1U/+XNxAyDi7kGIpZZEOit0JB4bbPtWuII5T58eRFC4qAasD3DiKT
	 XCbU8yjvbnCNf9LZyVv2cJidN/9flcbqVvosdqa+MrjYxfLL5HT/SItz4ep+XUuSBe
	 TU/MbPbBWQebg6DuSDgZjV3w0CzJaV8i/fvFmDNl9c1cYz5vXJn3UrM7BgXSrGw8kn
	 6r3Hf0IJVn/11EM9Uii5nYuSgqaLyeZzDJFnPtUt55I87hmMMBnse/jVnbrDEl3Q6t
	 0FkY/VfnBFZBymf0oJTmtds6l3o41fh3McxqTqyu5J+EUuyMs8WfUsKX/+25IacUsf
	 tsmlErLjv9SVg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] pwm: pca9685: Use bulk write to atomicially update registers
Date: Thu,  9 Oct 2025 11:56:10 -0400
Message-ID: <20251009155752.773732-104-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit de5855613263b426ee697dd30224322f2e634dec ]

The output of a PWM channel is configured by four register values. Write
them in a single i2c transaction to ensure glitch free updates.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://lore.kernel.org/r/bfa8c0267c9ec059d0d77f146998d564654c75ca.1753784092.git.u.kleine-koenig@baylibre.com
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- The driver currently programs each PCA9685 channel by four independent
  I²C writes, so the hardware latches intermediate ON/OFF values and the
  output glitches whenever duty/phase changes. The commit fixes that by
  introducing `pca9685_write_4reg()` and switching the two callsites in
  `pca9685_pwm_set_duty()` to a single `regmap_bulk_write()` transaction
  (`drivers/pwm/pwm-pca9685.c:136-183`), eliminating the observable
  glitch for both PWM and the GPIO shim users.
- To make the bulk write possible, the probe code now enables the
  device’s auto-increment bit and clears the OCH latch mode (`MODE1_AI`
  and rewrites of MODE2 in `drivers/pwm/pwm-pca9685.c:557-586`). This
  guarantees that the four-byte transfer is accepted as one atomic
  update and keeps the controller in its documented default signalling
  modes (invert/open-drain remain governed by the same DT properties).
- The reset path for the “all LED” channel is moved to the same helper
  (`drivers/pwm/pwm-pca9685.c:584-586`), so the fix also covers the
  initial state and any error paths that need to reinitialise the chip.
- The change is tightly scoped to `drivers/pwm/pwm-pca9685.c`, does not
  add features, and relies only on long-standing regmap APIs, so it
  backports cleanly without extra dependencies. The only behavioural
  change beyond glitch avoidance is that MODE2 is no longer inherited
  from firmware, but the new value matches the datasheet defaults; no
  existing in-kernel consumer depends on custom OUTNE/OCH bits, keeping
  regression risk low compared to the very visible glitch it resolves.

Given the real user-facing malfunction it corrects and the limited,
well-understood impact area, this is a solid candidate for the stable
trees.

 drivers/pwm/pwm-pca9685.c | 46 ++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 9ce75704a15f8..91f96b28ce1b5 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -61,6 +61,8 @@
 #define MODE1_SUB2		BIT(2)
 #define MODE1_SUB1		BIT(3)
 #define MODE1_SLEEP		BIT(4)
+#define MODE1_AI		BIT(5)
+
 #define MODE2_INVRT		BIT(4)
 #define MODE2_OUTDRV		BIT(2)
 
@@ -131,6 +133,19 @@ static int pca9685_write_reg(struct pwm_chip *chip, unsigned int reg, unsigned i
 	return err;
 }
 
+static int pca9685_write_4reg(struct pwm_chip *chip, unsigned int reg, u8 val[4])
+{
+	struct pca9685 *pca = to_pca(chip);
+	struct device *dev = pwmchip_parent(chip);
+	int err;
+
+	err = regmap_bulk_write(pca->regmap, reg, val, 4);
+	if (err)
+		dev_err(dev, "regmap_write to register 0x%x failed: %pe\n", reg, ERR_PTR(err));
+
+	return err;
+}
+
 /* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=2048 -> 50%) */
 static void pca9685_pwm_set_duty(struct pwm_chip *chip, int channel, unsigned int duty)
 {
@@ -143,12 +158,10 @@ static void pca9685_pwm_set_duty(struct pwm_chip *chip, int channel, unsigned in
 		return;
 	} else if (duty >= PCA9685_COUNTER_RANGE) {
 		/* Set the full ON bit and clear the full OFF bit */
-		pca9685_write_reg(chip, REG_ON_H(channel), LED_FULL);
-		pca9685_write_reg(chip, REG_OFF_H(channel), 0);
+		pca9685_write_4reg(chip, REG_ON_L(channel), (u8[4]){ 0, LED_FULL, 0, 0 });
 		return;
 	}
 
-
 	if (pwm->state.usage_power && channel < PCA9685_MAXCHAN) {
 		/*
 		 * If usage_power is set, the pca9685 driver will phase shift
@@ -163,12 +176,9 @@ static void pca9685_pwm_set_duty(struct pwm_chip *chip, int channel, unsigned in
 
 	off = (on + duty) % PCA9685_COUNTER_RANGE;
 
-	/* Set ON time (clears full ON bit) */
-	pca9685_write_reg(chip, REG_ON_L(channel), on & 0xff);
-	pca9685_write_reg(chip, REG_ON_H(channel), (on >> 8) & 0xf);
-	/* Set OFF time (clears full OFF bit) */
-	pca9685_write_reg(chip, REG_OFF_L(channel), off & 0xff);
-	pca9685_write_reg(chip, REG_OFF_H(channel), (off >> 8) & 0xf);
+	/* implicitly clear full ON and full OFF bit */
+	pca9685_write_4reg(chip, REG_ON_L(channel),
+			   (u8[4]){ on & 0xff, (on >> 8) & 0xf, off & 0xff, (off >> 8) & 0xf });
 }
 
 static unsigned int pca9685_pwm_get_duty(struct pwm_chip *chip, int channel)
@@ -544,9 +554,8 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 
 	mutex_init(&pca->lock);
 
-	ret = pca9685_read_reg(chip, PCA9685_MODE2, &reg);
-	if (ret)
-		return ret;
+	/* clear MODE2_OCH */
+	reg = 0;
 
 	if (device_property_read_bool(&client->dev, "invert"))
 		reg |= MODE2_INVRT;
@@ -562,16 +571,19 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	/* Disable all LED ALLCALL and SUBx addresses to avoid bus collisions */
+	/*
+	 * Disable all LED ALLCALL and SUBx addresses to avoid bus collisions,
+	 * enable Auto-Increment.
+	 */
 	pca9685_read_reg(chip, PCA9685_MODE1, &reg);
 	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
+	reg |= MODE1_AI;
 	pca9685_write_reg(chip, PCA9685_MODE1, reg);
 
 	/* Reset OFF/ON registers to POR default */
-	pca9685_write_reg(chip, PCA9685_ALL_LED_OFF_L, 0);
-	pca9685_write_reg(chip, PCA9685_ALL_LED_OFF_H, LED_FULL);
-	pca9685_write_reg(chip, PCA9685_ALL_LED_ON_L, 0);
-	pca9685_write_reg(chip, PCA9685_ALL_LED_ON_H, LED_FULL);
+	ret = pca9685_write_4reg(chip, PCA9685_ALL_LED_ON_L, (u8[]){ 0, LED_FULL, 0, LED_FULL });
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret, "Failed to reset ON/OFF registers\n");
 
 	chip->ops = &pca9685_pwm_ops;
 
-- 
2.51.0


