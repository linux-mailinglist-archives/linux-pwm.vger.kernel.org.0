Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858092965AF
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Oct 2020 22:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370652AbgJVUIC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Oct 2020 16:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370520AbgJVUEW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 22 Oct 2020 16:04:22 -0400
Subject: Re: [GIT PULL] pwm: Changes for v5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603397062;
        bh=4a2JBpVKRn9MmGJmCHbRUJ75MO7U2VPdIW5sFLIlKSk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JVmygizYwkriAGcSQ2ehIZXCAVe51CUvveJdI/DfDAhhSsSav3K8jbspg6orYpfV8
         444CuzfdpDM3MP8CcNGOnEgxJCZ3E5x1D8qj+JEuVnqN+6rf5QavwUun08P4LdocUV
         TNKUdHLNiPzTUbMCFQhyBrYBP9hlTu5pq8d7grM8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201022154903.21929-1-thierry.reding@gmail.com>
References: <20201022154903.21929-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201022154903.21929-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.10-rc1
X-PR-Tracked-Commit-Id: 3b1954cd57bf7648417c593d60eac1ec661ad514
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ceae608a54898fff2aa0aba358fe81af027ef8c9
Message-Id: <160339706199.15216.7481481578728448027.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Oct 2020 20:04:21 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pull request you sent on Thu, 22 Oct 2020 17:49:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ceae608a54898fff2aa0aba358fe81af027ef8c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
