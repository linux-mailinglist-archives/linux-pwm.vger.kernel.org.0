Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4DEDE003
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Oct 2019 20:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfJTSYb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 20 Oct 2019 14:24:31 -0400
Received: from vps.xff.cz ([195.181.215.36]:54346 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfJTSYb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 20 Oct 2019 14:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1571595869; bh=xHZcvSKU/IBWW2SVcrSlMQ+cmOT8EZkQSGIMBsAhJ4U=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=BezfH1bZNs2DSpcO4W778Sml3B90rcRc079OR8tWzOd/6DODdRrfMuUJQxLKuUyfw
         WjWTNVBP1D8tNFacPCkPsqWOUTALJhyuOmU8n17EhuhjMASREfRXyM4QJ3K8Zd4a4W
         pnzYsFKY4ckLViwByBcWANzdcC0D5kRlkWDyTJh0=
Date:   Sun, 20 Oct 2019 20:24:28 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: pwm_bl on i.MX6Q broken on 5.4-RC1+
Message-ID: <20191020182428.76l3ob4sxblrjr4m@core.my.home>
Mail-Followup-To: Adam Ford <aford173@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
References: <CAHCN7xJSz+QhOb4vE6b67jh5jnSOHnw79EyX8RW91TqPkD__Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xJSz+QhOb4vE6b67jh5jnSOHnw79EyX8RW91TqPkD__Lw@mail.gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 16, 2019 at 02:55:54PM -0500, Adam Ford wrote:
> I have an i.MX6Q with an LCD and PWM controlled backlight.  On 5.4-RC1
> through the current master (16 Oct 2019), the backlight does not come
> on by default.  I can get it come on by manually setting the
> brightness, but any video activity seems to blank the screen again
> until I change the brightness again.

You might want to check PWM driver that's used on your SoC. I had a similar
breakage on Allwinner SoCs, and it was caused by a broken get_state callback.
The problem was there for a long time and it was only exposed by the commit you
bisected to.

regards,
	o.

> I bisected the patch to 01ccf903edd6 ("pwm: Let pwm_get_state() return
> the last implemented state")
> 
> If I revert this patch on 5.4-rc3, the issue goes away.
> 
> I was hoping someone might have a suggestion on how to fix it to play
> nicely with the iMX6Q PWM or revert if no solution can be found.
> 
> thank you,
> 
> adam
