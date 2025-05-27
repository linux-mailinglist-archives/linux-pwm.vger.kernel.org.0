Return-Path: <linux-pwm+bounces-6156-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A5BAC5D5E
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 00:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A767B1177
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 22:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620A21FFC45;
	Tue, 27 May 2025 22:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhTT8paD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1E19CD1B;
	Tue, 27 May 2025 22:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748386047; cv=none; b=UESCE/ZgOiDkSudleybFS5MlUuZzXLlZCFmiMNXoRWBw61KXMT3J7hcOoXGKpOn5OwheNwp8vAnP76RohoUkdmNkmdeGoeJH6a33qWQMlPoNHoDKyXImqMD3YkEQFzeW6U/wHBY30zqrCpWzl41Vi5Bwxk/EGKuU9e7krCso4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748386047; c=relaxed/simple;
	bh=EGrfNlaDiyUWzAoT0q9aZunqk0MiGCrxtW54Ez7yUNw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=APEBMmx+I9ynlojEPKUOng7nTQGQ4v70uuMCTSV3GigCD6hLAo8ZEXLhDQnjBJJODSdzUiPfpafqqIZ07JSUb86gdgG5Zva+mpbjrHanRKJTSowmmlzj8z5GLUJo18Has6zjiovWwKJ+fIzz8izqBdto5fcLR4o+PPVmBeJl/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhTT8paD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7FBC4CEE9;
	Tue, 27 May 2025 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748386047;
	bh=EGrfNlaDiyUWzAoT0q9aZunqk0MiGCrxtW54Ez7yUNw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lhTT8paDTsysytQ9m4ovtpR/UBmAP5OdBRjyGG7s39gtAqB8E2WqiSGEqsbHEIGlF
	 e6N45gsqEuiPkvz3WAxbabTGOl/bUlLQrwYIOssTWQxyHqHsBkEgDXZjRgB4WX9cIM
	 drsfwLAJg2eBVigNCeZu/CiWfMtc0VD1zBTMY3x9dACwbqRLvadTPka+uuNu0bwz5Y
	 6qW+cld7sigxMVMz6M5uIJ79IhjueCS9ZDO0jarEnj4Ius+sp0grzkzq41cgKLqap3
	 vx1jQcDaiKmU+ynWb0Ch8uoF299NrfwFYd5so21uHlg9/HGiz49JQuzTx2kGMc86sd
	 0g48XmMAtyTVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71019380AAE2;
	Tue, 27 May 2025 22:48:02 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for 6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <rsnijkpfz2u2y67352hmcmo7bufcwm4ukdklf6ucw3fj72utxa@snrwsd27ye6a>
References: <rsnijkpfz2u2y67352hmcmo7bufcwm4ukdklf6ucw3fj72utxa@snrwsd27ye6a>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <rsnijkpfz2u2y67352hmcmo7bufcwm4ukdklf6ucw3fj72utxa@snrwsd27ye6a>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.16-rc1
X-PR-Tracked-Commit-Id: c0c980f237e822fd9cc6c0ab5b60ce8efe76464e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11147c16a6e0649cc95f8bb90302e4a99ece30bc
Message-Id: <174838608135.1808984.9005670776729317627.pr-tracker-bot@kernel.org>
Date: Tue, 27 May 2025 22:48:01 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Lee Jones <lee@kernel.org>, Andi Shyti <andi@smida.it>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 25 May 2025 23:25:51 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11147c16a6e0649cc95f8bb90302e4a99ece30bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

