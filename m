Return-Path: <linux-pwm+bounces-8116-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABMiIPHmjGnquwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8116-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Feb 2026 21:30:41 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C5312766D
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Feb 2026 21:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E522B304352F
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Feb 2026 20:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD6C35CBA0;
	Wed, 11 Feb 2026 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv0zwsSj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992E36656F;
	Wed, 11 Feb 2026 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770841699; cv=none; b=tOey2bsTfjHnSIDWaWs5t1aDekpobXI4+OMduY0u2V4Vn4kesSeAf059dpwHaLIyF4CxNzH9Q07G1uvDiPuu0G7Vuti+CjUoCNgxG5czk01yjPogqDFWPl6wDMScYqK1a5Vvx/WU4Aj4xnnGSIGJs+0/ymfOzHBZenwQCZs9vEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770841699; c=relaxed/simple;
	bh=5txl9W/WyKIl9UF95e+c2WEsmGRtKJOxjrtyAu4Xh9Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GdxXHFxfbTLF6P7nKzisduB7S1pkFm5aqgyZvzj1R7lIKvvuQfqYm5yTHvmrmeMpFAg/hWSrayMOdMCpNBJvGOftTonWNZbEPIQgQeRUDAiXSqO7qp2a6K0yulpjsSEk/nmtG5QCWAXimLUk6pKT+Dvmj6veAfKyKXdMXwhQ5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv0zwsSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F308C19425;
	Wed, 11 Feb 2026 20:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770841699;
	bh=5txl9W/WyKIl9UF95e+c2WEsmGRtKJOxjrtyAu4Xh9Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Bv0zwsSjQShNgz7SpJ3ERaGldzSArCSJlwP719Wj1ydkvz+edBc1f2xpVHSdfrYPk
	 8Sv/dGKlVlYv1qbUigmgEBlAGZFnQzId6fmUq9aewoM8bpTbGb3IIX7PkzUImubguh
	 i2IozDZz1S99hzsiDiSKwYBAiWqvrKrv0BUeXr5PZ3qLd4vbX76Uk0B2O/flqAmz24
	 RLs92RZ03lpW6G/aZ4CiapaLZx6h0ZcTZ8zoVKlBWXUQmGibk59ltkOQgnVddM9yxT
	 Wp+uuc2lAruTSezAknHjGiSb1sYG3h2l7MiWbrDvxiPqT9NIogDtagdShzOIOF+jVR
	 vqa76F0tIfIYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B27E39EF964;
	Wed, 11 Feb 2026 20:28:15 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for 7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aYmcqN2aAqhqqwxX@monoceros>
References: <aYmcqN2aAqhqqwxX@monoceros>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <aYmcqN2aAqhqqwxX@monoceros>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.0-rc1
X-PR-Tracked-Commit-Id: 9321f9d27fbaf6c4f32772fc2620961a0c492135
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c371f62da7982ff4f19484a131db7a255538ad00
Message-Id: <177084169368.710910.13772028139307837669.pr-tracker-bot@kernel.org>
Date: Wed, 11 Feb 2026 20:28:13 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8116-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-pwm@vger.kernel.org]
X-Rspamd-Queue-Id: 36C5312766D
X-Rspamd-Action: no action

The pull request you sent on Mon, 9 Feb 2026 09:46:41 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c371f62da7982ff4f19484a131db7a255538ad00

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

