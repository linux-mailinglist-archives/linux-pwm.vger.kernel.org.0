Return-Path: <linux-pwm+bounces-8739-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNJmNe+V8GnnVAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8739-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 13:11:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F7A48364C
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 13:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E219F30A7EE5
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 10:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4F63FB7F4;
	Tue, 28 Apr 2026 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLaKGxOk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801283FB7EF;
	Tue, 28 Apr 2026 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373257; cv=none; b=NWKJlesKeqJxat8RZlYi0CvV97BYLKs0dRfrgweGHmiCy1Au7RqAoCrOkIikjTGkK6JtVjgE6Eo62TEF6exUY5uehxBYvUoCY5fpC2FFgzdx5v5KZ7hysps80mxiCUiPl0418KA4HEkE5z1UAueBozdZ79/jzblue5afFrwPLKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373257; c=relaxed/simple;
	bh=9I3S+ZMjQ+CX5ruVFO8hHEKt9n+ligax17wFo6u0nUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VCi4egTeulUrRbYu3LXFWmRpoVXSZTiLxGK9Nkfigy6fZiPVyGpcRcPOs2tuaUaTO2ikUUsXkJfRkt5diTtPlyGJYRjQXaMTqby5CQK5HlCDsEop+RqwuuiU3mwqCm/WoeKprN+luki5WdnXogU695kKDci8ifKYKbGb4i7kcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLaKGxOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BC3C2BCB6;
	Tue, 28 Apr 2026 10:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777373257;
	bh=9I3S+ZMjQ+CX5ruVFO8hHEKt9n+ligax17wFo6u0nUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LLaKGxOk+VWT+nhOtElYEmSHoBxPwYg5VhZBk2DO3Xqml+wqTAqlswriKiVLSTGje
	 KgNT7xSoJomNUjvdRWAQLWensYeNVB9Ya1KoDC0N1a1dR81zL947cJrDZMSrUkzkTi
	 EtVPQ7afGwgNbk9mhMxbeDFxw3L21FloiOTXKxdDAABDj+oIqupSkXqjGbFYxAOq2D
	 KEp+xa+hnNTnDAbFs4z3chsN8YUow7r7M1BUTqKim0ItNhQ82LrHQaDaYvLIxmmT1K
	 jtXNM8wdIPfWuevSRemc365GRbSW+gx7hHoSXLbysRDaQ2nyyoFQoP8OruOpiIcnGW
	 PBmnV6PwKTVsQ==
From: Yixun Lan <dlan@kernel.org>
Date: Tue, 28 Apr 2026 10:46:51 +0000
Subject: [PATCH v2 2/2] pwm: pxa: Add optional bus clock
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-03-k3-pwm-drv-v2-2-a532bbe45556@kernel.org>
References: <20260428-03-k3-pwm-drv-v2-0-a532bbe45556@kernel.org>
In-Reply-To: <20260428-03-k3-pwm-drv-v2-0-a532bbe45556@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=dlan@kernel.org;
 h=from:subject:message-id; bh=9I3S+ZMjQ+CX5ruVFO8hHEKt9n+ligax17wFo6u0nUQ=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBp8JA2t6Oh3boo/AQsj6aqlzUcUURaIZlQZlq6U
 Zf4kLhr1jSJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCafCQNhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3jOQ//Y8FpkguGvfJYxeQJkXpK+fjeQHQoHtHMKdwNvQ60UOtgYSVOZTjD3
 mzQnZSlcpRU02iACF6nCZmZ3+eAlIbXi6nLDgkyrNg4RMIu8sch19RdUhr5mVmCytb+o8YRiRD1
 VMD3HIbHg1BhezDY/cvYFP/GUpfA93JtELUhUGU6oWUhIDZzH78e0QwMLhVNCXwRn+oL+Lx4obG
 87QtXW9V3RXUMQTiXGhmwJRciAEX4rNHzpv8gDiOfsQ1AtBjh+uO/5rNigTvq12zQhSi640q8Va
 iNJAivx6BvDjVpEJo9Z5mWQvU+Vr4tiaLkAiAkYE9YgzPvgc4SsWeVwlm8xXnRvcwttcPI3KWqN
 toDgHLdk+wH92E1xbkWy7CxprSsJAnnBuS4UVl/ch6Hp0CqxPHb9VLu9AasuYNG2PhjuuV6VeG8
 scynopWwrZqpauSNPVbZLchwlV+zxbLslJuy/qz/mOu00CGqwUmvR9XhvFKLvCgcCsJqN3MH24B
 kB7zxIwUrAYNm/r2mpCUqHB1hxB31VVH2UjYyaSSTjQjjAn+KMbi7elgKNrPVNi43MnY7+8/azd
 2Vy+BdqhRmdPzEmOZPtWnzpt1yV8yFnHO3wCBGwJLNHUPyZ89J1M4rmjuVaBxz+zl3pd60kSuqM
 mqpuohQ8cjZs5fG5me1Acf6aIsQg/s=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-Rspamd-Queue-Id: 38F7A48364C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8739-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlan@kernel.org,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add one secondary optional bus clock for the PWM PXA driver, also keep it
compatible with old single clock.

The SpacemiT K3 SoC require a bus clock for PWM controller, acquire and
enable it during probe phase.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/pwm/pwm-pxa.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 0f5bdb0e395e..80d2fa10919f 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -161,6 +161,7 @@ static int pwm_probe(struct platform_device *pdev)
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct pwm_chip *chip;
 	struct pxa_pwm_chip *pc;
+	struct clk *bus_clk;
 	struct device *dev = &pdev->dev;
 	struct reset_control *rst;
 	int ret = 0;
@@ -177,7 +178,12 @@ static int pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(chip);
 	pc = to_pxa_pwm_chip(chip);
 
-	pc->clk = devm_clk_get(dev, NULL);
+	bus_clk = devm_clk_get_optional_enabled(dev, "bus");
+	if (IS_ERR(bus_clk))
+		return dev_err_probe(dev, PTR_ERR(bus_clk), "Failed to get bus clock\n");
+
+	/* Get named func clk if bus clock is valid */
+	pc->clk = devm_clk_get(dev, bus_clk ? "func" : NULL);
 	if (IS_ERR(pc->clk))
 		return dev_err_probe(dev, PTR_ERR(pc->clk), "Failed to get clock\n");
 

-- 
2.53.0


