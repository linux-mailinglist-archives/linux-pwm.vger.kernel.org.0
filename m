Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749283749A9
	for <lists+linux-pwm@lfdr.de>; Wed,  5 May 2021 22:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhEEUuS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 May 2021 16:50:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhEEUuO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 5 May 2021 16:50:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 41C0C61176;
        Wed,  5 May 2021 20:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620247757;
        bh=JAPEwygHF0DlXdg0rwn6ALhQHLMU50LUI/kyN4dsCdE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Oe5Cnj4qK3AKlqvXDWdDo821h9weRZ1GseG3+8+8xBq7zF2w6dqGsJg6uDU3xtAcY
         jKr5l0sAd4m2JfDuLhjKdmZbjyFNWQs0I9rLS/f2pHJJikaWVU7dCfvzQYsWKWpCJ1
         u5//3Ts4QNACc3fzhfRLDMB/poQ9ogx6xDd2APb/9wtKKfDPE4X+1bKBLFyyNq+3Fg
         TxMfRZDYyTFm4wXu4nT3N7MI/3q/r8QZBGzPPBiVB3OQl40KyGyDngwUHCbUPrzTCt
         S9MljagP3065ri+gLCkeLvFnfq10vdMnUE9lxK4s+VfeQFb0Wj0ZUN114b04rzAPJP
         T//myeBvs+gWQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3B36C609AD;
        Wed,  5 May 2021 20:49:17 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210505184015.1250649-1-thierry.reding@gmail.com>
References: <20210505184015.1250649-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210505184015.1250649-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.13-rc1
X-PR-Tracked-Commit-Id: a6efb35019d00f483a0e5f188747723371d659fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b9df264f0ab6595eabe367b04c81824a06d9227
Message-Id: <162024775723.12235.7235479426274310541.pr-tracker-bot@kernel.org>
Date:   Wed, 05 May 2021 20:49:17 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pull request you sent on Wed,  5 May 2021 20:40:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b9df264f0ab6595eabe367b04c81824a06d9227

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
