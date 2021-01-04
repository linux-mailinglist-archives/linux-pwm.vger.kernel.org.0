Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00572E92BF
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Jan 2021 10:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbhADJoC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Jan 2021 04:44:02 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:59119 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbhADJoC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 4 Jan 2021 04:44:02 -0500
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id E7BF54407E8;
        Mon,  4 Jan 2021 11:43:17 +0200 (IST)
References: <cover.1607601615.git.baruch@tkos.co.il>
 <CACRpkdaDzNyUUARs63ydC+XkW29vxvZBjtj4K5rp7+_WEUeeAQ@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K?= =?utf-8?Q?=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] gpio: mvebu: Armada 8K/7K PWM support
In-reply-to: <CACRpkdaDzNyUUARs63ydC+XkW29vxvZBjtj4K5rp7+_WEUeeAQ@mail.gmail.com>
Date:   Mon, 04 Jan 2021 11:43:17 +0200
Message-ID: <87pn2l9gwa.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

On Mon, Jan 04 2021, Linus Walleij wrote:
> this series seem to have missed the previous merge window due to
> remaining comments, will you rebase on v5.11-rc1 and resend them?

This series applies cleanly on v5.11-rc2. I have just tested.

As far as I understand there are no remaining comments. Rob acked the
DT binding change.

Would you like me to post the series again anyway?

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
