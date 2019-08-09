Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38B9B88041
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 18:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437378AbfHIQf1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 12:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437336AbfHIQfL (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 9 Aug 2019 12:35:11 -0400
Subject: Re: [GIT PULL] pwm: Fixes for v5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565368510;
        bh=V8oXQxfmqp7qCQuqH/9/wYJ5mskVhb6yYv8o1W+SQco=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qQrpvHaQlvPuGW0ScxrhwIjGnrEetCe0/kf6/TXUxWSXEtF6iXATcVa5oSUUqy4Tt
         jWYqTmIVfQMxAGlhsxiM3P1eU/fsBks+of24+Yh9VIaeX+XKGxA0kOZw2XRIbLPzU3
         re1QC3RcpShlnJYiu+2u92pG7UoVQh27s/RQGEOY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190809134848.18297-1-thierry.reding@gmail.com>
References: <20190809134848.18297-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190809134848.18297-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
 tags/pwm/for-5.3-rc4
X-PR-Tracked-Commit-Id: 6cf9481b440da6d6d86bd8e4c99a8b553b9d1271
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c808f2ad8fcddb856ce42901cd5b4f06f9da9184
Message-Id: <156536851085.6429.6086666407903295936.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Aug 2019 16:35:10 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pull request you sent on Fri,  9 Aug 2019 15:48:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c808f2ad8fcddb856ce42901cd5b4f06f9da9184

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
