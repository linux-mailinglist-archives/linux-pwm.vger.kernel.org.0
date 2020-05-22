Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9178C1DF297
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2020 00:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbgEVW71 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 18:59:27 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:18099 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731029AbgEVW71 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 18:59:27 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 May 2020 15:59:24 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg02-sd.qualcomm.com with ESMTP; 22 May 2020 15:59:24 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id DAB454DAC; Fri, 22 May 2020 15:59:23 -0700 (PDT)
Date:   Fri, 22 May 2020 15:59:23 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v13 00/11] Convert PWM period and duty cycle to u64
Message-ID: <20200522225923.GA2873@codeaurora.org>
References: <20200423114857.GG3612@dell>
 <20200423215306.GA8670@codeaurora.org>
 <20200424064303.GJ3612@dell>
 <20200424221422.GA31118@codeaurora.org>
 <20200427064434.GA3559@dell>
 <20200520231508.GA29437@codeaurora.org>
 <20200521071505.GL271301@dell>
 <20200522111657.GA2163848@ulmo>
 <20200522113147.GU271301@dell>
 <20200522125028.GG2163848@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522125028.GG2163848@ulmo>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, May 22, 2020 at 02:50:28PM +0200, Thierry Reding wrote:
> Looking at v14 I think there are no longer any discussions (looks like
> the last comment I thought was from v14 was actually on v13 and it seems
> to have been solved in v14 now) and there are Acked-bys for all the non-
> PWM patches, so there's nothing in the way of me applying this to the
> PWM tree. I can let it soak there for a few days and send out a stable
> branch if anyone needs it if there aren't any huge issues.
> 
> Does that sound like a plan?

There is one ongoing discussion on v14 [1]: Daniel just gave me some
comments on the clps711x.c patch that I will address in the next
patchset. The plan you outlined sounds good to me - just let me send out
v15 which you may then pick up.

[1] https://lore.kernel.org/lkml/20200521101934.j5ivjky4e6byveut@holly.lan/

Thank you.

Guru Das.
