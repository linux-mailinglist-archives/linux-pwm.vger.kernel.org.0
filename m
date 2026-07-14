Return-Path: <linux-pwm+bounces-9717-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f80FC80oVmpj0QAAu9opvQ
	(envelope-from <linux-pwm+bounces-9717-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:17:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3094754676
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:17:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="FEI9Ga/U";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9717-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9717-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB6A334FE022
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 12:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74324391E76;
	Tue, 14 Jul 2026 12:03:20 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB0238B7DB;
	Tue, 14 Jul 2026 12:03:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030600; cv=none; b=RgVTCgPXAI58eS6yNCYGumciB5g7AkmSxnRG5/bn4ed6k1Vpc8UG7fBoUbOinGkbFh5Fj/uRSsh5xJxrKpeNmX38ei8cO8KJdqT8fDZNQVw0rrAPg0C4N2V9KdhbEb29DIMIWxz86ZhuFE8nrETqh9Kzh3o7EnWSZO8lWOkFGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030600; c=relaxed/simple;
	bh=x4plyMAzWJTKe+BF08ui5PhIVzw+4SZR6NAusQWQWHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2wneWDUChtK1ku3cyduvR95zTRkWKODp+vsHEUVuhsrWEFvAUK6svlK8W96cBCVbwbRv7Oi7IUd1cfsjRJEkouUsEPv0ndv2nDsiZq/5NCpKZFUzMT9mUq6yN+Ul1yddnpfW4mWOdMG6vsTrilxDpi36MbsRb1Nk5nCBjdIiBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEI9Ga/U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D95811F00A3E;
	Tue, 14 Jul 2026 12:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784030595;
	bh=eLUbjGqmlmNUS7QSp3JdvECjdMhcY9OtVw/PD8mXPCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FEI9Ga/UZSrDrrx2I+N63E0YOUxyoOsd59HRz/JCIOTehSoPjzA5pJgpCInHuJMY0
	 bFwyfClG2Bgv4JPAoeUnaPnWkMnGusyFTNv+xUOs6TdhEc7ISUdJfeRYGD+IBmxgwt
	 bo3gR6S8XQzXfNtujiwEae+6fZDqpzYWNr4TzFJ5zZKtN15BEMjmcbOCp7tZXvi3Vm
	 HfPjrrnjLmCRjSLtq8riSx8UJuAfSWJ0zBQ9VbxKA6GvjLN+WQ7jypymVNRVCvLnfK
	 h2uOeUlSCZeXIYJy3dQuazl3lzGeKpi3m3mtLkPJYLVnZobvgjBKOpauCHClf9xk7x
	 qPOES++Vnq+Fg==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v1 6/6] pwm: tegra: Implement .get_state()
Date: Tue, 14 Jul 2026 14:02:40 +0200
Message-ID:  <33b13f17d7135923d08e2ff40c867803e19609b9.1784030076.git.ukleinek@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2128; i=ukleinek@kernel.org; h=from:subject:message-id; bh=x4plyMAzWJTKe+BF08ui5PhIVzw+4SZR6NAusQWQWHA=; b=owGbwMvMwMXY3/A7olbonx/jabUkhqww1WwvO7HCzIeTbEKfPlMNv+jKxq+QcI7p3x4D5oNev hs3HpLrZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiTdns/0Mmbz+t9OLnqVxr trifFtxRFj76P7smcKRzi4bqKi08kb4076Mm78bjpf5GD5u251y4es2Fn6tnUrnkgknT6meff/L +hZKyiHeyc+XP+PMf1ZXl2LVXqt5/JK+d1uvnXSKc6HVh59opjp7p/Itf1GnnLQ38tCqndL1z4/ PkZBOR1M+s7Ge+nnd/Gv3uVnVfv8fyb3asHF92lqtMu7n38rEVItlhasUFHzbv65rc0HtImWPBj ZJJm3ZbP6lR17v0yuyc6IIaX4NIp70/9HTD94Z9KuD9Jtxa0HTyJKcze+PhTIfvTE2yx9J4PbM3 q21f6vR0L9O+T75Cm1R+qmr2hj59fmVJHE/GHLb81ZpPAQ==
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:mperttunen@nvidia.com,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9717-lists,linux-pwm=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3094754676

The registers of the PWM IP are readable. Use that to implement the
.get_state() callback.

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 drivers/pwm/pwm-tegra.c | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 8e5e7e37f4ff..79bfc7589db8 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -309,8 +309,56 @@ static int tegra_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return err;
 }
 
+static int tegra_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
+	int rc;
+	u32 val;
+
+	rc = pm_runtime_resume_and_get(pwmchip_parent(chip));
+	if (rc)
+		return rc;
+
+	val = tegra_pwm_readl(pwm, pc->soc->enable_reg);
+	if (val & TEGRA_PWM_ENABLE) {
+		u32 scale, pwm0;
+
+		if (pc->soc->enable_reg != TEGRA_PWM_CSR_0)
+			val = tegra_pwm_readl(pwm, TEGRA_PWM_CSR_0);
+
+		scale = (val >> TEGRA_PWM_SCALE_SHIFT) & (((1 << pc->soc->scale_width) - 1));
+		pwm0 = (val >> TEGRA_PWM_DUTY_SHIFT) & (2 * TEGRA_PWM_DEPTH - 1);
+
+		if (pwm0 > TEGRA_PWM_DEPTH)
+			pwm0 = TEGRA_PWM_DEPTH;
+
+		/*
+		 * scale + 1 is at most 1 << 17, TEGRA_PWM_DEPTH is 256, so the
+		 * multiplication for .period doesn't overflow a u64. With
+		 * pwm0 ≤ TEGRA_PWM_DEPTH, .duty_cycle is also fine.
+		 */
+		*state = (struct pwm_state){
+			.period = DIV64_U64_ROUND_UP((u64)(scale + 1) * TEGRA_PWM_DEPTH * NSEC_PER_SEC, pc->clk_rate),
+			.duty_cycle = DIV64_U64_ROUND_UP((u64)(scale + 1) * pwm0 * NSEC_PER_SEC, pc->clk_rate),
+			.polarity = PWM_POLARITY_NORMAL,
+			.enabled = true,
+		};
+
+	} else {
+		*state = (struct pwm_state){
+			.enabled = false,
+		};
+	}
+
+	pm_runtime_put(pwmchip_parent(chip));
+
+	return 0;
+}
+
 static const struct pwm_ops tegra_pwm_ops = {
 	.apply = tegra_pwm_apply,
+	.get_state = tegra_pwm_get_state,
 };
 
 static int tegra_pwm_probe(struct platform_device *pdev)
-- 
2.55.0.11.g153666a7d9bb


