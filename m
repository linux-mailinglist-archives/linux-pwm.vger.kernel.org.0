Return-Path: <linux-pwm+bounces-9298-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ctf3LtmwMGpPWQUAu9opvQ
	(envelope-from <linux-pwm+bounces-9298-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jun 2026 04:11:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC0D68B6A3
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jun 2026 04:11:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K9YBIhsa;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9298-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9298-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74EAA301AA9D
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jun 2026 02:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4C53B42EF;
	Tue, 16 Jun 2026 02:11:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E53ABD90;
	Tue, 16 Jun 2026 02:11:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575891; cv=none; b=mSULwJRN/PZLSec3ytxx75rkdwe0RmBvbtNPYB81tknMFPghnlCRW6qrslG8YVXdCfOKNO1t42CspSecURFf/B9wDDWu+e2QSXeEogh8AlIy6qH+SpnS+LT0oIAQm/gZjJGWxAGJKHXtOV2TLR+T0kjy7Ee9X7y9QvtbT8qSwLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575891; c=relaxed/simple;
	bh=hfIqkDLNcjv8ghTui/6OzgVgL5FTtMciiv1Uh/FGdDo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fUqzvwAgtU2wX94RUJJrDOjbSYavYI0vOtGfdZJBrc5T+cxAkdr2jtNTY4ILLajGc/p1JAhMfqkeN0OqXZ5YntuCofHl8a0Hf8NHQx1nxReHN52s4D2y03Bv8HWtB3cv2/uWBqOKOS2K1Nq3EPGjMpEALO1JA/KYpXAHYbHgNU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9YBIhsa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BDC1F000E9;
	Tue, 16 Jun 2026 02:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575889;
	bh=PqvdLKdDzSmUZhgF3YahrwAG68Txf4SWXUFvk0CI+/M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=K9YBIhsa6xd72tlK6qfesEGVuMJOhve92SFJqvar1CGxIZC9tmCIPHeb6ZIbSLkG0
	 +EWuV1Z8p0iF9b5UGgpsg9TJxF9dB8uyyjbUzfOuY2HLQKk0n/tBS17rqvSoCxwzSp
	 4wlo1I0/7d5fAKxq67Sl7TYP5IZ6/sb1heyuGe/LKWMH8Ca8k3fHILkymIDx+Ygztw
	 rmAmRY9QjnemVlLXvxxSrF7C5ESVDpjZz1OeeEj2D9LEqkz9ioTNImMHbDVfjF6KV9
	 aBVQdPGWvVH1ECCxEFjnAgy2wF79OyJzgN8feQzyad3HcMhktgRkJrHtLbmkutlUnM
	 Un2BKVywNqDGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A283839A26;
	Tue, 16 Jun 2026 02:11:25 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ai-PyEf2c2Ce63FQ@monoceros>
References: <ai-PyEf2c2Ce63FQ@monoceros>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <ai-PyEf2c2Ce63FQ@monoceros>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.2-rc1
X-PR-Tracked-Commit-Id: 6f9b73071c15001530e6697491b6db1bf639f4c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b617c82580599994c8dd078ab0dcb0375b42eda
Message-Id: <178157588436.390807.13377302349431390382.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jun 2026 02:11:24 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9298-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:torvalds@linux-foundation.org,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-pwm@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EC0D68B6A3

The pull request you sent on Mon, 15 Jun 2026 07:46:40 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b617c82580599994c8dd078ab0dcb0375b42eda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

