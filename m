Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11AE4079DC
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Sep 2021 19:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhIKRbV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 11 Sep 2021 13:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232830AbhIKRbT (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 11 Sep 2021 13:31:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 078E261027;
        Sat, 11 Sep 2021 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631381407;
        bh=oPy4srsl6gYyAlGzl+B4jySZyUjrtVIVHmlAgFV+sv0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kyKIdMnYZHxrmp1vQzlZRUfN6DqToSeHE9fBFhNUXfUFHsmL0WhZtdjXYMOja6WcC
         XI1GSC+smI2SiPLv+ju5edZY0FxbGfQLOUghtrv6OWl+9ItBsfSA7j8gvriNxZee7t
         Xq6Y5/CslW7pPSmn2FoL1Swk/14O2DcE4IftBJMeUXDPVEadxuptCiAhdC3VVqoDqp
         ijEd7LNmB7RQfCdlv4asKMAIaR3LmO3AnMYY2HxWvpCETMTUCDo4ZW073LbOIvG8It
         cP0M4cVDI1/dlwTz+zGl9dMBXvJDGXZDvPX2bkpAWWa5DYL1RqrTFgAUIhhmpkv0Hy
         QnZdR3ylV3nww==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0244F600E8;
        Sat, 11 Sep 2021 17:30:07 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210909173420.3551559-1-thierry.reding@gmail.com>
References: <20210909173420.3551559-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210909173420.3551559-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.15-rc1
X-PR-Tracked-Commit-Id: 3f2b16734914fa7c53ef7f8a10a63828890dbd37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6701e7e7d8ee4f80d0c450aeab101e4a2a2678fa
Message-Id: <163138140700.31565.15244975679554617738.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Sep 2021 17:30:07 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pull request you sent on Thu,  9 Sep 2021 19:34:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6701e7e7d8ee4f80d0c450aeab101e4a2a2678fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
