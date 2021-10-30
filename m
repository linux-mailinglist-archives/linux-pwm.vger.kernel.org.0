Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE95B440831
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Oct 2021 11:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhJ3JXj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 30 Oct 2021 05:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhJ3JXi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 30 Oct 2021 05:23:38 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5422C061714;
        Sat, 30 Oct 2021 02:21:08 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 0A5FFC6398; Sat, 30 Oct 2021 10:21:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1635585666; bh=/XwIbqzaI1ZkAS9A2CztCzPHMUN0TjT18ogjpqMHCZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ndr3m9V+p3zyw5/EijsnQrn07JdPitxSYikrHJ/QOeI4Pb8kaqKg0quOYWsRRH1Zv
         Si/DjgKbyOFZ1cugFSHdbwjCu8YNa1MwBsZ91yyxcZZcumtguczrnPNk54ovjjn35X
         uuq7/d4Ynf/vhL48O13f0Nt2Ei7h011aN3eZs2lMHzHyyhcS4UzMJfm+pRiwgPclj3
         6bbUq4vKVNfP/HcsQKgIxmltxtkzfra0OKgswZdymPhoetrnIdW6uhjfa3yinmlyEy
         uMHjGZlJaw2jbezMLAnW/OATK0VWsUOx+qowjTbkIm+mYyWFFQsJGyUzjE+y+1+fVo
         ENllqxcSphk6w==
Date:   Sat, 30 Oct 2021 10:21:05 +0100
From:   Sean Young <sean@mess.org>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        kernel test robot <lkp@intel.com>, mchehab@kernel.org,
        thierry.reding@gmail.com, Lee Jones <lee.jones@linaro.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <20211030092105.GA12707@gofer.mess.org>
References: <YXlxhpZWf2mxJaMi@fedora>
 <20211028064513.guziv6uaivzlk6ki@pengutronix.de>
 <20211028091442.GA16514@gofer.mess.org>
 <20211028111535.x7xgz7domx2lpyfh@pengutronix.de>
 <20211028122610.GA18767@gofer.mess.org>
 <20211028180516.t2tpfbzztm7s6cqm@pengutronix.de>
 <20211029071608.GA28997@gofer.mess.org>
 <20211029110602.uugnbm5vtfpghiwh@pengutronix.de>
 <20211029115412.GA32383@gofer.mess.org>
 <CAH7FV3njgZ7sOnZZF88KZ2C4UwqxoodpUuLsnucvBxYXmaZo1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH7FV3njgZ7sOnZZF88KZ2C4UwqxoodpUuLsnucvBxYXmaZo1Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 29, 2021 at 09:08:29AM -0300, Maíra Canal wrote:
> I would like to thank you guys for the attention and this interesting
> discussion. I'm looking for some work in the kernel and I would like
> to know if you guys have any suggestions for beginner tasks in this
> subsystem. I have solid knowledge in C programming, but I started in
> the kernel a couple of weeks ago. Anyway, thank you for all the
> feedback.

Thank you for your contributions.

rc-core (drivers/media/rc) is in good shape and I don't know of any
outstanding issues.

There is a ton of work around dvb, but this requires actual dvb hardware
to test.

 - port drivers/media/usb/dvb-usb to drivers/media/usb/dvb-usb-v2
 - Re-write dvb frontend without dvb_attach()
 - Implement dma-buf for dvb

Like I said, you'll need actual hardware to test against, and this is
probably not beginner tasks.


Sean
