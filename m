Return-Path: <linux-pwm+bounces-2171-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 214E68C5D8D
	for <lists+linux-pwm@lfdr.de>; Wed, 15 May 2024 00:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5553A1C20D97
	for <lists+linux-pwm@lfdr.de>; Tue, 14 May 2024 22:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7963A181D04;
	Tue, 14 May 2024 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjA4MPyc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E37181CFD
	for <linux-pwm@vger.kernel.org>; Tue, 14 May 2024 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715725019; cv=none; b=BQuHsZox2D8tmftbwHxG9pVm081qwMSvU7530WsrH3j9VAJkklXGn2PjrLc+4A3ELKLraVhD7BtpMG45c6T0losfOxReYnJN2ybJ+qFCVrH6dy86nBieg3vm87uLLH7ndOWSBA4f6nwBOV+OJXwddrwXS4TcyX5PDDlPtfbwiNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715725019; c=relaxed/simple;
	bh=MXJrNOEDBfSX+ZvSgFuknMglxe1YhK4X7oo1wWr4PlM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L2ZEYiCRtML8NXo2kn47v3E84Lt4q0U+FLAeI5nzGtDELFC8dfANdl9XZHoI89m/n0safkct1w4KRLMJzdiCJRGWLUDpOSSFIFpVQBAo9ZHHFD7OqWNiSc/BHhPFaLWvkwQOnhj4s6nWuSdS2Nj66IxIYOtXcNEtq55bmL+zCmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjA4MPyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B718C4AF07;
	Tue, 14 May 2024 22:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715725019;
	bh=MXJrNOEDBfSX+ZvSgFuknMglxe1YhK4X7oo1wWr4PlM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GjA4MPyc4u7TTdVNwZkhuaxQGQ7vLeb+YiMwPdW0sGfM0keGiXOOlmvu9pkpH4Bqf
	 lLH8aW14qmCzUP1H7H6IfJP7xyPg0PFTM39FTiWOBkmzixRBuBbV6Yx3lJWg03fcPe
	 LHjm1oHh5hju539ftktsqm1O4es++zYINJmySs1WhY0gUIq/7PrSlGmbK0BE0nZQZm
	 HBrhvAnlIlR3O5Bu2N+Tu/ZirGsgtmTLGYDSQcvDCTspXFt9SCFBWxJH9vr1nZNo5p
	 gHmvqtNdXpPElB0Px9fabW0cp0hWTPQKuZEMSIGqGXXaR+pRpTpxTcSP72TNNJXxPI
	 3hs6fHzKJw0Jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21D30C433A2;
	Tue, 14 May 2024 22:16:59 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ea6vevhosh66ghu724gpsvawqq3zggvruhhjsvbmasskhevmsq@lircam7wky64>
References: <ea6vevhosh66ghu724gpsvawqq3zggvruhhjsvbmasskhevmsq@lircam7wky64>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <ea6vevhosh66ghu724gpsvawqq3zggvruhhjsvbmasskhevmsq@lircam7wky64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.10-rc1
X-PR-Tracked-Commit-Id: 4817118f257e49b043f3d80f021a327b7e1d796f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d81e2d5a9e4befa119e40742a60c366e15d76ce
Message-Id: <171572501913.5061.14437284566442066517.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 22:16:59 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Alexandre Mergnat <amergnat@baylibre.com>, Binbin Zhou <zhoubinbin@loongson.cn>, Dmitry Rokosov <ddrokosov@salutedevices.com>, George Stark <gnstark@salutedevices.com>, Jerome Brunet <jbrunet@baylibre.com>, Varshini Rajendran <varshini.rajendran@microchip.com>, kernel@pengutronix.de
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 May 2024 09:52:22 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d81e2d5a9e4befa119e40742a60c366e15d76ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

