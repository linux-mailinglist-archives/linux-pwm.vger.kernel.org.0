Return-Path: <linux-pwm+bounces-6794-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6076AFD891
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 22:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA6A188E88F
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 20:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F92242D7F;
	Tue,  8 Jul 2025 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sP5VSnQA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C83242D72;
	Tue,  8 Jul 2025 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007228; cv=none; b=raHQWEdMCxvnTj4yc+YX/zsiSrh4l1oYyqi0Sd8SOivCBALdRJmmNbGhM8cAPUbgGK8AKSs3C+xhYsDHkxwGy2KfWzta+4J/p5gff+Dae52ttXfZWcOmOZ1sO/VNU64qaZcio2YQvcdQaHQNCY+tglT2KtP085ruVCrbUSU6POI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007228; c=relaxed/simple;
	bh=3b7bSQD0s3tJcxlci9+pS3wsKNp/9JotMWpR5RMF/R0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=V29Dp2anzAtwisuNcE2duTJdUvbNyF8aYc1XFNtnX+CV0bKGwXXGXPr/ps1a0BQYp8pp6cDY6R0kEJ8pKap73WDqSqK5ArGK+PlrCn29czYYGW23XD5+u221JctGSNXoST9pRztBfizLY1wLFSdwX8pEXhpAfQN3CmEGAYqZdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sP5VSnQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62ADBC4CEED;
	Tue,  8 Jul 2025 20:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752007228;
	bh=3b7bSQD0s3tJcxlci9+pS3wsKNp/9JotMWpR5RMF/R0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sP5VSnQAudzRd0Oepjf+aFCHVCTa1xz3MX3by7dGnyyJY4NGP5l6B5vh9tMFffdbr
	 +UcgWXiL5I43Fyxvh7Su09b5xDAC6WR8fKVm2cameocWsvUJtp2D5LED8Bobbe7Tup
	 Bf7aDzIYcyLn7ZzJT2TdALxS82HyBCejKi/fE9ovr1BZrfbhzPd8LLEoI3UboQxpVK
	 +x3IxB/EE6FV9uOrPaKDl0PNvE575amK/Hx+L2cRhn0fRUjRLQ9+z397f+QyFOwgsP
	 xNtN7dq/Uyti8zbbvVBkQC22gwdviYsk/usykaDFBA8I4epaw5ne+QMJDCy65IrPj0
	 OXjxypDNneoog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DAB380DBEE;
	Tue,  8 Jul 2025 20:40:52 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Fixes for 6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <fmymgdr7p3ergu7i4u2n7mwwkjakhs3krq4btywcepbgt2266x@swjnq4cy7s2c>
References: <fmymgdr7p3ergu7i4u2n7mwwkjakhs3krq4btywcepbgt2266x@swjnq4cy7s2c>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <fmymgdr7p3ergu7i4u2n7mwwkjakhs3krq4btywcepbgt2266x@swjnq4cy7s2c>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.16-rc6-fixes
X-PR-Tracked-Commit-Id: 505b730ede7f5c4083ff212aa955155b5b92e574
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 733923397fd95405a48f165c9b1fbc8c4b0a4681
Message-Id: <175200725107.8458.1981898868780080261.pr-tracker-bot@kernel.org>
Date: Tue, 08 Jul 2025 20:40:51 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 8 Jul 2025 22:02:55 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.16-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/733923397fd95405a48f165c9b1fbc8c4b0a4681

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

