Return-Path: <linux-pwm+bounces-9716-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2+lZMlkmVmpo0AAAu9opvQ
	(envelope-from <linux-pwm+bounces-9716-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:06:49 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9174175445E
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:06:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="gPM5n4f/";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9716-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9716-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE28B300C0C7
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 12:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19D336F8F3;
	Tue, 14 Jul 2026 12:03:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FA38F23D;
	Tue, 14 Jul 2026 12:03:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030595; cv=none; b=Ct4oPle+nckCTPbwxuwHW/aW2/IDedA0gWS5tvVmUFjruhxYYOWre+HUW4NLJbwbBi2r1j1F7dKZaxiiH9+mXxOwDAViLs2gYMxWu5KJk4q6Dh84JTj9QeRA9eTDabbJRdmPFdRZYZQmlNSY6RR8x9MSBxUpsTceZwbol0GSvXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030595; c=relaxed/simple;
	bh=9dA+6t34pMSi8qJ2BqbrCAW16Zr5GHup4B2vPWEWisI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyRclwNqzekIN/Q1N0Hopdp/Zt5nMALp7g7bK+J+G3OXYRUrGZtIov71ktW7d+XLpZoEwaHsBPdoRNHKCbqbLWvq44/nnNWapjZ9hFrt/V3qjzlu+HIJGTZE/wvkOVSYGiWkHciJM8KO3OAgTeGcULl0/B2vcBl8v2ULlNFF18c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPM5n4f/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AD6FA1F00A3A;
	Tue, 14 Jul 2026 12:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784030590;
	bh=JmkdDJ43Cm/VdhAf41H08opF2ADVkyfZJL95zSmuYN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gPM5n4f/tlywSVmiPxUimCsxugHPNBcBg+wB0MofRbOdYrXHphOVHyjR85DrDAJQf
	 z9FimPEOE8/7JMBS4CdLxqpF7iKHeIp3fmbwqWFpmXD01p08e42bVH9RiU3y0sWwih
	 2ATjRocP5FsyuNqihZxqgh9nS6fjDumrPXcPaJi6u/1cIaes/IB0Lqm+OTLwxMj7Hw
	 UHx9ghWf1gnJyvUGazG4tdp15e38wS/7B6Bvi+hBK40GwW62BhyzMoO6ewsCz+iwy3
	 1bWppXjQSAJLqQWzesBjR+Pzr7fPzsJaBVMM2zUwM+Xjy+wT8EGhybqxnaUUEpcd5b
	 Hj89e1oQ6MC6A==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v1 4/6] pwm: tegra: Simplify using devm_reset_control_get_exclusive_deasserted()
Date: Tue, 14 Jul 2026 14:02:38 +0200
Message-ID:  <1f12ae7f9479aa910fcaf066fae82c7b7cb89073.1784030076.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1784030076.git.ukleinek@kernel.org>
References: <cover.1784030076.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; i=ukleinek@kernel.org; h=from:subject:message-id; bh=9dA+6t34pMSi8qJ2BqbrCAW16Zr5GHup4B2vPWEWisI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqViVl461s/SnIyf+M8qzpe3b0RIT4BH29rsXDY /fgfx8c0jiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCalYlZQAKCRCPgPtYfRL+ TjNtCACPyEfaAPG6Tav012bZBd75EZeppqe9z8IsaKbkYXrjK75PanoCU5NV7i2vJdDoQHpJZyy PV40VtCm/Qvln7yVwYmbv0vp7aQzKWOpaUlxEZ05nkbfNCaAPC68wU7GymU4AzpshPsTCfsx8sY MHmG57mfiY+D58NC65IRn/+EUy6hxvgeavNa1kitZ0o04SkHe8F5zXMAlW0qzWqeJ+hTNcRJspl SechmAqJlJAxrrAGd7K2DTZug7L34Yd9B0Sw4rtbOZ2TQ9Dp2mncWXoA6LdwgZX+1MVFuCmUbg0 W7Rohzler8N25DEQf+Px4b/kBYOxKRnxqfB+O7NddJ9ZLnID
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:mperttunen@nvidia.com,m:p.zabel@pengutronix.de,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9716-lists,linux-pwm=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9174175445E

This function ensures the reset is already deasserted at probe time and
asserted at unbind. So the remove function and the error paths in the
probe function can be simplified accordingly.

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 drivers/pwm/pwm-tegra.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index e99e1c5b18c3..d7f4baa4cd9b 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -108,7 +108,6 @@ struct tegra_pwm_soc {
 
 struct tegra_pwm_chip {
 	struct clk *clk;
-	struct reset_control*rst;
 
 	unsigned long clk_rate;
 	unsigned long min_period_ns;
@@ -319,6 +318,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct pwm_chip *chip;
 	struct tegra_pwm_chip *pc;
+	struct reset_control*rst;
 	const struct tegra_pwm_soc *soc;
 	int ret;
 
@@ -391,20 +391,17 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	pc->min_period_ns =
 	    (NSEC_PER_SEC / (pc->clk_rate / TEGRA_PWM_DEPTH)) + 1;
 
-	pc->rst = devm_reset_control_get_exclusive(dev, "pwm");
-	if (IS_ERR(pc->rst)) {
-		ret = dev_err_probe(dev, PTR_ERR(pc->rst), "Failed to get reset control\n");
+	rst = devm_reset_control_get_exclusive_deasserted(dev, "pwm");
+	if (IS_ERR(rst)) {
+		ret = dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset control\n");
 		goto put_pm;
 	}
 
-	reset_control_deassert(pc->rst);
-
 	chip->ops = &tegra_pwm_ops;
 
 	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "Adding pwmchip failed\n");
-		reset_control_assert(pc->rst);
 		goto put_pm;
 	}
 
@@ -419,11 +416,8 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 static void tegra_pwm_remove(struct platform_device *pdev)
 {
 	struct pwm_chip *chip = platform_get_drvdata(pdev);
-	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 
 	pwmchip_remove(chip);
-
-	reset_control_assert(pc->rst);
 }
 
 static int __maybe_unused tegra_pwm_runtime_suspend(struct device *dev)
-- 
2.55.0.11.g153666a7d9bb


