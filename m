Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4036956BF
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2019 07:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfHTFlH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Aug 2019 01:41:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59937 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbfHTFlH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Aug 2019 01:41:07 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hzwt8-0002bd-Tl; Tue, 20 Aug 2019 07:40:58 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hzwt7-0001bl-Td; Tue, 20 Aug 2019 07:40:57 +0200
Date:   Tue, 20 Aug 2019 07:40:57 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 2/10] pwm: mediatek: droping the check for
 of_device_get_match_data
Message-ID: <20190820054057.xtbhtjm65f6rphcg@pengutronix.de>
References: <1566265225-27452-1-git-send-email-sam.shih@mediatek.com>
 <1566265225-27452-3-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566265225-27452-3-git-send-email-sam.shih@mediatek.com>
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

On Tue, Aug 20, 2019 at 09:40:17AM +0800, Sam Shih wrote:
> From: sam shih <sam.shih@mediatek.com>

Your Signed-off-by and the mail's From uses capital letters. Can you
please make them all match?

> This patch drop the check for of_device_get_match_data.
> Due to the only way call driver probe is compatible match,
> In this case, the platform data should never be NULL.

Yeah, all entries in the of_match_table have a .data pointer.
Theoretically the driver could be bound by driver.name and then
of_device_get_match_data returns NULL.

It's still ok to drop this check if you want to, I just want to make
sure this possibility is known.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
