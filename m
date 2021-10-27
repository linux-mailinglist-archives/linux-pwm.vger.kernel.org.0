Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE543CA10
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Oct 2021 14:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhJ0Mvb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 Oct 2021 08:51:31 -0400
Received: from gofer.mess.org ([88.97.38.141]:37929 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231811AbhJ0Mva (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 27 Oct 2021 08:51:30 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 00696C63A3; Wed, 27 Oct 2021 13:48:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1635338940; bh=e5phXM1J44gIrmBY104P/Z08rUN8SJnDxfNLQ7YhK9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fXwpmhdz1XnLnKj4zPrYJ6JGcQZJmmNFwe1OFjLEXDsEx2s/3vGxAHZq/7RD51477
         b6OfiEW3+eZH4+Y8TPyWzeFkwAah6q+oQEPwTYsfUUiwSpZv/1WNyv2RVsGrtFIc/Q
         PJASj0OOsIwi3mvZo2NNc+wcjrle60lGtMO8HvUOoKThrWLx9AQjQ2qv4U383oY28H
         b+OKnCFBAHHi3Tg+PF9KHUqXsuIATctW8QJiuHskKMQ6Mz43zTvMwckj/ZZZWOm1JU
         kytwA8tGjTZ85qy3/h5Ck2ppu8HN6LdSR2EaKGm371M3ytRmp/kjsuA5873mqPHE37
         hgYCFqUv88PYA==
Date:   Wed, 27 Oct 2021 13:48:59 +0100
From:   Sean Young <sean@mess.org>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        kernel test robot <lkp@intel.com>, mchehab@kernel.org,
        thierry.reding@gmail.com, Lee Jones <lee.jones@linaro.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <20211027124859.GA6320@gofer.mess.org>
References: <YXU2i0FtAGDRCMSu@fedora>
 <202110271450.Z8JPybLg-lkp@intel.com>
 <20211027061552.bb4fczniqp6b7amh@pengutronix.de>
 <20211027073204.GA3978@gofer.mess.org>
 <CAH7FV3nb8K2qKgGZh-uMCk_BykWJ_sOb7K-jEhNjazYSiXdqbw@mail.gmail.com>
 <CAH7FV3=7Y7Z0y+Mq5Ak12KDMiZpHQHXGixF_pcrnQkuqCO9kvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH7FV3=7Y7Z0y+Mq5Ak12KDMiZpHQHXGixF_pcrnQkuqCO9kvQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Maíra,

On Wed, Oct 27, 2021 at 09:43:47AM -0300, Maíra Canal wrote:
> [resend it in Plain Text]
> Thank you for the feedback! I appreciate that! I'm new at the kernel
> and I got a little confused about how to send the new patch. Should I
> send a v4 of this patch or just send a new patch fixing this issue?
> I'm sorry about the question and thank you for your attention.

Please send out a v4 with the problem fixed.

Also top-posting is deprecated on linux mailing lists.

Thanks,

Sean

> > Em qua., 27 de out. de 2021 às 04:32, Sean Young <sean@mess.org> escreveu:
> >>
> >> On Wed, Oct 27, 2021 at 08:15:52AM +0200, Uwe Kleine-König wrote:
> >> > On Wed, Oct 27, 2021 at 02:07:19PM +0800, kernel test robot wrote:
> >> > > If you fix the issue, kindly add following tag as appropriate
> >> > > Reported-by: kernel test robot <lkp@intel.com>
> >> > >
> >> > > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >> > >
> >> > > >> ERROR: modpost: "__udivdi3" [drivers/media/rc/pwm-ir-tx.ko] undefined!
> >> >
> >> > This comes from the line:
> >> >
> >> >       state.duty_cycle = DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * state.period, 100);
> >> >
> >> > where DIV_ROUND_CLOSEST expands to a normal division but state.period is
> >> > a u64. So this should use DIV64_U64_ROUND_CLOSEST I guess.
> >>
> >> DIV64_U64_ROUND_CLOSEST is for dividing a u64 with a u64. We're dividing
> >> by 100 here so this is not necessary.
> >>
> >> It should use DIV_ROUND_CLOSEST_ULL, however it might be nicer to use:
> >>
> >>         pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
> >>
> >> Thanks
> >>
> >> Sean
