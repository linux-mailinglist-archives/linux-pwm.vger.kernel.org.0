Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F571180B71
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Mar 2020 23:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgCJWYT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Mar 2020 18:24:19 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:8935 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbgCJWYT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Mar 2020 18:24:19 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Mar 2020 15:24:18 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 10 Mar 2020 15:24:18 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 50F004A2B; Tue, 10 Mar 2020 15:24:18 -0700 (PDT)
Date:   Tue, 10 Mar 2020 15:24:18 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v7 03/13] hwmon: pwm-fan: Use 64-bit division macros for
 period and duty cycle
Message-ID: <20200310222418.GA8053@codeaurora.org>
References: <cover.1583782035.git.gurus@codeaurora.org>
 <b503833e0f58bd6dd9fe84d866124e7c457e099e.1583782035.git.gurus@codeaurora.org>
 <20200309214822.GA19773@roeck-us.net>
 <20200310120814.4kjxmii3c7zxw55y@pengutronix.de>
 <bd6c7679-9569-2cf1-1664-61bf368d82dd@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd6c7679-9569-2cf1-1664-61bf368d82dd@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Mar 10, 2020 at 08:05:58AM -0700, Guenter Roeck wrote:
> I don't see support in the LED subsystem to utilize the PWM framework directly
> for blinking. Plus, you say yourself that it isn't a _real_ use case, just a
> theoretic one.

An example use case is a mobile phone OEM that wishes to set a period of
5 seconds or more for, say, a low battery slow blinking indication - currently
this is not possible. The PWM framework not having direct support for
blinking should not be a concern if the PWM peripheral being controlled
supports it via register writes.

> Either case, the reason / use case for this series should be explained
> in the summary patch. That is what it is for. That case is not made.

Will upload a new patchset adding more details in the summary patch.

Thank you.

Guru Das.
