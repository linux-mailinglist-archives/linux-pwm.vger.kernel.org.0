Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1110F32D3F6
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Mar 2021 14:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbhCDNMv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Mar 2021 08:12:51 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:39500 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241172AbhCDNMs (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 4 Mar 2021 08:12:48 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 9EAC6C72819;
        Thu,  4 Mar 2021 14:12:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1614863525;
        bh=UBm3BsLarYKigyPuOUZYg4A+DBbZVtMrUvRlGDw64oY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XIoLx4vwL50rbP6ijOM0qasc9dgPFZy3B/N9+bdStlW//aMy62yksZjodMJZ4OP4D
         Ufe7Ld42mGMr8rG5XuKK1TsjG5xh5O2CJ1p8IGiKl21/ffNyR9/XYfjHf00otq9C1u
         xCDrMTQSax239vZ3gxKdxWluhs1eBoW0WypTML9U=
Date:   Thu, 4 Mar 2021 14:12:04 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v5 1/7] pwm: pca9685: Switch to atomic API
Message-ID: <YEDcpAtQAc2Mu6Wz@workstation.tuxnet>
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
 <20210301214407.4xitetvqbsdoer6w@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210301214407.4xitetvqbsdoer6w@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, Mar 01, 2021 at 10:44:07PM +0100, Uwe Kleine-König wrote:
> Hello Clemens,
> 
> On Tue, Dec 15, 2020 at 10:22:22PM +0100, Clemens Gruber wrote:
> > +	if (state->polarity != PWM_POLARITY_NORMAL)
> > +		return -EOPNOTSUPP;
> 
> We agreed on -EINVAL for that one since 2b1c1a5d5148.
> 
> Other than that the patch looks ok (but note I only looked quickly).

Thanks for looking over it. This will be -EINVAL in the next revision.

Best regards,
Clemens
