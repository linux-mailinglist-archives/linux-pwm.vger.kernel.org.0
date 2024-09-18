Return-Path: <linux-pwm+bounces-3287-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2044997B9AA
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Sep 2024 10:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7DB286A89
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Sep 2024 08:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B984517E46E;
	Wed, 18 Sep 2024 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaPztvCV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FE317E44F;
	Wed, 18 Sep 2024 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649830; cv=none; b=lCZQLPhaQEBD9UeL1JT0+QcRCLySDVcqByYnpueAdX5KC69LxzYwInUQU4ijPkhhSZye0iokv8I5ijMlALWZukM7gfVge31tmW3FxNqkdbqrHMwJq62+kCkPVjHUFLQqLIhMskfh8bzAbxmHrY2cWItrV3Z3Bik9vuQNap0HjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649830; c=relaxed/simple;
	bh=SU3UZfABhydEKjqSydN99OKW+Tck+MllDzQbQU3ZgSA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KPXdkGmAa8jscCWmosBTbA4dm+VcgjnMTb3PNGGgdPgvjJA+nY6huqxU5mpC8CbavlvtdtTTiCpjM6mpQSuEaOZW87wpQ7sjYd2vactZE/9z2ZGeRm4ntW6XNDN1oGfU77BVLyPBqtvAKILG50TSdYQHZQ0nSqJoXyViq3cV7lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaPztvCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7536EC4CEC3;
	Wed, 18 Sep 2024 08:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726649830;
	bh=SU3UZfABhydEKjqSydN99OKW+Tck+MllDzQbQU3ZgSA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JaPztvCV4XQNl7jGO6dHt4joYFwf2LBIrkszdkB73OhUUteZKSoEEvoZZkIVW/GFb
	 mRciWZazfMVjUdVUrvUTA7WA57OgOnDJFPZM91TAlFkj8C3G+4qGU0Ivs1G/IG1PE5
	 vdixW2955Mfme2lOKBfe1xYl9cPB6qwqzQMhhFnurDVmXarx2Bf2k7PkZwDwicRRwb
	 zk97NfqKrInL9XdtfW3l5n2pkL3gnQqRXWvG0/3clkzhrLWuoGiHsMiDDaUuYGbPqO
	 LUfEw7imvvuxPWYJfRdN42e6w+5LbbwKkTXwpEhEv3ITiPbg+xwPeAUbDMF37Fi4oU
	 H2UBZEEIL87SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EBD3806655;
	Wed, 18 Sep 2024 08:57:13 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <b4pdalox2xlrrwontj7ceesyko6v3atbtgoa4fcbe52ei4kqe3@yw7yfwl7zz5o>
References: <b4pdalox2xlrrwontj7ceesyko6v3atbtgoa4fcbe52ei4kqe3@yw7yfwl7zz5o>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <b4pdalox2xlrrwontj7ceesyko6v3atbtgoa4fcbe52ei4kqe3@yw7yfwl7zz5o>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.12-rc1
X-PR-Tracked-Commit-Id: d242feaf81d63b25d8c1fb1a68738dc33966a376
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc52dc2fe39ff5dee9916ac2d9381ec3cbf650c0
Message-Id: <172664983213.725883.14252501098707325070.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 08:57:12 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 15:54:44 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc52dc2fe39ff5dee9916ac2d9381ec3cbf650c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

