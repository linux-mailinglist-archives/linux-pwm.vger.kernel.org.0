Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DF3367FAE
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Apr 2021 13:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhDVLjj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Apr 2021 07:39:39 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:51892 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235955AbhDVLji (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 22 Apr 2021 07:39:38 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id AFBCEC725CF;
        Thu, 22 Apr 2021 13:39:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1619091542;
        bh=MMc8JCRyxFdvyYZeG7GEnCEXw7rR9PccoTmcF4kV0r4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+J54Wc7PrEMXfoeoCjFhJxxAfeJCivLZ6z5Ojh7TOV8d77gLwNy20U0Nb0G2gu8k
         1Cp2BVzGmVI1QtiHvHPRThjYvB6evobSZTnH68bI3dW1GzF3HcDCMGTR99bSOYd2ki
         2FcoTdlESD7EGcuUbODj/pU7vfOkJOcY7wstsLIQ=
Date:   Thu, 22 Apr 2021 13:39:01 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/8] pwm: pca9685: Switch to atomic API
Message-ID: <YIFgVZL4PBcIKvMp@workstation.tuxnet>
References: <20210415121455.39536-1-clemens.gruber@pqgruber.com>
 <20210417195150.5fdcpxfbasp4y264@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210417195150.5fdcpxfbasp4y264@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Apr 17, 2021 at 09:51:50PM +0200, Uwe Kleine-König wrote:
> On Thu, Apr 15, 2021 at 02:14:48PM +0200, Clemens Gruber wrote:
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
> > 
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> 
> (I sent my ack to v8 before, but indeed this was the version I intended
> to ack)
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thierry: Do you think we can get patches 1 to 3 into 5.13-rc1?

Thanks,
Clemens
