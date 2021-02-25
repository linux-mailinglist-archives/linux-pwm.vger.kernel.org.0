Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEE93257AE
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Feb 2021 21:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhBYUbh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 25 Feb 2021 15:31:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234107AbhBYUab (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 25 Feb 2021 15:30:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9196064F31;
        Thu, 25 Feb 2021 20:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614284990;
        bh=6TzGkHYtDWGGkmRQMOy+QOiaiKcrffOEkxH+upkAS/8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PPTaVJdoNN9M01sGplTIliLxmEUPkYxoLOCKEV4kpZN9IAnOve8NmajpWfIHOhmPV
         yR6zXZs9s+5585GDdHKwbMaTCsSlFFL8i3ObQiA3zo1LhDj3OW7MTO4qpo+muc7fDp
         tsZdwBUVPRnQAYuC4g2vF9kx/rhoo8p80nBLQTXBRZ9RM+Sdw/WJd8OopxGgpgQ5F5
         ifrI41CBqKx/nE3sMv3vfv+Q5u3mPEWF6p456LiP2rQ/XbTrlNmTaWJmAs1FyYCpQa
         WLqa1a/mZa7EnXS/SIGtE/lIEon/euv6iBPaSyFUpS63fTpv1tnMLIh3VAwznmrFk9
         AiuQSYA7m/cYg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8BC51609F5;
        Thu, 25 Feb 2021 20:29:50 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210225193426.3679817-1-thierry.reding@gmail.com>
References: <20210225193426.3679817-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210225193426.3679817-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.12-rc1
X-PR-Tracked-Commit-Id: 9a9dd7e473517b68412fd2da3da8a4aeb4ecb38a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c87f7a38f930ef6f6a7bdd04aeb82ce3971b54b
Message-Id: <161428499056.20173.10269401811789879646.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Feb 2021 20:29:50 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pull request you sent on Thu, 25 Feb 2021 20:34:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c87f7a38f930ef6f6a7bdd04aeb82ce3971b54b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
