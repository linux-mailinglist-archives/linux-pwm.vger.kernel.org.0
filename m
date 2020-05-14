Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C441D3F20
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 22:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgENUp7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 16:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725975AbgENUp6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 16:45:58 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2A2C061A0C;
        Thu, 14 May 2020 13:45:58 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BF3CB22EEB;
        Thu, 14 May 2020 22:45:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1589489154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DMXKBlWL/MST7cL34EcyY2r7dUnEYA7BplVDp3fsnk0=;
        b=vkg/zj/0PDSbf5X0pK+in32oGplSgPjZpIyY9VFe7AbF/2ZsjfhevzzkEFvlj0qRy3JA0c
        1CSKjkXkWnIGZ95mLlXpOIqKRhQvgXP6n4LMjJosWwuh08bDDGHGGq619bZyreTcqDdXnr
        T5BtNH3gx2QelwgM2PzR7k5O5g5eGkA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 May 2020 22:45:53 +0200
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
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
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 02/16] mfd: mfd-core: Don't overwrite the dma_mask of
 the child device
In-Reply-To: <20200428152543.GI5677@sirena.org.uk>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-3-michael@walle.cc>
 <20200428124548.GS185537@smile.fi.intel.com>
 <3cd3705a-4f48-6a46-e869-3ee11dc17323@arm.com>
 <20200428142938.GX185537@smile.fi.intel.com>
 <6ccad285-7b5f-3037-d4d5-ff4d9571b612@arm.com>
 <20200428152543.GI5677@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <8fb998f882938680d98f1c2f6f8254c1@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-04-28 17:25, schrieb Mark Brown:
> On Tue, Apr 28, 2020 at 03:49:49PM +0100, Robin Murphy wrote:
> 
>> For better or worse, the platform bus is the dumping ground for random 
>> crap,
>> so we just have to deal with all the abstraction breakage that leaks 
>> out of
>> that.
> 
> The reason we're using the platform bus for this is that historically
> people were creating buses which were essentially carbon copies of the
> platform bus with the name changed and it was felt that rather than
> duplicate code it was better to just use platform devices with no MMIO
> ranges defined.  If there's some assumptions about DMA for platform
> devices floating about somewhere it might be reasonable to revisit this
> and create a non-DMA variant of platform devices since there is a
> meaningful difference.

Was there any conclusion? Should I keep or drop this patch in the next 
version
of this series?

-- 
-michael
