Return-Path: <linux-pwm+bounces-9713-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vJvxKoUpVmq30QAAu9opvQ
	(envelope-from <linux-pwm+bounces-9713-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:20:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A87B754715
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:20:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DAftm8xI;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9713-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9713-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E19B7327EC71
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 12:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA42238D3F2;
	Tue, 14 Jul 2026 12:03:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66884384CFB;
	Tue, 14 Jul 2026 12:03:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030586; cv=none; b=ppPHiO80A00uQcVS5pMCP5tigmbjR8J2CwYBsxUl7ZXwacUmIc9DocBbfN6oHCcxNZ2QFPT5MJqLPLIEQT1KcvvRKXFqOC9Pq4os7VUDd2qcfLMSmY/QBRrdWMFrg/HM+5K4wVp1SdlNs6S0vVMCVYbYoHBE7L1hve8Bj5UIE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030586; c=relaxed/simple;
	bh=dcigbRou6TH+aATJPtBQ76g+mQZMJfkDmVD1d/Isbic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPvZCTQuPB9wi8bKv1A2CX1RkqoiiTxScH7a1MYdTq8fIg0+Suu7DBA/otdthWuKalGrKu9wWXwM4/Xg2ugOGwjshA1KaYbRfzXSUG0LDXWF12d/hG1q9HYA1mugBc0DznOMjDpNuz5uD22K68TjuaS+flDoqYakdQAfp+VixLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAftm8xI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 885911F000E9;
	Tue, 14 Jul 2026 12:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784030585;
	bh=lhKgnjohH3tuJlecyZ9C3GCiImj1ilJw/Wru5yy+Urg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DAftm8xI/BJ9slKFJyWoQMgw9LNa5jFSHfLAlMiqJocyhnGwDpQMfW2I09GOKe8zg
	 gfEJndACjkeS+zo6zRZ7CV7c32p8jb98QbQoxB6ugTyNiQgNzZk85w/yfphkYfefim
	 sP37zZvx9RYNLmyJGaNVZ3mGHcyvDVu+KxmPSbYbEw64e+cwykEHDk4S9iQSB+nSOV
	 fYOPFVn9Uy+TlxhDKziCj/+HgdyB7nn63SCGyTg/eYJ2YqJwsAci8T6tVUCzaE8YiZ
	 rTwNp7wJCLIibfNsPhXGBYCSPEJVPp4hWha8bwiazpzzLM0ynKzdR/C7OVMtN/DDiq
	 rPaceysFzutaQ==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v1 2/6] pwm: tegra: Make use of dev_err_probe()
Date: Tue, 14 Jul 2026 14:02:36 +0200
Message-ID:  <0080b5bc2e7268740216bd911fd2c2358f219dc5.1784030076.git.ukleinek@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4161; i=ukleinek@kernel.org; h=from:subject:message-id; bh=dcigbRou6TH+aATJPtBQ76g+mQZMJfkDmVD1d/Isbic=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqViVgZtV/o7lyYqkrUSgFiCXl0FiyK83UKp3xn TMCxDSaaTqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCalYlYAAKCRCPgPtYfRL+ ThcsCAC1cI/MypaNy/2lb0ABcxCRGatgaMqGgd0F4+IvvArzBziWIB+wl1gc2NzKA82D9L+IwYo ersxTJeplicffH6sfqXvO9RrUyA2FSWdRg/ySeIjx/ln5BLyzVf9CjASbsixQNNhvvTC3+zxvuJ aP2ZKocj5/Ldf6P1SJtB3jV72Jqxc85whl8bTKr7hzl9bpq1rrgKkOuappyS2oyQjOJq3fULFfN lZprfhKpimrydGeGc6zDo4DnUEA/WbI9Kf4zF5RxxAwLUTY9UdK2gBPoGCe0avFjqhzskI76f4m C6QdYJ7sZViGvH6X2155JU+CWjIHvHfr0A2YScKYipxSs+U9
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-9713-lists,linux-pwm=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A87B754715

