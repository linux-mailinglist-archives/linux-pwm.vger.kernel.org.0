Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8773F7040
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2019 10:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfKKJQK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Nov 2019 04:16:10 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37461 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKJQK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Nov 2019 04:16:10 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iU5nr-0000hf-1h; Mon, 11 Nov 2019 10:16:07 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iU5nq-00048w-Bn; Mon, 11 Nov 2019 10:16:06 +0100
Date:   Mon, 11 Nov 2019 10:16:06 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, Neil Brown <neilb@suse.de>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/4] pwm: omap-dmtimer: remove pwmchip in .remove before
 making it unfunctional
Message-ID: <20191111091606.qf7gj5gln3khfnsl@pengutronix.de>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

I created a cover letter but failed to send it together with the series
:-|

It said:

| I promised a cleanup patch but as I found a few more issues I have four
| patches now. The third patch replaces Markus' patch with a more complete
| fix that also drops the reference in .remove not only the error path of
| .probe.
| 
| The last patch allows to compile the driver in more configurations, it
| compiled successfully on amd64 and arm.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
