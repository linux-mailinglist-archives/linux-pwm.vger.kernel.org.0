Return-Path: <linux-pwm+bounces-2588-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4BC9134BF
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Jun 2024 17:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297FC284737
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Jun 2024 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F85716F8F5;
	Sat, 22 Jun 2024 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgmtnuOz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF86B660
	for <linux-pwm@vger.kernel.org>; Sat, 22 Jun 2024 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719069669; cv=none; b=l6IAEhA0peaFyhodNrs+CFkRt65nh8ZLCDNZME/6oIfUtioEc7YY74dU0SpHjpGIjNWo7ybe/K9PL+SYPUgLOeznG/3NW95x84+2yfzUtaVOUGWgejot1iZuLZaeN8KHwwXrEeJyzDurDhWitDWQmBnu4NMaeFox2GA5YkhiimM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719069669; c=relaxed/simple;
	bh=kvQo1B3v2PhCJZyCahT3YWp6xEaig2KfwS0Dep7Fw3o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S5ud9RP08CsGI6XE86CfzKmI329/vDDLtuAsKVyrO1L03DbO95DbEDJhrYf8meOocPmcNvejw1MxFEabEiBYwcJKOaM1eqN9qcqCnwP4/Rl4d2vrLQ0cjvdBGcrCYFtq6BGBvknxxLniFNV1BzLAQQxgUrikqHDfjLrs3d/88JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgmtnuOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D5A7C3277B;
	Sat, 22 Jun 2024 15:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719069669;
	bh=kvQo1B3v2PhCJZyCahT3YWp6xEaig2KfwS0Dep7Fw3o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tgmtnuOzXFOTNQwdf5u+KcU52OOkFgC0DtjW+CE0J7w+LRAtWdelXxrIH4kfHAOQj
	 0RJjKJl8E5gZoG8vnNXIWCTUIyycWG7mQcchAVoAdzEYgF2kwsi+38NDwFIocai9fi
	 xNwq9455yjfKaF3hdiE0OmxQdZVdsIc6fIgBJIuZ9xtHHMM5oBA4wIYSGy+8WrJijT
	 zdFurXDRhTCBxI+mtL5YjB2N4SpsssSdHzrxvg/JxQBMQNGKqON17t59iSfN98zvZG
	 0T1z6cvYxlYNOxKrXz4FgdPjcW+W0bJfn7JkpnPEgRkV1L99/F0C38juIvA551WoGX
	 E+SqX7ZQZfZPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44125E7C4C8;
	Sat, 22 Jun 2024 15:21:09 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Three fixes for the pwm-stm32 driver (take 2)
From: pr-tracker-bot@kernel.org
In-Reply-To: <kgjqqj4lw7tc5cnafhjttozhiukrm7hgsb2veutlrhxgfmap57@dxeuw37qo6sg>
References: <kgjqqj4lw7tc5cnafhjttozhiukrm7hgsb2veutlrhxgfmap57@dxeuw37qo6sg>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <kgjqqj4lw7tc5cnafhjttozhiukrm7hgsb2veutlrhxgfmap57@dxeuw37qo6sg>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.10-rc5-fixes-take2
X-PR-Tracked-Commit-Id: f01af3022d4a46362c5dda3d35dea939f3246d10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f5c537182f52ce2609d677b21a7c30ffa318d33
Message-Id: <171906966927.9703.7907867738476140544.pr-tracker-bot@kernel.org>
Date: Sat, 22 Jun 2024 15:21:09 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Trevor Gamblin <tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Jun 2024 16:48:22 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.10-rc5-fixes-take2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f5c537182f52ce2609d677b21a7c30ffa318d33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

