Return-Path: <linux-pwm+bounces-7755-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8974CA523D
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Dec 2025 20:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614B8314B402
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Dec 2025 19:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594D734DB61;
	Thu,  4 Dec 2025 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDwinERc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3312C34DB5D;
	Thu,  4 Dec 2025 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764876632; cv=none; b=fe5N97XKOpsl0mk0Sm9mGWDVNmNwxc6P0Ih90WMEGc5mUTJTxZlFfkC6uncd8831U7UAX4bLwy54d/KbbbkOqb7/9JQuSsHvSjlUB+qyYaZHvUl73B+vCMhVn7eAlJKsaQxXWlbLdH0iDZ5nB2s/bTR41n4fLypNLthx8K5NUu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764876632; c=relaxed/simple;
	bh=4n3ipQMSXGvtUzwffo3s5knNbGcdthd9JZ3qmvp4isQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TUvbGiwdngSuCDyi/2TikehtvNsmRZZbJIW4s2k+cxNAIaU8uJRhvADg8kdGsk5Z4TYDJQdJ4nAEb+jZOjurCyaHv1epj+TZzGonUiaumdKvtNIOxeF3Mzx4vyWUPPEvwyfhXCz+bVutEWgMdP+4RaL4FcQSEaFPfElxsH66hhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDwinERc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161BAC4CEFB;
	Thu,  4 Dec 2025 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764876632;
	bh=4n3ipQMSXGvtUzwffo3s5knNbGcdthd9JZ3qmvp4isQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KDwinERc6hN03YkLqkOMr4nzt3IeJIlOzmXbG2kkcNORP6MljqJnxWzRHp97v8gRA
	 bQfDsDeQYpHZNAiI38tLRiaw2RrlLe5vDysyJUV8vkxv2WnjRc7mZv5f5HVXEheH0S
	 BR5Alk8F9LSzO/7Aho/yNe7wLaEhdKUmpK++J7vetDGTsaT988jXYOTL7KdhKtK3Tr
	 INPUQHVtXsyTqAPTNpSofEeuQ375d9NiDzKahVVGnpNVLoTNvHaP1qncdkp7VrfeEl
	 Pc9gr/OjV2D+M9oaBQrCQEnYw4UT0QazNQhmOVdqOOY5IYO8mOuQQW7qx+vY/0Zgni
	 yP7FmnagBDSKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78A94380048B;
	Thu,  4 Dec 2025 19:27:31 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ew3w7xtjwbsk77bzdjj2fek3z5kzou2su2gdhdn5qqrnboyxgj@sqmo7mn5myes>
References: <ew3w7xtjwbsk77bzdjj2fek3z5kzou2su2gdhdn5qqrnboyxgj@sqmo7mn5myes>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <ew3w7xtjwbsk77bzdjj2fek3z5kzou2su2gdhdn5qqrnboyxgj@sqmo7mn5myes>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.19-rc1
X-PR-Tracked-Commit-Id: fae00ea9f00367771003ace78f29549dead58fc7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77956cf36494cc5e5649b187f552b90fb14d0674
Message-Id: <176487645017.944914.14839231147559213126.pr-tracker-bot@kernel.org>
Date: Thu, 04 Dec 2025 19:27:30 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Gomez <da.gomez@samsung.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 1 Dec 2025 09:54:20 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77956cf36494cc5e5649b187f552b90fb14d0674

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

