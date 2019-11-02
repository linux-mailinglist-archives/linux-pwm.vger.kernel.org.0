Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78D26ED03B
	for <lists+linux-pwm@lfdr.de>; Sat,  2 Nov 2019 19:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfKBSfM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 2 Nov 2019 14:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfKBSfH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 2 Nov 2019 14:35:07 -0400
Subject: Re: [GIT PULL] pwm: Fixes for v5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572719707;
        bh=n9CPRKBrUU1oEg012hyOLl1Jb/UBbu3K4CfKBWcrutw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R5S23xf40pGa3rPCxJ/3RNT9ZuD5p2BvsQSBAp/+B00NyXuOMEVq2kq6ddAVi3T5b
         r4lDbWH/PS0C1P8AbbxvC1GK9rrGizqLH65vTkaYcgBgbZIzOaVDdRTd4sEBSie6Jk
         qNggada8arDc2QDf8fSrnnaS57QX4Tnrc++TSFBg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191102134800.3847540-1-thierry.reding@gmail.com>
References: <20191102134800.3847540-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191102134800.3847540-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
 tags/pwm/for-5.4-rc6
X-PR-Tracked-Commit-Id: 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e935842a06dbcdefcdd93174a97010f22a36e26d
Message-Id: <157271970699.32009.3011524479832490601.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Nov 2019 18:35:06 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pull request you sent on Sat,  2 Nov 2019 14:48:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e935842a06dbcdefcdd93174a97010f22a36e26d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
