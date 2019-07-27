Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 182057784A
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jul 2019 12:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfG0KuN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 27 Jul 2019 06:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfG0KuM (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 27 Jul 2019 06:50:12 -0400
Received: from localhost (lfbn-1-17239-195.w86-248.abo.wanadoo.fr [86.248.61.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37D112085A;
        Sat, 27 Jul 2019 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564224612;
        bh=g6N3S38sMlPdUwOIQ954YRUIiHzxHJSm1difeoQG+D0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LK0V1Uytt60lUv2RslLChq0URR7ysSdVmJbcdtZNiVWm4tzK2FONkUo2nLMt7PQzC
         XOqn+hSmXLZs44TwrgBNI3MVzTEYcPQReIUhkOtbpBeClUqncnuk0MwyHmomUMW9Qy
         dT6gZH2XQCPmC5TtvO4CzUdBvkz7TjtDea5VhCEM=
Date:   Sat, 27 Jul 2019 12:50:08 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     thierry.reding@gmail.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 5/6] pwm: sun4i: Add support to output source clock
 directly
Message-ID: <20190727105008.he35sixfvoyl2lm7@flea.home>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-6-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726184045.14669-6-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 26, 2019 at 08:40:44PM +0200, Jernej Skrabec wrote:
> PWM core has an option to bypass whole logic and output unchanged source
> clock as PWM output. This is achieved by enabling bypass bit.
>
> Note that when bypass is enabled, no other setting has any meaning, not
> even enable bit.
>
> This mode of operation is needed to achieve high enough frequency to
> serve as clock source for AC200 chip, which is integrated into same
> package as H6 SoC.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

It doesn't seem to be available on the A10 (at least) though. The A13
seem to have it, so you should probably check that, and make that
conditional to the compatible if not available on all of them.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
