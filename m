Return-Path: <linux-pwm+bounces-3611-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A570299B04E
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 05:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC5A1F23467
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 03:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD9B839F4;
	Sat, 12 Oct 2024 03:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y4qnNvNl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6061224D7;
	Sat, 12 Oct 2024 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728702348; cv=none; b=eJ6PJZtKkXcHQubb+4aNfck9eal9SgD20yNMce8qd9SJkO3FMo0Ji13InR7sKweCx2oBOJFeAHBVWNT+rwHGxb1HRKbXNC/Y5Zjbt6OYKD9RCIvr0mNm1O8BPb4zy4ivR+4y6aebKtWILNF+8ZwJ1TgLPPM+PBbQw8JRQp8aHGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728702348; c=relaxed/simple;
	bh=xcbxZozTzOOydjpY37v/9USjfCOMyBAeZHXAiSdCmSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LxI/OUXLy0Y8nGxrI4DlG2CxN3ato4EFLZF68NtXkNaORaqzojULJDJjP0PLqdEb91dmvI8H+DhIplzYWm/ooYuKCy2Dbq5M1BMTltHbh5sBKh3LLl4XyzDdA9S1kv20r7zJjUVsPTqWRjOcDVdDT7nMrqgWOgDID+5YMkTLhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y4qnNvNl; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id AEFE0C0000F1;
	Fri, 11 Oct 2024 19:56:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com AEFE0C0000F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1728701770;
	bh=xcbxZozTzOOydjpY37v/9USjfCOMyBAeZHXAiSdCmSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4qnNvNlFxWS1FvRM9AXNoGD0hKC+Ezc+/DYFDglxWqw2lgE+y/nwbPwHxgbvxfLD
	 cpnzcl+UiVnmTjCJUEJdIhVvP6vWuL4xMjFIjEmdnyPwgzbc+lyzaYGxBpCrDaGhWm
	 duAAIAk1m/EhC02do1VBTXbYBskcBYHn6ZsuxraY=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 5825318041CAC6;
	Fri, 11 Oct 2024 19:56:10 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE),
	justin.chen@broadcom.com
Subject: [PATCH 2/2] pwm: brcmstb: Do not assume open drain configuration
Date: Fri, 11 Oct 2024 19:56:03 -0700
Message-Id: <20241012025603.1644451-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241012025603.1644451-1-florian.fainelli@broadcom.com>
References: <20241012025603.1644451-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read the 'open-drain' property to determine whether the PWM controller
output(s) should be configured in open-drain versus totem pole mode.

Fixes: 3a9f5957020f ("pwm: Add Broadcom BCM7038 PWM controller support")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/pwm/pwm-brcmstb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 0fdeb0b2dbf3..b7cecd36ed57 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -55,6 +55,7 @@ struct brcmstb_pwm {
 	void __iomem *base;
 	struct clk *clk;
 	struct pwm_chip chip;
+	bool open_drain;
 };
 
 static inline u32 brcmstb_pwm_readl(struct brcmstb_pwm *p,
@@ -176,6 +177,7 @@ static int brcmstb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 static inline void brcmstb_pwm_enable_set(struct brcmstb_pwm *p,
 					  unsigned int channel, bool enable)
 {
+	u32 oe_mask = p->open_drain ? CTRL_OPENDRAIN : 0;
 	unsigned int shift = channel * CTRL_CHAN_OFFS;
 	u32 value;
 
@@ -183,9 +185,9 @@ static inline void brcmstb_pwm_enable_set(struct brcmstb_pwm *p,
 
 	if (enable) {
 		value &= ~(CTRL_OEB << shift);
-		value |= (CTRL_START | CTRL_OPENDRAIN) << shift;
+		value |= (CTRL_START | oe_mask) << shift;
 	} else {
-		value &= ~((CTRL_START | CTRL_OPENDRAIN) << shift);
+		value &= ~((CTRL_START | oe_mask) << shift);
 		value |= CTRL_OEB << shift;
 	}
 
@@ -244,6 +246,7 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, p);
 
+	p->open_drain = device_property_read_bool(&pdev->dev, "open-drain");
 	p->chip.dev = &pdev->dev;
 	p->chip.ops = &brcmstb_pwm_ops;
 	p->chip.npwm = 2;
-- 
2.34.1


