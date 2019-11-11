Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C514F80B5
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2019 20:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKKT5P (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Nov 2019 14:57:15 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45781 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfKKT5P (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Nov 2019 14:57:15 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iUFoH-0003xS-PD; Mon, 11 Nov 2019 20:57:13 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iUFoG-0000LR-Vz; Mon, 11 Nov 2019 20:57:13 +0100
Date:   Mon, 11 Nov 2019 20:57:12 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-pwm@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Neil Brown <neilb@suse.de>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [0/4] pwm: omap-dmtimer: Software improvements
Message-ID: <20191111195712.mmk7f23cjson6e6x@pengutronix.de>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <20191111091606.qf7gj5gln3khfnsl@pengutronix.de>
 <3672014f-14f2-7568-8258-bc472f3b9ae1@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3672014f-14f2-7568-8258-bc472f3b9ae1@web.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Nov 11, 2019 at 02:28:52PM +0100, Markus Elfring wrote:
> > I created a cover letter but failed to send it together with the series
> > :-|
> 
> Did you omit the address “linux-kernel@vger.kernel.org” from
> the recipient list intentionally?

Yes, even though it's documented to Cc: all patches there, there is IMHO
little use. If there is a dedicated mailing list, not adding lkml is
fine for all maintainers I interacted with in the last few years.

The volume on lkml is that high that sending all patches there only adds
noise.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
