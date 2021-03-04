Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8E632D401
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Mar 2021 14:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241220AbhCDNRj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Mar 2021 08:17:39 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:39562 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235987AbhCDNRe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 4 Mar 2021 08:17:34 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 87AD3C72819;
        Thu,  4 Mar 2021 14:16:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1614863812;
        bh=DWI0TN3GCQFP2vA9S9QwKvOhEXn0PKUY4rRhtwCvJw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=orSXMRVnTbuhb25K+L1T+mnp6SoOw+zblvccKeHUJvl1ratlz+bhcbXnwZ2JNhnH2
         0Ys00UssC97Cy+lWIaVYalTvd5hHmf1mSjFLOVIwKpS1uDyIncYtI8B76FaqxNUDfz
         LkZ9kC9uiE5zVrQpCh+0Dyn5z7gQi7TKvVJ2JtBs=
Date:   Thu, 4 Mar 2021 14:16:51 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v5 4/7] pwm: pca9685: Reset registers to POR state in
 probe
Message-ID: <YEDdwzNxPEVK8JHT@workstation.tuxnet>
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
 <20201215212228.185517-4-clemens.gruber@pqgruber.com>
 <20210301214633.5xgxwtxuodrb3nyn@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210301214633.5xgxwtxuodrb3nyn@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 01, 2021 at 10:46:33PM +0100, Uwe Kleine-König wrote:
> Hello Clemens,
> 
> On Tue, Dec 15, 2020 at 10:22:25PM +0100, Clemens Gruber wrote:
> > Reset the prescale and ON/OFF registers to their POR default state in
> > the probe function. Otherwise, the PWMs could still be active after a
> > watchdog reset and reboot, etc.
> 
> My memories are swapped out because it's already so long ago I looked
> into this series. I thought it was already said that taking over the
> configured state in probe is the nice thing to do?!

Yes, but Sven voiced some concerns about the introduced complexities
when removing the resets.

I was torn between the two options.

I think it would be a good idea to first switch to the atomic API while
keeping the resets and then evaluate removing them in a separate patch
series.

Thanks,
Clemens
