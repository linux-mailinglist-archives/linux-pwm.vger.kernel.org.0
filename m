Return-Path: <linux-pwm+bounces-7376-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E41BB1872
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Oct 2025 20:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0861C80DD
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Oct 2025 18:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69DA2E229C;
	Wed,  1 Oct 2025 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRq+ZVqi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE12DCC13;
	Wed,  1 Oct 2025 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759344166; cv=none; b=A5O4Nca23o5lyAlV/m0eBhLqH5qOgR/a+LeWWwJI90nhqsgdKesSz+5S4Y2yHmn9rpZJbTzxVa2Qu7H9QTjxIkbb7BxkmpiEHt4Gdh2drRpuj3AzPCmz7FwziR5+OefBN6tmWPDNY/0mP5jKcwAjJjhCRMHbKREz7aoF1/7uLL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759344166; c=relaxed/simple;
	bh=TCMZZWzB3Z0vieAHw0/T/FgdXVqIjG1gH1eiF6rPBHo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MWE1SgMdpqQK7eaMS3EgSUg7cT/gD3kUBEK1Woeo++tyrMNvdoIHmVyRW13lQ1GgnmBzh3SdNGHevMBszPUHCLx/kLyLTHPhhwHxI7cwzk6gftwzlAGis2/vaQTehlXlLXt3vkiJyEz/l27tUO0gHboOOwQbTnKLfASaqk9UtLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRq+ZVqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745C3C4CEF1;
	Wed,  1 Oct 2025 18:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759344166;
	bh=TCMZZWzB3Z0vieAHw0/T/FgdXVqIjG1gH1eiF6rPBHo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BRq+ZVqilH6HSDqSmYY4V5bk738Lg5uSiaqWQFCYZKQ/DcRRERShR2bnRsXBTZHjX
	 FizEshT5Ep7bMd6SP/Ry6EPkUtIE6UBKwDphM/3F5urr8ScxuPMiwImQ51dOBo70ZB
	 txvPxNegZPIQotiZ50GjmCp9MIbDgrfzWb+Y8j3yhpC0mR2Yx+GlJM1GgF5gRpaQFh
	 /Jabc1/wLGu+bjddFHSVMHrs9RmI6antbf29CfaCkjv2goHw4KG3tkQFaP2Y1YR1QL
	 3lOSx1g/gRn1NO5C+lUcoeMgr4WeQouPXbJkFyGY8JU+7+RL/dCio8Gq3VvFxzt/lK
	 0nGmQHQz0hINw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E7439D0C3F;
	Wed,  1 Oct 2025 18:42:40 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <jeblxobrtuzcsgs3r7g5fxvpmauttof3qzrlvlaglueg4ls4ea@dk7kpwkplno2>
References: <jeblxobrtuzcsgs3r7g5fxvpmauttof3qzrlvlaglueg4ls4ea@dk7kpwkplno2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <jeblxobrtuzcsgs3r7g5fxvpmauttof3qzrlvlaglueg4ls4ea@dk7kpwkplno2>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.18-rc1
X-PR-Tracked-Commit-Id: 8f2689f194b8d1bff41150ae316abdfccf191309
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c050daf69f3edf72e274eaa321f663b1779c4391
Message-Id: <175934415870.2574344.6445445619974650791.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 18:42:38 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Lee Jones <lee@kernel.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 07:41:38 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c050daf69f3edf72e274eaa321f663b1779c4391

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

