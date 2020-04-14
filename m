Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862D71A8B4C
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2020 21:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505139AbgDNToB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Apr 2020 15:44:01 -0400
Received: from smtprelay0090.hostedemail.com ([216.40.44.90]:45892 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728340AbgDNTn7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Apr 2020 15:43:59 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 2B6EF1802B57F;
        Tue, 14 Apr 2020 19:06:44 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 00FE6181D341E;
        Tue, 14 Apr 2020 19:06:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:4423:5007:6248:7903:10004:10400:10848:11232:11658:11914:12043:12048:12262:12296:12297:12438:12555:12679:12740:12760:12895:13018:13019:13069:13095:13141:13161:13181:13229:13230:13311:13357:13439:14096:14097:14181:14659:14721:14777:21080:21212:21365:21433:21451:21627:21660:30054:30070:30079:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:7,LUA_SUMMARY:none
X-HE-Tag: sky28_1d7a3c1bf3225
X-Filterd-Recvd-Size: 2209
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Apr 2020 19:06:42 +0000 (UTC)
Message-ID: <b867ee8a02043ec6b18c9330bfe3a091d66c816c.camel@perches.com>
Subject: Re: [PATCH] pwm: Add missing '\n' in log messages
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thierry Reding <thierry.reding@gmail.com>,
        paul@crapouillou.net, Dan Carpenter <dan.carpenter@oracle.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Tue, 14 Apr 2020 12:04:32 -0700
In-Reply-To: <f13a8754-3866-d3d2-eaff-29cb6d14ff8d@wanadoo.fr>
References: <20200411153528.30130-1-christophe.jaillet@wanadoo.fr>
         <20200414135827.GB3593749@ulmo>
         <f13a8754-3866-d3d2-eaff-29cb6d14ff8d@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 2020-04-14 at 20:30 +0200, Christophe JAILLET wrote:
> Being able to detect early missing trailing '\n' would help maintainers 
> and patch providers.
> 
> You are the 2nd person (I've added Paul Cercueil in copy of my reply) 
> who reports that he is thinking that it is no more required to add a '\n'.

The printk subsystem will, for every printk, check
if the last printk has a newline termination and if
it doesn't and the current printk does not start with
KERN_CONT will insert a newline.

The negative to this approach is the last printk,
if it does not have a newline, is buffered and not
emitted until another printk occurs.

There is also the (now small) possibility that
multiple concurrent kernel threads or processes
could interleave printks without a terminating
newline and a different process could emit a
printk that starts with KERN_CONT and the emitted
message could be garbled.

See:

commit 4bcc595ccd80decb4245096e3d1258989c50ed41
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Oct 8 20:32:40 2016 -0700

    printk: reinstate KERN_CONT for printing continuation lines




