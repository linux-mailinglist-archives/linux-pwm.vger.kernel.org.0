Return-Path: <linux-pwm+bounces-4749-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505CDA202DC
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jan 2025 02:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09B81648B5
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jan 2025 01:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C653BBF0;
	Tue, 28 Jan 2025 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBuWIRzs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3CD27452;
	Tue, 28 Jan 2025 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738026440; cv=none; b=JGTo/SuA7HUNsiSvqAbvmsBxJWVApu1ixyRb29G4w68M14Wjb0x/0V4ER0oRfA6qSL+cJ7icvfrkjp/EOsh60E+xhJkK6+bGoCurohWL4HV8Mw5KrSGwhvcAfwSeCPtNf924CDjMNpI5XNd1F0I9AE35bDcj2vUA1N22FNJM56Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738026440; c=relaxed/simple;
	bh=IeZaVxQlfW8e2exhjigkEkEJMb9AkLO/P00+/VXsccY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LZvUxKO2KL4PTbeRtfGoSR3/JqsxwUjupdTpv6GklBeqFbUeyke2LbzfCn7cNKar+MVE8PmnlIkKoiRhMfudVS512ArVvzfmPP0WMOSur6oxtpNcde+65Cwj9F8QLWcUdTnvrdEwJHlzy1Z1mKTr2GIdZuftA9EdoVGqfePE+UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBuWIRzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D55EC4CED2;
	Tue, 28 Jan 2025 01:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738026440;
	bh=IeZaVxQlfW8e2exhjigkEkEJMb9AkLO/P00+/VXsccY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DBuWIRzsySKsateBDa61CajAjcxnj9n19zgJpEBN2BtOOWx4kItrDD/hiC37o6VKc
	 KTGaRS+iEpGux33d7mfeTLxWxAxB9ucq4K3QVNDSh+vJK7rUbNU1q6BnfRohteHNXT
	 9QM38OT3jPSa2YqDMJJydn4P2pQKM6hMAKfOh4rkpTAnaEvXMNfl3airY7BXoXHQ6x
	 UOmgLas9qT4M7O7MAwhZv5iqziXpXsThrx8nK6fyyvwGVIGY37yf95RbzHIHTo7seR
	 5B268mixx7ibFZU0ZQmW6dGLtJy4inJ0Itap+qCGqrQzyaZ5obWWC4By47iYsJ4Z11
	 9bj0XmrD8Qq7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C6C380AA63;
	Tue, 28 Jan 2025 01:07:47 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Two fixes for v6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <l5pzdnng5lha6vxfoetrectekbujvkqir35fc5cemo6qadqno6@abdgcnbtevb3>
References: <l5pzdnng5lha6vxfoetrectekbujvkqir35fc5cemo6qadqno6@abdgcnbtevb3>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <l5pzdnng5lha6vxfoetrectekbujvkqir35fc5cemo6qadqno6@abdgcnbtevb3>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.14-rc1-fixes
X-PR-Tracked-Commit-Id: da6b353786997c0ffa67127355ad1d54ed3324c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 078eac2b5ba3532ad3ded7c4aa10df8712722c50
Message-Id: <173802646602.3281647.3229932887758623485.pr-tracker-bot@kernel.org>
Date: Tue, 28 Jan 2025 01:07:46 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 27 Jan 2025 17:43:04 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.14-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/078eac2b5ba3532ad3ded7c4aa10df8712722c50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

