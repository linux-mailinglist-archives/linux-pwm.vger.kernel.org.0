Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2955819E785
	for <lists+linux-pwm@lfdr.de>; Sat,  4 Apr 2020 22:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgDDURN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 4 Apr 2020 16:17:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40931 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgDDURN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 4 Apr 2020 16:17:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id r19so11136516otn.7;
        Sat, 04 Apr 2020 13:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJTKSBOUH+yj0d/mHBM2UzGXlRDlu84qMDclsOkJFTU=;
        b=H59bFMWmi7k2GzCJRX+viMUgQUtNhyrcJpM/IWlC6Gtvi2GcinjlwWIJw2Wfp3tmUL
         5Gf+Bqa3OGealBlLihlAHSzz5GGszxPhebMim68HUceS0K9pPnA2xOl7FLRrj5BRFx2j
         psTvMWbQhEVmV/HVymomfcAYoYy8/TatHZ1DpFfl2yzAGymJjEiaEdAO2nRcCpL+KMtC
         4CbJjvAnhhoMDTgJFzLgQwZyysRom0g7zO04jvhagXG67qqMbtGq+xB1M0mgMA4HCC7T
         d6eYDZ8JwQro1CdANYmSKWJ9+rvnuQiu9G91y9Y8aUJ9XO6FS7EUL4bfACz4P0sZwfeE
         mTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJTKSBOUH+yj0d/mHBM2UzGXlRDlu84qMDclsOkJFTU=;
        b=ZtIh2IkhcIWE/dhkS1svaDMOVcvKSTT5wU8R7LxnsZEITopQWYiy5vlSnViYr6lk0+
         ZtBMQygrdE9QaytcOUruJThTq/l3eUlO88LtCOc0l/O0si/jvLmCwS1sezC+lOoSDFJ+
         sTQPRvfbbTz1FpIKzsGXaEb2kzbrV1b1XF4YABwMlFsOyUNsqyqWDM3ccGSh38uGo9ER
         10dnT8nPy0zKAidg3Tx+vXj9ndgrp8sm4iQ+LErtogwJIYTETa/RssAEuxuuVRiaeUOH
         BVK6oJ8jRMjy/T2ifvYOV9TFd6TraqP3oXWVpC+SZEa34CX0yzsN9pJNP65dm9IZ6GbZ
         2CfA==
X-Gm-Message-State: AGi0Pub19qfpCb3fRkwpTx0wBGI1O6t58eP8o3WLV+aKl+nPa4BaFogY
        PFmjJ75RUhqEWMNxLzatJVTTh3Zfc6BOan/FcF8=
X-Google-Smtp-Source: APiQypKYhZC30quW9Uejm8N+41KNx6kYhLVSS6y3yQ9quiUwebLgHG57LqEGqiBL88yuBW8RslnaeBm/pJwRfjrWRxA=
X-Received: by 2002:a9d:6a05:: with SMTP id g5mr11795340otn.116.1586031432020;
 Sat, 04 Apr 2020 13:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226151034.7i3h5blmrwre2yzg@pengutronix.de> <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
 <20200330151231.GA1650@workstation.tuxnet> <CAGngYiUe-tihBJUcXQ738_5aA9pzgp_-NSs4iCrz3eWO6rMukA@mail.gmail.com>
 <20200404173546.GA55833@workstation.tuxnet>
In-Reply-To: <20200404173546.GA55833@workstation.tuxnet>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 4 Apr 2020 16:17:00 -0400
Message-ID: <CAGngYiWpO_N+t74k-==RNaXkZcp6TZvVOJzXPOi84cpQ6PHbhw@mail.gmail.com>
Subject: Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle
 struct element
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Apr 4, 2020 at 1:35 PM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> As the user is setting the duty cycle in nanoseconds, it makes sense
> that the relative duty cycle decreases in an absolute period increase.
> As for the behavior that the other channels remain at the same relative
> duty cycle: Not sure how we can avoid this, other than reprogramming all
> 15 other channels if one of them is changed and that's not really
> acceptable, I think.

Thank you for the explanation, Clemens.

Yes, it does make sense that the relative duty cycle changes when we change
the period. A relative duty cycle of duty_cycle / period is what the user would
expect to see.

It also kind-of makes sense that the relative duty cycles of the other
pwm channels
do not change: after all, the user is not touching them, so would not expect
them to change.

However, the following does not make sense to me. Imagine pwm0 and pwm1
are both active and at 50%: period=5000000, duty_cycle=2500000. Then, change
the period on pwm0:

$ echo 10000000 > pwm0/period

Then pwm0 gets dimmer (makes sense) and pwm1 keeps the same relative duty
cycle (makes sense). However, if we now read out sysfs for pwm1, we get:

$ echo pwm1/period
5000000 (wrong!)
$ echo pwm1/duty_cycle
2500000 (wrong! although relative duty cycle is correct)

Although the pwm1 period has changed, the API calls do not reflect this.
This makes it next to impossible for users to know what the current period
is set to.

Moving to the atomic API won't help, because .get_state is called only
once, when the chip is registered.

It does look like we have a square peg (this chip) in a round hole (the
standard assumptions the pwm core makes) ?
