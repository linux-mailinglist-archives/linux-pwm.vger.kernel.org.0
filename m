Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F00F269844
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Sep 2020 23:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgINVvC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Sep 2020 17:51:02 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:54093 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgINVu6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Sep 2020 17:50:58 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D1C2222708;
        Mon, 14 Sep 2020 23:50:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1600120256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WEZa4tMQ4cVvyWubxXAttSAni9x1Ad4LL/hdsYs9YIY=;
        b=cDs8xrI9zE2wtJ2jpwESYmihri49VCiZX/oeN+Irn5SNubSaItGRdVZVurT88O3m0jXMNd
        oCuQYBjeRIH7It/XhJvqhvMVBr2XIqMWiMnihUjd7Oxg/Cz0EuQSU5WGGgcb9uy+bK/1LP
        IlutsJIUgbVkvo//mzQNp3WBP9tRs4k=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Sep 2020 23:50:55 +0200
From:   Michael Walle <michael@walle.cc>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v10 00/13] Add support for Kontron sl28cpld
In-Reply-To: <20200914214341.14268-1-michael@walle.cc>
References: <20200914214341.14268-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <9146339946ff041df991cae8e155413b@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Lee, Hi Shawn,

Am 2020-09-14 23:43, schrieb Michael Walle:
> The Kontron sl28cpld is a board management chip providing gpio, pwm, 
> fan
> monitoring and an interrupt controller. For now this controller is used 
> on
> the Kontron SMARC-sAL28 board. But because of its flexible nature, it
> might also be used on other boards in the future. The individual blocks
> (like gpio, pwm, etc) are kept intentionally small. The MFD core driver
> then instantiates different (or multiple of the same) blocks. It also
> provides the register layout so it might be updated in the future 
> without a
> device tree change; and support other boards with a different layout or
> functionalities.
[..]

Lee, because my last v9 wasn't merged for now, I though I can do a new 
v10
with the requested fixes.

Shawn, do you have any remarks on the "arm64:" patches? Will you merge 
them
through your tree. If there are any remarks, I'd wait and repost them in 
an
own series once the actual drivers are merged. I guess there is no need 
to
have all the maintainters on CC for these patches anymore.

-- 
-michael
