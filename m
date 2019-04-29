Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB7EE656
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Apr 2019 17:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfD2P12 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Apr 2019 11:27:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44397 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfD2P12 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Apr 2019 11:27:28 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hL8Bg-0005bK-1n; Mon, 29 Apr 2019 17:27:24 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hL8Bf-00046t-0a; Mon, 29 Apr 2019 17:27:23 +0200
Date:   Mon, 29 Apr 2019 17:27:22 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH v11 0/2] PWM support for HiFive Unleashed
Message-ID: <20190429152722.xw5bcocu2t77wb4u@pengutronix.de>
References: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
 <CAJ2_jOF8RsLWHkcCJzwfpeMN0+G0oqbHto=nBBnpZDNfuQMKOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ2_jOF8RsLWHkcCJzwfpeMN0+G0oqbHto=nBBnpZDNfuQMKOw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Apr 15, 2019 at 11:36:51AM +0530, Yash Shah wrote:
> Hi,
> 
> Any comments on this patch series?
> Any more changes are needed or it looks good to be merged upstream?

In my eyes it would be great if Andreas Schwab was able to resolve the
problems he pointed out in this thread.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
