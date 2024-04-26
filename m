Return-Path: <linux-pwm+bounces-2119-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D96668B3EEC
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Apr 2024 20:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9435A284CEE
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Apr 2024 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94EB16FF47;
	Fri, 26 Apr 2024 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCarVU/C"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59C316FF4E
	for <linux-pwm@vger.kernel.org>; Fri, 26 Apr 2024 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155004; cv=none; b=goNC8No4a78XTx5Y97tQyPUUuFsvvZSAKkjFhtZf6ImTkfut+rw2TIvq65AbOWjcNviTC33sdqvh4FfD1it4c3mVSVCON8C+DYfhrsIO47UGZtzsOWyKod2k/PUZjYnpH0NUcY+9lVT21DoMOeUV38tlom3lkDXPRM5GJaH02Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155004; c=relaxed/simple;
	bh=GCx4J8XNZfFJEEMQB+kOZQ5T4reE3j2G0VNHPf+xtjc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SHGpqC8DKIjdoFz0cveVu2VCmoClaaRutzOfgFxHBE/o3YC6kUhgWJuSOziXyZPgOtOoiao3iS9ihcN8U6RTY8dEybcd5a0dxRXXOs2E/DC0pSw6loWcXKkr+30EhqPdporj4lntopvGZy2sDJP7OLpq1hmVQqBkw6hbxVKDqi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCarVU/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F6C3C113CD;
	Fri, 26 Apr 2024 18:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714155004;
	bh=GCx4J8XNZfFJEEMQB+kOZQ5T4reE3j2G0VNHPf+xtjc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RCarVU/CkxSawaKUO6LGkCRJBX/R+BQ6Jd2EUuwfJ9o/VcYxwsYPx4VqaeSFhFITq
	 hPgNh3VfdUqcyMfP/Kg2i4iv3skUTMq3/cUmaCwexgekaWwLcyVcJJcS76Ia9Q6puL
	 l7tW9eYZziNDz5IP38jTMLs0Z2YliYKSmzWG6xxFJouCOywQMYsc9Kgdh7jsbI3nrr
	 ORudk2RLxqiPKEt+lz1VFkhIwEm1yoj07fRvh+hmUX2jf4A/HGAM5L4DUJcq85t1lq
	 wTnLEIvhbqQSBnvFWFlryOr4+O04J5QCNSY3wx4Nw86AX4X3qZy3qmo6t6gJwsVSlt
	 63v9IZc7AAEqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81BD3DF3C9B;
	Fri, 26 Apr 2024 18:10:04 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Update Uwe's maintainer entries
From: pr-tracker-bot@kernel.org
In-Reply-To: <wkokeh5mkc3d3j5d3aumdj3g4fzk5znbye2prdroqgwlhzledw@eskutdgi72nv>
References: <wkokeh5mkc3d3j5d3aumdj3g4fzk5znbye2prdroqgwlhzledw@eskutdgi72nv>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <wkokeh5mkc3d3j5d3aumdj3g4fzk5znbye2prdroqgwlhzledw@eskutdgi72nv>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.9-rc6-fixes
X-PR-Tracked-Commit-Id: 190f1f46ede17ca0d7153ac115d6518ec1be2ba3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 084c473cf7663318bb528c0284dee0cd9023f6e2
Message-Id: <171415500452.9216.14823322444433002330.pr-tracker-bot@kernel.org>
Date: Fri, 26 Apr 2024 18:10:04 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, kernel@pengutronix.de, Thorsten Scherer <t.scherer@eckelmann.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Apr 2024 08:31:51 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.9-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/084c473cf7663318bb528c0284dee0cd9023f6e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

