Return-Path: <linux-pwm+bounces-3141-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1696C96FBE1
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 21:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8070A281722
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 19:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DF51D79A1;
	Fri,  6 Sep 2024 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HujkKtNp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A71CEAA5;
	Fri,  6 Sep 2024 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649958; cv=none; b=rARl/BWWlYcepFKqjO6xs26P39xthip+GZ5InSx9/lpuk7np81aAiRW6TQbPailQvXIJxMAlsMXNDbRGfo8x/ho306s2YPKoyq0LJQa/uwlXB/cTqX1Vi5YHMxN++DqiQBYGr+KCk3qz2jzoziaVsSAldeVRvUBmKOBM7d8CZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649958; c=relaxed/simple;
	bh=3t+u9jAbXMsNpmt6NiHvUA4TXZtREMdgFqdpCRppfho=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PS7uLxSr7u/dq1UlXUD0fOhaSvITbUoCYCq4b/E/XrcpKqsmISWicRu2AbDqkKzLBJuzZErQklCWHXgx3bitY3CS/28vrf9eGg+lPnNScdTSYP+QrvW/Q8igI8MHVl4gZ8FsoEL1BnrXI1G6xlFtx9nct8ph09ltCymjEzio9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HujkKtNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAF2C4CEC8;
	Fri,  6 Sep 2024 19:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725649958;
	bh=3t+u9jAbXMsNpmt6NiHvUA4TXZtREMdgFqdpCRppfho=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HujkKtNpeYgjeHn183prgcHAYPvLBEyrpgpk/fXv1pqvLeYJytTWTG78Ff1jOmsUA
	 uXQNsx6AZYd+e3ol01lEYOBD0KbtDPteFxOIDwryOLvUBca3M16h4Z/mb0nAHZG9/0
	 lol/QxpzcyPyjgxiemai2vYliolrlMinSIT48cNSuLDL+L4qyiOEsvR84olYPTfaYM
	 ihkGGuAPeT+SVW5ULn2Exx6HP6SXgw32zHtQczbLz9lkUkLrNAbfvoDZB1hI1NkauR
	 LEgcOHKsJFpFp+hFNH5HLqh0y07DoyyuTj7t/fX430dQepPbD8TrrJfhz19X5BJkmL
	 N+39y1EcMWAyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE6E3806644;
	Fri,  6 Sep 2024 19:12:40 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Fix an off-by-one in the stm32 driver
From: pr-tracker-bot@kernel.org
In-Reply-To: <25x74hglxoyb33fphdrtxrpmvsqe5227d7vy6uo6ez77hjbrn6@dh637q6cvzax>
References: <25x74hglxoyb33fphdrtxrpmvsqe5227d7vy6uo6ez77hjbrn6@dh637q6cvzax>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <25x74hglxoyb33fphdrtxrpmvsqe5227d7vy6uo6ez77hjbrn6@dh637q6cvzax>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.11-rc7-fixes
X-PR-Tracked-Commit-Id: 10c48e9a8fd5e524d37559cf4a06039b4c25db48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8654fa5ca3514263a079886b57521bcb20ee7cfd
Message-Id: <172564995935.2497610.10119336085722247835.pr-tracker-bot@kernel.org>
Date: Fri, 06 Sep 2024 19:12:39 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Sep 2024 10:46:06 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.11-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8654fa5ca3514263a079886b57521bcb20ee7cfd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

