Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 316281A03BA
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Apr 2020 02:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDGA0d (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Apr 2020 20:26:33 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:32869 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgDGA0c (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Apr 2020 20:26:32 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Apr 2020 17:26:31 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg02-sd.qualcomm.com with ESMTP; 06 Apr 2020 17:26:31 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 0E03A4BFE; Mon,  6 Apr 2020 17:26:31 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:26:31 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH v11 04/12] pwm: clps711x: Cast period to u32 before use
 as divisor
Message-ID: <20200407002630.GA7019@codeaurora.org>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <3dc95ebc6539066cc58bc44c0e6e53ac979fe9a9.1584667964.git.gurus@codeaurora.org>
 <CAK8P3a0ueOXLFPd_C4nbqHwEmVOa5eFfSivbsMPKNCmjMiWF1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0ueOXLFPd_C4nbqHwEmVOa5eFfSivbsMPKNCmjMiWF1Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Mar 20, 2020 at 06:11:42PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 20, 2020 at 2:41 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> >
> > Since the PWM framework is switching struct pwm_args.period's datatype
> > to u64, prepare for this transition by typecasting it to u32.
> >
> > Also, since the dividend is still a 32-bit number, any divisor greater
> > than UINT_MAX will cause the quotient to be zero, so return 0 in that
> > case to efficiently skip the division.
> >
> > Cc: Alexander Shiyan <shc_work@mail.ru>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> >
> > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

The stated aim of adding the if condition is to determine when the
division operation may be skipped as the quotient would be zero anyway
[1]. That said, I think the current if condition is incorrect. The
quotient would be zero only when the denominator of the division exceeds
(v * 0xf) and not UINT_MAX. In fact, UINT_MAX has no bearing on whether
the quotient becomes zero or not.

Therefore, the correct if condition should be:

-       return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
+       if ((u32)pwm->args.period > (v * 0xf))
+               return 0;
+
+       return DIV_ROUND_CLOSEST(v * 0xf, (u32)pwm->args.period);

What do you think?

[1] https://www.spinics.net/lists/linux-pwm/msg11908.html

Thank you.

Guru Das.
