Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A09D213D5A3
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Jan 2020 09:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgAPIGi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Jan 2020 03:06:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52893 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgAPIGi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Jan 2020 03:06:38 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1is0Ak-0000yK-5r; Thu, 16 Jan 2020 09:06:34 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1is0Aj-0007Jm-Ej; Thu, 16 Jan 2020 09:06:33 +0100
Date:   Thu, 16 Jan 2020 09:06:33 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] pwm: Convert period and duty cycle to u64
Message-ID: <20200116080633.nikynj7jguu3c2br@pengutronix.de>
References: <cover.1578959442.git.gurus@codeaurora.org>
 <21a1431edfa86e061528b80021351c25c76976a9.1578959442.git.gurus@codeaurora.org>
 <20200114074710.kxkz4664oap3r752@pengutronix.de>
 <20200116005503.GA8559@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200116005503.GA8559@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

[added linux-pwm to Cc:]

On Wed, Jan 15, 2020 at 04:55:03PM -0800, Guru Das Srinagesh wrote:
> On Tue, Jan 14, 2020 at 08:47:10AM +0100, Uwe Kleine-König wrote:
> > I didn't thought about that much, but it would be great if we could
> > prepare the affected drivers to work with both, int and u64 and switch
> > in a separate commit. Reverting would then become cheaper.
> > The conversion to 64-bit division macros could be done even without
> > actually converting period and duty cycle, couldn't it?
> 
> I do agree that with such a two-step process the reverting (should the
> need arise) would be much cheaper. I tried out your suggestion and saw
> that this is not possible as the patch stands currently due to
> compilation warning and errors that arise for various architectures:
> 
> warning: comparison of distinct pointer types lacks a cast
> warning: right shift count >= width of type [-Wshift-count-overflow]
> error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
> note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'unsigned int *'
> warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]

This should be managable with appropriate casting. Maybe it's also a
good idea to add a greppable keyword (e.g. "PWM-TYPE-CONVERSION") and a
short comment at the places that are expected to be touched again after
the conversion is known to last. (e.g. to remuch such casts).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
