Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2A336313B
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Apr 2021 18:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbhDQQlK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 17 Apr 2021 12:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbhDQQlK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 17 Apr 2021 12:41:10 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DC0C061574;
        Sat, 17 Apr 2021 09:40:43 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 9F41CC725D8;
        Sat, 17 Apr 2021 18:40:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1618677641;
        bh=RmhXOMCFFCbce605ZIbZPj9mHR2sZMVr+GIMZbzQjv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IPxU1qS2JQXMzTWtfWiwsM7n21Ahu6UzIOMp2QGzj9UAPQwRduji1PDlM2rNt6nOj
         ms8PbzKUgjXC2Xz8zKDfVN4KKxG+7ESy73YaG/4r3PPmOvldfZIw+OD5GDuhJXXnD1
         21oosYNzdL/xumg3nPoCbxYYw58F7iokMJUP6jiw=
Date:   Sat, 17 Apr 2021 18:40:40 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/8] pwm: pca9685: Switch to atomic API
Message-ID: <YHsPiNAjr919VGIe@workstation.tuxnet>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210417153728.eohhphmtm6qf26y4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210417153728.eohhphmtm6qf26y4@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Sat, Apr 17, 2021 at 05:37:28PM +0200, Uwe Kleine-König wrote:
> On Mon, Apr 12, 2021 at 03:27:38PM +0200, Clemens Gruber wrote:
> > The switch to the atomic API goes hand in hand with a few fixes to
> > previously experienced issues:
> > - The duty cycle is no longer lost after disable/enable (previously the
> >   OFF registers were cleared in disable and the user was required to
> >   call config to restore the duty cycle settings)
> > - If one sets a period resulting in the same prescale register value,
> >   the sleep and write to the register is now skipped
> > - Previously, only the full ON bit was toggled in GPIO mode (and full
> >   OFF cleared if set to high), which could result in both full OFF and
> >   full ON not being set and on=0, off=0, which is not allowed according
> >   to the datasheet
> > - The OFF registers were reset to 0 in probe, which could lead to the
> >   forbidden on=0, off=0. Fixed by resetting to POR default (full OFF)
> 
> I didn't recheck all details, but the patch is definitively an
> improvement, so:
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks, but there is a newer version v9, I assume your acks are meant
for the newer one?

Clemens
