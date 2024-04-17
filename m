Return-Path: <linux-pwm+bounces-1996-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD0D8A8A1D
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Apr 2024 19:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70C5DB20F56
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Apr 2024 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B79171065;
	Wed, 17 Apr 2024 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZcEMpd/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB016FF52
	for <linux-pwm@vger.kernel.org>; Wed, 17 Apr 2024 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374530; cv=none; b=NNp7G0zILZAyWnr5vSofRjh5lVZ6ERj3BLmtEE1/ejPPITvD5gI+5tMDyf7mU+xUSNze1gmiJN4CAhwBsv5R73pKTMSGBHbDgLJ0hOnFea7NhVbsUV6/AXJRX1pbypNEiMkVbzz2p8bjn7WRyBrWh0dvv0rTrqU8V9R7CzsS1uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374530; c=relaxed/simple;
	bh=/4CW3Ia4KN3S8IxJeQTl89uNil9JgjAT/viHqqMwmwc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sF8GOHpbrlwVBZQWTrHer2ZgV4iQvfVeGNDjCgXcsLn37u6AN+e3DcGF1PlCY8mWwLtbNsWHMXrBrywaUC+kMztS+C9p2RA4miGsi3PC2Zi7WvYBLgJShpKVTXWPBg4QdF3x1Yvnd8liPTmy2L2SXO9qWSxZkXDjmBA8fY8fddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZcEMpd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C133C072AA;
	Wed, 17 Apr 2024 17:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713374530;
	bh=/4CW3Ia4KN3S8IxJeQTl89uNil9JgjAT/viHqqMwmwc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rZcEMpd/ohBbgoNGhbZChqXDeuTn7swNONkHHDY8M5OgWci/rYUJbEjURD6Bs3fJq
	 yLaTPBnj+1vhXfjDSvMcGI9DJVxFakdPkKm6CTPGacqGK6fMlgIkHnavWQZt1frCaw
	 PR0LHSNunYdpB/lvr+fXjDXb7frQl0HLIxxkOxVFcfpkHFxdSuH2IgyfmlfZSRyLYY
	 KRBuag7QR2H+9qMn0tPf3bCGmdktY+Ifg6k16mgvbFt/Mp00p8RlwHQpXnWH3R1agR
	 sD7ZEPsfugLXE+l9W6WNvnwIJ7FG40n5nSEX6Hkme86riUHiFpoP4U8WIDOqLQvzyb
	 RzIxyVlQvyCRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F490C43617;
	Wed, 17 Apr 2024 17:22:10 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Another batch of fixes targeting v6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <qcicxm224x2fw43wrgz5tmntkpiq5v2dro4lynrhomh7sfhtvp@6hh67yqpm423>
References: <qcicxm224x2fw43wrgz5tmntkpiq5v2dro4lynrhomh7sfhtvp@6hh67yqpm423>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <qcicxm224x2fw43wrgz5tmntkpiq5v2dro4lynrhomh7sfhtvp@6hh67yqpm423>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.9-rc5-fixes
X-PR-Tracked-Commit-Id: fb7c3d8ba039df877886fd457538d8b24ca9c84b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b6b513221181108b8406b22b33408f688583b32
Message-Id: <171337453031.30504.10724913455054995390.pr-tracker-bot@kernel.org>
Date: Wed, 17 Apr 2024 17:22:10 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, kernel@pengutronix.de, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Raag Jadav <raag.jadav@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Apr 2024 18:03:52 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.9-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b6b513221181108b8406b22b33408f688583b32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

