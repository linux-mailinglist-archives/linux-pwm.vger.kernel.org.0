Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D60622FB97
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 23:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgG0Vqv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 17:46:51 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:23305 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726110AbgG0Vqu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 17:46:50 -0400
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jul 2020 14:46:50 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg04-sd.qualcomm.com with ESMTP; 27 Jul 2020 14:46:49 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 9124A18FA; Mon, 27 Jul 2020 14:46:49 -0700 (PDT)
Date:   Mon, 27 Jul 2020 14:46:49 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Martin Botka <martin.botka1@gmail.com>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH RCC 1/6] pwm: Add different PWM output types support
Message-ID: <20200727214649.GA32280@codeaurora.org>
Mail-Followup-To: Martin Botka <martin.botka1@gmail.com>,
        Fenglin Wu <fenglinw@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724213659.273599-2-martin.botka1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724213659.273599-2-martin.botka1@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 24, 2020 at 11:36:51PM +0200, Martin Botka wrote:
> From: Fenglin Wu <fenglinw@codeaurora.org>
> 
> Normally, PWM channel has fixed output until software request to change
> its settings. There are some PWM devices which their outputs could be
> changed autonomously according to a predefined pattern programmed in
> hardware. Add pwm_output_type enum type to identify these two different
> PWM types and add relevant helper functions to set and get PWM output
> types and pattern.
> 
> Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
> [konradybcio@gmail.com: Fast-forward from kernel 4.14 to 5.8]
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> Signed-off-by: Martin Botka <martin.botka1@gmail.com>

Hello,

Re-sending my reply as somehow the cc-fields got dropped when I posted
earlier.

This was the feedback received from the maintainers when I posted this
patch last year [1]. Accordingly, we updated the patch to drop
"output_pattern" altogether and made "output_type" read-only [2] -
haven't attempted upstreaming this version yet.

[1]: https://lore.kernel.org/lkml/20190916140146.GC7488@ulmo/
[2]: https://android-review.googlesource.com/c/kernel/common/+/1170135

Thank you.

Guru Das.
