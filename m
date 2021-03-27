Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0626134B80D
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Mar 2021 16:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhC0PzN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 27 Mar 2021 11:55:13 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:52716 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhC0Pyw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 27 Mar 2021 11:54:52 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id D5828CB478B;
        Sat, 27 Mar 2021 16:54:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1616860489;
        bh=U1/5mO9/pvifbFBvwKUxzTpOhHdjmuuw1LjJ30iSfIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CKcIdTgNnf59N9VMHw0m7We3VIpxLqea3+nr91l+J/DMGef0MRIFoUdzJT31hwbrx
         /s1xEfLrMT2FbJkaf89jiRpOC/uAjkQ0s6Zk3MG2aQrGZM1BmklZ12xKu0FWb/0/nY
         p/N0ykruPyO5NIuviR2ESTT2TbmuG5qhP82I+KAY=
Date:   Sat, 27 Mar 2021 16:54:47 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>, linux-pwm@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v5 1/7] pwm: pca9685: Switch to atomic API
Message-ID: <YF9VR/ngZGAXBmGK@workstation.tuxnet>
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
 <CAGngYiWbQ2STTgh2OwJTqQ-niBDbbn+OdMkk7PMzYnrZWzSy9Q@mail.gmail.com>
 <X9uL13GA1uDbLJiG@workstation.tuxnet>
 <CAGngYiW7vcJjz36xsBYx5n7=j1_5sE5a1AGpqC3Jj+tw0+FAXQ@mail.gmail.com>
 <YFhOK7YuOtTI+gfa@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFhOK7YuOtTI+gfa@orome.fritz.box>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

On Mon, Mar 22, 2021 at 08:58:35AM +0100, Thierry Reding wrote:
> On Thu, Dec 17, 2020 at 12:10:10PM -0500, Sven Van Asbroeck wrote:
> > On Thu, Dec 17, 2020 at 11:48 AM Clemens Gruber
> > <clemens.gruber@pqgruber.com> wrote:
> > >
> > > I can initialize the values to 0 of course and check the file for other
> > > places with missing initializations.
> > >
> > > Or would it be better to check the return codes of regmap_read/write in
> > > such cases? I'm not sure.
> > 
> > I think that checking the regmap_read/write return values is overkill
> > in this driver. These functions can't realistically fail, except if the i2c
> > bus is bad, i.e. h/w failure or intermittency. And that's an externality
> > which I believe we can ignore.
> 
> I think there are (rare) occasions where it's fine to not check for
> errors, i.e. if you definitively know that calls can't fail. However,
> given that this uses regmap and you don't really know what's backing
> this, I think it's always better to err on the side of caution and
> properly check the return values.
> 
> The fact that this can be externally caused is actually a reason why
> we shouldn't be ignoring any errors. If there's a chip that's hogging
> the I2C bus or if you've even just mistyped the I2C client's address
> in DT, it's better if the PWM driver tells you with an error message
> than if it is silently ignoring the errors and keeps you guessing at
> why the PWM isn't behaving the way it should.
> 
> Granted, the error code isn't always going to pinpoint exactly what's
> going wrong, but for serious errors often the I2C bus driver will let
> you know with an extra error message. However, it's much easier to go
> looking for that error message if the PWM driver lets you know that
> something went wrong.
> 
> Please just add full checking of regmap operations.

OK, I will create a separate patch adding these checks in the next
series.

This will lead to > 20 additional dev_err statements, let me know if I
should instead just return the error code and not add dev_err's for
every failed regmap operation.

Clemens
