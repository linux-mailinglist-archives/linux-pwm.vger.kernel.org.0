Return-Path: <linux-pwm+bounces-8527-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCABIdr21mlUKQgAu9opvQ
	(envelope-from <linux-pwm+bounces-8527-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 02:46:18 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DECC73C5193
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 02:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 928F5302BEB6
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2026 00:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535A91AAE28;
	Thu,  9 Apr 2026 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhMwCL5c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0440DFB0;
	Thu,  9 Apr 2026 00:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775695532; cv=none; b=BJuhZhR8EU/U0BCdymK5aQCYpWL0J+3zGlhNAZ1EGAB6Jmk6UjrTck4thQIlufocveZsrxdK1TlJIB3nqBzr5XBZQrzeK1RGA2Z2OfPcLMGH6MVmMsl0P/GjfcUoC/GhoBpI06vhXTS+GfZfrTuCpgljKGrCWBCrrWjbR3tsa+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775695532; c=relaxed/simple;
	bh=UvKB/rO0ym8ehbjJC0/3pdgIwU+JdYoe/WxSBUf/xtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GDBRy4PKabLPGYlogjkNa/DABo7Gq9C7zOacmq+OlnN22v6Dr7tdnuZofHIIb4YW0K85caGFFtRuiOIfIR7SmTwCLjGU1QtJrdH0PxDzTffpoPaKRc8dFob826RJmveSg3zQn+/uuNGneXN3nA3401wYBu4ZlmXA73iXXLC+wvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhMwCL5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAA8C2BC9E;
	Thu,  9 Apr 2026 00:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775695531;
	bh=UvKB/rO0ym8ehbjJC0/3pdgIwU+JdYoe/WxSBUf/xtA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NhMwCL5cnZOvjpW/FT1aqATt59YE9Kxmgii91apFLZO5TlGHjoyVQBRHkANRPMCnL
	 BoHHAOCzjjTye+SXKjDDUmQfkQCD3WpnpofcYR0MToDAxxmWs0skpJf/OohygcYK4+
	 GChEfiDfQvlgQW2ONNJQ7lOHzMb5EnBPqNWItqe0mIxipdAF/kb/CUVQ57B4KkqaTW
	 4BnFRbYCNMXInQOiL8Y4Amg7bGk+rxMe6nWeSghrIAPrADjl6b05vsNwNgEHG/9B6q
	 bkvfXiAcT/QaSlUtQoIv4TqnF9QojxdFqEZymMw4cnpzrigcjGtDRMiDGeHKv+OhEl
	 yxqNXSSsBNE/g==
From: Yixun Lan <dlan@kernel.org>
Date: Thu, 09 Apr 2026 00:45:12 +0000
Subject: [PATCH 2/2] pwm: pxa: Add optional bus clock
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-03-k3-pwm-drv-v1-2-1307a06fba38@kernel.org>
References: <20260409-03-k3-pwm-drv-v1-0-1307a06fba38@kernel.org>
In-Reply-To: <20260409-03-k3-pwm-drv-v1-0-1307a06fba38@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=dlan@kernel.org;
 h=from:subject:message-id; bh=UvKB/rO0ym8ehbjJC0/3pdgIwU+JdYoe/WxSBUf/xtA=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBp1vafLCs9aBUlDwfMwtLHaT/gneL5h3TmzUk0S
 QajC3U3UB+JAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCadb2nxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0/yQ//QYPuYB0b8I0gFUKwB3KMY+w/ICUaD59ogvayqcLMSc0LFzgi1UnGZ
 l7hFHdAvNn+AfWW5VCLrelrpHmbTUZcbTAvZYgrkKgPmk6CK67ag1KAexBQosMS6Lf4lP83OXQ/
 Ys/5rssqfUC+CSU3zbj4IpHf3sNB+MO2wEO9LWZityY/tVIf6/vgpNi5KZhhQy2UakBcvkl/e72
 uaTa1/FBhOefLHCWuO9BZ7q6psSNNdshqQJCRK0b08OYNtsyuLmixU2bY5WFVHGZmYsuiW+Yodp
 E3srFvPPcvDduawh3CgF91BfR7xPkf1QEPflDhIKWMgb4WsowHFTDkI3EGlWO9bdIzsUTQNaW42
 CQSXvDH10jpVBmC87uUim7ifJ9uOCARtQrqDcOtxptMVnvsYgkjB8vqDU0PtpiFZejdXbjDR0ZJ
 zjWFnzu2lRwR/FvWCwtMv9jts8Edz+nEsNxkRAEh4/8jXtv9g5sPegEJ6QYX6lBugQnKkHZfcUM
 KR1SnB2VaCaVqPTZKNMot896z7/Ea6gklx88FewMq11wSfEe3dIDBdc3qtjQsSDzYMNaKJTMIpp
 CI0bJ+peWVejVvBbr0wnNFbOwwxenO3WsUFhkwjyFle/J0OA+qd04YZCN4sn7wr4Koy/uA23ATg
 Chadlirppt1DFcLKBqN8I+tAJ5Yj00=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8527-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlan@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DECC73C5193
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add one secondary optional bus clock for the PWM PXA driver, also keep it
compatible with old single clock.

The SpacemiT K3 SoC require one bus clock for PWM controller, acquire
and enable it during probe phase.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/pwm/pwm-pxa.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 0f5bdb0e395e..2ace31405c2d 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -53,6 +53,7 @@ struct pxa_pwm_chip {
 	struct device	*dev;
 
 	struct clk	*clk;
+	struct clk	*bus_clk;
 	void __iomem	*mmio_base;
 };
 
@@ -177,7 +178,12 @@ static int pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(chip);
 	pc = to_pxa_pwm_chip(chip);
 
-	pc->clk = devm_clk_get(dev, NULL);
+	pc->bus_clk = devm_clk_get_optional_enabled(dev, "bus");
+	if (IS_ERR(pc->bus_clk))
+		return dev_err_probe(dev, PTR_ERR(pc->bus_clk), "Failed to get bus clock\n");
+
+	/* Get named func clk if bus clock is valid */
+	pc->clk = devm_clk_get(dev, pc->bus_clk ? "func" : NULL);
 	if (IS_ERR(pc->clk))
 		return dev_err_probe(dev, PTR_ERR(pc->clk), "Failed to get clock\n");
 

-- 
2.53.0


