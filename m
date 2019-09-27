Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C635C0C08
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Sep 2019 21:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfI0TZZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 27 Sep 2019 15:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfI0TZZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 27 Sep 2019 15:25:25 -0400
Subject: Re: [GIT PULL] pwm: Changes for v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569612324;
        bh=IZr2QazcdgofARbHt+cPZkuALRzj7ItO4YgN7ly57i4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ifQTJ7LQDSPft1zOeSuor/9EPBQqWG6pkEbPF9ml8uXK1zJA/w9/HnAL1U18ORY1O
         iqTmviwykPw1oLDrQ05X0frudxM6V34ox0JCAn/9sjeNg/3SIpS1Jiur0LBhtKcrwJ
         JSch5fF1nFMQpg0NmGUblcoLjvxtTjR5YVRRIL/c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190927163104.1456471-1-thierry.reding@gmail.com>
References: <20190927163104.1456471-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190927163104.1456471-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
 tags/pwm/for-5.4-rc1
X-PR-Tracked-Commit-Id: da635e7abe3f4ec9a8270ca4f5ba946d1a43f678
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e37e3bc7e265d05d00f14079767537699cf6bd46
Message-Id: <156961232440.19941.3044215477937173311.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Sep 2019 19:25:24 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pull request you sent on Fri, 27 Sep 2019 18:31:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e37e3bc7e265d05d00f14079767537699cf6bd46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
