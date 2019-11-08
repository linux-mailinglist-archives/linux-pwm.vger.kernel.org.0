Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20727F5A63
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Nov 2019 22:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfKHVuG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Nov 2019 16:50:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfKHVuG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 8 Nov 2019 16:50:06 -0500
Subject: Re: [GIT PULL] pwm: Fixes for v5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573249805;
        bh=3MWfVzAWtHSbHtYeIurV1U5+Uy/NteCZuDPgeJ8Ih7w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pOUagQBhgxEFJ4J1u+2oZJq/t51Ry1NsKrbQkK727tlcUC0QS3ubqh8rZFnTq7+r3
         HkXiKml7XFZafVgLAZW22twcNUCoFPkkZy80ygXegsip9M5JTR7m+F17DkGBaIPMaF
         xar/sxe0r8TkPQSVWCsmhHl8/EOoR+tCvnoa58R0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191108174220.3384630-1-thierry.reding@gmail.com>
References: <20191108174220.3384630-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191108174220.3384630-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
 tags/pwm/for-5.4-rc7
X-PR-Tracked-Commit-Id: 24906a41eecb73d51974ade0847c21e429beec60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abf6c39796f9cccd0d258d05f2fa39a8c77eabc2
Message-Id: <157324980579.30145.5785182358604306565.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Nov 2019 21:50:05 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pull request you sent on Fri,  8 Nov 2019 18:42:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abf6c39796f9cccd0d258d05f2fa39a8c77eabc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
