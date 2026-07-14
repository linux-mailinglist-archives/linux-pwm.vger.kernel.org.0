Return-Path: <linux-pwm+bounces-9711-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OgF6IwknVmq00AAAu9opvQ
	(envelope-from <linux-pwm+bounces-9711-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:09:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E10C87544F7
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:09:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MSWM2yjJ;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9711-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9711-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE7B530804BD
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 12:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752E438D6BD;
	Tue, 14 Jul 2026 12:03:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579993921D6;
	Tue, 14 Jul 2026 12:03:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030581; cv=none; b=UnMPxTJe4NX7d4CpO6r7NeqN7CW95+4g3SeWopcsPlntqA910W9PI9kHFjyxpGKTIwySUY8kfZ0BHLADtSon0fOCqxrGoTHwUEUazfQ2g/GoAL3UsQwH+2/L7XDHlkyZ0cHbBAL2swqJ3aO8uhzFmvrJdysBTCyc8YGDJ+rqT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030581; c=relaxed/simple;
	bh=zdvttxB++OPgFS/P0oSzYrE+0LjRto99mwDgt5GhiKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TtzjwrbVxtXIOgeNlOY6kGPLlBjah3R3uCiUh/n2HipJKZBm13FCjBKBbSek8/w62azrtB1WlUIrn04IYh1NsZXqwqtSRj9W4cTx9ZihvAv7BMfl0Kv0199womr81+stKnqVe0n/MY3YGEiWQw5LnmD6V0WkjLPQlap/NnVLjfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSWM2yjJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5994C1F000E9;
	Tue, 14 Jul 2026 12:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784030579;
	bh=fuXufKmvo/6HSifVsX+u9QywX6Yc3DtFcrqAMBwjNwE=;
	h=From:To:Cc:Subject:Date;
	b=MSWM2yjJhbFFUL+U2GgFhW5FlLIfZS/rR2fueB6C1H2f1VKkand/iNOmP6bOByshC
	 oWj3XTk7hhgQvfKUyPBWAPAnGDGUEfgVKHwsPs2pCE8w7YWpsdIuyQTMenCS/z0Sfu
	 5m52r9E1VFfczzNzoMXvarPDl3JS10B2AQtJRfXkB4fcGf5kWxfchgSa3An75B29Je
	 V40LJXXzYwGWU9We7PHGOrYqG5H2hOtQk+tuoJD627Y361AuTGy3TQCyfxMtQse484
	 t2sPezfCjvyVZJB8GDYPfTeBtkuFfxqzhLY/Xv85LtmnEBpZm2joj/6lEakXROSrxx
	 zLbZKBDmyIjZw==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v1 0/6] pwm: tegra: Cleanups and .get_state()
Date: Tue, 14 Jul 2026 14:02:34 +0200
Message-ID: <cover.1784030076.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=ukleinek@kernel.org; h=from:subject:message-id; bh=zdvttxB++OPgFS/P0oSzYrE+0LjRto99mwDgt5GhiKw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqViVbLMW+VvxQs51fjWIvbf+QIuxwkRkiKpzdo 10m1lzZyFaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCalYlWwAKCRCPgPtYfRL+ Tt2iB/99j53XVVjssMyp+W4g8SDMVzAVUEaqnpVuAXOcxMv4rGRWSCygjYhVKral/yzLUPPhtub o+AU+Uuc8rmZTv3khdcmxXjGakP5UTfWBJuUsdIr4V5NUEAaC4FQp0JzfPEmr9v65RAW8rnAYYi 4ggnHEnApCtBDaRFx3p7sIojEwFCUcD+AmAxh1QyXooWyhjcx5H/u203sIMNaZykkz4VlG9PbQf m8dc87lC/U0YaUOR8kBb3JlvXlUcLna9rh8NqqT6mlJRGTFfkPvHY924MNctxT2ddZ60n2Y9od/ 5HmtCdtTUqqTst6dJtZPoTVZhWoBjaUDhON47fSDW3Vf4lOR
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-9711-lists,linux-pwm=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E10C87544F7

Hello,

the tegra PWM driver annoyed me for some time. This patch set addresses
some of the concerns. The implementation of .get_state() is the check if
I understood the hardware correctly. If so, the next step is to fix the
rounding in .apply() and/or convert to the waveform callbacks.

The first 5 patches should be fine (unless my understanding of
pm_runtime is wrong, which is quite possible), for the 6th patch I'd
like someone to test it before it gets applied.

Best regards
Uwe

Uwe Kleine-König (6):
  pwm: tegra: Check for match_data being NULL
  pwm: tegra: Make use of dev_err_probe()
  pwm: tegra: Use devm function for pm_runtime_enable()
  pwm: tegra: Simplify using
    devm_reset_control_get_exclusive_deasserted()
  pwm: tegra: Simplify using devm_pwmchip_add()
  pwm: tegra: Implement .get_state()

 drivers/pwm/pwm-tegra.c | 123 ++++++++++++++++++++++++++++------------
 1 file changed, 86 insertions(+), 37 deletions(-)


base-commit: 82dcd68f7246eeacbc2ef614b82e284a50b2b8bb
-- 
2.55.0.11.g153666a7d9bb