Usage of dev_err_probe() is more compact than dev_err()'s, emits the
error code and handles -ENOMEM and -EPROBE_DEFER properly. Benefit from
these improvements.

Also add a few messages in error paths that lacked an output before.

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 drivers/pwm/pwm-tegra.c | 44 ++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 53743f83869a..dba9a05675e3 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -316,6 +316,7 @@ static const struct pwm_ops tegra_pwm_ops = {
 
 static int tegra_pwm_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct pwm_chip *chip;
 	struct tegra_pwm_chip *pc;
 	const struct tegra_pwm_soc *soc;
@@ -330,7 +331,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 		 */
 		return dev_err_probe(dev, -ENODEV, "Unsupported device\n");
 
-	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_channels, sizeof(*pc));
+	chip = devm_pwmchip_alloc(dev, soc->num_channels, sizeof(*pc));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	pc = to_tegra_pwm_chip(chip);
@@ -339,27 +340,36 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	pc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->regs))
+		/*
+		 * devm_platform_ioremap_resource() already emits an error
+		 * message with CONFIG_HAS_IOMEM, so don't emit another message
+		 * here.
+		 */
 		return PTR_ERR(pc->regs);
 
 	platform_set_drvdata(pdev, chip);
 
-	pc->clk = devm_clk_get(&pdev->dev, NULL);
+	pc->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(pc->clk))
-		return PTR_ERR(pc->clk);
+		return dev_err_probe(dev, PTR_ERR(pc->clk), "Failed to get clock\n");
 
-	ret = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
+	ret = devm_tegra_core_dev_init_opp_table_common(dev);
 	if (ret)
+		/*
+		 * devm_tegra_core_dev_init_opp_table_common() emits an error
+		 * message most of the time, so don't add another.
+		 */
 		return ret;
 
-	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_resume_and_get(&pdev->dev);
+	pm_runtime_enable(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to runtime resume device\n");
 
 	/* Set maximum frequency of the IP */
-	ret = dev_pm_opp_set_rate(&pdev->dev, ULONG_MAX);
+	ret = dev_pm_opp_set_rate(dev, ULONG_MAX);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
+		dev_err_probe(dev, ret, "Failed to set max frequency\n");
 		goto put_pm;
 	}
 
@@ -370,8 +380,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	 */
 	pc->clk_rate = clk_get_rate(pc->clk);
 	if (pc->clk_rate < TEGRA_PWM_DEPTH) {
-		dev_err(&pdev->dev, "clock maximum frequency out of range\n");
-		ret = -ERANGE;
+		ret = dev_err_probe(dev, -ERANGE, "Clock maximum frequency out of range\n");
 		goto put_pm;
 	}
 
@@ -379,10 +388,9 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	pc->min_period_ns =
 	    (NSEC_PER_SEC / (pc->clk_rate / TEGRA_PWM_DEPTH)) + 1;
 
-	pc->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");
+	pc->rst = devm_reset_control_get_exclusive(dev, "pwm");
 	if (IS_ERR(pc->rst)) {
-		ret = PTR_ERR(pc->rst);
-		dev_err(&pdev->dev, "Reset control is not found: %d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(pc->rst), "Failed to get reset control\n");
 		goto put_pm;
 	}
 
@@ -392,17 +400,17 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	ret = pwmchip_add(chip);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
+		dev_err_probe(dev, ret, "Adding pwmchip failed\n");
 		reset_control_assert(pc->rst);
 		goto put_pm;
 	}
 
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put(dev);
 
 	return 0;
 put_pm:
-	pm_runtime_put_sync_suspend(&pdev->dev);
-	pm_runtime_force_suspend(&pdev->dev);
+	pm_runtime_put_sync_suspend(dev);
+	pm_runtime_force_suspend(dev);
 	return ret;
 }
 
-- 
2.55.0.11.g153666a7d9bb


