Return-Path: <linux-pwm+bounces-9714-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GW1MMqMoVmpJ0QAAu9opvQ
	(envelope-from <linux-pwm+bounces-9714-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:16:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2660D754630
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:16:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kVOtuIEE;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9714-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9714-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9861534FDC83
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D113909A3;
	Tue, 14 Jul 2026 12:03:09 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03204385D61;
	Tue, 14 Jul 2026 12:03:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030589; cv=none; b=Dm/TfK3Vc8k9wFSscRM+eSWCQE4AToVRP+Sr83hPSw8HqworQFNQN+JBhHpost8mKv4DWrpkiqgqqzDpAwi5YrXhgfmX2HLjDV0EFcHv9f1EDxvgUFRLIjm9JxR5UBMp2cYOaMLX+BVwokauOxtibf44odcAn6a2DvPyoIwAyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030589; c=relaxed/simple;
	bh=Gj5+4hK1pPdkl7yC+UcqD4xbqw/C859vfjKUcVtisnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svpTu2PsvZH5yURG5rKa3f/UiOGDmnaFMms2pFexrlwuGyyN7myg+/7KSr8lgS4S/sY0V2DJVbuxohhOjEfEi+SiStRB03joebYqROfp9VUOlkw7eXVKr+eKVqLQZF/U+ChELbrb9ljzb6bU2wHoCS10pTlAh/MplM1yPlPj2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVOtuIEE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 221E91F000E9;
	Tue, 14 Jul 2026 12:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784030587;
	bh=8tlPOy0FWEgWcDgALaYiTKUyh5LaC5T3gGla6QpgZFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kVOtuIEE6QkT+Wix47aVta/K8CrOvgz9PupByAsP5oVyDGgm6lgvhRQJPjuCVbX0r
	 Csc8QdpMRK4wdLwJxMqLG5G14q8y16SeQ9GZRRzUmLlf8IoOoz5DF3P/FWvF1aWuI4
	 GBrtEzwuHyNe+2+/pVpD+Xem86RPonbxessDEnam/J4f4nCGJmJ2DY0Ag6p6c1JdJK
	 p6iVQtGX6rHB9RQW9YMprRDXJIVZSjx1tlnEwoNNEXSByYKXjPd73Q9WtwhCjArf2Y
	 G4vNB0kwlWaF5ziA12m0i9ijiNlbrmW3Tg6XMLGJE9F6Zggizd2AryRsBvKPAuB/zL
	 s/DtwWWtq1Qpw==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v1 3/6] pwm: tegra: Use devm function for pm_runtime_enable()
Date: Tue, 14 Jul 2026 14:02:37 +0200
Message-ID:  <a7b7386ee7705b25cc1cd345c188e14978ab2e9d.1784030076.git.ukleinek@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1486; i=ukleinek@kernel.org; h=from:subject:message-id; bh=Gj5+4hK1pPdkl7yC+UcqD4xbqw/C859vfjKUcVtisnE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqViVj06LtliWZTO7+ZtA0/CppiNNeTwN0o/MW2 gxDJQSee3mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCalYlYwAKCRCPgPtYfRL+ TpOlCACYtG73dgO59oECrO0WwsAwLEMdD6cNCoAy0o04Zekq1csx9JEyAvZ3oaY+WGo9i0N5Kq8 oYoZLjxyF7sIkjeRcNpcNwaC89/U30peEugR69PuoGwKUlut+OA7NRT158yGQuerKxn5EBZcmRr yvItds/Q8g6QpQW+wOPDQ4eDkAfmptIFv3gWm6gY3DXC7ISl4SLEeep2vl5us4f9yOwAOqcr4dQ kil3ZMT3ziB2msLiqv35R62Zc8umg2ZZGHaMtuBjXYOXwTamxKnrMmSmD9XGC8wDBI5HWWV68Y9 V/ASyuKRRrd/OLPd7ZcvnzCfBPk5enNEm82PfkAfPdaMU3E3
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
	TAGGED_FROM(0.00)[bounces-9714-lists,linux-pwm=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2660D754630

This simplifies the error paths as pwm_runtime_disable() is called
automatatically by the driver core.

Note that pwm_runtime_disable() is the right function to undo
pm_runtime_enable(); pm_runtime_force_suspend() "should only be used
during system-wide PM transitions to sleep states".

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 drivers/pwm/pwm-tegra.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index dba9a05675e3..e99e1c5b18c3 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -361,7 +361,10 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 		 */
 		return ret;
 
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to runtime resume device\n");
@@ -410,7 +413,6 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	return 0;
 put_pm:
 	pm_runtime_put_sync_suspend(dev);
-	pm_runtime_force_suspend(dev);
 	return ret;
 }
 
@@ -422,8 +424,6 @@ static void tegra_pwm_remove(struct platform_device *pdev)
 	pwmchip_remove(chip);
 
 	reset_control_assert(pc->rst);
-
-	pm_runtime_force_suspend(&pdev->dev);
 }
 
 static int __maybe_unused tegra_pwm_runtime_suspend(struct device *dev)
-- 
2.55.0.11.g153666a7d9bb


