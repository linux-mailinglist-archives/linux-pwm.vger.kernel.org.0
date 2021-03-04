Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F9132D3F0
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Mar 2021 14:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbhCDNLr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Mar 2021 08:11:47 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:39460 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241136AbhCDNLj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 4 Mar 2021 08:11:39 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id A3803C72819;
        Thu,  4 Mar 2021 14:10:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1614863458;
        bh=zi1uK+zkf8Cgx3t0AT2qIAjy7nM1fwlN1EPUn/BXkj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n5LjpydTpkWqoXhs832+EtisbJ5GibaVksKmxZyFKAauph4aC8VxhiWOkd+DXvwWF
         dNDytUlNJOSPRVNWFfYGsKU6gyJAdW7WgM9vBQeC07c2PYOtzQ6QTgIs9Wcomx1OPY
         U9Gw9ypaJxPqabegMrGO/ZKrXAB7tgnwpDpcTc1o=
Date:   Thu, 4 Mar 2021 14:10:56 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v5 1/7] pwm: pca9685: Switch to atomic API
Message-ID: <YEDcYN70TIPlPXv7@workstation.tuxnet>
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
 <CAGngYiWbQ2STTgh2OwJTqQ-niBDbbn+OdMkk7PMzYnrZWzSy9Q@mail.gmail.com>
 <X9uL13GA1uDbLJiG@workstation.tuxnet>
 <CAGngYiW7vcJjz36xsBYx5n7=j1_5sE5a1AGpqC3Jj+tw0+FAXQ@mail.gmail.com>
 <20210301214115.xolncig676tgnxwn@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210301214115.xolncig676tgnxwn@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, Mar 01, 2021 at 10:41:15PM +0100, Uwe Kleine-König wrote:
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
> > 
> > Maybe Thierry or Uwe have further insights here.
> 
> I'm a fan of full checking, but I'm not sure what's Thierry's position
> on that.
> 
> My reasoning is: If the bus is bad and a request to modify the PWM fails
> because of that, the PWM consumer probably wants to know.

I see. Then I'd suggest that we postpone adding these checks until we
get a response from Thierry and if he agrees with you, we could add
these checks in a separate patch series?

Thanks,
Clemens
