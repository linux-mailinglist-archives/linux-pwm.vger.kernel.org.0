Return-Path: <linux-pwm+bounces-1821-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3466E88D026
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Mar 2024 22:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665E41C677C6
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Mar 2024 21:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C0813D63A;
	Tue, 26 Mar 2024 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzuL9WGj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D17353B
	for <linux-pwm@vger.kernel.org>; Tue, 26 Mar 2024 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488974; cv=none; b=tMnCM/vUP81DR8Ilj9woMtuSTNfpLltKTN1R7DRL0e4udN+1olTB88EczaAkvehJ8SXiB3k7L9c5TPi3BXcksCAPcBd/AouPM8x8x14402lme7+1KlP5gBbj/znHsIQWOrhZ6U2hw1wG7UA32FRDIYQwUm4Byvo4HriCpmwiQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488974; c=relaxed/simple;
	bh=TDotayzJxX0y2vdsDxXxnENtD2X4/xK7TSA2t63JWwo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jQdn0CpIZbldGfrrhS1PJwPZovA3ijUtv9eb3bUojzVq7gOZhVbn+NMK7ZAfexZmerw2UtDNB9hapU7W0RaSr06mSXer/NjpptggSsyAn9t4aosprjjQjdwjaaqvcEAqusItjWQGeU34RvQwz7vsabHNEPpJhsF+zmy3loyT95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzuL9WGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0A61C433F1;
	Tue, 26 Mar 2024 21:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711488973;
	bh=TDotayzJxX0y2vdsDxXxnENtD2X4/xK7TSA2t63JWwo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JzuL9WGj4vpGxEIb6FIqF+r1SqQqOOyCC7o4VJmGzjzwcrJHnP6Oot7fwtKGFtHaD
	 BsduNVJ1hWi6DLi+tiCz8Dirv/Fl9uDFOgyJQN30tDJuQCd5pnmTETC7+9U37R9/J6
	 BCQej4hWj6mI+hKFW6rJ7LZiMGk4RTBxJjPq3PLbWiqyYui7pLxlEb8pFC13zAx9H5
	 nkjjUcBU+uWB74jHWHeLhgqtXtqpoy/xYWfd0LG5yrtyiFXnna1RNtIQKTFRZSF83f
	 HZ9aWaZyoe27RRGOwlEq1kqSiK/oD0Moy36uspwef10Ud0mR/caJfJqvVBW7C3ia1U
	 Fc2imPOo0SdfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6FA8D2D0EC;
	Tue, 26 Mar 2024 21:36:13 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: A fix for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <unlcfjofn5lsga7ttr6egp6wjvsinwysi7lklc646ixap4oumx@uymlfmdyy6jf>
References: <unlcfjofn5lsga7ttr6egp6wjvsinwysi7lklc646ixap4oumx@uymlfmdyy6jf>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <unlcfjofn5lsga7ttr6egp6wjvsinwysi7lklc646ixap4oumx@uymlfmdyy6jf>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.9-rc2-fixes
X-PR-Tracked-Commit-Id: 9eb05877dbee03064d3d3483cd6702f610d5a358
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 576bb2d8e37a75a27400849327b996f330bc2380
Message-Id: <171148897374.26753.6059366761717688870.pr-tracker-bot@kernel.org>
Date: Tue, 26 Mar 2024 21:36:13 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, Zoltan HERPAI <wigyori@uid0.hu>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 26 Mar 2024 09:05:10 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.9-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/576bb2d8e37a75a27400849327b996f330bc2380

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

