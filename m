Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF25C1A8AB7
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2020 21:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504754AbgDNT26 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Apr 2020 15:28:58 -0400
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:41858 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504730AbgDNT25 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Apr 2020 15:28:57 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 2B1CF18064C30;
        Tue, 14 Apr 2020 19:12:00 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 032BF100E7B45;
        Tue, 14 Apr 2020 19:12:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3867:3868:3871:3872:3873:3874:4321:5007:6691:10004:10400:11026:11232:11658:11914:12296:12297:12438:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:14721:21080:21212:21627:21660:21939:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: rain29_4b79cd438ab50
X-Filterd-Recvd-Size: 1707
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Apr 2020 19:11:58 +0000 (UTC)
Message-ID: <19df87f5d093a6c2721316811aca1c90d287bf1d.camel@perches.com>
Subject: Re: [PATCH] pwm: Add missing '\n' in log messages
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Thierry Reding <thierry.reding@gmail.com>, paul@crapouillou.net,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Tue, 14 Apr 2020 12:09:49 -0700
In-Reply-To: <20200414184925.GA12862@kadam>
References: <20200411153528.30130-1-christophe.jaillet@wanadoo.fr>
         <20200414135827.GB3593749@ulmo>
         <f13a8754-3866-d3d2-eaff-29cb6d14ff8d@wanadoo.fr>
         <20200414184925.GA12862@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 2020-04-14 at 21:49 +0300, Dan Carpenter wrote:
> Huh...
> 
> If you look at dev_vprintk_emit().  It looks like if
> create_syslog_header() returns a string then vprintk_store() will add
> a newline.
> 
> I guess that means that dev_printk() can't be used to pr_cont().  And
> probably that's deliberate because using pr_cont() after boot is racy
> anyway.

Perhaps that's true, it didn't used to be.

There are couple dozen or so KERN_CONT uses after a dev_<level>
without a newline, so those _might_ be broken, but I don't thinks so.

$ git grep -P -A10 '\bdev_\w+\s*\(' | \
  grep -P -B10 "KERN_CONT|pr_cont"

