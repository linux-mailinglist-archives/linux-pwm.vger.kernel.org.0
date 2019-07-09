Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECB963A8B
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jul 2019 20:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfGISFH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jul 2019 14:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfGISFH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 9 Jul 2019 14:05:07 -0400
Subject: Re: [GIT PULL] pwm: Changes for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562695506;
        bh=2VWtp6phhJ75YvwQQnwZR3fgVyaKu6Vu+XSiGROl1Ew=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F+b1Sj0i4PdINjLFUpmz6wd8M74F/YKWjswNhXUVKLZHcjBDJCybAKZ7Dv+gqQ1jT
         azMMhyyEmrUma7CohzyFUqj5RAoA+IRkRrqaCIR+qUXnKcCAL5P7FlWszRyQ1GvW85
         wLP/2o9JcOCdnu2vdMoDQgaSHPqn9s+/bivr91MM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190628120002.19597-1-thierry.reding@gmail.com>
References: <20190628120002.19597-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190628120002.19597-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
 tags/pwm/for-5.3-rc1
X-PR-Tracked-Commit-Id: 3d25025ce9c2f364ea4ee76f1461c8714b9c0b6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e2bbb688aa6d05073dd1dd0b836d9becec195c1
Message-Id: <156269550646.14383.8718919902374016009.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 18:05:06 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pull request you sent on Fri, 28 Jun 2019 14:00:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e2bbb688aa6d05073dd1dd0b836d9becec195c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
