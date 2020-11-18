Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48432B7AAE
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 10:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgKRJuz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 04:50:55 -0500
Received: from smtprelay0142.hostedemail.com ([216.40.44.142]:45286 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726249AbgKRJuz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 04:50:55 -0500
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 04:50:55 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id ADAA418033F5D;
        Wed, 18 Nov 2020 09:41:35 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 9A220837F24D;
        Wed, 18 Nov 2020 09:41:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3351:3622:3865:3867:3868:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6691:7576:8985:9025:10004:10400:10848:10967:11232:11233:11658:11914:12043:12262:12297:12438:12555:12679:12683:12740:12895:13069:13161:13229:13311:13357:13439:13894:14110:14181:14659:14721:14777:21080:21627:21795:30029:30030:30034:30051:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:414,LUA_SUMMARY:none
X-HE-Tag: sun17_590424827339
X-Filterd-Recvd-Size: 1850
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Nov 2020 09:41:33 +0000 (UTC)
Message-ID: <ebe315dae8855ed2c55d6ce48f84aa4edd93e5fd.camel@perches.com>
Subject: Re: [PATCH] pwm: core: Use octal permission
From:   Joe Perches <joe@perches.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Soham Biswas <sohambiswas41@gmail.com>, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Nov 2020 01:41:31 -0800
In-Reply-To: <20201118093506.srljfosnamxe5wwz@pengutronix.de>
References: <20201117175452.26914-1-sohambiswas41@gmail.com>
         <20201117181214.GK1869941@dell>
         <CAMmt7eO5te05AuVC+MR-zLB-z+r9FCuJwtON=1QXXY2YwQG0eg@mail.gmail.com>
         <20201118085113.GO1869941@dell>
         <20201118093506.srljfosnamxe5wwz@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 2020-11-18 at 10:35 +0100, Uwe Kleine-König wrote:

> Actually I'd prefer keeping the symbolic name because this is easier to
> grep for. So to convince me a better reason than "checkpatch says so" is
> needed.

https://lore.kernel.org/lkml/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com/
-------------------------------------------------------------------
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Aug 2016 16:58:29 -0400

The symbolic names are good for the *other* bits (ie sticky bit, and
the inode mode _type_ numbers etc), but for the permission bits, the
symbolic names are just insane crap. Nobody sane should ever use them.
Not in the kernel, not in user space.

           Linus


