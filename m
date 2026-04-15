Return-Path: <linux-pwm+bounces-8594-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAiVCT0L4Gn2bwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8594-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 00:03:41 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B188C40861A
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 00:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3108631357B7
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 22:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012BA386C1F;
	Wed, 15 Apr 2026 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g67Rttuj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DB737E2FA;
	Wed, 15 Apr 2026 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776290493; cv=none; b=FItSwdH3J1rib1sxUwwuf0ZIrfMfIxcXUOmBkoNXZtUbAXds+rzo3YmVITFln09yoGYxw+6JiGRg5N8o7QeMk6Tcd7U0wSw86fGCNXZvD5XS/CAAoazVeeWhEvOJ/Grji1G7gYa8gFhBVRBrtClAIQwU+ZDpfrTruvViL+Fsbq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776290493; c=relaxed/simple;
	bh=DuH4ZckBrP/vdXKVcHbXCLNYcoumcEg9s9CyXTU6xQ0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A3+JZDNpzgvHxdhUXJN3pMR+2psvkHrGojZ/q+4LGLiiNueZ92M4kcPWI7B1vw2BaWfR6nFWipmJA9ML2VO7M0UDOYbVx8g1HTRChihL8+OW/hEKuFnHZWJ37XkH/R/iTuCPSKGcZBvfPa//kHAvTlKIQ3glvnqf89n2wPYHZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g67Rttuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CF9C2BCB3;
	Wed, 15 Apr 2026 22:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776290493;
	bh=DuH4ZckBrP/vdXKVcHbXCLNYcoumcEg9s9CyXTU6xQ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g67RttujsFIV39jHx471c5pPZAzx7NWW3G7iV8BjnrQF7nxLbgChVEKq0hGC+RTUJ
	 oH4jCveUgJ0fLPuuFFwrsj+tZIHyITX0vpiiA8/h5r0gfltjA9oY0ZcTM09FCKlxfC
	 PKec2XCNp59j6bCvsLnyz+CJggzwr1nTKhHbF5llFkmf8OmwtMGoIq8/79iFm0v0MS
	 a0RwJX1lEWFx6YXji6NTTb3+G9jYPk+6n96fWXB5KkCuIkCuPihBnTAHPmPPqx89MN
	 O1df4xKm8+L1FefQWaticskPneMFD0ecUS15WmcWy2mA0Htt6N63osAI+jX6wQL0an
	 cgnp3L8PdvXwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC5F380A964;
	Wed, 15 Apr 2026 22:01:04 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for 7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <adymoAWvo5IOs3yv@monoceros>
References: <adymoAWvo5IOs3yv@monoceros>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <adymoAWvo5IOs3yv@monoceros>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.1-rc1
X-PR-Tracked-Commit-Id: aa8f35172ab66c57d4355a8c4e28d05b44c938e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9962335d4c6dee152e95dce9f0dd32048735a6d
Message-Id: <177629046306.2457809.6919278602603095280.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 22:01:03 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-8594-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B188C40861A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Mon, 13 Apr 2026 10:22:44 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9962335d4c6dee152e95dce9f0dd32048735a6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

