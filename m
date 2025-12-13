Return-Path: <linux-pwm+bounces-7798-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 122ACCBA4A8
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Dec 2025 05:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AFE73045A52
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Dec 2025 04:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298C317BB21;
	Sat, 13 Dec 2025 04:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXJVNHzH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B5C757EA;
	Sat, 13 Dec 2025 04:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765601148; cv=none; b=LLfR/5GbJAkH56N8RfIPwO1VVtvv1a5h3TRo+kWp1nFVjRW4k1V4Ql1zGbWb4EUK+d3VVYyi+EqQvskxlq2ljJKYNVNEdWaFRik+t1RSBkVigygpGozB0iyKc8RtBhTGVK5zvCxEHhQ+XJEfMKQJsy8F6LDNLNSGCz6LCUN7eYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765601148; c=relaxed/simple;
	bh=/+Kccn/rXLn6pWMEXsTeejS8K/Zn8A06MiXBqK7RfdE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RiciPJiUkTvRC0DHNAcj99CUjyPxbzOcEFCf0Y9hyDzdb48Q/XyHjf5Jwv9of8h/FMAJgE5oJWF21Rs9AZxRze2j0UwaDM5AZxEScqXyZ914qIhMo1/EammNqfQt2bNDRoULeMTyG6TwUA02IqjzHxQgpQG+vgb1qswRPuA9Ut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXJVNHzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D998AC4CEF7;
	Sat, 13 Dec 2025 04:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765601147;
	bh=/+Kccn/rXLn6pWMEXsTeejS8K/Zn8A06MiXBqK7RfdE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eXJVNHzHhYtk/K79ohP10eRmFKjVZ3uGCzjruWfMws2rT74WIZ9NN082C5cZ1cgre
	 /ujxmVcGhQ939vexpeI7Va+2fDISMAR9uZM95l/89lgQ/0UwrzPM05fzSi8LTVxSaM
	 XxvYJnxpfzn03PjqyqZ2K+eiXA8HAf5uCiVC/EHVTFib1TGXxim8sIW5UOkB2xyV7V
	 bTrtfKBSlWS5gmntWe0Sib0hVJG5s286hdYkuAqMIMLzadism9cZwRWwQ7pKSvUqq9
	 oi1EqtEr1JgbRkYIkL8EuzVeleMhEgIwbrbtb1Ii7I3ERkU+skkqFsRWcflGB0dJ3B
	 SZbbsExhA3tWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2C61380A954;
	Sat, 13 Dec 2025 04:42:41 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: th1520: Fix missing Kconfig dependencies
From: pr-tracker-bot@kernel.org
In-Reply-To: <ntweqab35rlrfyvrkdljo6zebaxrs4ttceqam763ozip6vhbke@inqoc34facoe>
References: <ntweqab35rlrfyvrkdljo6zebaxrs4ttceqam763ozip6vhbke@inqoc34facoe>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <ntweqab35rlrfyvrkdljo6zebaxrs4ttceqam763ozip6vhbke@inqoc34facoe>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.19-rc1-fixes
X-PR-Tracked-Commit-Id: 3c180003dffbc252a72dec4f0c697e12922e0417
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a919610db43b34621d0c3b333e12db9002caf5da
Message-Id: <176560096056.2405448.11122580576506737742.pr-tracker-bot@kernel.org>
Date: Sat, 13 Dec 2025 04:42:40 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>, Markus Probst <markus.probst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Dec 2025 11:52:38 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.19-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a919610db43b34621d0c3b333e12db9002caf5da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

