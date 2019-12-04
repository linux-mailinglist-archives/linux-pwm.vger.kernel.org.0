Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D717E113526
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2019 19:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfLDSsC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Dec 2019 13:48:02 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47833 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfLDSsB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Dec 2019 13:48:01 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1icZgq-0003fy-Ad; Wed, 04 Dec 2019 19:47:56 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1icZgo-0002Xy-Mk; Wed, 04 Dec 2019 19:47:54 +0100
Date:   Wed, 4 Dec 2019 19:47:54 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] gpio: mvebu: use platform_irq_count
Message-ID: <20191204184754.5oj2xoem2v3544rx@pengutronix.de>
References: <1575433106-16171-1-git-send-email-peng.fan@nxp.com>
 <20191204072422.vfo3mrrcaav75jv4@pengutronix.de>
 <CAMpxmJUAk5Y3mX_irTjwveaii8W=coaG0w2aWvFXUEXqHxpArQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJUAk5Y3mX_irTjwveaii8W=coaG0w2aWvFXUEXqHxpArQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Dec 04, 2019 at 05:33:04PM +0100, Bartosz Golaszewski wrote:
> śr., 4 gru 2019 o 08:24 Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> napisał(a):
> >
> > On Wed, Dec 04, 2019 at 04:20:41AM +0000, Peng Fan wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > platform_irq_count() is the more generic way (independent of
> > > device trees) to determine the count of available interrupts. So
> > > use this instead.
> > >
> > > As platform_irq_count() might return an error code (which
> > > of_irq_count doesn't) some additional handling is necessary.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > Reviewed-and-Commit-Log-Provided-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> This is not a valid tag, but I take it as Suggested-by and Reviewed-by. :)

If you care about the validity of such tags, I suggest you take a look
at the output of

	$ git rev-list v4.0..v5.4 | while read rev; do git cat-file commit $rev; done | sed -n 's/ *\(.*-by\):.*/\1/p' | sort | uniq -c | sort -n

(which finds all tags used between 4.0 and 5.4 with its usage count).

A few of the tags (admittedly with low usage count :-) included there are:

  Badly-reviewed-by
  Bonus-points-awarded-by
  Compile-tested and Reviewed-by
  Enthusiastically-Acked-by
  Mea-culpa-by
  \o/-by
  Brown-paper-bag-by

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
