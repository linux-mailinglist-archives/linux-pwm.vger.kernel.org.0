Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC7D43FBDB
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Oct 2021 13:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhJ2L4q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Oct 2021 07:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhJ2L4q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Oct 2021 07:56:46 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C345BC061714;
        Fri, 29 Oct 2021 04:54:17 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 1493DC638B; Fri, 29 Oct 2021 12:54:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1635508453; bh=1ibxwqgBZhCbkK4nb0aNYAFKQRFLUuXXiDUrBdxYH+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n9s6MW2Kc68g44HK8GwSp2AYpSNTNWxYIksaYr9fiqOOSv3DFrcBMwLEi77QBNchy
         HA2ZtAIjt+hw8Vg9rAGowMOrbTKQZf6r02m7Ow/Xpl/z2W6VFMgmDzK7cqqRo8dmBl
         EsgthhJ/+fGXuxpJdESnaz2T+rNZ8zuvtsdMuVfjSNo4cocQXT80abn6Nc3Sbm5c83
         wrzn6iCVBY0JukBkFH8v66awRXqcFBgMhukmqTpUv0XRNiocLUUN9Qxbw9PCMbFuNO
         orIcmolElUKprCSP5xWlejyXS93XmuIbBh3tbNXY5SVG6vShvAQgQE3W2oafxVkOUf
         0s3voRAdpvocg==
Date:   Fri, 29 Oct 2021 12:54:12 +0100
From:   Sean Young <sean@mess.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>, lkp@intel.com,
        mchehab@kernel.org, thierry.reding@gmail.com, lee.jones@linaro.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <20211029115412.GA32383@gofer.mess.org>
References: <YXlxhpZWf2mxJaMi@fedora>
 <20211028064513.guziv6uaivzlk6ki@pengutronix.de>
 <20211028091442.GA16514@gofer.mess.org>
 <20211028111535.x7xgz7domx2lpyfh@pengutronix.de>
 <20211028122610.GA18767@gofer.mess.org>
 <20211028180516.t2tpfbzztm7s6cqm@pengutronix.de>
 <20211029071608.GA28997@gofer.mess.org>
 <20211029110602.uugnbm5vtfpghiwh@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211029110602.uugnbm5vtfpghiwh@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 29, 2021 at 01:06:02PM +0200, Uwe Kleine-König wrote:
> On Fri, Oct 29, 2021 at 08:16:08AM +0100, Sean Young wrote:
> > This means with your changes, if the carrier and duty cycle are both set
> > for each transmission, then we're doing more work. If only the carrier
> > is set for each transmission, then there is no net gain/loss (I think),
> > but the code size has increased.
> 
> OK, then I discard my patch.
> 
> While reading that I wondered if it makes sense to have a callback that
> sets both carrier and duty cycle and then remove the other two.

There are separate lirc ioctls to set carrier and duty cycle, that's why
there are separate callbacks.


Sean
