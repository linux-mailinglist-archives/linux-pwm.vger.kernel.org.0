Return-Path: <linux-pwm+bounces-9712-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9Z8lLNEmVmqY0AAAu9opvQ
	(envelope-from <linux-pwm+bounces-9712-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:08:49 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 574C17544B5
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:08:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nO9Jb20i;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9712-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9712-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D92330A3C47
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 12:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1B238C2AE;
	Tue, 14 Jul 2026 12:03:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB85F38A72F;
	Tue, 14 Jul 2026 12:03:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030583; cv=none; b=bQFe6aU1E4zN1/1N7OUdWh+pWy9Zph8ENa1zJyAxpCMR9fTneYU9AamRrANhA4NIZ3lO3bhBpFZI7Fw0k3TebjjlM633PfYpkL+Y9r94pN+gdsSUh0qBS0BS/DZjdEG0x6TWXpRnJnFUZGn6Jq2Pbv7Q4/mttirCVs1+8YwHtVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030583; c=relaxed/simple;
	bh=pVnlU5S0QlTvlD3xZ21lbYXgXDXotT6zCy2TTLhR4F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0Q3mNJkYGkqSi05I1wuoGMXX98uSeY5O1i7+zaAM8rmTIgt8HHtr8dExFtrbKdSVk+Rgov/E9es1b2/sHlqA/feO7vybSDcMth6ZKH9NF0z+w0Gx0r1gop0HiWAzjkczEd7vSgyvfze1Krx2NZrY941oEwSrSpiIPsNS+ER/Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO9Jb20i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E9BEC1F000E9;
	Tue, 14 Jul 2026 12:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784030582;
	bh=7Sdl57mcNdUoT2xcq0Eq+0KKRG1N9IMUDYtDo/88+3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nO9Jb20irruog5X2THIBrTsPSRmZV8gFB7Rt5itO+Ys6OI2CAIulqSEYYvhpA/oUL
	 VTP/GITlzxYBoEBg8tFcrJlSLD25P0SRqMw99DYAC2ycsjPRaCG9WWyxIr+HuziRbK
	 qmjB84ABzbsf8kivMxYvA1JAvSWjX2zMyJ6Sa2S2XUGr7U8jy8L89v8wT0OlhUk8Z3
	 0wOI8O7PbMgr3JCL6EQuaoUsD4F//qVxLbE2bXm61yr5mQ+DbV91BHxmivplbP/ixu
	 ujyJEotkO9K95LzXz7C9VBDvH+UIxL7J/bsBTcUezO40sBnxg2+1LoyD1HgMqsmWOs
	 mPAYOw1WcLEzw==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v1 1/6] pwm: tegra: Check for match_data being NULL
Date: Tue, 14 Jul 2026 14:02:35 +0200
Message-ID:  <c7d4a3ee8c615f5f6f468c0040fdb0e8864152ba.1784030076.git.ukleinek@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=ukleinek@kernel.org; h=from:subject:message-id; bh=pVnlU5S0QlTvlD3xZ21lbYXgXDXotT6zCy2TTLhR4F4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqViVeX5H8blbOOf6SwJoUM/NbwwgqTw0MJvVWm jmm9t+HSq+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCalYlXgAKCRCPgPtYfRL+ TqhyB/9Xa0xQMVMTzkn+Fhg1dT13wSMvpdfq6oeVDvaD/oMuszdLWL78QhIsHcrcq4H5S6l+6IC rtnFhkFeRF+4jt34m4plZ8MbtIHHBNeQX2mzmPRUOYniqJCtKeAdd1sGwUyDMhk+vkHvMM/KchM R4Kp67tNy2MQi7dljGCYxieobKazEh6w61ATAHM8CrndaaP9Ti8Po7g/mtTMdrOmklIJ+Km6+CZ XtF7fcZ+3/X9682tlrPYBcwhf+BtvC/jHfOspd48NJ6nRd/z9RqmOYwRZV9Q2/l9eVUiNfslqhI BbgW9iPApXpNnINufsxDMkvNnIbXSuY4aPzPPrP/FSHP2u41
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:mperttunen@nvidia.com,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
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
	TAGGED_FROM(0.00)[bounces-9712-lists,linux-pwm=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 574C17544B5

It's unlikely but not impossible that of_device_get_match_data() returns
NULL. Handle this case instead of triggering a NULL pointer exception.

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 drivers/pwm/pwm-tegra.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 5cdbe120ba2d..53743f83869a 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -322,6 +322,13 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	int ret;
 
 	soc = of_device_get_match_data(&pdev->dev);
+	if (!soc)
+		/*
+		 * This can only happen if pdev was matched via pdev->name
+		 * (which should not happen today) or in combination with a
+		 * driver override.
+		 */
+		return dev_err_probe(dev, -ENODEV, "Unsupported device\n");
 
 	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_channels, sizeof(*pc));
 	if (IS_ERR(chip))
-- 
2.55.0.11.g153666a7d9bb


