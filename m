Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE491A4B52
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2020 22:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgDJUko (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Apr 2020 16:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgDJUk2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 10 Apr 2020 16:40:28 -0400
Subject: Re: [GIT PULL] pwm: Changes for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586551227;
        bh=AqHynHzXeo73zkGEcdSrTM4EGM0Eiioyl8TfaY+4xtI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LpWh0DNo4WfS9C5+tkIKJ08eVm4o4ACXafHBfCiQL4TQ92b0XVYsc09W+Acs9eTAw
         VBO0L/rtmPES7kSmy0kYMXl4XqKz2zZMne9yK/2FvmK4ji8mTP+IlPkL+nE9J5Aez0
         6SsNSEgr7y3BzBnUWWNHJUO5l3kqae1lQAbF1g+0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200409145443.3494659-1-thierry.reding@gmail.com>
References: <20200409145443.3494659-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200409145443.3494659-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
 tags/pwm/for-5.7-rc1
X-PR-Tracked-Commit-Id: 9cc5f232a4b6a0ef6e9b57876d61b88f61bdd7c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75bdc9293dfd1c1dea297bbc65b37c7f6dcb2bd6
Message-Id: <158655122740.24997.9848280182754920032.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Apr 2020 20:40:27 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pull request you sent on Thu,  9 Apr 2020 16:54:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75bdc9293dfd1c1dea297bbc65b37c7f6dcb2bd6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
