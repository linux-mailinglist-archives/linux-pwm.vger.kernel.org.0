Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E372245008
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Aug 2020 01:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgHNXFR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Aug 2020 19:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgHNXFQ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 14 Aug 2020 19:05:16 -0400
Subject: Re: [GIT PULL] pwm: Changes for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597446315;
        bh=JGMBlZxpVz9L/JCrZJWseb1MuhaAPKBiaoMzbsArEhE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eVQJ8L58qokVdg5a+QtgGNHXekfcsy1kjScMyRWliMBCuwD8ATmqnEO5F+8UbOPty
         VGb1rjm+1VjczYywfHIxNtB+z/xdUzhmcbFrrvSgKjqJusMIl4rJ1ZSDkaLAhafLHh
         fpB+/q76YJlZH80FPhSv2fXdRwzGUzN3xHfjI2jw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200814130332.557034-1-thierry.reding@gmail.com>
References: <20200814130332.557034-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200814130332.557034-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.9-rc1
X-PR-Tracked-Commit-Id: 6ced5ff0be8e94871ba846dfbddf69d21363f3d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fded09198826b2998242ed2e1a16527849884d3f
Message-Id: <159744631575.12327.3516358021806989399.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Aug 2020 23:05:15 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pull request you sent on Fri, 14 Aug 2020 15:03:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fded09198826b2998242ed2e1a16527849884d3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
