Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967041A3357
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2020 13:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgDILmR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Apr 2020 07:42:17 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46218 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgDILmR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Apr 2020 07:42:17 -0400
Received: by mail-ot1-f67.google.com with SMTP id 88so907470otx.13;
        Thu, 09 Apr 2020 04:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QSdmLn/47rBWdzKSuy9mWSxAVccVvsu0MtzKNdTSVJs=;
        b=TQKvrRs72fLHco+11O8lbJRsVzpW+nmiLZg9JT2qYME6dfk909CrQi8VK4Znmzt9wF
         Jo0oPrDaNXJbB2lgXSml/x6zCoBvahhmyJgmWBPOLTfc5TgytB3ifSSNDmWzVpiaaV8W
         /ZmLmENX0mjBGyNA8/d20SWJhTeXI3G4KrPwHO50GQX/5+1Neoz466ZOLYwymWYQzI62
         5hvZdxzNjJrfkPIO3Rd2DaJ6BCAuSoCQ8kjtqPJMudpf9oEAW5vxAR0QhOIo8pQIJcQl
         axn3n1wlVHRLITZcIdyFPjJSd0Wam4tfOxVw2AcF2zF8UM1/JGIKHZn5gTQ5gWkQoBBW
         FszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSdmLn/47rBWdzKSuy9mWSxAVccVvsu0MtzKNdTSVJs=;
        b=hkHa0LUtftxkjPdxUvt2LPhIrgF3MBs7XWA7e7kbnGrjzNS7kCiAi8ZCp3rkfPh3K4
         R2Tx4ZuKbsD2i3LaEbxteBPEsh0ivt9ryBM2OJnp1324NysCeB3hD4LdETLAvZ6axGux
         SDZiXSpZ9z6l8C0gAtfbr29G9w4I5hROfDR6YJKVaRhcBq5v5JaPD7vCdBi3mcJpLgRp
         c4dk/lvjmGkYCG4bWYQNiJIt+M0Vn8R7KVoJfhv9MWVASrgdoY85MXcmnaUEZsYcuK8g
         IpXTnRrkhS1MA4JUVECU3f+a0IwneJ6Jr42HiopspmD8xI4cbVl8n0wndjgZjVKuVqm/
         jU2w==
X-Gm-Message-State: AGi0PuZnG30ekppm+HnYmh9S/3w2XMxp9BWKgBv7p815H3k+OxRCffvU
        Ubqpxv1rMCnsMREBuTUB56TJ5EZyyxSKLGMzL4s=
X-Google-Smtp-Source: APiQypJMFPyFCIIC/zZqgeb5ciZU4mgfNDDmqfwmYgNfamEqORgmLs/i8FWeNYIkHVPlaejOKAMgEtoUWlUMpWOy4rs=
X-Received: by 2002:a9d:19ca:: with SMTP id k68mr9439579otk.232.1586432536695;
 Thu, 09 Apr 2020 04:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226151034.7i3h5blmrwre2yzg@pengutronix.de> <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
 <20200330151231.GA1650@workstation.tuxnet> <CAGngYiUe-tihBJUcXQ738_5aA9pzgp_-NSs4iCrz3eWO6rMukA@mail.gmail.com>
 <20200404173546.GA55833@workstation.tuxnet> <CAGngYiWpO_N+t74k-==RNaXkZcp6TZvVOJzXPOi84cpQ6PHbhw@mail.gmail.com>
 <20200406095124.GA475759@ulmo>
In-Reply-To: <20200406095124.GA475759@ulmo>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 9 Apr 2020 07:42:05 -0400
Message-ID: <CAGngYiWz-XCenfWAnTFR9jKuQpGQXi26B5-K0T3dvB_g54h6qA@mail.gmail.com>
Subject: Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle
 struct element
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Apr 6, 2020 at 5:51 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> There are other chips where a single period is shared across multiple
> PWM channels. Typically what we do there is once a period is configured
> for a given channel, all subsequent PWM channel configurations must use
> the same period, or otherwise the driver will return an error code.

Thank you for the clarification Thierry. Do you think this method would be
appropriate for this chip?
