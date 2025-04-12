Return-Path: <linux-pwm+bounces-5473-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F380A86DF0
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Apr 2025 17:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7796A8C3E81
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Apr 2025 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EE11F03E2;
	Sat, 12 Apr 2025 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnejky8H"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2934190685;
	Sat, 12 Apr 2025 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744471194; cv=none; b=Z8GfMfaeTqnfeJaCrrrd4xPpMqeetC0pnze52mxfjbE7uxwNd9j7Ykd2YrrETWMaK93aXU9v1fX0BdhIxOVN/tgumcBmUjv94t4gAfk9gv4kYtQrtnb9+NDBIPKclwEiT1MJqBjOyAdcFNTw+7Bad7vuAA6ztk37V/GuJ0qF5a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744471194; c=relaxed/simple;
	bh=fnAsW+zPZA1mEhKDKLw1zr0jrdn4Wc2xMQErOqknuAI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZjGCIIg03wli/eDqsOTofPmGQPFcYkcE5ieqX8ZvvPWkwSSKu6xX+TGnfn01+xRin7Nd0HjqRor0kChe9GvE2vkG0e3qDOsl5pywAlWCHOPHCDWvohrVIckYPFTDkUDw5OaUlsS7D/pqHwNrUqe5sfaQX9Nrh1PDYwBpHuTARz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnejky8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E6BC4CEE3;
	Sat, 12 Apr 2025 15:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744471193;
	bh=fnAsW+zPZA1mEhKDKLw1zr0jrdn4Wc2xMQErOqknuAI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mnejky8Hoo+4ULBREP4rkcj9L+tjoAJYidJjaoH486g7obxp1lXTqJe1eIEYyZwrA
	 VVA6An97M/rlyAphWidb/tuMwu0Ax6k6Q0tRs8lXOWJjJdqzpkRCzcEPYft4lNqEiH
	 VYf+itIYoOwiDpstaGJ8RuL94TKrkHqneotSYiSsH7dy3J+gspqtS4nPNH4NeG+8nv
	 +X/LNhbsHOm3a7yX8OPtNDMn1T7G4OIDGGGXY2oj1FOv9+LAqr9sNqJODu9yoqdO5q
	 Y6V5SN4hpKs5BSU4xboXoqUKJoT9VYUyIGBBKC0k15fjeLfDipUbhNfIDwQG/sBFT1
	 RrBANjPn4MNVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BA22380CED9;
	Sat, 12 Apr 2025 15:20:32 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: A set of fixes for pwm core and various drivers
From: pr-tracker-bot@kernel.org
In-Reply-To: <7ebsnb2uoriokrmxswii64fiqjmtnojq26gk3xu733bgblmcm6@4rpajnkrc723>
References: <7ebsnb2uoriokrmxswii64fiqjmtnojq26gk3xu733bgblmcm6@4rpajnkrc723>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <7ebsnb2uoriokrmxswii64fiqjmtnojq26gk3xu733bgblmcm6@4rpajnkrc723>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.15-rc2-fixes
X-PR-Tracked-Commit-Id: a85e08a05bf77d5d03b4ac0c59768a606a1b640b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecd5d67ad602c2c12e8709762717112ef0958767
Message-Id: <174447123073.691053.14583800846175071205.pr-tracker-bot@kernel.org>
Date: Sat, 12 Apr 2025 15:20:30 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Josh Poimboeuf <jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 12 Apr 2025 14:44:40 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.15-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecd5d67ad602c2c12e8709762717112ef0958767

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

