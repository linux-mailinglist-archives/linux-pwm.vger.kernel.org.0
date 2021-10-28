Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E98E43DD83
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Oct 2021 11:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhJ1JRN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Oct 2021 05:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1JRN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Oct 2021 05:17:13 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D0BC061570;
        Thu, 28 Oct 2021 02:14:46 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 992B6C63F8; Thu, 28 Oct 2021 10:14:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1635412482; bh=TcwYNZ9H69bImLZ0/fzU687Op74rMoUC94o75C/+mGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l/o+pLpHf4DC/vWwSVZTNz1SUwcxoW/GrW6I7a8YFum1o3dbgllj+fwzIs6lt/TXN
         1FWhVesHP+QMAyuTkLu1M/zsKfKUr9WWdkqxOs6JStsTJq/myiWLHzi5opFPo+w623
         mF/P5Sqx8Y3R9qBxacNphGCs9Ct9MMsJZs/Lwt9U+WsUSIPVarw1FTjzI3wOApaGd3
         DFdfuNZZwzE+Me5jdP/Gx/ZJC/FJ5jiJO08nVf9GitDp5lQ0pqOJ7+11MJRdJwhCHa
         GPPKIteBr19d/GuNKtaU6PB40jrDjrZdtrKOYpvQN9pq31M0/kFCPBn0DsUqhrMkrU
         VkDSKQfkbzzIQ==
Date:   Thu, 28 Oct 2021 10:14:42 +0100
From:   Sean Young <sean@mess.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>, lkp@intel.com,
        mchehab@kernel.org, thierry.reding@gmail.com, lee.jones@linaro.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <20211028091442.GA16514@gofer.mess.org>
References: <YXlxhpZWf2mxJaMi@fedora>
 <20211028064513.guziv6uaivzlk6ki@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211028064513.guziv6uaivzlk6ki@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 28, 2021 at 08:45:13AM +0200, Uwe Kleine-König wrote:
> The conversion is right (I think),

We still have the problem that the pwm drivers calculate the period
incorrectly by rounding down (except pwm-bcm2835). So the period is not
as good as it could be in most cases, but this driver can't do anything
about that.

> note this could be optimized a bit
> further: state.period only depends on carrier which rarely changes, so
> the calculation could be done in pwm_ir_set_carrier(). Ditto for duty
> which only depends on state.period and pwm_ir->duty_cycle. (This is for
> a separate commit though.)

I'm not sure what caching this is much of a win. The calculation is a few
instructions, so you're not winning in the way of speed. On the flip side
you use more memory since pwm_state has to be kmalloc() rather than existing
just on the stack, and both ioctl handlers and the probe function need to
recalculate the period/duty cycle, so there is a slight increase in code size.

This change does not improve anything measurably and only increases code
complexity.

> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for your review.


Sean
